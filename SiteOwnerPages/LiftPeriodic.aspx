<%@ Page Title="" Language="C#" MasterPageFile="~/SiteOwnerPages/SiteOwner.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="LiftPeriodic.aspx.cs" Inherits="CEIHaryana.SiteOwnerPages.LiftPeriodic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="shortcut icon" type="image/png" href="/css2/style.min.css" />
    <link rel="stylesheet" href="/css2/style.css" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://kit.fontawesome.com/57676f1d80.js" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        th {
            font-size: 15px !important;
        }

        .fade {
            transition: opacity 0.15s linear;
            width: 110% !important;
            height: 100% !important;
        }

        .pagination-ys {
            /*display: inline-block;*/
            padding-left: 0;
            margin: 20px 0;
            border-radius: 4px;
        }

            .pagination-ys table > tbody > tr > td {
                display: contents;
            }

                .pagination-ys table > tbody > tr > td > a,
                .pagination-ys table > tbody > tr > td > span {
                    position: relative;
                    float: left;
                    padding: 8px 12px;
                    line-height: 1.42857143;
                    text-decoration: none;
                    color: #dd4814;
                    background-color: #ffffff;
                    border: 1px solid #dddddd;
                    margin-left: -1px;
                }

                .pagination-ys table > tbody > tr > td > span {
                    position: relative;
                    float: left;
                    padding: 8px 12px;
                    line-height: 1.42857143;
                    text-decoration: none;
                    margin-left: -1px;
                    z-index: 2;
                    color: #aea79f;
                    background-color: #f5f5f5;
                    border-color: #dddddd;
                    cursor: default;
                }

                .pagination-ys table > tbody > tr > td:first-child > a,
                .pagination-ys table > tbody > tr > td:first-child > span {
                    margin-left: 0;
                    border-bottom-left-radius: 4px;
                    border-top-left-radius: 4px;
                }

                .pagination-ys table > tbody > tr > td:last-child > a,
                .pagination-ys table > tbody > tr > td:last-child > span {
                    border-bottom-right-radius: 4px;
                    border-top-right-radius: 4px;
                }

                .pagination-ys table > tbody > tr > td > a:hover,
                .pagination-ys table > tbody > tr > td > span:hover,
                .pagination-ys table > tbody > tr > td > a:focus,
                .pagination-ys table > tbody > tr > td > span:focus {
                    color: #97310e;
                    background-color: #eeeeee;
                    border-color: #dddddd;
                }

        .col-md-4 {
            margin-bottom: 8px;
        }

        .form-control {
            box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
            margin-left: 0px !important;
            height: 25px;
        }

        select.form-control {
            box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
            margin-left: 0px !important;
            height: 25px;
        }

        label {
            font-size: 13px;
        }

        .form-control:focus {
            border: 2px solid #80bdff;
        }

        select.form-control:focus {
            border: 2px solid #80bdff;
        }

        .select2-container .select2-selection--single {
            height: 30px !important;
        }

        .select2-container--default .select2-selection--single {
            border: 1px solid #ccc !important;
            border-radius: 0px !important;
        }

        span.select2-selection.select2-selection--single {
            padding: 0px 0px 0px 5px;
            box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
            margin-left: 0px !important;
            height: 30px;
            border-radius: 5px !important;
        }

            span.select2-selection.select2-selection--single:focus {
                border: 2px solid #80bdff;
            }

        .card .card-title {
            font-size: 1.4rem !important;
        }

        .btn-primary:hover {
            box-shadow: rgba(50, 50, 93, 0.25) 0px 30px 60px -12px inset, rgba(0, 0, 0, 0.3) 0px 18px 36px -18px inset;
        }

        button.btn.btn-primary.mr-2 {
            padding: 10px 25px 10px 25px;
            font-size: 18px;
        }

        h6.card-title.fw-semibold.mb-4 {
            margin-bottom: 10px !important;
        }

        input.form-control.form-control-sm {
            margin-left: 7px !important;
        }

        td {
            text-align: center;
        }

        .headercolor {
            background-color: #9292cc;
        }

        .text-wrap {
            white-space: normal;
            overflow-wrap: break-word;
            word-wrap: break-word;
            max-width: 100%;
        }

        th {
            background-color: #9292cc;
        }

        select#ContentPlaceHolder1_ddlDistrict {
            padding: 0px 0px 0px 10px;
            height: 32px !important;
        }

        .grid-container {
            max-height: 450px;
            overflow-y: auto;
            overflow-x: auto;
            border: 1px solid #dbddff;
        }

            .grid-container table {
                width: 100%;
                margin-bottom: 0;
            }

            .grid-container th {
                position: sticky;
                top: 0;
                z-index: 2;
                background-color: #9292cc;
                color: white;
            }

            .grid-container th,
            .grid-container td {
                height: 40px;
                box-sizing: border-box;
                white-space: nowrap;
            }

        /* Address wise grouping */
        .addr-block {
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 15px;
            overflow: hidden;
        }

        .addr-head {
            background: #eceaf7;
            color: #000066;
            padding: 8px 12px;
            font-size: 14px;
        }

        .addr-pin {
            color: #1a3fb0;
            font-size: 22px;
            margin-right: 10px;
        }

        .addr-note {
            font-size: 12px;
            color: #6c757d;
            font-weight: 400;
        }

        .lift-head th {
            background: #9292cc;
            color: #fff;
            font-size: 13px;
        }

        .lift-table th, .lift-table td {
            text-align: left !important;
            vertical-align: middle;
            font-size: 14px;
            height: 40px;
        }

        .lift-table td {
            color: #252525;
        }

        .lift-table tr.row-selected td {
            background: #e6f4ec !important;
        }

        .lift-chk input {
            width: 16px;
            height: 16px;
        }

        .district-bar {
            padding: 10px 14px;
            background: #f4f6fb;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 14px;
            color: #000066;
        }

            .district-bar .other {
                display: block;
                font-size: 12px;
                color: #6c757d;
                margin-top: 3px;
            }

        .sel-box {
            display: inline-flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            white-space: nowrap;
            border: 1px solid #ddd;
            background: #fff;
            border-radius: 8px;
            padding: 8px 14px;
            font-size: 12px;
            margin-top: 8px;
        }

            .sel-box .selected-lifts-count {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-width: 30px;
                padding: 3px 8px;
                border-radius: 5px;
                background: #eceaf7;
                line-height: 1.2;
                font-size: 20px;
                font-weight: 700;
                color: #000066;
            }

        /* District blocks */
        .dist-block {
            border: 2px solid #9292cc;
            border-radius: 8px;
            margin-bottom: 20px;
            overflow: hidden;
        }

        .dist-head {
            background: #9292cc;
            color: #fff;
            padding: 8px 14px;
            font-size: 15px;
        }

            .dist-head .badge {
                font-size: 11px;
                margin-left: 6px;
            }

        .dist-block .addr-block {
            margin: 10px;
        }

        .lift-table tr.row-disabled td {
            opacity: 1;
        }

        /* Stepper */
        .step-bar {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 30px;
            width: 100%;
            margin: 10px auto 20px;
            font-size: 13px;
            color: #6c757d;
        }

            .step-bar .step {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .step-bar .num {
                width: 28px;
                height: 28px;
                border-radius: 50%;
                border: 1px solid #ccc;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #fff;
            }

            .step-bar .step.active {
                color: #1a3fb0;
                font-weight: 600;
            }

                .step-bar .step.active .num {
                    background: #1a3fb0;
                    color: #fff;
                    border-color: #1a3fb0;
                }

        .big {
            width: 15px;
            height: 15px;
            border-radius: 5px;
            z-index: 1;
            background-color: #4b49ac6e;
            animation: bigball 1s infinite linear;
            padding: 1px 10px;
            box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
        }
        /* Match the lower sections to the opening lift table typography. */
        .renewal-font-section .table td,
        .renewal-font-section .table td label,
        .renewal-font-section .table td span,
        .renewal-font-section input[type="file"] {
            font-size: 14px;
        }

        .renewal-font-section .table th {
            font-size: 15px !important;
        }

        .renewal-font-section .section-note {
            font-size: 14px !important;
            line-height: 1.5;
        }

        div#ContentPlaceHolder1_FeesDetails {
            padding: 0px 20px;
        }

        div#ContentPlaceHolder1_UploadDocuments {
            padding: 0px 20px;
        }

        div#ContentPlaceHolder1_InspectionRemarks {
            padding: 0px 20px;
        }


        /* Page-local section styling follows the district panels above. */
        .lift-periodic-page .renewal-section {
            padding: 0 20px;
            margin-bottom: 20px;
        }

        .lift-periodic-page .renewal-section-title {
            display: block;
            margin: 0;
            padding: 10px 14px;
            background: #9292cc;
            color: #fff;
            font-size: 15px;
            font-weight: 600;
            line-height: 1.5;
            border-radius: 8px 8px 0 0;
        }

        .lift-periodic-page .renewal-section-body,
        .lift-periodic-page .renewal-remarks > .row {
            margin: 0;
            padding: 16px;
            border: 1px solid #ccc;
            border-top: 0;
            border-radius: 0 0 8px 8px;
            background: #fff;
        }

        .lift-periodic-page .renewal-section .section-note {
            display: block;
            margin: 0 0 12px !important;
            font-weight: 400;
        }

        .lift-periodic-page .renewal-table-scroll {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .lift-periodic-page .renewal-section .table {
            display: table;
            width: 100%;
            min-width: 600px;
            margin-bottom: 0;
        }

            .lift-periodic-page .renewal-section .table th {
                background: #9292cc;
                color: #fff;
                text-align: left;
                vertical-align: middle;
                white-space: normal;
            }

            .lift-periodic-page .renewal-section .table td {
                color: #252525;
                text-align: left;
                vertical-align: middle;
            }

        .lift-periodic-page .renewal-section label,
        .lift-periodic-page .renewal-section .form-control,
        .lift-periodic-page .renewal-section td span {
            font-size: 14px !important;
        }

        .lift-periodic-page .renewal-section .form-control {
            min-height: 32px;
            height: auto;
            padding: 4px 10px;
        }

        .lift-periodic-page .renewal-payment-fields {
            row-gap: 12px;
            align-items: flex-start;
        }

        .lift-periodic-page .renewal-payment-fields > .col-4 {
            margin-top: 0 !important;
            margin-bottom: 0 !important;
        }

        .lift-periodic-page .renewal-section input[type="file"] {
            max-width: 100%;
        }

        @media (max-width: 767.98px) {
            .lift-periodic-page .renewal-section {
                padding: 0 12px;
            }

            .lift-periodic-page .renewal-payment-fields > .col-4 {
                flex: 0 0 100%;
                max-width: 100%;
            }
        }

        div#ContentPlaceHolder1_ChallanDetail {
            padding-bottom: 16px;
        }
        input#ContentPlaceHolder1_btnAddnew {
    height: 30px;
    padding: 0px 10px;
}
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper lift-periodic-page">
        <div class="card" style="box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px; border-radius: 5px !important">
            <div class="card-body">
                <div class="row">
                    <div class="col-12 text-center" style="margin-bottom:10px;">
                        <h6 class="card-title fw-semibold mb-4" style="text-align: center; width: 100%;">Renewal Of Inspection For Lift/Escalator</h6>
                    </div>
                </div>

              <%--  <div class="step-bar">
                    <div class="step"><span class="num">1</span> Review lifts &amp; documents</div>
                    <div class="step active"><span class="num">2</span> Raise inspection request</div>
                </div>--%>

                <div class="row align-items-center" style="margin-bottom: 10px;">
                    <div class="col-md-auto">
                        <div class="sel-box" style="margin-top: 0;">
                            <span>Selected lifts</span>
                            <span class="selected-lifts-count">
                                <asp:Label ID="lblSelCount" runat="server" Text="0"></asp:Label></span>
                        </div>
                    </div>
                    <div class="col-md text-end" style="text-align: right">
                        <asp:Label ID="lblAddNew" runat="server" Text="Click To Add Existing Lift/Escalator which not added" Style="font-weight: 600; margin-right: 10px;font-size:13px;"></asp:Label>
                        <asp:Button ID="btnAddnew" runat="server" OnClick="btnAddnew_Click" CssClass="btn btn-primary" Text="Add Lift/Escalator" CausesValidation="false" />
                    </div>
                </div>
                <asp:Panel ID="pnlDistrictInfo" runat="server" Visible="false">
                 <%--   <div class="district-bar">
                        <i class="fa fa-map-marker"></i>&nbsp;Selected District:
                    <b>
                        <asp:Label ID="lblSelDistrict" runat="server" Text="-"></asp:Label></b>
                        <span class="other">All pending records for every district are listed below. Each request can include lifts/escalators from only one district. The latest district is selected by default. To select another district, click "Select this district" in its header.</span>
                    </div>--%>

                    <div class="grid-container">
                        <asp:Repeater ID="rptDistrict" runat="server" OnItemDataBound="rptDistrict_ItemDataBound" OnItemCommand="rptDistrict_ItemCommand">
                            <ItemTemplate>
                                <div class="dist-block">
                                    <div class="dist-head d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fa fa-map-marker"></i>&nbsp;District: <b><%# Server.HtmlEncode(Convert.ToString(Eval("District"))) %></b>
                                            <asp:Label ID="lblLatest" runat="server" CssClass="badge badge-info" Text="Latest" Visible='<%# (bool)Eval("IsLatest") %>'></asp:Label>
                                            <asp:Label ID="lblSelBadge" runat="server" CssClass="badge badge-success" Text="Selected" Visible="false"></asp:Label>
                                            <span style="font-size: 12px; margin-left: 8px;">(<asp:Literal ID="litDistCount" runat="server"></asp:Literal>
                                                lifts)</span>
                                        </div>
                                        <div>
                                            <asp:HiddenField ID="hfDistrict" runat="server" Value='<%# Eval("District") %>' />
                                            <asp:LinkButton ID="lnkSelDistrict" runat="server" CssClass="btn btn-sm btn-light" CommandName="SelectDistrict"
                                                CommandArgument='<%# Eval("District") %>' CausesValidation="false">Select this district</asp:LinkButton>
                                        </div>
                                    </div>

                                    <asp:Repeater ID="rptAddress" runat="server" OnItemDataBound="rptAddress_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="addr-block">
                                                <div class="addr-head d-flex justify-content-between align-items-center">
                                                    <div class="d-flex align-items-center">
                                                        <i class="fa fa-map-marker addr-pin"></i>
                                                        <div>
                                                        <b style="white-space: normal;"><%# Server.HtmlEncode(Convert.ToString(Eval("SiteAddress"))) %></b>
                                                        </div>
                                                    </div>
                                                    <span class="addr-note">
                                                        <asp:Literal ID="litCount" runat="server"></asp:Literal>
                                                        lifts</span>
                                                </div>
                                                <asp:Repeater ID="rptLifts" runat="server" OnItemCommand="rptLifts_ItemCommand">
                                                    <HeaderTemplate>
                                                        <table class="table table-hover mb-0 lift-table">
                                                            <thead>
                                                                <tr class="lift-head">
                                                                    <th style="width: 40px;"></th>
                                                                    <th>Registration No.</th>
                                                                    <th>Type</th>
                                                                    <th>Make</th>
                                                                    <th>Serial No</th>
                                                                    <th>Capacity</th>
                                                                    <th>Approval date</th>
                                                                    <th>Amount</th>
                                                                    <th>Payment date</th>
                                                                    <th>View Report</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr id="trRow" runat="server">
                                                            <td>
                                                                <asp:CheckBox ID="CheckBox1" runat="server" CssClass="lift-chk" AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" />
                                                                <asp:HiddenField ID="hfCategory" runat="server" Value='<%# Eval("InstallationType") %>' />
                                                                <asp:HiddenField ID="hfRegNo" runat="server" Value='<%# Eval("RegistrationNo") %>' />
                                                                <asp:HiddenField ID="hfTestReportID" runat="server" Value='<%# Eval("TestReportID") %>' />
                                                                <asp:HiddenField ID="hfAmount" runat="server" Value='<%# Eval("Amount") %>' />
                                                                <asp:HiddenField ID="hfRowDistrict" runat="server" Value='<%# Eval("ApplicantDistrict") %>' />
                                                            </td>
                                                            <td><b><%# Server.HtmlEncode(Convert.ToString(Eval("RegistrationNo"))) %></b></td>
                                                            <td><%# Eval("InstallationType") %></td>
                                                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Make"))) %></td>
                                                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("SerialNo"))) %></td>
                                                            <td><%# Convert.ToString(Eval("InstallationType")) == "Escalator" ? "N/A" : Server.HtmlEncode(Convert.ToString(Eval("Capacity"))) + " persons" %></td>
                                                            <td><%# Eval("LastApprovalDate") %></td>
                                                            <td><%# Eval("Amount") %></td>
                                                            <td><%# Eval("LastPaymentDate", "{0:dd/MM/yyyy}") %></td>
                                                            <td>
                                                                <asp:LinkButton ID="lnkRedirect1" runat="server" Text="View Report" CommandName="Select" CausesValidation="false" />
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate></tbody></table></FooterTemplate>
                                                </asp:Repeater>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <label id="LblGridView1" runat="server"></label>
                    </div>
                </asp:Panel>
            </div>
            <div id="FeesDetails" class="renewal-font-section renewal-section" runat="server" visible="false">
                <h3 class="renewal-section-title">Fees Details</h3>
                <div class="renewal-section-body">
                    <h7 class="card-title fw-semibold mb-4 section-note" style="color: brown">
                        Note : Before proceeding to document checklist kindly pay your requisite fees first and then upload documents along with the treasury challan (PDF).
                    </h7>
                    <h4 class="section-note" style="color: red; margin: 20px;">-- 0043-51-102-51-51 Fees under the Indian Electr
                            icity Rules</h4>
                    <div class="renewal-table-scroll">
                        <asp:GridView class="table table-hover table-striped" Autopostback="true" ID="GridViewPayment" OnRowDataBound="GridViewPayment_RowDataBound" runat="server" Width="100%"
                            AutoGenerateColumns="false" BorderWidth="1px" BorderColor="#dbddff" ShowFooter="true">
                            <PagerStyle CssClass="pagination-ys" />
                            <Columns>
                                <asp:TemplateField HeaderText="Id" Visible="False">
                                    <ItemTemplate>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SNo">
                                    <HeaderStyle Width="5%" CssClass="headercolor" />
                                    <ItemStyle Width="5%" />
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Installation Type">
                                    <HeaderStyle HorizontalAlign="Left" Width="30%" CssClass="headercolor" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblInstallationType" runat="server" Text='<%#Eval("InstallationType") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="InstallationType" runat="server" Text="Total" Style="font-weight: bold;"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="No. of Lift/Escalator for Inspection">
                                    <HeaderStyle HorizontalAlign="Left" Width="30%" CssClass="headercolor" />
                                    <ItemStyle HorizontalAlign="Left" Width="30%" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Quantity") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblFooterQuantity" runat="server" Text="0" Style="font-weight: bold;"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Amount">
                                    <HeaderStyle HorizontalAlign="Left" Width="25%" CssClass="headercolor" />
                                    <ItemStyle HorizontalAlign="Left" Width="25%" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblInstallationAmount" runat="server" Text='<%#Eval("TotalAmount") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblFooterAmount" runat="server" Text="0" Style="font-weight: bold;"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Center" />
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#00547E" />
                        </asp:GridView>
                    </div>
                    <div id="TotalPayment" runat="server" visible="false" class="row" style="margin-bottom: -30px; margin-top: 30px;">
                        <div class="row" style="margin-left: 0%; margin-top: 6px;">
                        </div>
                    </div>
                </div>
            </div>
            <div id="UploadDocuments" class="renewal-font-section renewal-section" runat="server" visible="False">
                <h3 class="renewal-section-title">Document Checklist</h3>
                <div class="renewal-section-body">
                    <h7 class="card-title section-note" style="color: #a52a2a; margin-bottom: 5px;">Note: Size of all the Attachments should not be more than 2mb.</h7>
                    <div class="row">
                        <div class="col-12">
                            <div class="renewal-table-scroll">
                                <asp:GridView class="table table-hover table-striped" ID="Grd_Document" runat="server" Width="100%" AutoGenerateColumns="false">
                                    <PagerStyle CssClass="pagination-ys" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="SNo">
                                            <HeaderStyle Width="5%" CssClass="headercolor" />
                                            <ItemStyle Width="5%" />
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="DocumentName" HeaderText="DocumentName">
                                            <HeaderStyle HorizontalAlign="Left" Width="70%" CssClass="headercolor leftalign" />
                                            <ItemStyle HorizontalAlign="Left" Width="70%" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="File Upload (1MB PDF Only)">
                                            <HeaderStyle HorizontalAlign="Left" CssClass="headercolor leftalign" />
                                            <ItemTemplate>
                                                <%--<input type="hidden" id="Req" runat="server" value='<%# Eval("Req") %>' />--%>
                                                <input type="hidden" id="DocumentShortName" runat="server" value='<%# Eval("DocumentShortName") %>' />
                                                <input type="hidden" id="DocumentName" data-req='<%# Eval("DocumentName") %>' />
                                                <input type="hidden" id="DocumentID" runat="server" value='<%# Eval("DocumentID") %>' />
                                                <asp:FileUpload ID="FileUpload1" runat="server" OnClientClick="return validateFileUpload(this);" onchange="return validateFileUpload(this);" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Id" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="LblDocumentID" runat="server" Text='<%#Eval("DocumentID") %>'></asp:Label>
                                                <asp:Label ID="LblDocumentName" runat="server" Text='<%#Eval("DocumentName") %>'></asp:Label>
                                                <asp:Label ID="LblShortName" runat="server" Text='<%#Eval("DocumentShortName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <HeaderStyle BackColor="#9292cc" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Center" />
                                    <RowStyle ForeColor="#000066" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="PaymentDetails" class="renewal-font-section renewal-section" runat="server" visible="False">
                <h3 class="renewal-section-title">Payment Details</h3>
                <div id="ChallanDetail" runat="server" visible="false" class="renewal-section-body">

                    <div class="row renewal-payment-fields">
                        <div class="col-4">
                            <label>
                                GRN Number<samp style="color: red"> * </samp>
                            </label>
                            <asp:TextBox ID="txttransactionId" runat="server" class="form-control" MaxLength="20" Font-Size="12px" Style="height: 30px;" onkeypress="return isAlphaNumeric(event);"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="txttransactionId" ErrorMessage="Required" Display="Dynamic" ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txttransactionId" ValidationGroup="Submit" Display="Dynamic"
                                ForeColor="Red" ErrorMessage="GRN No. must be exactly 10 alphanumeric characters." ValidationExpression="^[a-zA-Z0-9]{10}$"> </asp:RegularExpressionValidator>
                        </div>
                        <div class="col-4">
                            <label>
                                Transaction Date<samp style="color: red"> * </samp>
                            </label>
                            <asp:TextBox ID="txttransactionDate" onfocus="disableFutureDates()" min='0000-01-01' onkeydown="return false;" max='9999-01-01' TextMode="Date" runat="server" class="form-control" Font-Size="12px" Style="height: 30px;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="txttransactionDate" ErrorMessage="Required" Display="Dynamic" ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-4" style="margin-top: auto; margin-bottom: auto;">
                            <label>
                                Payment Mode
                            </label>
                            <asp:RadioButtonList ID="RadioButtonList2" AutoPostBack="true" runat="server" RepeatDirection="Horizontal" TabIndex="25">
                                <asp:ListItem Text="Online" Value="0" Enabled="false"></asp:ListItem>
                                <asp:ListItem Text="Offline" Value="1" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="rfvRbList" runat="server" ControlToValidate="RadioButtonList2" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Please select a value" Display="Dynamic" />
                        </div>
                    </div>
                </div>

            </div>
            <div id="InspectionRemarks" runat="server" visible="False" class="renewal-font-section renewal-section renewal-remarks">
                <h3 class="renewal-section-title">Inspection Remarks</h3>
                <div class="row">
                    <div class="col-md-12">
                        <label for="Remarks">
                            Inspection Remarks<samp style="color: red"> * </samp>
                        </label>
                        <asp:TextBox class="form-control" ID="txtInspectionRemarks" runat="server" autocomplete="off" MaxLength="500" Style="margin-left: 18px" TabIndex="3"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtInspectionRemarks" ErrorMessage="Required" ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-4"></div>
            <div class="col-4" style="text-align: center;">
                <asp:Button ID="btnSubmit" Text="Submit" OnClick="btnSubmit_Click" runat="server" ValidationGroup="Submit" class="btn btn-primary mr-2" Visible="false" />
                <asp:Button type="submit" ID="btnReset" Text="Reset" runat="server" Visible="false" class="btn btn-primary mr-2" />
                <asp:Button type="Back" ID="btnBack" Text="Back" runat="server" Visible="false" class="btn btn-primary mr-2" />
            </div>
            <asp:HiddenField ID="hdnInstallationType" runat="server" />
            <%--   <asp:HiddenField ID="HdnDistrict" runat="server" />--%>
            <%-- <asp:HiddenField ID="HdnDivision" runat="server" />--%>
            <asp:HiddenField ID="InspectionIdClientSideCheckedRow" runat="server" />
            <asp:HiddenField ID="HdnUserID" runat="server" />
            <div class="col-4"></div>
        </div>
    </div>
    <script type="text/javascript">
        // Validate if the file is a PDF and the size is less than 1MB
        function validateFileUpload(sender) {
            var fileUpload = sender;
            var filePath = fileUpload.value;
            var fileExtension = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();
            var fileSize = fileUpload.files[0].size; // Size in bytes

            // Check file extension
            if (fileExtension !== "pdf") {
                alert("Only PDF files are allowed.");
                fileUpload.value = ""; // Clear the file input
                return false;
            }

            // Check file size (1MB = 1048576 bytes)
            if (fileSize > 1048576) {
                alert("File size should not exceed 1MB.");
                fileUpload.value = ""; // Clear the file input
                return false;
            }

            return true;
        }
    </script>
    <script type="text/javascript">
        function alertWithRedirectdata() {
            if (confirm('Inspection Applied successfully.')) {
                window.location.href = "/SiteOwnerPages/LiftPeriodic.aspx";
            } else {
            }
        }
    </script>
    <%-- <script type="text/javascript">

        function alertWithRedirectdata() {
            alert('Inspection Request Submitted Successfully, forwarding to concerned officer.');
            window.location.href = "/SiteOwnerPages/Periodic_Lift_EscalatorInspectionRequestPrint.aspx";
        }
</script>--%>
    <script type="text/javascript">
        function disableFutureDates() {
            // Get today's date in YYYY-MM-DD format
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0'); // Month is 0-indexed
            var yyyy = today.getFullYear();

            today = yyyy + '-' + mm + '-' + dd; // Format the date as YYYY-MM-DD

            // Set the max date to today's date
            document.getElementById('<%= txttransactionDate.ClientID %>').setAttribute('max', today);
        }

        // Call the function to set the max date when the page loads
        window.onload = disableFutureDates;
    </script>
    <script type="text/javascript">
        function isAlphaNumeric(evt) {
            var charCode = evt.which ? evt.which : evt.keyCode;
            var charStr = String.fromCharCode(charCode);
            // Allow only letters (a-z, A-Z) and digits (0-9)
            if (!/^[a-zA-Z0-9]$/.test(charStr)) {
                evt.preventDefault();
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
