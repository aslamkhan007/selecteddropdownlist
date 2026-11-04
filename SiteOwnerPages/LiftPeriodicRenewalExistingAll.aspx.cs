using CEI_PRoject;
using CEIHaryana.Contractor;
using CEIHaryana.Officers;
using CEIHaryana.UserPages;
using Org.BouncyCastle.Asn1.Cmp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Windows.Media;
using System.Windows.Media.TextFormatting;
using System.Xml.Linq;

namespace CEIHaryana.SiteOwnerPages
{
    public partial class LiftPeriodicRenewalExistingAll : System.Web.UI.Page
    {
        CEI CEI = new CEI();

        #region Properties

        // Logged-in user hamesha Session se
        private string CurrentUserId
        {
            get { return Convert.ToString(Session["SiteOwnerId"]); }
        }

        private bool IsReturnedApplication
        {
            get { return Convert.ToString(Session["ReturnedValue"]) == "1"; }
        }

        // Modal me selected row ka type ("Lift"/"Escalator") aur registration no. (ViewState = signed)
        private string SelectedType
        {
            get { return Convert.ToString(ViewState["SelType"]); }
            set { ViewState["SelType"] = value; }
        }

        private string SelectedRegNo
        {
            get { return Convert.ToString(ViewState["SelRegNo"]); }
            set { ViewState["SelRegNo"] = value; }
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Convert.ToString(Session["SiteOwnerId"]) != null && Convert.ToString(Session["SiteOwnerId"]) != "")
                    {
                        GridtoViewAllRecords(CurrentUserId);
                        Page.Session["ClickCount"] = "0";
                    }
                    else
                    {
                        Session["SiteOwnerId"] = "";
                        Response.Redirect("/LogOut.aspx");
                    }
                }
            }
            catch
            {
                Session["SiteOwnerId"] = "";
                Response.Redirect("/LogOut.aspx");
            }
        }

        #region Draft helpers

        private class DraftInfo
        {
            public string Type, RegNo, LastPay;
            public Dictionary<int, string[]> Docs = new Dictionary<int, string[]>(); // DocID -> {name, fileName, path}
        }

        private Dictionary<string, DraftInfo> GetDrafts(string user)
        {
            var map = new Dictionary<string, DraftInfo>();
            DataSet ds = CEI.GetLiftRenewalDrafts(user);
            if (ds == null || ds.Tables.Count == 0) return map;
            foreach (DataRow r in ds.Tables[0].Rows)
            {
                string key = r["InstallationType"] + "|" + r["RegistrationNo"];
                DraftInfo d;
                if (!map.TryGetValue(key, out d))
                {
                    d = new DraftInfo { Type = r["InstallationType"].ToString(), RegNo = r["RegistrationNo"].ToString(), LastPay = ToYmd(r["LastPaymentDate"]) };
                    map[key] = d;
                }
                if (r["DocumentID"] != DBNull.Value)
                    d.Docs[Convert.ToInt32(r["DocumentID"])] = new[] { r["DocumentName"].ToString(), r["FileName"].ToString(), r["DocumentPath"].ToString() };
            }
            return map;
        }

        // Type -> required DocumentIDs ("Other Document" optional)
        private Dictionary<string, HashSet<int>> GetRequiredDocs(string user)
        {
            var result = new Dictionary<string, HashSet<int>>();
            string applicantType = GetApplicantType(user);
            foreach (string type in new[] { "Lift", "Escalator" })
            {
                var set = new HashSet<int>();
                DataTable dt = CEI.GetDocumentsForLiftRenewal(applicantType, type == "Lift" ? 4 : 10, "Periodic", type);
                if (dt != null)
                    foreach (DataRow r in dt.Rows)
                        if (r["DocumentName"].ToString().Trim().ToLower() != "other document")
                            set.Add(Convert.ToInt32(r["DocumentID"]));
                result[type] = set;
            }
            return result;
        }

        private bool IsComplete(DraftInfo d, HashSet<int> required)
        {
            if (d == null || required == null || required.Count == 0) return false;
            foreach (int id in required)
                if (!d.Docs.ContainsKey(id)) return false;
            return true;
        }

        #endregion

        #region Grid / Record loading

        private DataTable _lifts;

        private void GridtoViewAllRecords(string createdBy)
        {
            DataTable dtAll = null;
            foreach (string type in new[] { "Lift", "Escalator" })
            {
                DataSet ds = CEI.GetRenewalLiftDataGridOfExpiredAllRecords(type, createdBy);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataTable dt = ds.Tables[0].Copy();
                    if (!dt.Columns.Contains("InstallationType")) dt.Columns.Add("InstallationType", typeof(string));
                    foreach (DataRow r in dt.Rows) r["InstallationType"] = type;
                    if (dtAll == null) dtAll = dt; else dtAll.Merge(dt);
                }
            }

            // Returned application: sirf wahi ek record
            if (dtAll != null && IsReturnedApplication)
            {
                string reg = Convert.ToString(Session["RegistrationNosessionPass"]).Replace("'", "''");
                string typ = Convert.ToString(Session["InstallTypePass"]) == "Lift" ? "Lift" : "Escalator";
                DataView dv = new DataView(dtAll) { RowFilter = "RegistrationNo = '" + reg + "' AND InstallationType = '" + typ + "'" };
                dtAll = dv.ToTable();
            }

            if (dtAll == null || dtAll.Rows.Count == 0)
            {
                LblGridView1.Visible = true;
                LblGridView1.InnerText = "There is no any Lift or Escalator exist for this User.";
                LblGridView1.Style["color"] = "red";
                rptAddress.DataSource = null;
                rptAddress.DataBind();
                return;
            }
            LblGridView1.Visible = false;

            dtAll.Columns.Add("DocStatus", typeof(string));
            dtAll.Columns.Add("DocInfo", typeof(string));
            dtAll.Columns.Add("AddrNo", typeof(int));

            var required = GetRequiredDocs(createdBy);
            var drafts = GetDrafts(createdBy);
            var addrNo = new Dictionary<string, int>();

            foreach (DataRow r in dtAll.Rows)
            {
                string addr = Convert.ToString(r["SiteAddress"]).Trim();
                r["SiteAddress"] = addr == "" ? "Address not available" : addr;

                string addrKey = r["SiteAddress"].ToString();
                if (!addrNo.ContainsKey(addrKey)) addrNo[addrKey] = addrNo.Count + 1;
                r["AddrNo"] = addrNo[addrKey];

                string type = r["InstallationType"].ToString();
                DraftInfo d;
                drafts.TryGetValue(type + "|" + r["RegistrationNo"], out d);
                HashSet<int> req = required[type];

                int have = 0;
                if (d != null) foreach (int id in req) if (d.Docs.ContainsKey(id)) have++;

                bool done = IsComplete(d, req);
                r["DocStatus"] = done ? "Completed" : "Pending";
                r["DocInfo"] = have + " / " + req.Count + " uploaded";
            }

            _lifts = dtAll;
            rptAddress.DataSource = dtAll.DefaultView.ToTable(true, "SiteAddress", "AddrNo");
            rptAddress.DataBind();
        }

        protected void rptAddress_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            string addr = Convert.ToString(((DataRowView)e.Item.DataItem)["SiteAddress"]);
            DataView dv = new DataView(_lifts) { RowFilter = "SiteAddress = '" + addr.Replace("'", "''") + "'" };

            Repeater rpt = (Repeater)e.Item.FindControl("rptLifts");
            rpt.DataSource = dv;
            rpt.DataBind();
            ((Literal)e.Item.FindControl("litCount")).Text = dv.Count.ToString();
        }

        protected void rptLifts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Upload" && e.CommandName != "Edit") return;

            string[] p = Convert.ToString(e.CommandArgument).Split('|');
            if (p.Length != 2) return;

            if (LoadRecord(p[0], p[1]))
            {
                lblModalTitle.Text = e.CommandName == "Edit" ? "Edit Documents" : "Upload Documents";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openDoc", "openDocModal();", true);
            }
            else
            {
                ShowAlert("Record not found. Please try again.");
            }
        }

        private bool LoadRecord(string installationType, string registrationNo)
        {
            string createdBy = CurrentUserId;
            DataSet ds = CEI.GetRenewalLiftData(installationType, registrationNo, createdBy);
            if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                ClearSelection();
                return false;
            }
            DataRow dr = ds.Tables[0].Rows[0];

            SelectedType = installationType;
            SelectedRegNo = dr["RegistrationNo"].ToString();

            string dbPay = ToYmd(dr["LastPaymentDate"]);
            string draftPay = "";
            DraftInfo di;
            if (GetDrafts(createdBy).TryGetValue(SelectedType + "|" + SelectedRegNo, out di)) draftPay = di.LastPay;

            txtRegistrationNo.Text = SelectedRegNo;
            txtExpiryDate.Text = ToYmd(dr["ExpiryDate"]);
            txtLastdateOfPayment.Text = string.IsNullOrEmpty(dbPay) ? draftPay : dbPay;
            txtLastdateOfPayment.ReadOnly = !string.IsNullOrEmpty(dbPay);

            FillMoreInfo(dr, installationType);
            GridDocument(createdBy);
            return true;
        }

        private void ClearSelection()
        {
            SelectedType = "";
            SelectedRegNo = "";
            txtRegistrationNo.Text = "";
            txtExpiryDate.Text = "";
            txtLastdateOfPayment.Text = "";
            txtLastdateOfPayment.ReadOnly = false;
            ClearMoreInfo();
            Grd_Document.DataSource = null;
            Grd_Document.DataBind();
        }

        private string GetApplicantType(string userId)
        {
            DataSet ds = CEI.GetApplicantTypeForLift(userId);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                return ds.Tables[0].Rows[0]["ApplicantTypeCode"].ToString();
            return string.Empty;
        }

        private void GridDocument(string userId)
        {
            string applicantType = GetApplicantType(userId);
            int installationTypeID = SelectedType == "Lift" ? 4 : 10;

            DataTable dt = CEI.GetDocumentsForLiftRenewal(applicantType, installationTypeID, "Periodic", SelectedType);
            if (dt == null || dt.Rows.Count == 0)
            {
                Grd_Document.DataSource = null;
                Grd_Document.DataBind();
                ShowAlert("No Record Found for document");
                return;
            }

            dt.Columns.Add("ExistingPath", typeof(string));
            DraftInfo d;
            if (GetDrafts(userId).TryGetValue(SelectedType + "|" + SelectedRegNo, out d))
            {
                foreach (DataRow r in dt.Rows)
                {
                    string[] x;
                    if (d.Docs.TryGetValue(Convert.ToInt32(r["DocumentID"]), out x))
                        r["ExistingPath"] = x[2];
                }
            }
            Grd_Document.DataSource = dt;
            Grd_Document.DataBind();
        }

        #endregion

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("/SiteOwnerPages/LiftPeriodic.aspx", false);
        }

        #region Modal Save (draft)

        protected void btnSaveDocs_Click(object sender, EventArgs e)
        {
            string user = CurrentUserId;
            if (string.IsNullOrEmpty(user)) { Response.Redirect("/LogOut.aspx", false); return; }
            if (string.IsNullOrEmpty(SelectedRegNo) || string.IsNullOrEmpty(SelectedType))
            {
                ShowAlert("Please select a Lift/Escalator from the list.");
                return;
            }

            // ownership check (record isi user ka hona chahiye)
            DataSet ds = CEI.GetRenewalLiftData(SelectedType, SelectedRegNo, user);
            if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                ShowAlert("Record not found. Please select again.");
                return;
            }

            DateTime? lastPay = null;
            DateTime tmp;
            if (DateTime.TryParse(txtLastdateOfPayment.Text, out tmp)) lastPay = tmp;

            // 1) server-side file validation (PDF, max 1MB)
            foreach (GridViewRow row in Grd_Document.Rows)
            {
                FileUpload fu = row.FindControl("FileUpload1") as FileUpload;
                if (fu != null && fu.HasFile)
                {
                    if (Path.GetExtension(fu.FileName).ToLower() != ".pdf" || fu.PostedFile.ContentLength > 1048576)
                    {
                        ShowAlert("Only PDF files up to 1MB are allowed: " + ((Label)row.FindControl("LblDocumentName")).Text);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openDoc", "openDocModal();", true);
                        return;
                    }
                }
            }

            try
            {
                string folderPath = "/Attachment/" + user + "/" + SelectedRegNo + "/Draft";
                string absolutePath = Server.MapPath(folderPath);
                if (!Directory.Exists(absolutePath)) Directory.CreateDirectory(absolutePath);

                // 2) header (payment date) save
                CEI.SaveLiftRenewalDraft(user, SelectedRegNo, SelectedType, lastPay, null, null, null, null);

                // 3) sirf wahi files save/replace jo choose ki hain
                foreach (GridViewRow row in Grd_Document.Rows)
                {
                    FileUpload fu = row.FindControl("FileUpload1") as FileUpload;
                    if (fu == null || !fu.HasFile) continue;

                    string docId = ((Label)row.FindControl("LblDocumentID")).Text;
                    string docName = ((Label)row.FindControl("LblDocumentName")).Text;
                    string shortName = ((Label)row.FindControl("LblShortName")).Text;
                    string noExt = shortName.Contains(".pdf") ? shortName.Substring(0, shortName.IndexOf(".pdf")) : shortName;

                    string savedName = noExt + "_" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".pdf";
                    fu.PostedFile.SaveAs(Path.Combine(absolutePath, savedName));

                    CEI.SaveLiftRenewalDraft(user, SelectedRegNo, SelectedType, lastPay,
                        int.Parse(docId), docName, shortName, folderPath + "/" + savedName);
                }

                ClearSelection();
                GridtoViewAllRecords(user);
                ShowAlert("Documents saved successfully.");
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openDoc", "openDocModal();", true);
            }
        }

        #endregion

        #region Final Submit (selected + completed rows, same address)

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int clickCount = Convert.ToInt32(Session["ClickCount"]);
            if (clickCount >= 1)
            {
                string back = IsReturnedApplication ? "ReturnLiftInspections.aspx" : "LiftPeriodic.aspx";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorMessage", "alert('You double click on Button.'); window.location='" + back + "'", true);
                return;
            }

            string user = CurrentUserId;
            if (string.IsNullOrEmpty(user)) { Response.Redirect("/LogOut.aspx", false); return; }

            // 1) checked rows + same-address check
            var keys = new List<string>();
            int addrIndex = -1;
            bool mixed = false;
            foreach (RepeaterItem ai in rptAddress.Items)
            {
                Repeater rl = (Repeater)ai.FindControl("rptLifts");
                if (rl == null) continue;
                foreach (RepeaterItem li in rl.Items)
                {
                    CheckBox chk = li.FindControl("chkSel") as CheckBox;
                    if (chk == null || !chk.Checked) continue;
                    if (addrIndex == -1) addrIndex = ai.ItemIndex;
                    else if (addrIndex != ai.ItemIndex) mixed = true;
                    keys.Add(((HiddenField)li.FindControl("hfKey")).Value);
                }
            }

            if (keys.Count == 0) { ShowAlert("Please select at least one lift/escalator."); return; }
            if (mixed) { ShowAlert("Lifts at different addresses require separate inspection requests."); return; }

            // 2) har selected record ka draft complete hona chahiye
            var required = GetRequiredDocs(user);
            var drafts = GetDrafts(user);

            int ok = 0;
            var errors = new List<string>();
            var submittedKeys = new List<string>();
            foreach (string key in keys)
            {
                DraftInfo d;
                if (!drafts.TryGetValue(key, out d) || !IsComplete(d, required[d.Type]))
                {
                    errors.Add(key.Split('|')[1] + ": documents incomplete");
                    continue;
                }
                string err = SubmitOne(d, user);
                if (err == null) { ok++; submittedKeys.Add(key); } else errors.Add(err);
            }
            // LiftPeriodic page par default selection ke liye: jo records abhi submit hue (Type|RegNo)
            if (submittedKeys.Count > 0)
                Session["LastRenewalKeys"] = string.Join(";", submittedKeys.ToArray());
            if (errors.Count > 0)
            {
                GridtoViewAllRecords(user);
                ShowAlert(ok + " submitted. Failed: " + string.Join(" | ", errors.ToArray()));
                return;   // ClickCount nahi badhaya, taaki baaki dobara try ho sakein
            }

            Session["ClickCount"] = clickCount + 1;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert",
                IsReturnedApplication ? "alertWithReturnRedirectdata();" : "alertWithRedirectdata();", true);
        }

        // Ek record ka renewal insert + documents. Success par null, warna error text.
        private string SubmitOne(DraftInfo d, string user)
        {
            SqlConnection connection = null;
            SqlTransaction transaction = null;
            try
            {
                DataSet dsRec = CEI.GetRenewalLiftData(d.Type, d.RegNo, user);
                if (dsRec == null || dsRec.Tables.Count == 0 || dsRec.Tables[0].Rows.Count == 0)
                    return d.RegNo + ": record not found";
                DataRow dr = dsRec.Tables[0].Rows[0];

                string expiryDateStr = ToYmd(dr["ExpiryDate"]);
                string erectionDateStr = ToYmd(dr["ErectionDate"]);
                string memoDateStr = ToYmd(dr["MemoDate"]);
                string lastPaymentStr = ToYmd(dr["LastPaymentDate"]);
                if (string.IsNullOrEmpty(lastPaymentStr)) lastPaymentStr = d.LastPay;   // DB me khali ho to draft wali

                DateTime lastExpiryDate, erectionDate, memoDate, lastdateOfPayment;
                if (!DateTime.TryParse(expiryDateStr, out lastExpiryDate) ||
                    !DateTime.TryParse(erectionDateStr, out erectionDate) ||
                    !DateTime.TryParse(memoDateStr, out memoDate) ||
                    !DateTime.TryParse(lastPaymentStr, out lastdateOfPayment))
                    return d.RegNo + ": Last date of payment / record dates missing";

                string errorMsg;
                if (!ValidateErectionAndMemoDates(lastExpiryDate, lastdateOfPayment, erectionDate, memoDate, out errorMsg))
                    return d.RegNo + ": " + errorMsg;

                string make = dr["Make"].ToString();
                string serialNo = dr["LiftSrNo"].ToString();
                string type = dr["TypeOfLift"].ToString();
                string controlType = dr["TypeOfControl"].ToString();
                string capacity = dr["Capacity"].ToString();
                decimal weight = 0.0m;
                decimal.TryParse(dr["Weight"].ToString(), out weight);
                string districtValue = dr["District"].ToString();
                string memoNo = dr["MemoNo"].ToString();
                string siteAddress = dr["SiteAddress"].ToString();

                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString());
                connection.Open();
                transaction = connection.BeginTransaction();

                string TRID;
                if (!IsReturnedApplication)
                {
                    TRID = CEI.InsertPeriodicLiftData(d.Type, d.RegNo, expiryDateStr, "", lastPaymentStr, erectionDateStr,
                        make, serialNo, type, controlType, capacity, weight, districtValue, memoNo, memoDateStr,
                        siteAddress, user, transaction);
                }
                else
                {
                    string TestReportId = Session["EscalatorTestReportID"].ToString();
                    int InspectionId = int.Parse(Session["InspectionId"].ToString());
                    DataTable dt = CEI.InsertReturnPeriodicLiftData(TestReportId, d.Type, d.RegNo, expiryDateStr, "",
                        lastPaymentStr, erectionDateStr, make, serialNo, type, controlType, capacity, weight,
                        districtValue, memoNo, memoDateStr, siteAddress, InspectionId, user);
                    TRID = dt.Rows[0]["TestReportId"].ToString();
                }

                foreach (var doc in d.Docs)
                {
                    // x[0]=DocumentName, x[1]=short FileName, x[2]=saved path
                    CEI.UploadDocumentforLiftPeriodic(TRID, d.RegNo, d.Type, doc.Key.ToString(),
                        doc.Value[0], doc.Value[1], doc.Value[2], user, transaction);
                }

                transaction.Commit();
                CEI.DeleteLiftRenewalDraft(user, d.RegNo, d.Type);
                return null;
            }
            catch (Exception ex)
            {
                if (transaction != null) transaction.Rollback();
                return d.RegNo + ": " + ex.Message;
            }
            finally
            {
                if (connection != null && connection.State == ConnectionState.Open) connection.Close();
            }
        }

        private bool ValidateErectionAndMemoDates(DateTime Lastexpirydate, DateTime LastApprovalDate, DateTime erectionDate, DateTime memoDate, out string errorMsg)
        {
            errorMsg = "";
            DateTime currentDate = DateTime.Today;
            DateTime twentyYearsAgo = currentDate.AddYears(-20);
            if (erectionDate < twentyYearsAgo)
            {
                errorMsg = "You are not eligible for renewal. As your Erection date is more than 20 years old.";
                return false;
            }

            if (erectionDate >= memoDate)
            {
                errorMsg = "Date of Erection must be smaller than Memo Date.";
                return false;
            }
            //2 date checks added by navneet on instructions of vinod sir
            if (Lastexpirydate <= LastApprovalDate)
            {
                errorMsg = "Date of Renewal must be Greater than or equal to Last date of payment";
                return false;
            }

            return true;
        }

        #endregion

        #region Helpers

        private string ToYmd(object value)
        {
            DateTime dt;
            return DateTime.TryParse(Convert.ToString(value), out dt) ? dt.ToString("yyyy-MM-dd") : "";
        }

        private string ToDmy(object value)
        {
            DateTime dt;
            return DateTime.TryParse(Convert.ToString(value), out dt) ? dt.ToString("dd-MM-yyyy") : "";
        }

        // "More Info" popup: sirf display ke liye. Label.Text HTML-encode nahi karta, isliye Server.HtmlEncode.
        private void FillMoreInfo(DataRow dr, string installationType)
        {
            lblInfoInstallationType.Text = Server.HtmlEncode(installationType);
            lblInfoMake.Text = Server.HtmlEncode(dr["Make"].ToString());
            lblInfoSerialNo.Text = Server.HtmlEncode(dr["LiftSrNo"].ToString());
            lblInfoType.Text = Server.HtmlEncode(dr["TypeOfLift"].ToString());
            lblInfoControl.Text = Server.HtmlEncode(dr["TypeOfControl"].ToString());
            lblInfoErection.Text = ToDmy(dr["ErectionDate"]);
            lblInfoCapacity.Text = Server.HtmlEncode(dr["Capacity"].ToString());
            lblInfoWeight.Text = Server.HtmlEncode(dr["Weight"].ToString());
            lblInfoDistrict.Text = Server.HtmlEncode(dr["District"].ToString());
            lblInfoMemoNo.Text = Server.HtmlEncode(dr["MemoNo"].ToString());
            lblInfoMemoDate.Text = ToDmy(dr["MemoDate"]);
            lblInfoSiteAddress.Text = Server.HtmlEncode(dr["SiteAddress"].ToString());
        }

        private void ClearMoreInfo()
        {
            Label[] labels =
            {
                lblInfoInstallationType, lblInfoMake, lblInfoSerialNo, lblInfoType,
                lblInfoControl, lblInfoErection, lblInfoCapacity, lblInfoWeight,
                lblInfoDistrict, lblInfoMemoNo, lblInfoMemoDate, lblInfoSiteAddress
            };
            foreach (Label l in labels)
            {
                l.Text = "";
            }
        }

        // JS alert me quotes / new lines se script na toote
        private static string JsSafe(string s)
        {
            return (s ?? "").Replace("\\", "\\\\").Replace("'", "\\'").Replace("\r", " ").Replace("\n", " ");
        }

        private void ShowAlert(string message)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert" + Guid.NewGuid().ToString("N"), "alert('" + JsSafe(message) + "');", true);
        }

        #endregion

    }
}
