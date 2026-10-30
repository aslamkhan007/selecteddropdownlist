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
    public partial class ComponentHistory : System.Web.UI.Page
    {
        CEI CEI = new CEI();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Convert.ToString(Session["SiteOwnerId"])))
                {
                    GridBind();
                }
            }
        }
        public void GridBind()
        {
            try
            {
                string Type, SerialNumber, TransformerCapacity, TransformerCapacityType, TranformerType, PrimaryVoltage, SecondoryVoltage, GeneratingType, GeneratingSetCapacityType, GeneratingSetCapacity, GeneratingSetType, GeneratorVoltageLevel, CurrenntCapacityOfBreaker, BreakingCapacityofBreaker, TypeOfPlant, LineVoltage, LineLength, LineType, NoOfCircuit, Conductortype, NumberofPoleTower, ConductorSize, GroundWireSize, TypeOfLift, TypeOfControl, Weight, Capacity, Make, RegistrationNo;

                // Group initialization
                Type = SerialNumber = TransformerCapacity = TransformerCapacityType =
                TranformerType = PrimaryVoltage = SecondoryVoltage = GeneratingType =
                GeneratingSetCapacityType = GeneratingSetCapacity = GeneratingSetType =
                GeneratorVoltageLevel = CurrenntCapacityOfBreaker = BreakingCapacityofBreaker =
                TypeOfPlant = LineVoltage = LineLength = LineType = NoOfCircuit =
                Conductortype = NumberofPoleTower = ConductorSize = GroundWireSize =
                TypeOfLift = TypeOfControl = Weight = Capacity = Make = RegistrationNo = null;
                Type = Session["Type"]?.ToString();


                if (Type == "Transformer")
                {
                    #region Transformer
                    SerialNumber = Session["SerialNumber"]?.ToString();
                    TransformerCapacity = Session["TransformerCapacity"]?.ToString();
                    TransformerCapacityType = Session["TransformerCapacityType"]?.ToString();
                    TranformerType = Session["TranformerType"]?.ToString();
                    PrimaryVoltage = Session["PrimaryVoltage"]?.ToString();
                    SecondoryVoltage = Session["SecondoryVoltage"]?.ToString();
                    #endregion
                }

                else if (Type == "Generating Set")
                {
                    #region GeneratingSet
                    SerialNumber = Session["SerialNumber"]?.ToString();
                    GeneratingSetCapacity = Session["GeneratingSetCapacity"]?.ToString();
                    GeneratingSetCapacityType = Session["GeneratingSetCapacityType"]?.ToString();
                    GeneratingSetType = Session["GeneratingSetType"]?.ToString();
                    GeneratorVoltageLevel = Session["GeneratingSetVoltage"]?.ToString();
                    CurrenntCapacityOfBreaker = Session["CurrenntCapacityOfBreaker"]?.ToString();
                    BreakingCapacityofBreaker = Session["BreakingCapacityofBreaker"]?.ToString();
                    TypeOfPlant = Session["TypeOfPlant"]?.ToString();
                    #endregion
                }

                else if (Type == "Line")
                {
                    #region Line
                    SerialNumber = string.Empty;
                    LineVoltage = Session["LineVoltage"]?.ToString();
                    LineLength = Session["LineLength"]?.ToString();
                    LineType = Session["LineType"]?.ToString();
                    NoOfCircuit = Session["NoOfCircuit"]?.ToString();
                    Conductortype = Session["Conductortype"]?.ToString();
                    NumberofPoleTower = Session["NumberofPoleTower"]?.ToString();
                    ConductorSize = Session["ConductorSize"]?.ToString();
                    GroundWireSize = Session["GroundWireSize"]?.ToString();
                    #endregion
                }

                else
                {
                    #region Lift
                    SerialNumber = Session["SerialNumber"]?.ToString();
                    TypeOfLift = Session["TypeOfLift"]?.ToString();
                    TypeOfControl = Session["TypeOfControl"]?.ToString();
                    Weight = Session["Weight"]?.ToString();
                    Capacity = Session["Capacity"]?.ToString();
                    Make = Session["Make"]?.ToString();
                    RegistrationNo = Session["RegistrationNo"]?.ToString();
                    #endregion
                }

                //string searchText = txtSearch.Text;
                DataSet ds = new DataSet();
                // 1. Assign the correct GridView to a temporary variable
                GridView targetGrid = (Type == "Transformer") ? TransformerGridView :
                    (Type == "Generating Set") ? GeneratingSetGridView :
                     (Type == "Line") ? LineGridView : LiftGridView;

                ds = CEI.GetInspectionHistoryOfTransformer(Type, SerialNumber,  TransformerCapacity, TransformerCapacityType, TranformerType, PrimaryVoltage, SecondoryVoltage, GeneratingSetCapacityType, GeneratingSetCapacity, GeneratingSetType, GeneratorVoltageLevel, CurrenntCapacityOfBreaker, BreakingCapacityofBreaker, TypeOfPlant,
                    LineVoltage, LineLength, LineType, NoOfCircuit, Conductortype, NumberofPoleTower, ConductorSize, GroundWireSize, TypeOfLift, TypeOfControl, Weight, Capacity, Make, Session["SiteOwnerId"].ToString(), RegistrationNo);
                if (ds.Tables.Count > 0 && ds != null)
                {
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
                lblPreviewPage.Text = Type + " " + "History";
                ds.Dispose();
            }
            catch (Exception ex)
            {
                throw;
            }

        }
        protected void TransformerGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            try
            {
                //Control ctrl = e.CommandSource as Control;
                //GridViewRow row = ctrl.Parent.NamingContainer as GridViewRow;

                //if (e.CommandName == "Select")
                //{
                //    string transformerSerialNumber = e.CommandArgument.ToString().Trim();

                //    // Store in Session
                //    Session["TransformerSerialNumber"] = transformerSerialNumber;

                //    // Redirect to another page
                //    Response.Redirect("~/SiteOwnerPages/ComponentHistory.aspx");
                //}
            }
            catch (Exception ex)
            {

                ScriptManager.RegisterStartupScript(this, GetType(), "aleert", "alert('" + ex.Message + "');", true);
            }

        }
        protected void TransformerGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                TransformerGridView.PageIndex = e.NewPageIndex;
                GridBind();
            }
            catch { }
        }

        protected void GeneratingSetGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            try
            {
                //Control ctrl = e.CommandSource as Control;
                //GridViewRow row = ctrl.Parent.NamingContainer as GridViewRow;

                //if (e.CommandName == "Select")
                //{
                //    string transformerSerialNumber = e.CommandArgument.ToString().Trim();

                //    // Store in Session
                //    Session["TransformerSerialNumber"] = transformerSerialNumber;

                //    // Redirect to another page
                //    Response.Redirect("~/SiteOwnerPages/ComponentHistory.aspx");
                //}
            }
            catch (Exception ex)
            {

                ScriptManager.RegisterStartupScript(this, GetType(), "aleert", "alert('" + ex.Message + "');", true);
            }

        }
        protected void GeneratingSetGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                TransformerGridView.PageIndex = e.NewPageIndex;
                GridBind();
            }
            catch { }
        }

        protected void LineGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            try
            {
                //Control ctrl = e.CommandSource as Control;
                //GridViewRow row = ctrl.Parent.NamingContainer as GridViewRow;

                //if (e.CommandName == "Select")
                //{
                //    string transformerSerialNumber = e.CommandArgument.ToString().Trim();

                //    // Store in Session
                //    Session["TransformerSerialNumber"] = transformerSerialNumber;

                //    // Redirect to another page
                //    Response.Redirect("~/SiteOwnerPages/ComponentHistory.aspx");
                //}
            }
            catch (Exception ex)
            {

                ScriptManager.RegisterStartupScript(this, GetType(), "aleert", "alert('" + ex.Message + "');", true);
            }

        }
        protected void LineGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                TransformerGridView.PageIndex = e.NewPageIndex;
                GridBind();
            }
            catch { }
        }

        protected void LiftGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            try
            {
                //Control ctrl = e.CommandSource as Control;
                //GridViewRow row = ctrl.Parent.NamingContainer as GridViewRow;

                //if (e.CommandName == "Select")
                //{
                //    string transformerSerialNumber = e.CommandArgument.ToString().Trim();

                //    // Store in Session
                //    Session["TransformerSerialNumber"] = transformerSerialNumber;

                //    // Redirect to another page
                //    Response.Redirect("~/SiteOwnerPages/ComponentHistory.aspx");
                //}
            }
            catch (Exception ex)
            {

                ScriptManager.RegisterStartupScript(this, GetType(), "aleert", "alert('" + ex.Message + "');", true);
            }

        }
        protected void LiftGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                TransformerGridView.PageIndex = e.NewPageIndex;
                GridBind();
            }
            catch { }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (Convert.ToString(Session["SiteOwnerId"]) != null && Convert.ToString(Session["SiteOwnerId"]) != string.Empty)
            {
                Response.Redirect("~/SiteOwnerPages/TotalComponentSummary.aspx", false);
            }
            else
            {
                Session["SiteOwnerId"] = "";
                Response.Redirect("/SiteOwnerLogout.aspx");
            }
        }
    }
}