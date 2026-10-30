using CEI_PRoject;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CEIHaryana.SiteOwnerPages
{
    public partial class SiteOwnerDashboard : System.Web.UI.Page
    {
        CEI cei = new CEI();
        string LoginId = string.Empty;
        string RegNo = string.Empty, LoginToken = string.Empty;
        #region On Page Init
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            Response.Buffer = true;
            Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
            Response.Cache.SetExpires(DateTime.Now.AddDays(-1));
            Response.Expires = 0;
            Response.CacheControl = "no-cache";
            Response.Cache.SetNoStore();

            if (!string.IsNullOrEmpty(Convert.ToString(Session["SiteOwnerId"])) && !string.IsNullOrEmpty(Convert.ToString(Session["LoginToken"])))
            {
                RegNo = Session["SiteOwnerId"].ToString();
                LoginToken = Session["LoginToken"].ToString();
                string currentSessionId = Session.SessionID;

                string dbSessionId = cei.GetSessionIdFromDB(RegNo);

                if (dbSessionId != currentSessionId)
                {
                    Session.Abandon();
                    Response.Redirect("/SiteOwnerLogout.aspx", false);
                }

                string DBToken = cei.GetUserToken(RegNo);
                if (LoginToken != DBToken)
                {
                    Session.Abandon();
                    Response.Redirect("/SiteOwnerLogout.aspx", false);
                }

            }
        }
        #endregion

        /// <summary>
        /// Page Load
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (!string.IsNullOrEmpty(Convert.ToString(Session["SiteOwnerId"])) && !string.IsNullOrEmpty(Convert.ToString(Session["LoginToken"])))
                    {

                        RegNo = Session["SiteOwnerId"].ToString();
                        LoginToken = Session["LoginToken"].ToString();
                        string currentSessionId = Session.SessionID;

                        string dbSessionId = cei.GetSessionIdFromDB(RegNo);

                        if (dbSessionId != currentSessionId)
                        {
                            Session.Abandon();
                            Response.Redirect("/SiteOwnerLogout.aspx", false);
                        }

                        string DBToken = cei.GetUserToken(RegNo);
                        if (LoginToken == DBToken)
                        {
                            string sKey = RegNo;
                            string sUser = Convert.ToString(Cache[sKey]);
                            if (sUser == RegNo)
                            {
                                GetDataforSiteowner();
                                Session["PerviewPage"] = null;
                                GetAllCount();
                            }
                            else
                            {
                                Session["SiteOwnerId"] = "";
                                Response.Redirect("/SiteOwnerLogout.aspx");
                            }
                        }
                        else
                        {
                            //Token mismatch
                            Session["SiteOwnerId"] = "";
                            Response.Redirect("/SiteOwnerLogout.aspx", false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error Message " + ex.Message.ToString());
                throw;
            }
        }

        /// <summary>
        /// Get All Count for all equipment types
        /// </summary>
        private void GetAllCount()
        {
            try
            {
                LoginId = Session["SiteOwnerId"].ToString();
                DataSet ds = new DataSet();
                ds = cei.GetAllCounts(LoginId, 1);

                #region Substation Transformer data binding
                TotalSubstationTransformer.Text = ds.Tables[0].Rows[0]["TotalCount"].ToString();
                //TotalActiveSubstationTransformer.Text = ds.Tables[0].Rows[0]["ActiveCount"].ToString();
                TotalNearToExpiryAndExpiryTransformer.Text = ds.Tables[0].Rows[0]["ExpiringCount"].ToString();
                #endregion

                #region Generating Set data binding
                TotalGeneratingSet.Text = ds.Tables[0].Rows[1]["TotalCount"].ToString();
                //TotalActiveGeneratingSet.Text = ds.Tables[0].Rows[1]["ActiveCount"].ToString();
                TotalNearToExpiryAndExpiryGeneratingSet.Text = ds.Tables[0].Rows[1]["ExpiringCount"].ToString();
                #endregion

                #region Line data binding
                TotalLine.Text = ds.Tables[0].Rows[2]["TotalCount"].ToString();
                //TotalActiveLine.Text = ds.Tables[0].Rows[2]["ActiveCount"].ToString();
                TotalNearToExpiryAndExpiryLine.Text = ds.Tables[0].Rows[2]["ExpiringCount"].ToString();
                #endregion

                #region Lift data binding
                TotalLift.Text = ds.Tables[0].Rows[3]["TotalCount"].ToString();
                //TotalActiveLift.Text = ds.Tables[0].Rows[3]["ActiveCount"].ToString();
                TotalNearToExpiryAndExpiryLift.Text = ds.Tables[0].Rows[3]["ExpiringCount"].ToString();
                #endregion
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error Message " + ex.Message.ToString());
            }
        }

        /// <summary>
        /// Get Data for Site owner
        /// </summary>
        private void GetDataforSiteowner()
        {
            try
            {
                LoginId = Session["SiteOwnerId"].ToString();
                DataSet ds = new DataSet();
                ds = cei.GetdataforSiteownerdashboard(LoginId);
                txtTotalinspection.Text = ds.Tables[0].Rows[0]["TotalInspections"].ToString();
                txtRejected.Text = ds.Tables[0].Rows[0]["Return"].ToString();
                txtApproved.Text = ds.Tables[0].Rows[0]["Approved"].ToString();
                txtPending.Text = ds.Tables[0].Rows[0]["Pending"].ToString();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error Message " + ex.Message.ToString());
            }
        }
    }
}