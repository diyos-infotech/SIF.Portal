﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Imports.aspx.cs" Inherits="SIF.Portal.Imports" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>REPORTS</title>
    <link href="css/global.css" rel="stylesheet" type="text/css" />
    <link href="css/Load.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style2 {
            font-size: 10pt;
            font-weight: bold;
            color: #333333;
            background: #cccccc;
            padding: 5px 5px 2px 10px;
            border-bottom: 1px solid #999999;
            height: 26px;
        }
    </style>

    <script language="javascript">
        function OnFocus(txt, text) {
            if (txt.value == text) {
                txt.value = "";
            }
        }
        function OnBlur(txt, text) {
            if (txt.value == "") {
                txt.value = text;
            }
        }
    </script>

</head>
<body>

    <form id="form1" runat="server">
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
                        <li><a href="Reminders.aspx">Reminders</a></li>
                        <li>Welcome <b>
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
                        <li><a href="Reports.aspx" id="ReportsLink" runat="server" class="current">
                            <span>Reports</span></a></li>
                        <li class="after"><a href="CreateLogin.aspx" id="SettingsLink" runat="server"><span>Settings</span></a></li>
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
                                            &nbsp;
                                        </div>
                                        <div class="submenuactions">
                                            &nbsp;
                                        </div>
                                        <ul>
                                            <li class="current"><a href="ActiveEmployeeReports.aspx" id="EmployeeReportLink"
                                                runat="server"><span>Employees</span></a></li>
                                            <li><a href="ClientReports.aspx" id="ClientsReportLink" runat="server"><span>Clients</span></a></li>
                                            <li><a href="ListOfItemsReports.aspx" id="InventoryReportLink" runat="server"><span>Inventory</span></a></li>
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
                <h1>Employee Reports</h1>
                <!-- DASHBOARD CONTENT BEGIN -->
                <div class="contentarea" id="contentarea">
                    <ul class="shortcuts" style="margin-left: 13px">
                       

                         <li><a href="ImportAadhaarNo.aspx"><span class="shortcuts-icon iconsi-event"></span>
                            <span class="shortcuts-label">Aadhar No</span> </a></li>

                         <li><a href="ImportBankACNo.aspx"><span class="shortcuts-icon iconsi-event"></span>
                            <span class="shortcuts-label">Bank Ac No</span> </a></li>

                         <li><a href="ImportDrivingLicenseNo.aspx"><span class="shortcuts-icon iconsi-event"></span>
                            <span class="shortcuts-label">DrivingLicense No</span> </a></li>

                         <li><a href="ImportESINos.aspx"><span class="shortcuts-icon iconsi-event"></span>
                            <span class="shortcuts-label">ESI No</span> </a></li>

                         <li><a href="ImportPFNos.aspx"><span class="shortcuts-icon iconsi-event"></span>
                            <span class="shortcuts-label">PF No</span> </a></li>

                         <li><a href="ImportPANNo.aspx"><span class="shortcuts-icon iconsi-event"></span>
                            <span class="shortcuts-label">PAN No</span> </a></li>

                         <li><a href="ImportUANNos.aspx"><span class="shortcuts-icon iconsi-event"></span>
                            <span class="shortcuts-label">UAN No</span> </a></li>

                         <li><a href="ImportVoterNo.aspx"><span class="shortcuts-icon iconsi-event"></span>
                            <span class="shortcuts-label">Voter No</span> </a></li>

                    </ul>
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
                    <asp:Label ID="lblcname" runat="server"></asp:Label>.
                    </div>
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
