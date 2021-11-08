﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportforBillingAndPaysheet.aspx.cs" Inherits="SIF.Portal.ReportforBillingAndPaysheet" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>REPORT: BILLING AND PAYSHEET</title>
    <link href="css/global.css" rel="stylesheet" type="text/css" />
    <link href="css/Load.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 47%;
        }
    </style>
</head>
<body>
    <form id="ClientpfReports1" runat="server">
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
                    <li class="active"><a href="#" style="z-index: 7;" class="active_bread">Billing and
                        Paysheet</a></li>
                </ul>
            </div>
            <!-- DASHBOARD CONTENT BEGIN -->
            <div class="contentarea" id="contentarea">
                <div class="dashboard_center">
                    <div class="sidebox">
                        <div class="boxhead">
                            <h2 style="text-align: center">
                                Billing and Paysheet
                            </h2>
                        </div>
                        <div class="boxbody" style="padding: 5px 5px 5px 5px;">
                            <div class="boxin">
                                <asp:ScriptManager runat="server" ID="ScriptEmployReports">
                                </asp:ScriptManager>
                                <div class="dashboard_firsthalf" style="width: 100%">
                                    <div align="right">
                                        <asp:LinkButton ID="lbtn_Export" runat="server" OnClick="lbtn_Export_Click">Export to Excel</asp:LinkButton>
                                    </div>
                                
                                <asp:UpdatePanel runat="server" ID="Updatepanel1">
                                    <ContentTemplate>
                                     
                                            <table width="52%">
                                                <tr>
                                                    <td>
                                                        Month :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtmonth" runat="server" Text="" class="sinput"></asp:TextBox>
                                                        <cc1:CalendarExtender ID="txtFrom_CalendarExtender" runat="server" Enabled="true"
                                                            Format="MM/dd/yyyy" TargetControlID="txtmonth">
                                                        </cc1:CalendarExtender>
                                                        <cc1:FilteredTextBoxExtender ID="FTBEDOI" runat="server" Enabled="True" TargetControlID="txtmonth"
                                                            ValidChars="/0123456789">
                                                        </cc1:FilteredTextBoxExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnSearch" runat="server" class="btn save" Text="Search" OnClick="btnSearch_Click" />
                                                    </td>
                                                </tr>
                                                <tr style="width: 100%">
                                                    <td colspan="3" style="width: 30%">
                                                        <asp:Label ID="LblResult" runat="server" Text="" Style="color: Red"> </asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="rounded_corners">
                                            <asp:GridView ID="GVListEmployees" runat="server" AutoGenerateColumns="False" Width="100%"
                                                Height="50px" CssClass="datagrid" CellPadding="4" CellSpacing="3" ForeColor="#333333"
                                                GridLines="None">
                                                <RowStyle BackColor="#EFF3FB" Height="30" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Client ID">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblclientid" Text="<%#Bind('ClientId') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Client Name">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblclientname" Text="<%#Bind('clientname') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Billing Dts">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillingDts" Text="<%#Bind('Invoice') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Billing Generation">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillinggeneration" Text="<%#Bind('BillGenerate') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Payment Dts">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblPaymentDts" Text="<%#Bind('paysheet') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Payment Generation">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblPaymentgeneration" Text="<%#Bind('PaysheetGenerate') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                <EditRowStyle BackColor="#2461BF" />
                                                <AlternatingRowStyle BackColor="White" />
                                            </asp:GridView>
                                        </div>
                                        <div class="dashboard_firsthalf" style="width: 100%">
                                            <table width="70%">
                                                <tr>
                                                    <td>
                                                        Billing Duties :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtBduties" runat="server" ReadOnly="True" class="sinput"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        Pay Sheet Duties :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPduties" runat="server" ReadOnly="True" class="sinput"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="45%" cellpadding="5" cellspacing="5">
                                                <tr>
                                                    <td>
                                                        No of Clients for Billing : &nbsp;&nbsp;&nbsp;Yes
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtBYes" runat="server" ReadOnly="True" class="sinput" Width="56px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        No
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtBNo" runat="server" ReadOnly="True" class="sinput" Width="56px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        No of Clients for Paysheet: Yes
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPYes" runat="server" ReadOnly="True" class="sinput" Width="56px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        No
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPNo" runat="server" ReadOnly="True" class="sinput" Width="56px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <div id="Background">
                                                </div>
                                                <div id="Progress">
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
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
