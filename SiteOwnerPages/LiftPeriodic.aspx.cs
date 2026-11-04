using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using CEI_PRoject;
using Pipelines.Sockets.Unofficial.Buffers;

namespace CEIHaryana.SiteOwnerPages
{
    public partial class LiftPeriodic : System.Web.UI.Page
    {
        //Page Created By Neha 
        CEI CEI = new CEI();
        //private static string Category, InspectionType, PaymentMode;
        private static string Category, InspectionType;
        string InstallationId = string.Empty;
        private int totalQuantity = 0;
        private decimal totalAmountSum = 0;
        int ServiceType = 0;
        List<(string Installtypes, string DocumentID, string DocSaveName, string FileName, string FilePath)> uploadedFiles = new List<(string, string, string, string, string)>();

        // Abhi selected district (default: latest CreatedDate wala). ViewState = signed, client edit nahi kar sakta.
        private string SelectedDistrict
        {
            get { return Convert.ToString(ViewState["SelectedDistrict"]); }
            set { ViewState["SelectedDistrict"] = value; }
        }

        private string CurrentUserId
        {
            get { return Convert.ToString(Session["SiteOwnerId"]); }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Convert.ToString(Session["SiteOwnerId"]) != null && Convert.ToString(Session["SiteOwnerId"]) != "")
                    {
                                String UserId = Convert.ToString(Session["SiteOwnerId"]);
                                HdnUserID.Value = UserId;
                                Session["RegistrationNosessionPass"] = null;
                                Session["InstallTypePass"] = null;
                                Session["ReturnedValue"] = "Treys";
                                Session["Duplicacy"] = "0";   // pehle ddlDistrict change par set hota tha
                                GridBind(UserId);

                    }
                    else
                    {
                        Session["SiteOwnerId"] = "";
                        Response.Redirect("/LogOut.aspx", false);
                    }
                }
          }
            catch
            {
                Session["SiteOwnerId"] = "";
                Response.Redirect("/LogOut.aspx", false);
            }
        }

        protected void btnAddnew_Click(object sender, EventArgs e)
        {
            Session["ReturnedValue"] = "Treys";
            Response.Redirect("/SiteOwnerPages/LiftPeriodicRenewal.aspx", false);
        }

        #region Grid (district -> address -> lifts)

        private DataTable _lifts;

        private static bool SameDistrict(string a, string b)
        {
            return string.Equals((a ?? "").Trim(), (b ?? "").Trim(), StringComparison.OrdinalIgnoreCase);
        }

        private static string DistrictFilter(string d)
        {
            return "ApplicantDistrict = '" + d.Replace("'", "''") + "'";
        }

        // Ek time me sirf ek district dikhta hai (pichle page wala, warna latest add hua)
        private void GridBind(string SiteOwnerId)
        {
            string latest = CEI.GetLatestLiftRenewalDistrict(SiteOwnerId);
            DataTable dt = CEI.GetDataForLiftRenewal(null, SiteOwnerId);

            if (dt == null || dt.Rows.Count == 0)
            {
                SelectedDistrict = "";
                //lblSelDistrict.Text = "-";
                rptDistrict.DataSource = null;
                rptDistrict.DataBind();
                pnlDistrictInfo.Visible = rptDistrict.Items.Count > 0;
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", "alert('No Record Found for document');", true);
                return;
            }

            if (!dt.Columns.Contains("SiteAddress")) dt.Columns.Add("SiteAddress", typeof(string));
            dt.Columns.Add("AddrNo", typeof(int));

            // Address number har district me 1 se shuru
            var addrNo = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
            var perDistrict = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
            var districts = new List<string>();
            foreach (DataRow r in dt.Rows)
            {
                string dist = Convert.ToString(r["ApplicantDistrict"]).Trim();
                if (dist == "") dist = "Unknown";
                r["ApplicantDistrict"] = dist;

                string addr = Convert.ToString(r["SiteAddress"]).Trim();
                if (addr == "") addr = "Address not available";
                r["SiteAddress"] = addr;

                if (!districts.Exists(x => SameDistrict(x, dist))) districts.Add(dist);

                string key = dist + "|" + addr;
                if (!addrNo.ContainsKey(key))
                {
                    int n;
                    perDistrict.TryGetValue(dist, out n);
                    perDistrict[dist] = n + 1;
                    addrNo[key] = n + 1;
                }
                r["AddrNo"] = addrNo[key];
            }

            // Pichle page (LiftPeriodicRenewalExistingAll) se aaye records: Session["LastRenewalKeys"] = "Type|RegNo;Type|RegNo"
            var carried = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            foreach (string k in Convert.ToString(Session["LastRenewalKeys"]).Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries))
                carried.Add(k.Trim());

            // un me se jo abhi pending grid me hain, unka district (latest district me ho to wahi)
            var carriedInGrid = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            string carriedDistrict = null;
            if (carried.Count > 0)
            {
                foreach (DataRow r in dt.Rows)
                {
                    string rk = Convert.ToString(r["InstallationType"]) + "|" + Convert.ToString(r["RegistrationNo"]);
                    if (!carried.Contains(rk)) continue;
                    string rd = Convert.ToString(r["ApplicantDistrict"]);
                    if (carriedDistrict == null) carriedDistrict = rd;
                    else if (!SameDistrict(carriedDistrict, latest) && SameDistrict(rd, latest)) carriedDistrict = rd;
                }
                if (carriedDistrict != null)
                {
                    foreach (DataRow r in dt.Rows)
                    {
                        string rk = Convert.ToString(r["InstallationType"]) + "|" + Convert.ToString(r["RegistrationNo"]);
                        if (carried.Contains(rk) && SameDistrict(Convert.ToString(r["ApplicantDistrict"]), carriedDistrict))
                            carriedInGrid.Add(rk);
                    }
                    latest = carriedDistrict;   // ye records jis district ke hain wo upar dikhe
                }
            }

            // Latest district pehle, baaki alphabetical
            if (string.IsNullOrEmpty(latest) || !districts.Exists(x => SameDistrict(x, latest)))
                latest = districts[0];

            // Sirf ek district dikhana hai: pichle page ke records ka district, warna last add hue record ka district
            for (int i = dt.Rows.Count - 1; i >= 0; i--)
            {
                if (!SameDistrict(Convert.ToString(dt.Rows[i]["ApplicantDistrict"]), latest))
                    dt.Rows[i].Delete();
            }
            dt.AcceptChanges();
            districts.Clear();
            districts.Add(latest);

            DataTable dtDist = new DataTable();
            dtDist.Columns.Add("District", typeof(string));
            dtDist.Columns.Add("IsLatest", typeof(bool));
            foreach (string d in districts)
                dtDist.Rows.Add(d, SameDistrict(d, latest));

            _lifts = dt;
            rptDistrict.DataSource = dtDist;
            rptDistrict.DataBind();
            pnlDistrictInfo.Visible = rptDistrict.Items.Count > 0;

            // 1st priority: pichle page se aaye wahi records hi tick
            if (carriedInGrid.Count > 0)
            {
                SetDistrictSelection(latest, carriedInGrid);
                ApplySelection();
                return;
            }

            // Session me kuch nahi: koi bhi selected nahi, user ko khud select karna hai; saare checkbox enabled
            SelectedDistrict = "";
            ApplySelection(false);
        }

        protected void rptDistrict_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            string d = Convert.ToString(((DataRowView)e.Item.DataItem)["District"]);
            DataView dv = new DataView(_lifts) { RowFilter = DistrictFilter(d) };

            Repeater ra = (Repeater)e.Item.FindControl("rptAddress");
            ra.DataSource = dv.ToTable(true, "SiteAddress", "AddrNo", "ApplicantDistrict");
            ra.DataBind();
            ((Literal)e.Item.FindControl("litDistCount")).Text = dv.Count.ToString();
        }

        protected void rptAddress_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            DataRowView drv = (DataRowView)e.Item.DataItem;
            string d = Convert.ToString(drv["ApplicantDistrict"]);
            string addr = Convert.ToString(drv["SiteAddress"]);
            DataView dv = new DataView(_lifts)
            {
                RowFilter = DistrictFilter(d) + " AND SiteAddress = '" + addr.Replace("'", "''") + "'"
            };

            Repeater rpt = (Repeater)e.Item.FindControl("rptLifts");
            rpt.DataSource = dv;
            rpt.DataBind();
            ((Literal)e.Item.FindControl("litCount")).Text = dv.Count.ToString();
        }

        // Saari lift/escalator rows (sab districts / addresses ki) ek list me
        private List<RepeaterItem> GetLiftItems()
        {
            var list = new List<RepeaterItem>();
            foreach (RepeaterItem di in rptDistrict.Items)
            {
                Repeater ra = di.FindControl("rptAddress") as Repeater;
                if (ra == null) continue;
                foreach (RepeaterItem ai in ra.Items)
                {
                    Repeater rl = ai.FindControl("rptLifts") as Repeater;
                    if (rl == null) continue;
                    foreach (RepeaterItem li in rl.Items)
                    {
                        if (li.ItemType == ListItemType.Item || li.ItemType == ListItemType.AlternatingItem)
                            list.Add(li);
                    }
                }
            }
            return list;
        }

        // Koi selection nahi: saare districts ke checkbox enabled + untick
        private void ClearDistrictSelection()
        {
            SelectedDistrict = "";
            lblSelCount.Text = "0";

            foreach (RepeaterItem li in GetLiftItems())
            {
                CheckBox chk = (CheckBox)li.FindControl("CheckBox1");
                chk.Checked = false;
                chk.Enabled = true;
                HtmlTableRow tr = li.FindControl("trRow") as HtmlTableRow;
                if (tr != null) tr.Attributes["class"] = "";
            }
            foreach (RepeaterItem di in rptDistrict.Items)
            {
                ((LinkButton)di.FindControl("lnkSelDistrict")).Visible = true;
                ((Label)di.FindControl("lblSelBadge")).Visible = false;
            }
        }

        // Ek district select karo: us district ki rows enabled, baaki disabled.
        // keys (Type|RegNo) diye hon to sirf wahi rows tick, warna district ki saari rows tick.
        private void SetDistrictSelection(string district, HashSet<string> keys = null)
        {
            SelectedDistrict = district;
            //lblSelDistrict.Text = Server.HtmlEncode(district);

            foreach (RepeaterItem li in GetLiftItems())
            {
                CheckBox chk = (CheckBox)li.FindControl("CheckBox1");
                bool inD = SameDistrict(((HiddenField)li.FindControl("hfRowDistrict")).Value, district);
                bool keyOk = keys == null ||
                    keys.Contains(((HiddenField)li.FindControl("hfCategory")).Value + "|" + ((HiddenField)li.FindControl("hfRegNo")).Value);
                chk.Checked = inD && keyOk;
                chk.Enabled = inD;
            }

            foreach (RepeaterItem di in rptDistrict.Items)
            {
                bool sel = SameDistrict(((HiddenField)di.FindControl("hfDistrict")).Value, district);
                ((LinkButton)di.FindControl("lnkSelDistrict")).Visible = !sel;
                ((Label)di.FindControl("lblSelBadge")).Visible = sel;
            }
        }

        protected void rptDistrict_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectDistrict")
            {
                SetDistrictSelection(Convert.ToString(e.CommandArgument));
                ApplySelection();
            }
        }

        protected void rptLifts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string reg = ((HiddenField)e.Item.FindControl("hfRegNo")).Value;
                string category = ((HiddenField)e.Item.FindControl("hfCategory")).Value;
                string testReportId = ((HiddenField)e.Item.FindControl("hfTestReportID")).Value;

                Session["RegistrationNo"] = reg;
                Session["TestReportID"] = testReportId;

                if (category == "Lift")
                {
                    Response.Redirect("/TestReportModal/LiftPeriodicTestReportModal.aspx", false);
                }
                else if (category == "Escalator")
                {
                    Response.Redirect("/TestReportModal/EscalatorPeriodicTestReportModal.aspx", false);
                }
            }
        }

        #endregion

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                CheckBox chk = (CheckBox)sender;
                RepeaterItem row = chk.NamingContainer as RepeaterItem;
                if (row != null && chk.Checked)
                {
                    string rowDist = ((HiddenField)row.FindControl("hfRowDistrict")).Value;
                    if (!SameDistrict(rowDist, SelectedDistrict))
                    {
                        // Naye district ki lift tick hui: ek request me ek hi district, isliye baaki districts ki ticks hata do
                        string key = ((HiddenField)row.FindControl("hfCategory")).Value + "|" + ((HiddenField)row.FindControl("hfRegNo")).Value;
                        SetDistrictSelection(rowDist, new HashSet<string>(new[] { key }, StringComparer.OrdinalIgnoreCase));
                    }
                }
                ApplySelection();
            }
            catch (Exception ex)
            { }
        }

        // Selected district ki ticked rows ko inspection ke liye mark karo, baaki ko unmark; fees + documents section update
        private void ApplySelection(bool alertIfNone = true)
        {
            string SiteOwnerId = CurrentUserId;
            if (string.IsNullOrEmpty(SiteOwnerId)) return;

            int liftCount = 0;
            int EscalatorCount = 0;
            int LiftCountForPayment = 0;
            int EscalatorCountForPayment = 0;
            string selectedTypes = string.Empty;
            var instIds = new Dictionary<string, string>();

            foreach (RepeaterItem rows in GetLiftItems())
            {
                CheckBox chk = (CheckBox)rows.FindControl("CheckBox1");
                HtmlTableRow tr = rows.FindControl("trRow") as HtmlTableRow;
                string type = ((HiddenField)rows.FindControl("hfCategory")).Value;
                string reg = ((HiddenField)rows.FindControl("hfRegNo")).Value;
                string amountText = ((HiddenField)rows.FindControl("hfAmount")).Value;
                bool inSelected = SameDistrict(((HiddenField)rows.FindControl("hfRowDistrict")).Value, SelectedDistrict);

                if (chk.Checked && inSelected)
                {
                    if (type == "Lift") liftCount++;
                    else if (type == "Escalator") EscalatorCount++;

                    if (type == "Lift" && !selectedTypes.Contains("4")) selectedTypes += "4,";
                    else if (type == "Escalator" && !selectedTypes.Contains("10")) selectedTypes += "10,";

                    decimal Amount;
                    if (decimal.TryParse(amountText, out Amount) && Amount > 0.00m)
                    {
                        if (type == "Lift") LiftCountForPayment++;
                        else if (type == "Escalator") EscalatorCountForPayment++;
                    }

                    string id;
                    if (!instIds.TryGetValue(type, out id))
                    {
                        DataTable dtc = CEI.GetApplicantCode(type);
                        id = dtc.Rows.Count > 0 ? dtc.Rows[0]["Id"].ToString() : "";
                        instIds[type] = id;
                    }
                    if (id != "")
                    {
                        CEI.Update_LiftRenewalPeriodicInspection(reg, int.Parse(id), SiteOwnerId);
                    }
                    if (tr != null) tr.Attributes["class"] = "row-selected";
                }
                else
                {
                    chk.Checked = false;
                    CEI.TohandleUncheckedCheckbox(reg, SiteOwnerId);
                    if (tr != null) tr.Attributes["class"] = (!string.IsNullOrEmpty(SelectedDistrict) && !inSelected) ? "row-disabled" : "";
                }
            }

            lblSelCount.Text = (liftCount + EscalatorCount).ToString();
            Session["Duplicacy"] = "1";
            InspectionType = "Periodic";

            if (liftCount + EscalatorCount == 0)
            {
                ClearDistrictSelection();   // kuch bhi tick nahi: saare checkbox phir se enabled
                FeesDetails.Visible = false;
                PaymentDetails.Visible = false;
                btnSubmit.Visible = false;
                btnReset.Visible = false;
                UploadDocuments.Visible = false;
                InspectionRemarks.Visible = false;
                if (alertIfNone)
                    ScriptManager.RegisterStartupScript(this, GetType(), "serverscript", "alert(\"Please check atleast One checkbox\");", true);
                return;
            }

            TotalPayment.Visible = true;
            ChallanDetail.Visible = true;
            FeesDetails.Visible = true;
            PaymentDetails.Visible = true;
            btnSubmit.Visible = true;
            btnReset.Visible = true;

            if (selectedTypes.EndsWith(","))
            {
                selectedTypes = selectedTypes.Substring(0, selectedTypes.Length - 1);
            }
            PaymentGridViewBind(selectedTypes, liftCount, EscalatorCount, LiftCountForPayment, EscalatorCountForPayment);

            string Installationtypes = string.Empty;
            if (liftCount == 0 && EscalatorCount == 1) Installationtypes = "Escalator";
            else if (liftCount == 1 && EscalatorCount == 0) Installationtypes = "Lift";
            else if (liftCount >= 1) Installationtypes = EscalatorCount >= 1 ? "Lift/Escalator" : "MultiLift";
            else if (EscalatorCount >= 1) Installationtypes = "MultiEscalator";
            hdnInstallationType.Value = Installationtypes;

            UploadDocuments.Visible = true;
            btnSubmit.Visible = true;
            InspectionRemarks.Visible = true;
        }

        protected void GridViewPayment_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int quantity = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Quantity"));
                decimal totalAmount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalAmount"));
                // Update the footer totals
                totalQuantity += quantity;
                totalAmountSum += Convert.ToDecimal(totalAmount);

            }
            // Check if the row is a footer row to display the totals
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblFooterQuantity = (Label)e.Row.FindControl("lblFooterQuantity");
                Label lblFooterAmount = (Label)e.Row.FindControl("lblFooterAmount");

                lblFooterQuantity.Text = totalQuantity.ToString();

                decimal formattedAmount = Math.Round(totalAmountSum, 2);

                lblFooterAmount.Text = formattedAmount.ToString("F2");  // Display amount with 2 decimal places
                Session["Amount"] = lblFooterAmount.Text;
                if (!string.IsNullOrEmpty(lblFooterAmount.Text) && decimal.TryParse(lblFooterAmount.Text, out decimal footerAmount)
                    && footerAmount > 0)
                {
                    BindGridDocumentsBind();
                    PaymentDetails.Visible = true;
                }
                else
                {
                    BindDocumentGridwithOutChallan();
                    PaymentDetails.Visible = false;
                }
            }
        }
        private void BindGridDocumentsBind()
        {
            DataTable ds = new DataTable();
            ds = CEI.GetDocumentforLiftPeriodicRenewal();
            if (ds.Rows.Count > 0)
            {
                Grd_Document.DataSource = ds;
                Grd_Document.DataBind();
            }
            else
            {
                Grd_Document.DataSource = null;
                Grd_Document.DataBind();
                string script = "alert(\"No Record Found for document \");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
            ds.Dispose();
        }
        private void BindDocumentGridwithOutChallan()
        {
            DataTable ds = new DataTable();
            ds = CEI.Get_DocumentGridwithOutChallan();
            if (ds.Rows.Count > 0)
            {
                Grd_Document.DataSource = ds;
                Grd_Document.DataBind();
            }
            else
            {
                Grd_Document.DataSource = null;
                Grd_Document.DataBind();
                string script = "alert(\"No Record Found for document \");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
            ds.Dispose();
        }
        protected void PaymentGridViewBind(string selectedType, int LiftCount, int EscaltorCount, int LiftCountForPayment, int EscalatorCountForPayment)
        {
            try
            {
                DataTable dsa = new DataTable();
                dsa = CEI.Payment_LiftPeriodic(selectedType, LiftCount, EscaltorCount, LiftCountForPayment, EscalatorCountForPayment);
                if (dsa.Rows.Count > 0 && dsa != null)
                {
                    GridViewPayment.DataSource = dsa;
                    GridViewPayment.DataBind();
                }
                else
                {
                    GridViewPayment.DataSource = null;
                    GridViewPayment.DataBind();
                    string script = "alert(\"Please check atleast One checkbox\");";
                    ScriptManager.RegisterStartupScript(this, GetType(), "serverscript", script, true);

                    FeesDetails.Visible = false;
                    PaymentDetails.Visible = false;
                    btnSubmit.Visible = false;
                    btnReset.Visible = false;
                    UploadDocuments.Visible = false;
                    InspectionRemarks.Visible = false;
                }
                dsa.Dispose();
            }
            catch (Exception ex)
            {
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Convert.ToString(Session["SiteOwnerId"]) != null && Convert.ToString(Session["SiteOwnerId"]) != "")
            {
                string CreatedBy = Session["SiteOwnerId"].ToString();
                try
                {
                    bool atLeastOneInspectionChecked = false;
                    bool isFileUploadValid = true;
                    bool mixedDistrict = false;
                    foreach (RepeaterItem rows in GetLiftItems())
                    {
                        CheckBox chk = (CheckBox)rows.FindControl("CheckBox1");

                        if (chk != null && chk.Checked)
                        {
                            atLeastOneInspectionChecked = true;
                            if (!SameDistrict(((HiddenField)rows.FindControl("hfRowDistrict")).Value, SelectedDistrict))
                                mixedDistrict = true;
                        }
                    }
                    if (mixedDistrict)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('One inspection request can include lifts of one district only.')", true);
                        return;
                    }
                    if (atLeastOneInspectionChecked)
                    {

                        foreach (GridViewRow row in Grd_Document.Rows)
                        {
                            // Get the label that holds the document name
                            Label LblDocumentName = (Label)row.FindControl("LblDocumentName");

                            if (LblDocumentName != null)
                            {
                                string documentName = LblDocumentName.Text.Trim();

                                // Only check for file uploads if the document is not "Other Document"
                                if (documentName != "Other Document")
                                {
                                    FileUpload fileUpload = (FileUpload)row.FindControl("FileUpload1");

                                    if (fileUpload != null && !fileUpload.HasFile)
                                    {
                                        isFileUploadValid = false;  // Set flag to false if no file is uploaded
                                        break;  // Exit loop once invalid file upload is detected
                                    }
                                }
                            }
                        }

                        if (!isFileUploadValid)
                        {
                            // If any mandatory file upload is missing, show an alert and stop the submission
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('Please upload Treasury Challan.')", true);
                            return;
                        }

                        string lblCategory = string.Empty;

                        if (hdnInstallationType.Value != null && hdnInstallationType.Value != "")
                        {
                            lblCategory = hdnInstallationType.Value;
                        }
                        else
                        {
                            return;
                        }

                        // District: jo district selected hai (default latest), ViewState me saved
                        string District = SelectedDistrict;
                        if (string.IsNullOrEmpty(District))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('District not found. Please reload the page.')", true);
                            return;
                        }
                        string PaymentMode = string.Empty;
                        string Division = string.Empty;
                        DataSet ds = new DataSet();
                        ds = CEI.GetDivisionByDistrict(District);
                        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            Division = ds.Tables[0].Rows[0]["Area"].ToString();
                        }
                        decimal TotalAmount = 0;
                        string transcationId = string.Empty;
                        string TranscationDate = string.Empty;
                        TotalAmount = Convert.ToDecimal(Session["Amount"]);

                        string Assigned = string.Empty;
                        string InstallationTypeID = string.Empty;

                        if (ChallanDetail.Visible == true)
                        {
                            if (txttransactionId.Text != "")
                            {
                                transcationId = txttransactionId.Text.Trim();
                                TranscationDate = txttransactionDate.Text;
                            }
                            else
                            {
                                txttransactionDate.Focus();
                                txttransactionId.Focus();
                                return;
                            }
                        }
                        string ApplicantType = string.Empty;

                        DataSet dsa = new DataSet();
                        dsa = CEI.GetApplicantTypeForLift(Session["SiteOwnerId"].ToString());
                        ApplicantType = dsa.Tables[0].Rows[0]["ApplicantType"].ToString();

                        if (RadioButtonList2.SelectedValue != null)
                        {
                            PaymentMode = RadioButtonList2.SelectedItem.ToString();
                        }
                        ServiceType = 4;
                        DataSet dsp = new DataSet();
                        dsp = CEI.ToGetStaffIdforPeriodic(Division, "XEN", District);
                        if (dsp.Tables.Count > 0 && dsp.Tables[0].Rows.Count > 0)
                        {
                            Assigned = dsp.Tables[0].Rows[0]["StaffUserId"].ToString();
                        }
                        InstallationTypeID = "10";
                        int inspectionId = 0;
                        if (string.IsNullOrEmpty(InspectionIdClientSideCheckedRow.Value))
                        {
                            inspectionId = 0;
                        }
                        else
                        {
                            inspectionId = Convert.ToInt32(InspectionIdClientSideCheckedRow.Value);
                        }

                        InsertFilesIntoDatabase(InstallationTypeID, CreatedBy, ApplicantType, lblCategory.Trim(), District, Division, PaymentMode,
                   txtInspectionRemarks.Text.Trim(), CreatedBy, TotalAmount, Assigned, transcationId, TranscationDate,
                   inspectionId, ServiceType);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('Please First tick the any one installation for inspection')", true);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert()", "alert('" + ex.Message.ToString() + "')", true);
                    return;
                }
            }
        }
        public void InsertFilesIntoDatabase(string InstallationTypeID, string para_CreatedBy, string para_ApplicantType, string para_lblCategory, string para_District,
            string para_To, string para_PaymentMode, string para_txtInspectionRemarks, string para_CreatedByy, decimal para_TotalAmount,
            string para_Assigned, string para_transcationId, string para_TranscationDate, int para_InspectID,
               int ServiceType)
        {
            bool isInsertSuccessful = true;
            // Insert the uploaded files into the database
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ToString();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();
                try
                {
                    Session["Duplicacy"] = "2";
                    string InspectionId = CEI.InsertInspectionDataForPeriodic_LiftInspection(para_ApplicantType, para_lblCategory, para_District,
                        para_To, para_PaymentMode, para_txtInspectionRemarks, para_CreatedByy, para_TotalAmount, para_Assigned, para_transcationId, para_TranscationDate, para_InspectID, ServiceType, transaction);
                    Session["PrintInspectionID"] = InspectionId;
                    UploadCheckListDocInCollection(para_lblCategory, para_CreatedByy, para_lblCategory, InspectionId);

                    foreach (var file in uploadedFiles)
                    {
                        string query = "sp_InsertInspectionAttachments";
                        using (SqlCommand command = new SqlCommand(query, connection, transaction))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.AddWithValue("@InspectionId", InspectionId);
                            command.Parameters.AddWithValue("@InstallationType", file.Installtypes);
                            command.Parameters.AddWithValue("@DocumentID", file.DocumentID);
                            command.Parameters.AddWithValue("@DocSaveName", file.DocSaveName);
                            command.Parameters.AddWithValue("@FileName", file.FileName);
                            command.Parameters.AddWithValue("@FilePath", file.FilePath);
                            command.Parameters.AddWithValue("@CreatedBy", para_CreatedBy);
                            command.ExecuteNonQuery();
                        }
                    }
                    transaction.Commit();
                    Session["LastRenewalKeys"] = null;   // default selection ka kaam khatam
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alertWithRedirectdata();", true);

                }
                catch (Exception ex)
                {
                    isInsertSuccessful = false;
                    if (ex.Message == "Please Upload Pdf Files Only")
                    {
                        transaction.Rollback();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('" + ex.Message.ToString() + "')", true);
                        return;
                    }
                    else if (ex.Message == "Please Upload Pdf Files Less Than 1 Mb Only")
                    {
                        transaction.Rollback();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('" + ex.Message.ToString() + "')", true);
                    }
                    else if (ex.Message.Contains(" is mandatory to upload."))
                    {
                        transaction.Rollback();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('" + ex.Message.ToString() + "')", true);
                    }
                    else
                    {
                        transaction.Rollback();
                        //Commented below to raise errors as per backend                       
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('" + ex.Message.ToString() + "')", true);
                    }
                }
                finally
                {
                    connection.Close();
                }

            }
        }
        public void UploadCheckListDocInCollection(string Category, string CreatedByy, string InstallTypes, string InspectionId)
        {
            if (InstallTypes == "Lift/Escalator")
            {
                InstallTypes = "Lift_Escalator";
            }

            foreach (GridViewRow row in Grd_Document.Rows)
            {
                FileUpload fileUpload = (FileUpload)row.FindControl("FileUpload1");
                string DocSaveName = ((HtmlInputHidden)row.FindControl("DocumentShortName")).Value.Replace("\r\n", "");
                string DocumentID = ((HtmlInputHidden)row.FindControl("DocumentID")).Value.Replace("\r\n", "");
                string DocName = row.Cells[1].Text.Replace("\r\n", "");


                if (fileUpload.HasFile)
                {
                    string CreatedBy = CreatedByy;
                    if (Path.GetExtension(fileUpload.FileName).ToLower() == ".pdf")
                    {
                        if (fileUpload.PostedFile.ContentLength <= 1048576)
                        {
                            string FileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                            if (!Directory.Exists(Server.MapPath("~/Attachment/" + CreatedBy + "/" + InspectionId + "/" + InstallTypes + "/")))
                            {
                                Directory.CreateDirectory(Server.MapPath("~/Attachment/" + CreatedBy + "/" + InspectionId + "/" + InstallTypes + "/"));
                            }
                            string ext = fileUpload.PostedFile.FileName.Split('.')[1];
                            string path = "";
                            path = "/Attachment/" + CreatedBy + "/" + InspectionId + "/" + InstallTypes + "/";
                            string fileName = DocSaveName + DateTime.Now.ToString("yyyyMMddHHmmssFFF") + ".pdf";

                            string filePathInfo2 = "";

                            filePathInfo2 = Server.MapPath("~/Attachment/" + CreatedBy + "/" + InspectionId + "/" + InstallTypes + "/" + fileName);
                            fileUpload.PostedFile.SaveAs(filePathInfo2);
                            uploadedFiles.Add((Category, DocumentID, DocName, fileName, path + fileName));
                        }
                        else
                        {
                            throw new Exception("Please Upload Pdf Files Less Than 1 Mb Only");
                        }
                    }
                    else
                    {
                        throw new Exception("Please Upload Pdf Files Only");
                    }
                }
            }
        }
    }
}
