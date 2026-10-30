using CEI_PRoject;
using CEIHaryana.UserPages;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Media.Media3D;

namespace CEIHaryana.SiteOwnerPages
{
    public partial class TotalComponentSummary : System.Web.UI.Page
    {
        CEI CEI = new CEI();
        string RegNo = string.Empty, LoginToken = string.Empty;

        /// <summary>
        /// Page Load for Transformer and Generating Set
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (!string.IsNullOrEmpty(Convert.ToString(Session["SiteOwnerId"])))
                    {
                        //Request.QueryString["source"] = Session["PerviewPage"]?.ToString();
                        // Check if the query string exists
                        if (Request.QueryString["source"] != null || Session["PerviewPage"] != null)
                        {
                            string sourcePage = Request.QueryString["source"];
                            if (Session["PerviewPage"] == null)
                            {
                                Session["PerviewPage"] = sourcePage;
                            }
                            else
                            {
                                sourcePage = Session["PerviewPage"]?.ToString();
                            }
                            GridBind(sourcePage);
                            lblPreviewPage.Text = sourcePage + " " + "Summary";
                        }
                    }
                    else
                    {
                        Response.Redirect("/SiteOwnerLogout.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("/SiteOwnerLogout.aspx");
            }
        }

        /// <summary>
        /// Grid Bind Transformer and Generating Set based on the source page parameter.
        /// </summary>
        /// <param name="sourcePage"></param>
        public void GridBind(string sourcePage)
        {
            try
            {
                string LoginID = string.Empty;
                LoginID = Session["SiteOwnerId"].ToString();
                //string searchText = txtSearch.Text;
                DataSet ds = new DataSet();
                ds = CEI.GetTotalComponentSummary(LoginID, sourcePage);

                // 1. Assign the correct GridView to a temporary variable
                GridView targetGrid = (sourcePage == "Transformer") ? TransformerGridView :
                    (sourcePage == "Generating Set") ? GeneratingSetGridView :
                     (sourcePage == "Line") ? LineGridView : LiftGridView;

                // 2. Correct the null check order (always check if ds is null BEFORE checking its tables)
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    // 3. Perform operations on the target grid smoothly
                    targetGrid.DataSource = ds;
                    targetGrid.DataBind();
                }
                else
                {
                    targetGrid.DataSource = null;
                    targetGrid.DataBind();

                    string script = "alert(\"No Record Found\");";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                }
                ds.Dispose();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        #region for Transformer
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void TransformerGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 1. Guard Clause: Exit early if it's not the "Select" command
            if (e.CommandName != "View") return;

            try
            {
                //// 2. Safely extract the CommandArgument (Serial Number)
                //string transformerSerialNumber = e.CommandArgument?.ToString()?.Trim();
                //if (string.IsNullOrEmpty(transformerSerialNumber)) return;

                //// Store Serial Number in Session
                //Session["SerialNumber"] = transformerSerialNumber;

                // 2. Safe Row Extraction using NamingContainer
                if (e.CommandSource is Control ctrl)
                {
                    if (ctrl.NamingContainer is GridViewRow row)
                    {
                        // Find controls safely using 'as' casting and store their .Text values in Session
                        Session["SerialNumber"] = (row.FindControl("TransformerSerialNumberLbl") as Label)?.Text;
                        Session["Type"] = (row.FindControl("TypeLbl") as Label)?.Text;
                        Session["TransformerCapacity"] = (row.FindControl("TransformerCapacityLbl") as Label)?.Text;
                        Session["TransformerCapacityType"] = (row.FindControl("TransformerCapacityTypeLbl") as Label)?.Text;
                        Session["TranformerType"] = (row.FindControl("TranformerTypeLbl") as Label)?.Text;
                        Session["PrimaryVoltage"] = (row.FindControl("PrimaryVoltageLbl") as Label)?.Text;
                        Session["SecondoryVoltage"] = (row.FindControl("SecondoryVoltageLbl") as Label)?.Text;
                    }
                }

                // 3. Redirect safely to prevent ThreadAbortException
                Response.Redirect("~/SiteOwnerPages/ComponentHistory.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                // Prevent JS injection/breaking quotes in the alert by replacing single quotes
                string safeMessage = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{safeMessage}');", true);
            }
        }


        /// <summary>
        /// Transformer Grid View Page Index Changing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void TransformerGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                TransformerGridView.PageIndex = e.NewPageIndex;
                GridBind("Transformer");
            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region for Generating Set
        /// <summary>
        /// Generating Set Grid View Row Command
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GeneratingSetGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 1. Guard Clause: Exit early if it's not the "Select" command
            if (e.CommandName != "View") return;

            try
            {
                //// 2. Safely extract the CommandArgument (Serial Number)
                //string generatingSetSerialNumber = e.CommandArgument?.ToString()?.Trim();
                //if (string.IsNullOrEmpty(generatingSetSerialNumber)) return;

                //// Store Serial Number in Session
                //Session["SerialNumber"] = generatingSetSerialNumber;

                // 2. Safe Row Extraction using NamingContainer
                if (e.CommandSource is Control ctrl)
                {
                    if (ctrl.NamingContainer is GridViewRow row)
                    {
                        // Find controls safely using 'as' casting and store their .Text values in Session
                        Session["SerialNumber"] = (row.FindControl("GeneratingSetSerialNumberLbl") as Label)?.Text;
                        Session["Type"] = (row.FindControl("GeneratingTypeLbl") as Label)?.Text;
                        Session["GeneratingSetCapacity"] = (row.FindControl("GeneratingSetCapacityLbl") as Label)?.Text;
                        Session["GeneratingSetCapacityType"] = (row.FindControl("GeneratingSetCapacityTypeLbl") as Label)?.Text;
                        Session["GeneratingSetType"] = (row.FindControl("GeneratingSetTypeLbl") as Label)?.Text;
                        Session["GeneratingSetVoltage"] = (row.FindControl("GeneratingSetVoltageLbl") as Label)?.Text;
                        Session["CurrenntCapacityOfBreaker"] = (row.FindControl("GeneratingSetCurrenntCapacityOfBreakerLbl") as Label)?.Text;
                        Session["BreakingCapacityofBreaker"] = (row.FindControl("GeneratingSetBreakingCapacityofBreakerLbl") as Label)?.Text;
                        Session["TypeOfPlant"] = (row.FindControl("GeneratingSetTypeOfPlantLbl") as Label)?.Text;
                    }
                }

                // 3. Redirect safely to prevent ThreadAbortException
                Response.Redirect("~/SiteOwnerPages/ComponentHistory.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                // Prevent JS injection/breaking quotes in the alert by replacing single quotes
                string safeMessage = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{safeMessage}');", true);
            }
        }

        /// <summary>
        /// Generating Set Grid View Page Index Changing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GeneratingSetGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                GeneratingSetGridView.PageIndex = e.NewPageIndex;
                GridBind("GeneratingSet");
            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region for Line
        /// <summary>
        /// Line Grid View Row Command
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LineGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            // 1. Guard Clause: Exit early if it's not the "Select" command
            if (e.CommandName != "View") return;

            try
            {
                //// 2. Safely extract the CommandArgument (Serial Number)
                //string generatingSetSerialNumber = e.CommandArgument?.ToString()?.Trim();
                //if (string.IsNullOrEmpty(generatingSetSerialNumber)) return;

                //// Store Serial Number in Session
                //Session["SerialNumber"] = generatingSetSerialNumber;

                // 2. Safe Row Extraction using NamingContainer
                if (e.CommandSource is Control ctrl)
                {
                    if (ctrl.NamingContainer is GridViewRow row)
                    {
                        // Find controls safely using 'as' casting and store their .Text values in Session
                        Session["LineVoltage"] = (row.FindControl("LineVoltageLbl") as Label)?.Text;
                        Session["Type"] = (row.FindControl("TypeOfLineLbl") as Label)?.Text;
                        Session["LineLength"] = (row.FindControl("LineLengthLbl") as Label)?.Text;
                        Session["LineType"] = (row.FindControl("LineTypeLbl") as Label)?.Text;
                        Session["NoOfCircuit"] = (row.FindControl("NoOfCircuitLbl") as Label)?.Text;
                        Session["Conductortype"] = (row.FindControl("ConductortypeLbl") as Label)?.Text;
                        Session["NumberofPoleTower"] = (row.FindControl("NumberofPoleTowerLbl") as Label)?.Text;
                        Session["ConductorSize"] = (row.FindControl("ConductorSizeLbl") as Label)?.Text;
                        Session["GroundWireSize"] = (row.FindControl("GroundWireSizeLbl") as Label)?.Text;
                    }
                }

                // 3. Redirect safely to prevent ThreadAbortException
                Response.Redirect("~/SiteOwnerPages/ComponentHistory.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                // Prevent JS injection/breaking quotes in the alert by replacing single quotes
                string safeMessage = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{safeMessage}');", true);
            }
        }

        /// <summary>
        /// Line Grid View Page Index Changing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LineGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                LineGridView.PageIndex = e.NewPageIndex;
                GridBind("Line");
            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region for Lift
        /// <summary>
        /// Lift Grid View Row Command
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LiftGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 1. Guard Clause: Exit early if it's not the "Select" command
            if (e.CommandName != "View") return;

            try
            {
                // 2. Safe Row Extraction using NamingContainer
                if (e.CommandSource is Control ctrl)
                {
                    if (ctrl.NamingContainer is GridViewRow row)
                    {
                        // Find controls safely using 'as' casting and store their .Text values in Session
                        Session["SerialNumber"] = (row.FindControl("SerialNoLbl") as Label)?.Text;
                        Session["Type"] = "Lift/Escalator";
                        //Session["Type"] = (row.FindControl("ComponentTypeLbl") as Label)?.Text;
                        Session["TypeOfLift"] = (row.FindControl("TypeOfLiftLbl") as Label)?.Text;
                        Session["TypeOfControl"] = (row.FindControl("TypeOfControlLbl") as Label)?.Text;
                        Session["Weight"] = (row.FindControl("WeightLbl") as Label)?.Text;
                        Session["Capacity"] = (row.FindControl("CapacityLbl") as Label)?.Text;
                        Session["Make"] = (row.FindControl("MakeLbl") as Label)?.Text;
                        Session["RegistrationNo"] = (row.FindControl("RegistrationNolbl") as Label)?.Text;
                        
                    }
                }

                // 3. Redirect safely to prevent ThreadAbortException
                Response.Redirect("~/SiteOwnerPages/ComponentHistory.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                // Prevent JS injection/breaking quotes in the alert by replacing single quotes
                string safeMessage = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{safeMessage}');", true);
            }
        }

        /// <summary>
        /// Lift Grid View Page Index Changing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LiftGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                LiftGridView.PageIndex = e.NewPageIndex;
                GridBind("Line");
            }
            catch
            {
                throw;
            }
        }
        #endregion
    }
}