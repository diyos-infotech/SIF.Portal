﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaySheetPrintOuts.aspx.cs" Inherits="SIF.Portal.PaySheetPrintOuts" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>PAYSHEET PDF</title>
    <link href="css/global.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style2
        {
            font-size: 10pt;
            font-weight: bold;
            color: #333333;
            background: #cccccc;
            padding: 5px 5px 2px 10px;
            border-bottom: 1px solid #999999;
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="ReceiveReports1" runat="server">
    <!-- HEADER SECTION BEGIN -->
    <div id="headerouter">
        <!-- LOGO AND MAIN MENU SECTION BEGIN -->
        <div id="header">
            <!-- LOGO BEGIN -->
            <div id="logo">
                <a href="default.aspx">
                    <img border="0" src="assets/logo.png" alt="FACILITY MANAGEMENT SOFTWARE" title="FACILITY MANAGEMENT SOFTWARE" /></a>
            </div>
            <!-- LOGO END -->
            <!-- TOP INFO BEGIN -->
            <div id="toplinks">
                <ul>
                    <li><a href="Reminders.aspx">Reminders</a></li><li>Welcome <b>
                        <asp:Label ID="lblDisplayUser" runat="server" Text="Label" Font-Bold="true"></asp:Label></b></li>
                    <li class="lang"><a href="Login.aspx">Logout</a></li>
                </ul>
            </div>
            <!-- TOP INFO END -->
            <!-- MAIN MENU BEGIN -->
            <div id="mainmenu">
                <ul>
                    <li class="first"><a href="Employees.aspx" id="EmployeesLink" runat="server"><span>Employees</span></a></li>
                    <li><a href="clients.aspx" id="ClientsLink" runat="server"><span>Clients</span></a></li>
                    <li><a href="companyinfo.aspx" id="CompanyInfoLink" runat="server"><span>Company Info</span></a></li>
                    <li><a href="ViewItems.aspx" id="InventoryLink" runat="server"><span>Inventory</span></a></li>
                    <li><a href="Reports.aspx" id="ReportsLink" runat="server" class="current"><span>Reports</span></a></li>
                    <li class="after"><a href="CreateLogin.aspx" id="SettingsLink" runat="server"><span>
                        Settings</span></a></li>
                    <li class="last"><a href="login.aspx" id="LogOutLink" runat="server"><span><span>Logout</span></span></a></li>
                </ul>
            </div>
            <!-- MAIN MENU SECTION END -->
        </div>
        <!-- LOGO AND MAIN MENU SECTION END -->
        <!-- SUB NAVIGATION SECTION BEGIN -->
        <!--  <div id="submenu"> <img width="1" height="5" src="assets/spacer.gif"> </div> -->
        <div id="submenu">
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tbody>
                    <tr>
                        <td>
                            <div style="display: inline">
                                <div id="submenu" class="submenu">
                                    <div class="submenubeforegap">
                                        &nbsp;</div>
                                    <div class="submenuactions">
                                        &nbsp;</div>
                                    <ul>
                                        <li><a href="ActiveEmployeeReports.aspx" id="EmployeeReportLink" runat="server"><span>
                                            Employees</span></a></li>
                                        <li class="current"><a href="ActiveClientReports.aspx" id="ClientsReportLink" runat="server">
                                            <span>Clients</span></a></li>
                                        <li><a href="ListOfItemsReports.aspx" id="InventoryReportLink" runat="server"><span>
                                            Inventory</span></a></li>
                                        <li><a href="ExpensesReports.aspx" id="ExpensesReportsLink" runat="server"><span>Companyinfo</span></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <!-- SUBNAVIGATION SECTION END -->
    </div>
    <!-- HEADER SECTION END -->
    <!-- CONTENT AREA BEGIN -->
    <div id="content-holder">
        <div class="content-holder">
            <div id="breadcrumb">
                <ul class="crumbs">
                    <li class="first"><a href="#" style="z-index: 9;"><span></span>Reports</a></li>
                    <li><a href="ClientReports.aspx" style="z-index: 8;">Client Reports</a></li>
                    <li class="active"><a href="#" style="z-index: 7;" class="active_bread">Paysheets</a></li>
                </ul>
            </div>
            <!-- DASHBOARD CONTENT BEGIN -->
            <div class="contentarea" id="contentarea">
                <div class="dashboard_center">
                    <div class="sidebox">
                        <div class="boxhead">
                            <h2 style="text-align: center">
                                Paysheets
                            </h2>
                        </div>
                        <div class="boxbody" style="padding: 5px 5px 5px 5px;">
                            <div class="boxin">
                                <asp:ScriptManager runat="server" ID="ScriptEmployReports">
                                </asp:ScriptManager>
                                <div class="dashboard_firsthalf" style="width: 100%">
                                    <table width="100%" cellpadding="5" cellspacing="5">
                                        <tr style="width: 100%">
                                            <td>
                                                Client Id :<span style="color: Red">*</span>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlclient" runat="server" AutoPostBack="true" class="sdrop"
                                                    OnSelectedIndexChanged="ddlclient_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                Client Name :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlcname" runat="server" AutoPostBack="true" class="sdrop"
                                                    OnSelectedIndexChanged="ddlcname_OnSelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Select Month :
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtmonth" runat="server" class="sinput"> </asp:TextBox>
                                                <cc1:CalendarExtender ID="CEMonth" runat="server" Enabled="true" TargetControlID="txtmonth"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:FilteredTextBoxExtender ID="FTBEMonth" runat="server" Enabled="True" TargetControlID="txtmonth"
                                                    ValidChars="/0123456789">
                                                </cc1:FilteredTextBoxExtender>
                                            </td>
                                            <td>
                                                Selct PaySheet Type :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlpaymenttype" runat="server" class="sdrop">
                                                    <asp:ListItem>--Select--</asp:ListItem>
                                                    <asp:ListItem>Duties+Ots</asp:ListItem>
                                                    <asp:ListItem>Duties+OTs(2)</asp:ListItem>
                                                    <asp:ListItem>Only Duties </asp:ListItem>
                                                    <asp:ListItem>Only OTs </asp:ListItem>
                                                    <asp:ListItem>Only Duties2</asp:ListItem>
                                                    <asp:ListItem>No PF/ESI</asp:ListItem>
                                                    <asp:ListItem>Only Duties3 </asp:ListItem>
                                                    <asp:ListItem>Bellow(10) </asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Attendance :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlnoofattendance" runat="server" class="sdrop">
                                                    <asp:ListItem Selected="True">10-Above</asp:ListItem>
                                                    <asp:ListItem>0-10</asp:ListItem>
                                                    <asp:ListItem>ALL</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:Button ID="btnpaysheetdownload" runat="server" Text="Download" CssClass="btn save"
                                                    OnClick="btndownloadpdffile_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
        </div>
        <!-- DASHBOARD CONTENT END -->
        <!-- FOOTER BEGIN -->
        <div id="footerouter">
            <div class="footer">
                <div class="footerlogo">
                    <a href="http://www.diyostech.in" target="_blank">Powered by DIYOS </a>
                </div>
                <!--    <div class="footerlogo">&nbsp;</div> -->
                <div class="footercontent">
                    <a href="#">Terms &amp; Conditions</a> | <a href="#">Privacy Policy</a> | ©
                    <asp:Label ID="lblcname" runat="server"></asp:Label>.</div>
                <div class="clear">
                </div>
            </div>
        </div>
        <!-- FOOTER END -->
        <!-- CONTENT AREA END -->
    </div>
    </form>
</body>
</html>
