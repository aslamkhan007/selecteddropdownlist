<%@ Page Title="" Language="C#" MasterPageFile="~/SiteOwnerPages/SiteOwner.Master" AutoEventWireup="true" CodeBehind="LiftPeriodicRenewalExistingAll.aspx.cs" Inherits="CEIHaryana.SiteOwnerPages.LiftPeriodicRenewalExistingAll" %>

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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://kit.fontawesome.com/57676f1d80.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/solid.min.css" integrity="sha512-P9pgMgcSNlLb4Z2WAB2sH5KBKGnBfyJnq+bhcfLCFusrRc4XdXrhfDluBl/usq75NF5gTDIMcwI1GaG5gju+Mw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        th.headercolor { background: #9292cc; color: white; }
        .table-dark { text-align: center !important; background-color: #9292cc !important; }
        .form-control { box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px; margin-left: 0px !important; height: 30px; }
        select.form-control { box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px; margin-left: 0px !important; height: 30px; }
        label { font-size: 13px; }
        .form-control:focus { border: 2px solid #80bdff; }
        .card .card-title { font-size: 1rem !important; }
        .card { box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px; }
        .btn-primary:hover { box-shadow: rgba(50, 50, 93, 0.25) 0px 30px 60px -12px inset, rgba(0, 0, 0, 0.3) 0px 18px 36px -18px inset; }
        input[type="radio"], input[type="checkbox"] { margin-right: 5px; box-sizing: border-box; padding: 0; }
        .table-responsive { width: 100%; }
        .record-scroll { max-height: 600px; overflow-y: auto; }

        /* Popups */
        .info-modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 1050; }
        .info-modal-box { background: #fff; border-radius: 8px; width: 90%; max-width: 900px; max-height: 85vh; display: flex; flex-direction: column; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.3); }
        .info-modal-header { display: flex; justify-content: space-between; align-items: center; padding: 12px 20px; border-bottom: 1px solid #dee2e6; background: #9292cc; color: white; border-radius: 8px 8px 0 0; }
        .info-modal-header h5 { margin: 0; font-size: 16px; }
        .info-modal-close { background: none; border: none; color: white; font-size: 26px; line-height: 1; cursor: pointer; }
        .info-modal-body { padding: 20px; overflow-y: auto; }
        .info-modal-body .info-item { border: 1px solid #ccc; border-radius: 4px; }
        .info-modal-footer { padding: 10px 20px; border-top: 1px solid #dee2e6; text-align: right; }
        .info-item { margin-bottom: 14px; }
        .info-item .info-label { display: block; font-size: 12px; color: #6c757d; margin-bottom: 2px; }
        .info-item .info-value { display: block; font-size: 14px; font-weight: 600; color: #252525; word-break: break-word; }
        #moreInfoModal { z-index: 1060; }
        #moreInfoModal .info-modal-box { overflow: hidden; }
        #moreInfoModal .info-modal-header,
        #moreInfoModal .info-modal-footer { flex-shrink: 0; }
        #moreInfoModal .info-modal-body {
            flex: 1 1 auto;
            min-height: 0;
            padding: 20px;
        }
        #moreInfoModal .info-modal-body > .row {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 14px;
            margin: 0;
        }
        #moreInfoModal .info-item {
            width: auto;
            max-width: none;
            min-width: 0;
            margin: 0;
            padding: 12px 14px;
            border: 1px solid #dce0e8;
            border-radius: 6px;
            background: #f8f9fc;
        }
        #moreInfoModal .info-item.col-md-12 { grid-column: 1 / -1; }
        #moreInfoModal .info-label { margin-bottom: 6px; line-height: 1.4; }
        #moreInfoModal .info-value { line-height: 1.5; overflow-wrap: anywhere; }
        @media (max-width: 767.98px) {
            #moreInfoModal .info-modal-body > .row { grid-template-columns: repeat(2, minmax(0, 1fr)); }
        }
        @media (max-width: 575.98px) {
            #moreInfoModal .info-modal-body { padding: 14px; }
            #moreInfoModal .info-modal-body > .row { grid-template-columns: minmax(0, 1fr); gap: 10px; }
        }

        /* Keep the document table layout separate from the other popups. */
        #docModal .info-modal-box {
            width: calc(100% - 32px);
            max-width: 1100px;
            overflow: hidden;
        }
        #docModal .info-modal-header,
        #docModal .info-modal-footer { flex-shrink: 0; }
        #docModal .info-modal-body {
            flex: 1 1 auto;
            min-height: 0;
            min-width: 0;
        }
        #docModal .info-modal-body > .row { row-gap: 14px; margin-bottom: 16px; }
        #docModal .info-modal-body > .row label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            font-weight: 600;
            color: #252525;
        }
        #docModal .form-control {
            width: 100%;
            min-width: 0;
            height: 38px;
            padding: 7px 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 14px;
            line-height: 1.5;
            color: #252525;
            background-color: #fff;
            box-sizing: border-box;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
        }
        #docModal .form-control[readonly] { background-color: #f4f6fb; }
        #docModal .form-control:focus {
            border: 1px solid #9292cc;
            outline: 0;
            box-shadow: 0 0 0 3px rgba(146, 146, 204, 0.2);
        }
        #docModal .document-table-scroll {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        #docModal .document-table {
            display: table;
            width: 100%;
            min-width: 760px;
            table-layout: fixed;
            margin-bottom: 0;
        }
        #docModal .document-table th,
        #docModal .document-table td {
            padding: 12px;
            vertical-align: middle;
            text-align: left;
            white-space: normal;
            overflow-wrap: anywhere;
        }
        #docModal .document-table th:first-child,
        #docModal .document-table td:first-child { width: 64px; text-align: center; }
        #docModal .document-table th:nth-child(2),
        #docModal .document-table td:nth-child(2) { width: 36%; text-align: left; }
        #docModal .document-table th:nth-child(4),
        #docModal .document-table td:nth-child(4) { width: 170px; }
        #docModal .document-table input[type="file"] {
            display: block;
            width: 100%;
            max-width: 100%;
            min-width: 0;
            font-size: 13px;
        }
        #docModal .document-table a { display: inline-block; margin-top: 0; }
        @media (max-width: 575.98px) {
            #docModal .info-modal-body { padding: 12px; }
            #docModal .info-modal-header,
            #docModal .info-modal-footer { padding: 12px; }
            #docModal .info-modal-body > .row > [class*="col-"] { margin-bottom: 12px; }
        }

        /* Stepper */
        .step-bar { display: flex; justify-content: center; align-items: center; flex-wrap: wrap; gap: 30px; width: 100%; margin: 10px auto 20px; font-size: 13px; color: #6c757d; }
        .step-bar .step { display: flex; align-items: center; gap: 8px; }
        .step-bar .num { width: 28px; height: 28px; border-radius: 50%; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background: #fff; }
        .step-bar .step.active { color: #1a3fb0; font-weight: 600; }
        .step-bar .step.active .num { background: #1a3fb0; color: #fff; border-color: #1a3fb0; }

        /* Address blocks */
        .addr-block { border: 1px solid #ccc; border-radius: 6px; margin-bottom: 15px; overflow: hidden; }
        .addr-head { 
            background: #eceaf7; 
            color: #252525; 
            padding: 8px 12px; 
            font-size: 14px; }
        .addr-pin { color: #1a3fb0; font-size: 22px; margin-right: 10px; }
        .addr-note { font-size: 12px; color: #6c757d; font-weight: 400; }
        .lift-head th { background: #9292cc; color: #fff; font-size: 13px; }
        .lift-table th, .lift-table td { text-align: left !important; vertical-align: middle; font-size: 14px; }
        .lift-table td { color: #252525; }
        .lift-table tr.row-selected td { background: #e6f4ec !important; }
        .lift-chk input { width: 16px; height: 16px; }
        .pill { display: inline-block; padding: 3px 10px; border-radius: 12px; font-size: 12px; }
        .pill-ok { background: #dff3e6; color: #1e7e45; }
        .pill-pending { background: #eee; color: #777; }
        .btn-act { border: 1px solid #6c7ae0; background: #fff; color: #1a3fb0; border-radius: 5px; padding: 3px 10px; font-size: 12px; font-weight: 600; }

        /* Bottom bar */
        .sel-bar { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; margin-top: 15px; padding: 12px; background: #f4f6fb; border-radius: 8px; }
        .sel-box { margin-left: auto; border: 1px solid #ddd; background: #fff; border-radius: 8px; padding: 8px 14px; font-size: 12px; }
        .sel-box .big { font-size: 20px; font-weight: 700; color: #252525; }
        .note-info { margin-top: 10px; padding: 10px 14px; background: #eef2ff; border-radius: 6px; font-size: 12px; color: #3b4a8c; }
   th {
    font-size: 15px !important;
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
        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="card-body" style="box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px; background: white; padding: 25px; margin-bottom: 25px; border-radius: 10px; margin-top: 10px;">
            <div class="card-title" style="margin-bottom: 5px; font-size: 22px; font-weight: 600; margin-left: -10px; text-align: center;">
                Lift/Escalator Renewal
            </div>
            <div style="text-align: center; color: #6c757d; font-size: 13px; margin-bottom: 5px;">
                Upload documents for each lift, then create an inspection request for the selected lifts.
            </div>
            <div class="step-bar">
                <div class="step active"><span class="num">1</span> Review lifts &amp; documents</div>
                <div class="step"><span class="num">2</span> Raise inspection request</div>
            </div>

            <div id="divSelectRecord" runat="server">
<%--                <div class="row align-items-center" style="margin-bottom: 10px;">
                    <div class="col-md-12 text-end" style="text-align: right">
                        <asp:Label ID="lblAddNew" runat="server" Text="Click To Add Existing Lift/Escalator which not added" Style="font-weight: 600; margin-right: 10px;"></asp:Label>
                        <asp:Button ID="btnAddnew" runat="server" OnClick="btnAddnew_Click" CssClass="btn btn-primary" Text="Add Lift/Escalator" CausesValidation="false" />
                    </div>
                </div>--%>

                <div class="record-scroll">
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
                                        lifts &bull; Requests can include lifts at this address only</span>
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
                                                    <th>Capacity</th>
                                                    <th>Documents</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkSel" runat="server" CssClass="lift-chk"
                                                    data-addr='<%# Eval("AddrNo") %>'
                                                    data-complete='<%# Convert.ToString(Eval("DocStatus")) == "Completed" ? "1" : "0" %>' />
                                                <asp:HiddenField ID="hfKey" runat="server" Value='<%# Eval("InstallationType") + "|" + Eval("RegistrationNo") %>' />
                                            </td>
                                            <td><b><%# Server.HtmlEncode(Convert.ToString(Eval("RegistrationNo"))) %></b></td>
                                            <td><%# Eval("InstallationType") %></td>
                                            <td><%# Server.HtmlEncode(Convert.ToString(Eval("Make"))) %></td>
                                            <td><%# Convert.ToString(Eval("InstallationType")) == "Escalator" ? "N/A" : Server.HtmlEncode(Convert.ToString(Eval("Capacity"))) + " persons" %></td>
                                            <td>
                                                <span class='pill <%# Convert.ToString(Eval("DocStatus")) == "Completed" ? "pill-ok" : "pill-pending" %>' title='<%# Eval("DocInfo") %>'>
                                                    <i class='fa <%# Convert.ToString(Eval("DocStatus")) == "Completed" ? "fa-check-circle" : "fa-info-circle" %>'></i>
                                                    <%# Convert.ToString(Eval("DocStatus")) == "Completed" ? "Documents complete" : "Documents pending" %>
                                                </span>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="lnkUpload" runat="server" CssClass="btn-act" CommandName="Upload" CausesValidation="false"
                                                    CommandArgument='<%# Eval("InstallationType") + "|" + Eval("RegistrationNo") %>'
                                                    Visible='<%# Convert.ToString(Eval("DocStatus")) != "Completed" %>'>
                                                    <i class="fa fa-upload"></i> Upload documents</asp:LinkButton>
                                                <asp:LinkButton ID="lnkEdit" runat="server" CssClass="btn-act" CommandName="Edit" CausesValidation="false"
                                                    CommandArgument='<%# Eval("InstallationType") + "|" + Eval("RegistrationNo") %>'
                                                    Visible='<%# Convert.ToString(Eval("DocStatus")) == "Completed" %>'>
                                                    <i class="fa fa-edit"></i> Edit documents</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate></tbody></table></FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <label id="LblGridView1" runat="server"></label>
                </div>
            </div>

            <div class="note-info">
                <i class="fa fa-info-circle"></i>
                Only lifts with all mandatory documents uploaded can be selected. Lifts at different addresses require separate inspection requests.
            </div>

            <div class="sel-bar">
                <asp:Button ID="btnSubmit" runat="server" Text="Goto inspection request →" OnClick="btnSubmit_Click" CausesValidation="false" CssClass="btn btn-primary" />
                <a href="javascript:void(0);" onclick="clearSel();" style="font-weight: 600;"><i class="fa fa-rotate-right"></i> Clear selection</a>
                <span id="selText" style="font-size: 13px; color: #555;">0 lifts selected</span>
                <div class="sel-box">
                    Selected lifts<br />
                    <span class="big" id="selCount">0</span><br />
                    Inspection fee: Calculated on next step
                </div>
            </div>
            <div style="margin-top: 15px;">
                <asp:Button ID="btnBack" OnClick="btnBack_Click" Text="Back" runat="server" class="btn btn-primary" CausesValidation="false" />
            </div>
        </div>
    </div>

    <%-- Documents modal (Upload / Edit) --%>
    <div id="docModal" class="info-modal-overlay">
        <div class="info-modal-box">
            <div class="info-modal-header">
                <h5>
                    <asp:Label ID="lblModalTitle" runat="server" Text="Upload Documents"></asp:Label></h5>
                <button type="button" class="info-modal-close" onclick="closeDocModal()" aria-label="Close">&times;</button>
            </div>
            <div class="info-modal-body">
                <div class="row">
                    <div class="col-md-4">
                        <label>Registration No.</label>
                        <asp:TextBox class="form-control" ID="txtRegistrationNo" ReadOnly="true" autocomplete="off" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label>Last Expiry Date</label>
                        <asp:TextBox type="date" class="form-control" ID="txtExpiryDate" ReadOnly="true" autocomplete="off" runat="server" Style="width: 100% !important;"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label>Last date of payment</label>
                        <asp:TextBox type="date" class="form-control" ID="txtLastdateOfPayment" autocomplete="off" runat="server" Style="width: 100% !important;"></asp:TextBox>
                    </div>
                </div>
                <div style="margin: 8px 0 12px;">
                    <a href="javascript:void(0);" onclick="openInfoModal(); return false;" style="font-size: 13px; font-weight: 600;">
                        <i class="fa fa-info-circle"></i>&nbsp;More Info</a>
                </div>

                <div class="document-table-scroll" role="region" aria-label="Documents to upload" tabindex="0">
                <asp:GridView CssClass="table table-bordered table-hover table-striped document-table" ID="Grd_Document" runat="server" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="SNo" HeaderText="SNo" />
                        <asp:TemplateField HeaderText="Document Name">
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblDocumentName" runat="server" Text='<%#Eval("DocumentName") %>'></asp:Label>
                                <asp:Label ID="lblMandatory1" runat="server" Text="*" ForeColor="Red" Visible='<%# Eval("DocumentName").ToString() != "Other Document" %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="File Upload (1MB PDF Only)">
                            <ItemTemplate>
                                <asp:FileUpload ID="FileUpload1" runat="server" onchange="return validateFileUpload(this);" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Uploaded File">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkExisting" runat="server" Target="_blank" Text="View uploaded file"
                                    NavigateUrl='<%# Eval("ExistingPath") %>'
                                    Visible='<%# !string.IsNullOrEmpty(Convert.ToString(Eval("ExistingPath"))) %>'></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Id" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="LblDocumentID" runat="server" Text='<%#Eval("DocumentID") %>'></asp:Label>
                                <asp:Label ID="LblShortName" runat="server" Text='<%#Eval("DocumentShortName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle BackColor="#9292cc" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle ForeColor="#252525" />
                </asp:GridView>
                </div>
            </div>
            <div class="info-modal-footer">
                <asp:Button ID="btnSaveDocs" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSaveDocs_Click" CausesValidation="false" />
                <button type="button" class="btn btn-secondary" onclick="closeDocModal()">Close</button>
            </div>
        </div>
    </div>

    <%-- More Info popup (display only) --%>
    <div id="moreInfoModal" class="info-modal-overlay" onclick="if (event.target === this) closeInfoModal();">
        <div class="info-modal-box">
            <div class="info-modal-header">
                <h5>Registration Details</h5>
                <button type="button" class="info-modal-close" onclick="closeInfoModal()" aria-label="Close">&times;</button>
            </div>
            <div class="info-modal-body">
                <div class="row">
                    <div class="col-md-4 info-item"><span class="info-label">Installation Type</span><asp:Label ID="lblInfoInstallationType" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Make</span><asp:Label ID="lblInfoMake" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Serial No.</span><asp:Label ID="lblInfoSerialNo" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Type of Lift / Escalator</span><asp:Label ID="lblInfoType" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Type of Control</span><asp:Label ID="lblInfoControl" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Date of Erection</span><asp:Label ID="lblInfoErection" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Capacity (Persons)</span><asp:Label ID="lblInfoCapacity" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Capacity (In Kg)</span><asp:Label ID="lblInfoWeight" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">District</span><asp:Label ID="lblInfoDistrict" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Memo No.</span><asp:Label ID="lblInfoMemoNo" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-4 info-item"><span class="info-label">Memo Date</span><asp:Label ID="lblInfoMemoDate" runat="server" CssClass="info-value"></asp:Label></div>
                    <div class="col-md-12 info-item"><span class="info-label">Site Address</span><asp:Label ID="lblInfoSiteAddress" runat="server" CssClass="info-value"></asp:Label></div>
                </div>
            </div>
            <div class="info-modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeInfoModal()">Close</button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openInfoModal() { document.getElementById("moreInfoModal").style.display = "flex"; }
        function closeInfoModal() { document.getElementById("moreInfoModal").style.display = "none"; }
        function openDocModal() { document.getElementById("docModal").style.display = "flex"; }
        function closeDocModal() { document.getElementById("docModal").style.display = "none"; }

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                if (document.getElementById("moreInfoModal").style.display === "flex") closeInfoModal();
                else closeDocModal();
            }
        });

        // PDF only, max 1MB
        function validateFileUpload(sender) {
            if (!sender.files || sender.files.length === 0) return true;
            var filePath = sender.value;
            var ext = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();
            if (ext !== "pdf") { alert("Only PDF files are allowed."); sender.value = ""; return false; }
            if (sender.files[0].size > 1048576) { alert("File size should not exceed 1MB."); sender.value = ""; return false; }
            return true;
        }

        // Selection: sirf completed rows, aur sirf ek hi address ki
        function updateSel() {
            var chks = document.querySelectorAll('.lift-chk input[type=checkbox]');
            var addr = null, n = 0;
            chks.forEach(function (c) {
                if (c.checked) { n++; addr = c.parentNode.getAttribute('data-addr'); }
            });
            chks.forEach(function (c) {
                var sp = c.parentNode;
                var ok = sp.getAttribute('data-complete') === '1';
                var other = (addr !== null && sp.getAttribute('data-addr') !== addr);
                c.disabled = !ok || other;
                var tr = c.closest('tr');
                if (tr) tr.classList.toggle('row-selected', c.checked);
            });
            document.getElementById('selCount').innerText = n;
            document.getElementById('selText').innerText =
                n === 0 ? '0 lifts selected' : n + ' lift' + (n > 1 ? 's' : '') + ' selected at Address ' + addr;
            document.getElementById('<%= btnSubmit.ClientID %>').disabled = (n === 0);
        }
        function clearSel() {
            document.querySelectorAll('.lift-chk input[type=checkbox]').forEach(function (c) { c.checked = false; });
            updateSel();
        }
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.lift-chk input[type=checkbox]').forEach(function (c) {
                c.addEventListener('change', updateSel);
            });
            updateSel();

            // Date limits
            var today = new Date();
            var minDate = new Date(); minDate.setFullYear(today.getFullYear() - 20);
            var nextMonth = new Date(today); nextMonth.setMonth(today.getMonth() + 1);
            var fToday = today.toISOString().split('T')[0];
            var fMin = minDate.toISOString().split('T')[0];
            var fNext = nextMonth.toISOString().split('T')[0];

            var txtExp = document.getElementById('<%= txtExpiryDate.ClientID %>');
            if (txtExp) { txtExp.setAttribute("max", fNext); txtExp.setAttribute("min", fMin); }
            var txtPay = document.getElementById('<%= txtLastdateOfPayment.ClientID %>');
            if (txtPay) { txtPay.setAttribute("max", fToday); txtPay.setAttribute("min", fMin); }
        });

        function alertWithRedirectdata() {
            if (confirm('Documents Submitted successfully.')) {
                window.location.href = "/SiteOwnerPages/LiftPeriodic.aspx";
            }
        }
        function alertWithReturnRedirectdata() {
            if (confirm('Documents Submitted successfully.')) {
                window.location.href = "/SiteOwnerPages/ReturnLiftInspections.aspx";
            }
        }
    </script>
</asp:Content>
