<%@ Page Language="C#" MasterPageFile="~/SiteOwnerPages/SiteOwner.Master" AutoEventWireup="true" CodeBehind="TotalComponentSummary.aspx.cs" Inherits="CEIHaryana.SiteOwnerPages.TotalComponentSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="shortcut icon" type="image/png" href="/css2/style.min.css" />
    <link rel="stylesheet" href="/css2/style.css" />
    <!-- CSS -->
    <link rel="shortcut icon" type="image/png" href="/css2/style.min.css" />
    <link rel="stylesheet" href="/css2/style.css" />
    <!-- Bootstrap 4.6.2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- DataTables with Bootstrap 4 CSS -->
    <link href="https://cdn.datatables.net/1.13.11/css/dataTables.bootstrap4.min.css" rel="stylesheet" />

    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />

    <!-- Font Awesome 6.5.2 CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet" />
    <!-- jQuery 3.5.1 (must be first) -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <!-- DataTables Core -->
    <script src="https://cdn.datatables.net/1.13.11/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.11/js/dataTables.bootstrap4.min.js"></script>

    <!-- Popper.js (required by Bootstrap dropdowns/modals) -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Bootstrap 4.6.2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

    <!-- Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .headercolor {
            background-color: #9292cc;
        }

        .col-4 {
            margin-bottom: 8px;
        }

        .form-control {
            box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
            margin-left: 0px !important;
            height: 30px;
            padding-top: 1px;
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
            color: #fff;
            background-color: #9292cc;
            border-color: #9292cc;
        }

        .btn-primary {
         background-color: #9292cc; 
         border-color: #9292cc;
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

        th.textjustify {
            text-align: justify;
        }

        td.owner-name {
            text-align: justify;
        }

        select#ContentPlaceHolder1_ddldivision {
            padding: 0px 0px 3px 5px;
        }

        .form-group label {
            font-size: 16px !important;
        }

        th {
            background: #9292cc;
        }

        input#ContentPlaceHolder1_RadioButtonList1_0 {
            margin-right: 7px;
        }

        input#ContentPlaceHolder1_RadioButtonList1_1 {
            margin-left: 10px;
            margin-right: 7px;
        }

        .PowerUtilityRowColor {
            background-color: rgb(255, 205, 210) !important;
        }

        .modal-content {
            width: 1000px !important;
            right: 20%;
        }

        .fade {
            transition: opacity 0.15s linear;
            height: 100% !important;
            width: 100% !important;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="card" style="box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px; border-radius: 5px !important">
            <div class="card-body">
                <div class="row ">                    
                        <div class="col-sm-12 col-md-12" style="text-align: center;">
                        <h6 class="card-title fw-semibold mb-4">
                            <asp:Label ID="lblPreviewPage" runat="server"></asp:Label>
                        </h6>
                    </div>
                </div>
                    
                <div class="card-body" style="box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px; padding: 25px; margin-bottom: 25px; border-radius: 10px; margin-top: 10px;">
                    <asp:GridView class="table-responsive table table-striped table-hover" ID="TransformerGridView" runat="server" Width="100%" AutoGenerateColumns="false"
                        OnRowCommand="TransformerGridView_RowCommand" AllowPaging="true" PageSize="200" OnPageIndexChanging="TransformerGridView_PageIndexChanging" BorderWidth="1px" BorderColor="#dbddff">
                        <Columns>
                            <asp:TemplateField HeaderText="Id" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="TransformerSerialNumberLbl" runat="server" Text='<%#Eval("TransformerSerialNumber") %>'></asp:Label>
                                    <asp:Label ID="TypeLbl" runat="server" Text='<%#Eval("Type") %>'></asp:Label>
                                    <asp:Label ID="TransformerCapacityLbl" runat="server" Text='<%#Eval("TransformerCapacity") %>'></asp:Label>
                                    <asp:Label ID="TransformerCapacityTypeLbl" runat="server" Text='<%#Eval("TransformerCapacityType") %>'></asp:Label>
                                    <asp:Label ID="TranformerTypeLbl" runat="server" Text='<%# Eval("TranformerType") %>'></asp:Label>
                                    <asp:Label ID="PrimaryVoltageLbl" runat="server" Text='<%#Eval("PrimaryVoltage") %>'></asp:Label>
                                    <asp:Label ID="SecondoryVoltageLbl" runat="server" Text='<%#Eval("SecondoryVoltage") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SNo">
                                <HeaderStyle Width="5%" CssClass="headercolor" />
                                <ItemStyle Width="5%" />
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="TransformerSerialNumber" HeaderText="Transformer Serial Number">
                                <HeaderStyle HorizontalAlign="center" Width="28%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="28%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Type" HeaderText="Type">
                                <HeaderStyle HorizontalAlign="center" Width="28%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="28%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="TransformerCapacity" HeaderText="Transformer Capacity">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="TransformerCapacityType" HeaderText="Transformer Capacity Type">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="TranformerType" HeaderText="Tranformer Type">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="PrimaryVoltage" HeaderText="Primary Voltage">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="SecondoryVoltage" HeaderText="SecondoryVoltage">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Component Summary">
                                <HeaderStyle Width="5%" CssClass="headercolor" />
                                <ItemStyle Width="5%" CssClass="center" />
                                <ItemTemplate>
                                    <asp:LinkButton
                                        runat="server"
                                        ID="TransformerLinkButton"
                                        Style="padding: 5px 5px 5px 5px; font-size: 18px; border-radius: 3px;"
                                        Text='<i class="fa fa-eye" style="color:white !important;"></i>'
                                        CssClass="greenButton btn-primary"
                                        CommandName="View"
                                        CommandArgument="<%# Container.DataItemIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>


                            <%--<asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Transformer Serial Number
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblTransformerSerialNumber" runat="server" CommandArgument=' <%#Eval("TransformerSerialNumber") %> ' CommandName="Select"><%#Eval("TransformerSerialNumber") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Type of Transformer
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblTransformerType" runat="server" CommandArgument=' <%#Eval("Type") %> ' CommandName="Select"><%#Eval("Type") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Transformer Capacity
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblTransformerCapacity" runat="server" CommandArgument=' <%#Eval("TransformerCapacity") %> ' CommandName="Select"><%#Eval("TransformerCapacity") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Transformer Capacity Type
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblTransformerCapacityType" runat="server" CommandArgument=' <%#Eval("TransformerCapacityType") %> ' CommandName="Select"><%#Eval("TransformerCapacityType") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Tranformer Type
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblTranformerType" runat="server" CommandArgument=' <%#Eval("TranformerType") %> ' CommandName="Select"><%#Eval("TranformerType") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Primary Voltage
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblPrimaryVoltage" runat="server" CommandArgument=' <%#Eval("PrimaryVoltage") %> ' CommandName="Select"><%#Eval("PrimaryVoltage") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Secondory Voltage
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblSecondoryVoltage" runat="server" CommandArgument=' <%#Eval("SecondoryVoltage") %> ' CommandName="Select"><%#Eval("PrimaryVoltage") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
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

                    <asp:GridView class="table-responsive table table-striped table-hover" ID="GeneratingSetGridView" runat="server" Width="100%" AutoGenerateColumns="false"
                        OnRowCommand="GeneratingSetGridView_RowCommand" AllowPaging="true" PageSize="200" OnPageIndexChanging="GeneratingSetGridView_PageIndexChanging" BorderWidth="1px" BorderColor="#dbddff">
                        <Columns>
                            <asp:TemplateField HeaderText="Id" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="GeneratingSetSerialNumberLbl" runat="server" Text='<%#Eval("SerialNumbrOfAcGenerator") %>'></asp:Label>
                                    <asp:Label ID="GeneratingTypeLbl" runat="server" Text='<%#Eval("Type") %>'></asp:Label>
                                    <asp:Label ID="GeneratingSetCapacityLbl" runat="server" Text='<%#Eval("GeneratingSetCapacity") %>'></asp:Label>
                                    <asp:Label ID="GeneratingSetCapacityTypeLbl" runat="server" Text='<%#Eval("GeneratingSetCapacityType") %>'></asp:Label>
                                    <asp:Label ID="GeneratingSetTypeLbl" runat="server" Text='<%# Eval("GeneratingSetType") %>'></asp:Label>
                                    <asp:Label ID="GeneratingSetVoltageLbl" runat="server" Text='<%#Eval("GeneratorVoltageLevel") %>'></asp:Label>
                                    <asp:Label ID="GeneratingSetCurrenntCapacityOfBreakerLbl" runat="server" Text='<%#Eval("CurrenntCapacityOfBreaker") %>'></asp:Label>
                                    <asp:Label ID="GeneratingSetBreakingCapacityofBreakerLbl" runat="server" Text='<%# Eval("BreakingCapacityofBreaker") %>'></asp:Label>
                                    <asp:Label ID="GeneratingSetTypeOfPlantLbl" runat="server" Text='<%#Eval("TypeOfPlant") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SNo">
                                <HeaderStyle Width="5%" CssClass="headercolor" />
                                <ItemStyle Width="5%" />
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="SerialNumbrOfAcGenerator" HeaderText="Generating Set Serial Number">
                                <HeaderStyle HorizontalAlign="center" Width="28%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="28%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Type" HeaderText="Type">
                                <HeaderStyle HorizontalAlign="center" Width="28%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="28%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="GeneratingSetCapacity" HeaderText="Generating Set Capacity">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="GeneratingSetCapacityType" HeaderText="Generating Set Capacity Type">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="GeneratingSetType" HeaderText="Generating Set Type">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="GeneratorVoltageLevel" HeaderText="Generator Voltage Level">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="CurrenntCapacityOfBreaker" HeaderText="Currennt Capacity Of Breaker">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="BreakingCapacityofBreaker" HeaderText="Breaking Capacity Of Breaker">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="TypeOfPlant" HeaderText="Type Of Plant">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Component Summary">
                                <HeaderStyle Width="5%" CssClass="headercolor" />
                                <ItemStyle Width="5%" CssClass="center" />
                                <ItemTemplate>
                                    <asp:LinkButton
                                        runat="server"
                                        ID="GeneratingSetLinkButton"
                                        Style="padding: 5px 5px 5px 5px; font-size: 18px; border-radius: 3px;"
                                        Text='<i class="fa fa-eye" style="color:white !important;"></i>'
                                        CssClass="greenButton btn-primary"
                                        CommandName="View"
                                        CommandArgument="<%# Container.DataItemIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Generating Set Serial Number
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblSerialNumbrOfAcGenerator" runat="server" CommandArgument=' <%#Eval("SerialNumbrOfAcGenerator") %> ' CommandName="Select"><%#Eval("SerialNumbrOfAcGenerator") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Type of Generating Set
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblType" runat="server" CommandArgument=' <%#Eval("Type") %> ' CommandName="Select"><%#Eval("Type") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Generating Set Capacity
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblGeneratingSetCapacity" runat="server" CommandArgument=' <%#Eval("GeneratingSetCapacity") %> ' CommandName="Select"><%#Eval("GeneratingSetCapacity") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Generating Set Capacity Type
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblGeneratingSetCapacityType" runat="server" CommandArgument=' <%#Eval("GeneratingSetCapacityType") %> ' CommandName="Select"><%#Eval("GeneratingSetCapacityType") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Generating Set Type
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblGeneratingSetType" runat="server" CommandArgument=' <%#Eval("GeneratingSetType") %> ' CommandName="Select"><%#Eval("GeneratingSetType") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Voltage
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblGeneratorVoltageLevel" runat="server" CommandArgument=' <%#Eval("GeneratorVoltageLevel") %> ' CommandName="Select"><%#Eval("GeneratorVoltageLevel") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
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

                    <asp:GridView class="table-responsive table table-striped table-hover" ID="LineGridView" runat="server" Width="100%" AutoGenerateColumns="false"
                        OnRowCommand="LineGridView_RowCommand" AllowPaging="true" PageSize="200" OnPageIndexChanging="LineGridView_PageIndexChanging" BorderWidth="1px" BorderColor="#dbddff">
                        <Columns>
                            <asp:TemplateField HeaderText="Id" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="LineVoltageLbl" runat="server" Text='<%#Eval("LineVoltage") %>'></asp:Label>
                                    <asp:Label ID="TypeOfLineLbl" runat="server" Text='<%#Eval("Type") %>'></asp:Label>
                                    <asp:Label ID="LineLengthLbl" runat="server" Text='<%#Eval("LineLength") %>'></asp:Label>
                                    <asp:Label ID="LineTypeLbl" runat="server" Text='<%#Eval("LineType") %>'></asp:Label>
                                    <asp:Label ID="NoOfCircuitLbl" runat="server" Text='<%# Eval("NoOfCircuit") %>'></asp:Label>
                                    <asp:Label ID="ConductortypeLbl" runat="server" Text='<%#Eval("Conductortype") %>'></asp:Label>
                                    <asp:Label ID="NumberofPoleTowerLbl" runat="server" Text='<%#Eval("NumberofPoleTower") %>'></asp:Label>
                                    <asp:Label ID="ConductorSizeLbl" runat="server" Text='<%# Eval("ConductorSize") %>'></asp:Label>
                                    <asp:Label ID="GroundWireSizeLbl" runat="server" Text='<%#Eval("GroundWireSize") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SNo">
                                <HeaderStyle Width="5%" CssClass="headercolor" />
                                <ItemStyle Width="5%" />
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="LineVoltage" HeaderText="Line Voltage">
                                <HeaderStyle HorizontalAlign="center" Width="28%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="28%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Type" HeaderText="Type">
                                <HeaderStyle HorizontalAlign="center" Width="28%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="28%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="LineLength" HeaderText="Line Length">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="LineType" HeaderText="Line Type">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="NoOfCircuit" HeaderText="No Of Circuit">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Conductortype" HeaderText="Conductor Type">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="NumberofPoleTower" HeaderText="Number of Pole Tower">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="ConductorSize" HeaderText="Conductor Size">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="GroundWireSize" HeaderText="Ground Wire Size">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Component Summary">
                                <HeaderStyle Width="5%" CssClass="headercolor" />
                                <ItemStyle Width="5%" CssClass="center" />
                                <ItemTemplate>
                                    <asp:LinkButton
                                        runat="server"
                                        ID="LineLinkButton"
                                        Style="padding: 5px 5px 5px 5px; font-size: 18px; border-radius: 3px;"
                                        Text='<i class="fa fa-eye" style="color:white !important;"></i>'
                                        CssClass="greenButton btn-primary"
                                        CommandName="View"
                                        CommandArgument="<%# Container.DataItemIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Voltage
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblLineVoltage" runat="server" CommandArgument=' <%#Eval("LineVoltage") %> ' CommandName="Select"><%#Eval("LineVoltage") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Type of Line
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblType" runat="server" CommandArgument=' <%#Eval("Type") %> ' CommandName="Select"><%#Eval("Type") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Line Length
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblLineLength" runat="server" CommandArgument=' <%#Eval("LineLength") %> ' CommandName="Select"><%#Eval("LineLength") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Line Type
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblLineType" runat="server" CommandArgument=' <%#Eval("LineType") %> ' CommandName="Select"><%#Eval("LineType") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    No Of Circuit
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblNoOfCircuit" runat="server" CommandArgument=' <%#Eval("NoOfCircuit") %> ' CommandName="Select"><%#Eval("NoOfCircuit") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Conductor Type
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblConductortype" runat="server" CommandArgument=' <%#Eval("Conductortype") %> ' CommandName="Select"><%#Eval("Conductortype") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    No. of Pole Tower
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblNumberofPoleTower" runat="server" CommandArgument=' <%#Eval("NumberofPoleTower") %> ' CommandName="Select"><%#Eval("NumberofPoleTower") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Conductor Size
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblConductorSize" runat="server" CommandArgument=' <%#Eval("ConductorSize") %> ' CommandName="Select"><%#Eval("ConductorSize") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Ground Wire Size
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblGroundWireSize" runat="server" CommandArgument=' <%#Eval("GroundWireSize") %> ' CommandName="Select"><%#Eval("GroundWireSize") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
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

                    <asp:GridView class="table-responsive table table-striped table-hover" ID="LiftGridView" runat="server" Width="100%" AutoGenerateColumns="false"
                        OnRowCommand="LiftGridView_RowCommand" AllowPaging="true" PageSize="200" OnPageIndexChanging="LiftGridView_PageIndexChanging" BorderWidth="1px" BorderColor="#dbddff">
                        <Columns>
                            <asp:TemplateField HeaderText="Id" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="ComponentTypeLbl" runat="server" Text='<%#Eval("ComponentType") %>'></asp:Label>
                                    <asp:Label ID="SerialNoLbl" runat="server" Text='<%#Eval("SerialNo") %>'></asp:Label>
                                    <asp:Label ID="TypeOfLiftLbl" runat="server" Text='<%#Eval("TypeOfLift") %>'></asp:Label>
                                    <asp:Label ID="TypeOfControlLbl" runat="server" Text='<%#Eval("TypeOfControl") %>'></asp:Label>
                                    <asp:Label ID="WeightLbl" runat="server" Text='<%# Eval("Weight") %>'></asp:Label>
                                    <asp:Label ID="CapacityLbl" runat="server" Text='<%#Eval("Capacity") %>'></asp:Label>
                                    <asp:Label ID="MakeLbl" runat="server" Text='<%#Eval("Make") %>'></asp:Label>
                                    <asp:Label ID="RegistrationNolbl" runat="server" Text='<%#Eval("RegistrationNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SNo">
                                <HeaderStyle Width="5%" CssClass="headercolor" />
                                <ItemStyle Width="5%" />
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="RegistrationNo" HeaderText="Registration No">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="SerialNo" HeaderText="Serial No">
                                <HeaderStyle HorizontalAlign="center" Width="28%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="28%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="ComponentType" HeaderText="Component Type">
                                <HeaderStyle HorizontalAlign="center" Width="28%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="28%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="TypeOfLift" HeaderText="Type Of Lift">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="TypeOfControl" HeaderText="Type Of Control">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Weight" HeaderText="Weight">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Capacity" HeaderText="Capacity">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Make" HeaderText="Make">
                                <HeaderStyle HorizontalAlign="center" Width="15%" CssClass="headercolor" />
                                <ItemStyle HorizontalAlign="center" Width="15%" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Component Summary">
                                <HeaderStyle Width="5%" CssClass="headercolor" />
                                <ItemStyle Width="5%" CssClass="center" />
                                <ItemTemplate>
                                    <asp:LinkButton
                                        runat="server"
                                        ID="LiftLinkButton"
                                        Style="padding: 5px 5px 5px 5px; font-size: 18px; border-radius: 3px;"
                                        Text='<i class="fa fa-eye" style="color:white !important;"></i>'
                                        CssClass="greenButton btn-primary"
                                        CommandName="View"
                                        CommandArgument="<%# Container.DataItemIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Serial Number
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblSerialNo" runat="server" CommandArgument=' <%#Eval("SerialNo") %> ' CommandName="Select"><%#Eval("SerialNo") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Component Type
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblComponentType" runat="server" CommandArgument=' <%#Eval("ComponentType") %> ' CommandName="Select"><%#Eval("ComponentType") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Type Of Lift
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblTypeOfLift" runat="server" CommandArgument=' <%#Eval("TypeOfLift") %> ' CommandName="Select"><%#Eval("TypeOfLift") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Type Of Control
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblTypeOfControl" runat="server" CommandArgument=' <%#Eval("TypeOfControl") %> ' CommandName="Select"><%#Eval("TypeOfControl") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Weight
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblWeight" runat="server" CommandArgument=' <%#Eval("Weight") %> ' CommandName="Select"><%#Eval("Weight") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Capacity
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblCapacity" runat="server" CommandArgument=' <%#Eval("Capacity") %> ' CommandName="Select"><%#Eval("Capacity") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderStyle Width="10%" CssClass="headercolor" />
                                <ItemStyle Width="10%" Font-Bold="true" />
                                <HeaderTemplate>
                                    Make
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblMake" runat="server" CommandArgument=' <%#Eval("Make") %> ' CommandName="Select"><%#Eval("Make") %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
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

                    <div class="modal fade" id="ownerModal" tabindex="-1" role="dialog" aria-labelledby="ownerModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="ownerModalLabel">Owner Details</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body" id="modalBodyContent">
                                    <!-- Your custom static HTML or dynamic content -->
                                    <div class="row">

                                        <div class="col-md-4">
                                            <label>
                                                Applicant Type
                                                <samp style="color: red">* </samp>
                                            </label>
                                            <asp:TextBox class="form-control" ID="txttypeofapplicant" Visible="true" ReadOnly="true" TabIndex="1" MaxLength="10" oninput="this.value = this.value.toUpperCase();" AutoPostBack="true" autocomplete="off" runat="server"></asp:TextBox>
                                        </div>

                                        <div class="col-md-4" runat="server" id="DivPancard_TanNo" visible="true">

                                            <label id="LblTanNumber" runat="server" visible="true" for="TanNumber">
                                                PAN/TAN Number
                       <samp style="color: red">* </samp>
                                            </label>
                                            <asp:TextBox class="form-control" ID="txtPANTan" Visible="true" ReadOnly="true" TabIndex="1" MaxLength="10" oninput="this.value = this.value.toUpperCase();" AutoPostBack="true" autocomplete="off" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="col-md-4">
                                            <label>
                                                Electrical Installation For<samp style="color: red"> * </samp>
                                            </label>
                                            <asp:TextBox class="form-control" ID="txtElectricalInstallation" Visible="true" ReadOnly="true" TabIndex="1" MaxLength="10" oninput="this.value = this.value.toUpperCase();" AutoPostBack="true" autocomplete="off" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">


                                        <div class="col-md-4" id="individual" runat="server">
                                            <label id="LblNameofOwner" runat="server" for="Name">
                                                Name of Owner/ Org.<samp style="color: red"> * </samp>
                                            </label>

                                            <div class="input-box" style="padding-left: 0px !important;">
                                                <asp:TextBox class="form-control" ID="txtName" ReadOnly="true" TabIndex="4" onkeydown="return preventEnterSubmit(event)" onKeyPress="return alphabetKey(event)" MaxLength="50" placeholder="As Per Demand Notice of Utility or Electricity Bill" autocomplete="off" runat="server" Style="padding-left: 10px !important; padding: 0px; height: 30px; box-shadow: none !important; font-size: inherit;"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <label for="Address">
                                                Address of Site(As Per Demand Notice of Utility/Electricity Bill)
    <samp style="color: red">* </samp>
                                            </label>
                                            <%-- <asp:TextBox class="form-control" ID="txtAddress" onkeydown="return preventEnterSubmit(event)" autocomplete="off" runat="server" Style="margin-left: 18px"></asp:TextBox>--%>
                                            <asp:TextBox class="form-control" ID="txtAddress" ReadOnly="true" onkeydown="return preventEnterSubmit(event)" autocomplete="off" MaxLength="100" TabIndex="5" runat="server" Style="width: 100%;"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="col-md-4" runat="server">
                                            <label for="Pin">State</label>
                                            <asp:TextBox class="form-control" ID="txtState" MaxLength="6" Text="Haryana" ReadOnly="true" autocomplete="off" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="col-md-4">
                                            <label>
                                                District
                                                    <samp style="color: red">* </samp>
                                            </label>
                                            <asp:TextBox class="form-control" ID="txtDistrict" ReadOnly="true" Visible="true" TabIndex="1" MaxLength="10" oninput="this.value = this.value.toUpperCase();" AutoPostBack="true" autocomplete="off" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="col-md-4" runat="server">
                                            <label for="Pin">PinCode</label>
                                            <asp:TextBox class="form-control" ID="txtPin" TabIndex="7" ReadOnly="true" MaxLength="6" onkeydown="return preventEnterSubmit(event)" onKeyPress="return isNumberKey(event);" autocomplete="off" runat="server"></asp:TextBox>
                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-md-4" style="margin-top: 20px;">
                                            <label for="Phone">
                                                Contact Number
                                                <samp style="color: red">* </samp>
                                            </label>
                                            <asp:TextBox class="form-control" ID="txtPhone" TabIndex="8" ReadOnly="true" onkeydown="return preventEnterSubmit(event)" onKeyPress="return isNumberKey(event);" MaxLength="10" autocomplete="off" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="col-md-4" runat="server" style="margin-top: 20px;">
                                            <label for="Email">
                                                Email
    <samp style="color: red">* </samp>
                                            </label>
                                            <asp:TextBox class="form-control" ID="txtEmail" ReadOnly="true" TabIndex="9" MaxLength="50" onkeydown="return preventEnterSubmit(event)" onkeyup="return ValidateEmail();" autocomplete="off" runat="server"></asp:TextBox>

                                        </div>
                                        <%--<div class="col-md-4" runat="server" style="margin-top: 45px;">
                                            <label for="copyofpan">
                                                Copy of PanNumber
                                            </label>
                                            <asp:LinkButton ID="LnkDocumemtPath" runat="server" OnClick="LnkDocumemtPath_Click">View document </asp:LinkButton>

                                        </div>--%>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                        <asp:HiddenField ID="HdnPanFilePath" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
