using CEI_PRoject;
using CEIHaryana.Officers;
using Org.BouncyCastle.Utilities.Collections;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static iText.StyledXmlParser.Jsoup.Select.Evaluator;

namespace CEIHaryana.SiteOwnerPages
{
    public partial class InspectionRenewalCart : System.Web.UI.Page
    {
        CEI CEI = new CEI();

        //string strPreviousRowID = string.Empty;
        int intSubTotalIndex = 1, highestOfficerDesignation = 0;
        decimal dblSubTotalCapacity = 0, dblGrandTotalCapacity = 0;
        double dblSubHighestVoltage = 0, dblHighestVoltage = 0;
        string InstallationTypeId = string.Empty, strPreviousRowID = string.Empty;
        private static int TotalAmount = 0, CheckCase = 0;
        private static string PrevInspectionId = string.Empty, PrevInstallationType = string.Empty, PrevTestReportId = string.Empty,
                              PrevIntimationId = string.Empty, PrevVoltageLevel = string.Empty,
                              PrevApplicantType = string.Empty, AssignToOfficer = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Convert.ToString(Session["SiteOwnerId"]) != null && Convert.ToString(Session["SiteOwnerId"]) != "")
                    {
                        hfOwner.Value = Convert.ToString(Session["SiteOwnerId"]);
                        Page.Session["FinalAmount"] = "0";
                        BindAdress();
                    }
                    else
                    {
                        Session["SiteOwnerId"] = "";
                        Response.Redirect("/SiteOwnerLogout.aspx", false);
                    }
                }
            }
            catch
            {
                Session["SiteOwnerId"] = "";
                Response.Redirect("/SiteOwnerLogout.aspx", false);
            }
        }
        private void BindAdress()
        {
            try
            {
                if (Convert.ToString(Session["SiteOwnerId"]) != null && Convert.ToString(Session["SiteOwnerId"]) != "")
                {
                    if (hfOwner.Value == Convert.ToString(Session["SiteOwnerId"]))
                    {
                        string CreatedBy = Session["SiteOwnerId"].ToString();
                        DataSet FilterAddress = new DataSet();
                        FilterAddress = CEI.GetAddressToFilterCart(CreatedBy);
                        ddlAddress.DataSource = FilterAddress;
                        ddlAddress.DataTextField = "AddressText";
                        ddlAddress.DataValueField = "AddressText";
                        ddlAddress.DataBind();
                        ddlAddress.Items.Insert(0, new ListItem("Select", "0"));
                        FilterAddress.Clear();
                    }
                    else
                    {
                        Session["SiteOwnerId"] = "";
                        Response.Redirect("/SiteOwnerLogout.aspx", false);
                    }
                }
            }
            catch (Exception ex)
            {
                Session["SiteOwnerId"] = "";
                Response.Redirect("/SiteOwnerLogout.aspx", false);
            }
        }
        protected void ddlAddress_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                txtAddressFilter.Visible = true;
                txtAddressFilter.Text = ddlAddress.SelectedItem.ToString();

                DivGrid.Visible = true;
                BindGrid();
                BtnSubmit.Visible = true;
                BtnDelete.Visible = true;
            }
            catch (Exception ex)
            {
            }
        }
        private void BindGrid()
        {
            if (Convert.ToString(Session["SiteOwnerId"]) != null && Convert.ToString(Session["SiteOwnerId"]) != "")
            {
                if (hfOwner.Value == Convert.ToString(Session["SiteOwnerId"]))
                {
                    string CreatedBy = Session["SiteOwnerId"].ToString();
                    string[] str = txtAddressFilter.Text.Split('|');
                    string address = str[0].Trim();
                    string CartID = str[1].Trim();
                    //Session["SelectedCartID"] = CartID;

                    DataSet ds = new DataSet();
                    ds = CEI.ShowDataToCart(address, CartID, CreatedBy);
                    if (ds.Tables.Count > 0)
                    {
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                    else
                    {
                        GridView1.DataSource = null;
                        GridView1.DataBind();
                    }
                }
                else
                {
                    Session["SiteOwnerId"] = "";
                    Response.Redirect("/SiteOwnerLogout.aspx", false);
                }
            }
            else
            {
                Session["SiteOwnerId"] = "";
                Response.Redirect("/SiteOwnerLogout.aspx", false);
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Label LblCount = e.Row.FindControl("LblCount") as Label;
                    Label LblInstallationName = e.Row.FindControl("LblInstallationName") as Label;
                    Label LblIntimationId = e.Row.FindControl("LblIntimationId") as Label;
                    Label LblInspectionId = e.Row.FindControl("LblInspectionId") as Label;
                    string InspectionId = LblInspectionId.Text;

                    PrevInspectionId = InspectionId;
                    Label Lbldesignation = e.Row.FindControl("Lbldesignation") as Label;
                    //string Assignedoff = Lbldesignation.Text;
                    //if (Assignedoff != null && Assignedoff != "")
                    //{
                    //    getassignedofficer(Assignedoff);
                    //}

                    if (LblCount.Text != null && LblInstallationName.Text != null && LblIntimationId != null)
                    {
                        if (LblInstallationName.Text == "Line")
                        {
                            InstallationTypeId = "1";
                        }
                        else if (LblInstallationName.Text == "Substation Transformer")
                        {
                            InstallationTypeId = "2";
                        }
                        else if (LblInstallationName.Text == "Generating Set")
                        {
                            InstallationTypeId = "3";
                        }
                        string InspectionType = "Periodic";
                        DataTable ds = new DataTable();
                        ds = CEI.Payment(LblIntimationId.Text, LblCount.Text, InstallationTypeId, InspectionType);
                        if (ds.Rows.Count > 0 && ds != null)
                        {
                            int Amount = Convert.ToInt32(ds.Rows[0]["Amount"].ToString());
                            TotalAmount = Convert.ToInt32(Session["FinalAmount"]);
                            TotalAmount = TotalAmount + Amount;
                            Session["FinalAmount"] = TotalAmount;
                        }
                    }

                    strPreviousRowID = DataBinder.Eval(e.Row.DataItem, "InstallationName").ToString();

                    // Check and parse Capacity
                    object capacityObj = DataBinder.Eval(e.Row.DataItem, "CapacityNumeric");
                    decimal dblCapacity = 0;
                    if (capacityObj != null && decimal.TryParse(capacityObj.ToString(), out dblCapacity))
                    {
                        dblSubTotalCapacity += dblCapacity;
                        dblGrandTotalCapacity += dblCapacity;
                    }

                    // Check and parse Voltage
                    object voltageObj = DataBinder.Eval(e.Row.DataItem, "Voltage");
                    double dblVoltage = 0;
                    if (voltageObj != null && double.TryParse(voltageObj.ToString(), out dblVoltage))
                    {
                        // Update the highest voltage for the subtotal 
                        dblSubHighestVoltage = Math.Max(dblSubHighestVoltage, dblVoltage);
                        dblHighestVoltage = Math.Max(dblHighestVoltage, dblVoltage);
                    }
                }
                else if (e.Row.RowType == DataControlRowType.Footer)
                {
                    Label lblTotalCapacity = (Label)e.Row.FindControl("lblTotalCapacity");
                    Label lblMaxVoltage = (Label)e.Row.FindControl("lblMaxVoltage");

                    //lblTotalCapacity.Text = "Total Capacity: " + dblGrandTotalCapacity.ToString("N0") + "KVA";
                    lblTotalCapacity.Text = "Total Capacity: " + dblGrandTotalCapacity + "KVA";
                    lblMaxVoltage.Text = "Max Voltage: " + dblHighestVoltage.ToString("N0");

                    Session["TotalCapacity"] = dblGrandTotalCapacity;
                    Session["HighestVoltage"] = dblHighestVoltage;
                }
            }
            catch (Exception ex) { }
        }
        //private void getassignedofficer(string Assignedoff)
        //{
        //    try
        //    {
        //        if (Assignedoff.StartsWith("JE"))
        //        {
        //            CheckCase = 1;
        //            if (CheckCase > highestOfficerDesignation)
        //            {
        //                highestOfficerDesignation = CheckCase;
        //                AssignToOfficer = Assignedoff;
        //            }
        //        }
        //        else if (Assignedoff.StartsWith("AE"))
        //        {
        //            CheckCase = 2;
        //            if (CheckCase > highestOfficerDesignation)
        //            {
        //                highestOfficerDesignation = CheckCase;
        //                AssignToOfficer = Assignedoff;
        //            }
        //        }
        //        else if (Assignedoff.StartsWith("XEN"))
        //        {
        //            CheckCase = 3;
        //            if (CheckCase > highestOfficerDesignation)
        //            {
        //                highestOfficerDesignation = CheckCase;
        //                AssignToOfficer = Assignedoff;
        //            }
        //        }
        //        else if (Assignedoff.StartsWith("CEI"))
        //        {
        //            CheckCase = 4;
        //            if (CheckCase > highestOfficerDesignation)
        //            {
        //                highestOfficerDesignation = CheckCase;
        //                AssignToOfficer = Assignedoff;
        //            }
        //        }

        //    }
        //    catch { }
        //}
        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                bool IsSubTotalRowNeedToAdd = false;
                if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "InstallationName") != null))
                    if (strPreviousRowID != DataBinder.Eval(e.Row.DataItem, "InstallationName").ToString())
                        IsSubTotalRowNeedToAdd = true;
                if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "InstallationName") == null))
                {
                    IsSubTotalRowNeedToAdd = true;
                    intSubTotalIndex = 0;
                }
                if ((strPreviousRowID == string.Empty) && (DataBinder.Eval(e.Row.DataItem, "InstallationName") != null))
                {
                    GridView grdViewOrders = (GridView)sender;
                    GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);
                    TableCell cell = new TableCell();
                    cell.Text = "Installation Name: " + DataBinder.Eval(e.Row.DataItem, "InstallationName").ToString();
                    cell.Font.Bold = true;
                    cell.ColumnSpan = 6;
                    row.Cells.Add(cell);
                    grdViewOrders.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                    intSubTotalIndex++;
                }
                if (IsSubTotalRowNeedToAdd)
                {
                    AddSubTotalRow((GridView)sender, e.Row.RowIndex + intSubTotalIndex);
                    intSubTotalIndex++;

                    if (DataBinder.Eval(e.Row.DataItem, "InstallationName") != null)
                    {
                        GridView grdViewOrders = (GridView)sender;
                        GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);
                        TableCell cell = new TableCell();
                        cell.Text = "Installation Name: " + DataBinder.Eval(e.Row.DataItem, "InstallationName").ToString();
                        cell.Font.Bold = true;
                        cell.ColumnSpan = 6;
                        row.Cells.Add(cell);
                        grdViewOrders.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                        intSubTotalIndex++;
                    }
                    //dblSubTotalCapacity = 0;
                    //dblSubHighestVoltage = 0;
                }
            }
            catch (Exception ex) { }
        }
        private void AddSubTotalRow(GridView gridView, int rowIndex)
        {
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

            // Create a cell for the subtotal label
            TableCell cell = new TableCell();
            cell.Text = "Sub Total";
            cell.Font.Bold = true;
            cell.HorizontalAlign = HorizontalAlign.Left;
            cell.ColumnSpan = 2;
            cell.CssClass = "SubTotalRowStyle";
            row.Cells.Add(cell);

            // Create a cell for the subtotal capacity
            cell = new TableCell();
            //cell.Text = string.Format("{0:0}", dblSubTotalCapacity);
            cell.Text = string.Format("{0:N2}", dblSubTotalCapacity);
            cell.Font.Bold = true;
            cell.HorizontalAlign = HorizontalAlign.Left;
            cell.CssClass = "SubTotalRowStyle";
            row.Cells.Add(cell);

            // Create a cell for the highest voltage in the group
            cell = new TableCell();
            cell.Text = string.Format("{0:0}", dblSubHighestVoltage);
            cell.Font.Bold = true;
            cell.HorizontalAlign = HorizontalAlign.Left;
            cell.CssClass = "SubTotalRowStyle";
            row.Cells.Add(cell);

            // Add the subtotal row to the grid
            gridView.Controls[0].Controls.AddAt(rowIndex, row);

            dblSubTotalCapacity = 0;
            dblSubHighestVoltage = 0;
        }
        //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    try
        //    {
        //        if (e.CommandName == "DeleteRow")
        //        {
        //            int inspectionId = Convert.ToInt32(e.CommandArgument);
        //            DataSet ds = new DataSet();
        //            ds = CEI.ToRemoveDataCart(inspectionId);

        //            BindGrid();
        //        }
        //    }
        //    catch (Exception ex) { }
        //}
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToString(Session["SiteOwnerId"]) != null && Convert.ToString(Session["SiteOwnerId"]) != "")
                {
                    if (hfOwner.Value == Convert.ToString(Session["SiteOwnerId"]))
                    {
                        string id = Session["SiteOwnerId"].ToString();
                        string GrandTotalCapacity = Session["TotalCapacity"].ToString();
                        string HighestVoltage = Session["HighestVoltage"].ToString();

                        int totalAmount = Convert.ToInt32(Session["FinalAmount"]);
                        string AssignTo = AssignToOfficer;
                        string Division = string.Empty;
                        string District = string.Empty;
                        string StaffAssignedCount = string.Empty;
                        string StaffAssigned = string.Empty;
                        string Assigned = string.Empty;
                        int ServiceType = 0;
                        string[] str = txtAddressFilter.Text.Split('|');
                        string address = str[0].Trim();
                        string CartID = str[1].Trim();

                        DataSet ds = new DataSet();
                        ds = CEI.ToGetDatafromCart(address, CartID);
                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow row in ds.Tables[0].Rows)
                            {
                                Division = row["Division"].ToString();
                                District = row["District"].ToString();
                            }
                        }
                        ds = CEI.GetStaffAssigned(CartID);

                        if (ds.Tables.Count > 0 && ds != null)
                        {
                            StaffAssignedCount = ds.Tables[0].Rows[0]["AssignedCount"].ToString();
                        }

                        if (StaffAssignedCount == "1")
                        {
                            StaffAssigned = "JE";
                            ServiceType = 2;
                        }
                        else if (StaffAssignedCount == "2")
                        {
                            StaffAssigned = "AE";
                            ServiceType = 3;
                        }

                        else if (StaffAssignedCount == "3")
                        {
                            StaffAssigned = "XEN";
                            ServiceType = 4;
                        }
                        else if (StaffAssignedCount == "4")
                        {
                            StaffAssigned = "CEI";
                            ServiceType = 5;
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('your details or component are wrong')", true);
                            return;
                        }


                        DataSet dsp = new DataSet();
                        dsp = CEI.ToGetStaffIdforPeriodic(Division, StaffAssigned, District);
                        if (dsp.Tables.Count > 0 && dsp.Tables[0].Rows.Count > 0)
                        {
                            Assigned = dsp.Tables[0].Rows[0]["StaffUserId"].ToString();
                        }

                        CEI.InsertInspectinData(CartID, GrandTotalCapacity, HighestVoltage, Assigned, totalAmount, id, ServiceType);

                        Session["CartID"] = CartID;
                        Session["IDCart"] = string.Empty;
                        Session["TotalCapacity"] = string.Empty;
                        Session["HighestVoltage"] = string.Empty;
                        Session["FinalAmount"] = string.Empty;

                        Response.Redirect("/SiteOwnerPages/ProcessInspectionRenewalCart.aspx", false);
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "alert('Cart Submitted Successfully !!!'); window.location='/SiteOwnerPages/ProcessInspectionRenewalCart.aspx';", true);
                    }
                    else
                    {
                        Session["SiteOwnerId"] = "";
                        Response.Redirect("/SiteOwnerLogout.aspx", false);
                    }
                }
            }
            catch (Exception ex)
            {
                Session["SiteOwnerId"] = "";
                Response.Redirect("/SiteOwnerLogout.aspx", false);
            }
        }

        //private int GetAffectedRowsCount(string cartId)
        //{
        //    int count = 0;
        //    count = CEI.GetAffectedRowsCountByCartId(cartId);

        //    return count;
        //}
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            string[] str = txtAddressFilter.Text.Split('|');
            if (str.Length > 1)
            {
                string selectedCartID = str[1].Trim();

                if (!string.IsNullOrEmpty(selectedCartID))
                {
                    try
                    {
                        CEI.ToDeleteCart(selectedCartID);
                        Response.Redirect("/SiteOwnerPages/PeriodicRenewal.aspx", false);
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('An error occurred while deleting the cart.');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('No Cart ID selected.');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('An error occurred while deleting the cart.');</script>");
            }
        }

    }
}