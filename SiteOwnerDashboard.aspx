<%@ Page Title="" Language="C#" MasterPageFile="~/SiteOwnerPages/SiteOwner.Master" AutoEventWireup="true" CodeBehind="SiteOwnerDashboard.aspx.cs" Inherits="CEIHaryana.SiteOwnerPages.SiteOwnerDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard</title>

    <!-- Fontfaces CSS-->
    <link href="/Dashboard_Css/css/font-face.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/font-awesome-5/css/fontawesome-all.min.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.2/css/fontawesome.min.css" integrity="sha384-BY+fdrpOd3gfeRvTSMT+VUZmA728cfF9Z2G42xpaRkUGu2i3DyzpTURDo5A6CaLK" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.2/font/bootstrap-icons.min.css" integrity="sha512-D1liES3uvDpPrgk7vXR/hR/sukGn7EtDWEyvpdLsyalQYq6v6YUsTUJmku7B4rcuQ21rf0UTksw2i/2Pdjbd3g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Bootstrap CSS-->
    <link href="/Dashboard_Css/vendor/bootstrap-4.1/bootstrap.min.css" rel="stylesheet" media="all">

    <!-- Vendor CSS-->
    <link href="/Dashboard_Css/vendor/animsition/animsition.min.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/bootstrap-progressbar/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/wow/animate.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/css-hamburgers/hamburgers.min.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/slick/slick.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/select2/select2.min.css" rel="stylesheet" media="all">
    <link href="/Dashboard_Css/vendor/perfect-scrollbar/perfect-scrollbar.css" rel="stylesheet" media="all">
    <!-- Example using CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <!-- Main CSS-->
    <link href="/Dashboard_Css/css/theme.css" rel="stylesheet" media="all">
    <style type="text/css">
        canvas#myChart2 {
            height: 239px !important;
        }

        input#ContentPlaceHolder1_txtTotalinspection {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        input#ContentPlaceHolder1_txtRejected {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        input#ContentPlaceHolder1_txtApproved {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        input#ContentPlaceHolder1_txtPending {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        canvas#myDoughnutChart {
            height: 240px !important;
            width: 300px !important;
        }

        .overview__inner {
            margin-top: -15px;
        }

        i.bi.bi-journal-medical {
            font-size: 32px;
        }

        i.bi.bi-folder-symlink-fill {
            font-size: 32px;
        }

        i.bi.bi-file-earmark-check {
            font-size: 32px;
        }

        i.bi.bi-file-earmark-plus {
            font-size: 32px;
        }

        canvas#doughutChart {
            height: 200px !important;
            width: 525px !important;
        }

        canvas#barChart {
            height: 200px !important;
        }

        .overview-box .text span {
            font-size: 15px !important;
            color: rgba(255, 255, 255, 0.6);
            /* MARGIN-LEFT: 24PX;*/
            FONT-WEIGHT: 400;
            COLOR: WHITE;
        }

        .col-md-6 {
            max-width: 47% !important;
        }

        .content-wrapper {
            padding: 0px !important;
        }

        ::before {
            color: #ffffff !important;
        }

        h2 {
            font-size: 20px !important;
            font-weight: 700 !important;
        }

        .au-card.recent-report {
            padding: 15px !important;
        }

        .au-card.chart-percent-card {
            padding: 15px !important;
        }

        .percent-chart {
            padding-top: 10px !important;
        }

        .section__content--p30 {
            padding: 0px !important;
        }

        .container, .container-fluid, .container-sm, .container-md, .container-lg, .container-xl {
            padding-right: 2px !important;
            padding-left: 2px !important;
            margin-right: auto !important;
            margin-left: auto !important;
        }

        canvas#recent-rep-chart {
            height: 160px !important;
        }

        canvas#percent-chart {
            height: 190px !important;
        }

        .icon {
            margin-top: -8px;
        }

        input#ContentPlaceHolder1_txtFirmName {
            border: none;
            background: #2d51fe;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox1 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox3 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox4 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox2 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox5 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox6 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox7 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox8 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox9 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox10 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox11 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox12 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox13 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox14 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox15 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox16 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox17 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox18 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox19 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox20 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox21 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox22 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox23 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox24 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox25 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox26 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox27 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox28 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        input#ContentPlaceHolder1_TextBox29 {
            border: none;
            background: transparent;
            color: white;
            font-size: 15px;
            padding: 0px;
            margin-top: -13%;
            margin-bottom: -15px;
        }

        .au-card.au-card--bg-blue.au-card-top-countries.m-b-40 {
            height: 300px;
        }

        div#officers_table {
            height: 155px;
        }
        /* ::-webkit-scrollbar {
    display: none;
}*/
        h2.title-1.m-b-25 {
            margin-bottom: 32px;
            margin-top: 32px;
        }

        input#ContentPlaceHolder1_TotalRequestRecieved {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        input#ContentPlaceHolder1_Approved_rejected {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        input#ContentPlaceHolder1_In_process {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        input#ContentPlaceHolder1_Initiated {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        .title-2 {
            text-transform: capitalize;
            font-weight: 400;
            font-size: 20px;
            line-height: 1;
        }

        input#ContentPlaceHolder1_txtApprovalAndReject {
            TEXT-ALIGN: END;
            border: none;
            background: transparent;
            color: white;
            font-size: 30px;
            padding: 0px;
            margin-top: -30%;
            margin-bottom: -2px;
            font-weight: 700;
        }

        canvas#myDoughnutChart {
            height: 290px;
        }

        canvas#myChart {
            height: 240px !important;
        }

        th.headercolor {
            background: #1d4be3;
            padding: 9px;
        }

        .au-card.au-card--bg-blue.au-card-top-countries.m-b-40 {
            background: white;
            padding: 10px;
        }

        th.division-align {
            text-align: left;
        }

        th.staff-align {
            text-align: left;
        }

        .overview-item.overview-item--c1 {
            background: #604db8;
        }

        .overview-item.overview-item--c2 {
            background: #63c28d;
        }

        .overview-item.overview-item--c3 {
            background: #ed39b1;
        }

        .overview-item.overview-item--c4 {
            background: #ff826c;
        }

        h3.title-2.m-b-40 {
            margin-top: -20px;
            margin-bottom: 30px;
            font-weight: 700;
        }

        a#ContentPlaceHolder1_HyperLink1 {
            color: blue;
            text-decoration-line: underline;
            font-size: 17px;
            margin-right: 10px;
            margin-bottom: 5px;
        }

        .bi-printer-fill::before {
            content: "\f500";
            color: blue !important;
            font-size: 30px;
            margin-right: 6px;
        }

        span#APPROVED {
            MARGIN-LEFT: -10px;
        }

        span#PROCESS {
            margin-left: 63%;
        }

        span#INITIATED {
            margin-left: 40%;
        }

        table#ContentPlaceHolder1_GridView2 {
            width: 735px !important;
        }

        table#ContentPlaceHolder1_GridView3 {
            width: 775px !important;
        }

        .au-card {
            -webkit-box-shadow: 0px 2px 5px 0px rgba(0, 0, 0, 0.1);
            -moz-box-shadow: 0px 2px 5px 0px rgba(0, 0, 0, 0.1);
            box-shadow: 0px 2px 5px 0px rgba(0, 0, 0, 0.1);
            padding: 20px;
            padding-top: 35px;
            padding-right: 35px;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            background: #fff;
            overflow: hidden;
        }

        /* Clean fix for padding issues without touching the GridView properties directly */
        .table th, .table td {
            padding: 10px !important;
        }

        /* Dashboard specific utility styles */
        .dashboard-container {
            background: #f4f6f9;
            border-radius: 12px;
            padding: 15px;
            padding-top: 5px;
        }

        .metric-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #edf2f9;
        }

            .metric-row:last-child {
                border-bottom: none;
            }

        .metric-label {
            font-weight: 500;
            color: #6c757d;
            font-size: 15px;
        }

        .metric-value {
            font-weight: 600;
            color: #2b3a4a;
            font-size: 15px;
        }

        .card-title-custom {
            font-size: 17px;
            font-weight: 700;
            color: #053d95;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 10px;
            margin-bottom: 15px;
            text-align: left;
        }

        .asset-img {
            max-width: 100% !important;
            height: 140px !important;
            object-fit: contain;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper" style="margin-top: 30px;">
        <%--<div class="main-content">--%>
        <div class="section__content section__content--p30">
            <div class="container-fluid">

                <div class="card" style="background: #f9f9f9; margin: 15px; margin-top: 10px; margin-bottom: 10px; box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px; padding: 0px 24px 5px 25px; border-radius: 10px;">
                    <div class="row m-t-25">
                        <div class="col-sm-6 col-md-3">
                            <div class="overview-item overview-item--c1">
                                <div class="overview__inner">
                                    <a href="InspectionsDetails.aspx?parameter=TotalInspection">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="bi bi-file-earmark-plus"></i>
                                            </div>
                                            <div class="text">
                                                <h2>
                                                    <asp:TextBox class="form-control" ID="txtTotalinspection" runat="server" onkeydown="return preventEnterSubmit(event)" autocomplete="off" ReadOnly="true"></asp:TextBox>
                                                </h2>
                                                <span id="totalinspection">Total Inspections</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="overview-item overview-item--c3">
                                <div class="overview__inner">
                                    <a href="InspectionsDetails.aspx?parameter=Return">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="bi bi-file-earmark-check"></i>
                                            </div>
                                            <div class="text">
                                                <h2>
                                                    <asp:TextBox class="form-control" ID="txtRejected" runat="server" onkeydown="return preventEnterSubmit(event)" autocomplete="off" ReadOnly="true"></asp:TextBox></h2>
                                                <span id="Rejected">Rejected/Returned Inspections</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="overview-item overview-item--c2">

                                <div class="overview__inner">
                                    <a href="InspectionsDetails.aspx?parameter=Approved">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="bi bi-journal-medical"></i>
                                            </div>
                                            <div class="text">
                                                <h2>
                                                    <asp:TextBox class="form-control" ID="txtApproved" runat="server" onkeydown="return preventEnterSubmit(event)"
                                                        autocomplete="off" ReadOnly="true"></asp:TextBox></h2>
                                                <span id="Approved">Approved Inspections</span>
                                            </div>
                                        </div>
                                    </a>
                                    <%--<div class="overview-chart">
                                     <canvas id="widgetChart3"></canvas>
                                 </div>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="overview-item overview-item--c4">
                                <div class="overview__inner">
                                    <a href="InspectionsDetails.aspx?parameter=Pending">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="bi bi-folder-symlink-fill"></i>
                                            </div>
                                            <div class="text">
                                                <h2>
                                                    <asp:TextBox class="form-control" ID="txtPending" runat="server" onkeydown="return preventEnterSubmit(event)" autocomplete="off" ReadOnly="true"></asp:TextBox></h2>
                                                <span id="Pending">Pending Inspections</span>
                                            </div>
                                        </div>
                                    </a>
                                    <%--<div class="overview-chart">
                                     <canvas id="widgetChart4"></canvas>
                                 </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="dashboard-container">
                    <div class="row" style="display: flex; flex-wrap: wrap; margin-left: -10px; margin-right: -10px;">
                        <div class="col-lg-6" style="flex: 1; min-width: 45%; padding: 10px;">
                            <div class="au-card" style="background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); height: 100%;">
                                <h3 class="card-title-custom">Substation Transformer Summary</h3>
                                <div class="row" style="display: flex; align-items: center;">
                                    <div class="col-sm-5" style="text-align: center; padding-right: 15px;">
                                        <%-- <img src="../Image/Transformer.jpeg" alt="Substation Transformer" class="asset-img" />--%>
                                        <a href="TotalComponentSummary.aspx?source=Transformer">
                                            <img src="../Image/Transformer.jpeg" alt="Substation Transformer" class="asset-img" />
                                        </a>
                                    </div>
                                    <div class="col-sm-7" style="border-left: 1px solid #e9ecef; padding-left: 20px;">
                                        <div class="metric-row">
                                            <span class="metric-label">Total Count:</span>
                                            <span class="metric-value">
                                                <a href="TotalComponentSummary.aspx?source=Transformer" class="your-style">
                                                    <asp:Literal ID="TotalSubstationTransformer" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>
                                        <%--  <div class="metric-row">
                                            <span class="metric-label">Active Count:</span>
                                            <span class="metric-value" style="color: #28a745;">
                                                <a href="ActiveComponentSummary.aspx?source=Transformer" class="your-style">
                                                    <asp:Literal ID="TotalActiveSubstationTransformer" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>--%>

                                        <div class="metric-row">
                                            <span class="metric-label">Near To Expiry / Expired:</span>
                                            <span class="metric-value" style="color: #dc3545;">
                                                <a href="ExpiryComponentSummary.aspx?source=Transformer" class="your-style">
                                                    <asp:Literal ID="TotalNearToExpiryAndExpiryTransformer" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6" style="flex: 1; min-width: 45%; padding: 10px;">
                            <div class="au-card" style="background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); height: 100%;">
                                <h3 class="card-title-custom">Generating Set Summary</h3>
                                <div class="row" style="display: flex; align-items: center;">
                                    <div class="col-sm-5" style="text-align: center; padding-right: 15px;">
                                        <a href="TotalComponentSummary.aspx?source=Generating Set">
                                            <img src="../Image/Generating_Set.jpeg" alt="Generating Set" class="asset-img" />
                                        </a>
                                    </div>
                                    <div class="col-sm-7" style="border-left: 1px solid #e9ecef; padding-left: 20px;">
                                        <div class="metric-row">
                                            <span class="metric-label">Total Count:</span>
                                            <span class="metric-value">
                                                <a href="TotalComponentSummary.aspx?source=Generating Set" class="your-style">
                                                    <asp:Literal ID="TotalGeneratingSet" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>
                                        <%-- <div class="metric-row">
                                            <span class="metric-label">Active Count:</span>
                                            <span class="metric-value" style="color: #28a745;">
                                                <a href="ActiveComponentSummary.aspx?source=Generating Set" class="your-style">
                                                    <asp:Literal ID="TotalActiveGeneratingSet" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>--%>

                                        <div class="metric-row">
                                            <span class="metric-label">Near To Expiry / Expired:</span>
                                            <span class="metric-value" style="color: #dc3545;">
                                                <a href="ExpiryComponentSummary.aspx?source=Generating Set" class="your-style">
                                                    <asp:Literal ID="TotalNearToExpiryAndExpiryGeneratingSet" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row" style="display: flex; flex-wrap: wrap; margin-left: -10px; margin-right: -10px;">
                        <div class="col-lg-6" style="flex: 1; min-width: 45%; padding: 10px;">
                            <div class="au-card" style="background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); height: 100%;">
                                <h3 class="card-title-custom">Line Inspection Summary</h3>
                                <div class="row" style="display: flex; align-items: center;">
                                    <div class="col-sm-5" style="text-align: center; padding-right: 15px;">
                                        <a href="TotalComponentSummary.aspx?source=Line">
                                            <img src="../Image/Line.jpeg" alt="Line Inspection" class="asset-img" />
                                        </a>
                                    </div>
                                    <div class="col-sm-7" style="border-left: 1px solid #e9ecef; padding-left: 20px;">
                                        <div class="metric-row">
                                            <span class="metric-label">Total Count:</span>
                                            <span class="metric-value">
                                                <a href="TotalComponentSummary.aspx?source=Line" class="your-style">
                                                    <asp:Literal ID="TotalLine" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>
                                        <%--<div class="metric-row">
                                            <span class="metric-label">Active Count:</span>
                                            <span class="metric-value" style="color: #28a745;">
                                                <a href="ActiveComponentSummary.aspx?source=Line" class="your-style">
                                                    <asp:Literal ID="TotalActiveLine" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>--%>
                                       

                                        <div class="metric-row">
                                            <span class="metric-label">Near To Expiry / Expired:</span>
                                            <span class="metric-value" style="color: #dc3545;">
                                                <a href="ExpiryComponentSummary.aspx?source=Line" class="your-style">
                                                    <asp:Literal ID="TotalNearToExpiryAndExpiryLine" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6" style="flex: 1; min-width: 45%; padding: 10px;">
                            <div class="au-card" style="background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); height: 100%;">
                                <h3 class="card-title-custom">Lift/Escelator Inspection Summary</h3>
                                <div class="row" style="display: flex; align-items: center;">
                                    <div class="col-sm-5" style="text-align: center; padding-right: 15px;">
                                        <a href="TotalComponentSummary.aspx?source=Lift/Escalator">
                                            <img src="../Image/LiftAndEscelator.jpeg" alt="Lift/Escelator Inspection" class="asset-img" />
                                        </a>
                                    </div>
                                    <div class="col-sm-7" style="border-left: 1px solid #e9ecef; padding-left: 20px;">
                                        <div class="metric-row">
                                            <span class="metric-label">Total Count:</span>
                                            <span class="metric-value">
                                                <a href="TotalComponentSummary.aspx?source=Lift/Escalator" class="your-style">
                                                    <asp:Literal ID="TotalLift" runat="server" Text="0" />
                                                </a></span>
                                        </div>
                                        <%--<div class="metric-row">
                                            <span class="metric-label">Active Count:</span>
                                            <span class="metric-value" style="color: #28a745;">
                                                <a href="ActiveComponentSummary.aspx?source=Lift/Escalator" class="your-style">
                                                    <asp:Literal ID="TotalActiveLift" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>--%>

                                        <div class="metric-row">
                                            <span class="metric-label">Near To Expiry / Expired:</span>
                                            <span class="metric-value" style="color: #dc3545;">
                                                <a href="LiftPeriodicRenewalExistingAll.aspx" class="your-style">
                                                    <asp:Literal ID="TotalNearToExpiryAndExpiryLift" runat="server" Text="0" />
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>

        function printDiv2(printableDiv2) {
            var printContents = document.getElementById(printableDiv2).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
    <script type="text/javascript">

        function printDiv(printableDiv) {
            var printContents = document.getElementById(printableDiv).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
</asp:Content>
