﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportforPBAttendance.aspx.cs" Inherits="SIF.Portal.ReportforPBAttendance" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>REPORT: ATTENDANCE REPORT</title>
    <link href="css/global.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="ActiveClientReports1" runat="server">
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
                    <li><a href="ActiveEmployeeReports.aspx" id="ReportsLink" runat="server" class="current">
                        <span>Reports</span></a></li>
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
                    <li class="active"><a href="#" style="z-index: 7;" class="active_bread">Art Comparison</a></li>
                </ul>
            </div>
            <!-- DASHBOARD CONTENT BEGIN -->
            <div class="contentarea" id="contentarea">
                <div class="dashboard_center">
                    <div class="sidebox">
                        <div class="boxhead">
                            <h2 style="text-align: center">
                                Art Comparison
                            </h2>
                        </div>
                        <div class="boxbody" style="padding: 5px 5px 5px 5px;">
                            <div class="boxin">
                                <asp:ScriptManager runat="server" ID="ScriptEmployReports">
                                </asp:ScriptManager>
                                <div class="dashboard_firsthalf" style="width: 100%">
                                    <table width="100%" cellpadding="5" cellspacing="5">
                                        <tr>
                                            <td>
                                                Clientid :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlclientid" runat="server" class="sdrop" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlclientid_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                Name :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlcname" runat="server" class="sdrop" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlcname_OnSelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                Month :
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtmonth" runat="server" class="sinput"> </asp:TextBox><cc1:CalendarExtender
                                                    ID="txtFrom_CalendarExtender" runat="server" Enabled="true" TargetControlID="txtmonth"
                                                    Format="MM/dd/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:FilteredTextBoxExtender ID="FTBEDOI" runat="server" Enabled="True" TargetControlID="txtmonth"
                                                    ValidChars="/0123456789">
                                                </cc1:FilteredTextBoxExtender>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnsearch" runat="server" Text="Search" class="btn save" OnClick="btnsearch_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="rounded_corners">
                                    <asp:GridView ID="gvpaysheet" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        CellSpacing="3" EmptyDataRowStyle-BackColor="BlueViolet" EmptyDataRowStyle-BorderColor="Aquamarine"
                                        EmptyDataRowStyle-Font-Italic="true" EmptyDataText="No Records Found" ForeColor="#333333"
                                        GridLines="None" Width="100%" OnRowDataBound="gvpaysheet_RowDataBound">
                                        <RowStyle BackColor="#EFF3FB" Height="30" />
                                        <EmptyDataRowStyle BackColor="SkyBlue" BorderColor="Aquamarine" Font-Italic="True" />
                                        <Columns>
                                            <asp:BoundField HeaderText="Clientid" DataField="Clientid" />
                                            <asp:BoundField HeaderText="Name" DataField="Clientname" />
                                            <asp:BoundField HeaderText="Paysheet Duties" DataField="PaysheetDuties" />
                                            <asp:BoundField HeaderText="Paysheet Ots" DataField="PaysheetOts" />
                                            <asp:BoundField HeaderText="Total Paysheet Duties" DataField="TotalPaysheetduties" />
                                            <asp:TemplateField HeaderText="Billing Duties">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBillingduties" runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Billing ots">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBillingots" runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Difference">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDifferenceduties" runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Height="30" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
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
