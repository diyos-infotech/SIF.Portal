﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClentwiseEmployeesSalaryreports2.aspx.cs" Inherits="SIF.Portal.ClentwiseEmployeesSalaryreports2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>FACILITY MANAGEMENT SOFTWARE</title>
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
    <form id="ClentwiseEmployeesSalaryreports1" runat="server">
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
                    <li class="after"><a href="Settings.aspx" id="SettingsLink" runat="server"><span>Settings</span></a></li>
                    <li class="last"><a href="login.aspx" id="LogOutLink" runat="server"><span><span>Logout</span></span></a></li>
                </ul>
            </div>
            <!-- MAIN MENU SECTION END -->
        </div>
        <!-- LOGO AND MAIN MENU SECTION END -->
        <!-- SUB NAVIGATION SECTION BEGIN -->
        <!--  <div id="submenu"> <img width="1" height="5" src="assets/spacer.gif"> </div> -->
        <div id="submenu" style=" width:100%">
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
                                        <li><a href="ActiveEmployeeReports.aspx" id="EmployeeReportLink" runat="server"><span>  Employees</span></a></li>
                                        <li class="current"><a href="ActiveClientReports.aspx" id="ClientsReportLink" runat="server"> <span>Clients</span></a></li>
                                        <li><a href="ListOfItemsReports.aspx" id="InventoryReportLink" runat="server"><span> Inventory</span></a></li>
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
                    <li class="active"><a href="#" style="z-index: 7;" class="active_bread">Salary Details(2)</a></li>
                </ul>
            </div>
            <!-- DASHBOARD CONTENT BEGIN -->
            <div class="contentarea" id="contentarea">
                <div class="dashboard_center">
                    <div class="sidebox">
                        <div class="boxhead">
                            <h2 style="text-align: center">
                              Salary Details(2)
                            </h2>
                        </div>
                        <div class="boxbody" style="padding: 5px 5px 5px 5px;">
                            <div class="boxin">
                        <asp:ScriptManager runat="server" ID="ScriptEmployReports">
                        </asp:ScriptManager>
                        
                        <div class="dashboard_firsthalf" style="width: 100%">
                        
                            <div align="right">
                                                <asp:LinkButton ID="lbtn_Export" runat="server" OnClick="lbtn_Export_Click" Visible="False">Export to Excel</asp:LinkButton>
                                            </div>
                      <table width="100%" border="0" cellpadding="5" cellspacing="5">
                                    <tr>
                                        <td valign="top">
                           
                                <table width="100%" border="0" cellpadding="5" cellspacing="5">
                                    <tr>
                                        <td>
                                            Client Id
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlclientid" runat="server" class="sdrop" AutoPostBack="True"
                                             OnSelectedIndexChanged="ddlclientid_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <tr>
                                        <td>
                                           Client Name
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlcname" runat="server" class="sdrop" AutoPostBack="True"
                                             OnSelectedIndexChanged="ddlcname_OnSelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    </table>
                                    </td>
                                    
                                    <td>
                                    <table width="100%" border="0" cellpadding="5" cellspacing="5">
                                    <tr>
                                    <td>Select  Options  :</td>
                                    <td><asp:DropDownList ID="ddlpfesioptions" runat="server" class="sdrop"  >
                                    <asp:ListItem>PF</asp:ListItem>
                                    <asp:ListItem>ESI</asp:ListItem>
                                    <asp:ListItem>Non  PF</asp:ListItem>
                                    <asp:ListItem>Non ESI</asp:ListItem>
                                    </asp:DropDownList>  </td>
                                        </tr>
                                        

                                        <tr>
                                            <td>Attendance
                                             </td>
                                        <td ><asp:DropDownList ID="ddlAttendance" runat="server"  >
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>10 Above</asp:ListItem>
                                    <asp:ListItem>10 Below</asp:ListItem>
                                    </asp:DropDownList> </td>
                                        <td>
                                            Month
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtmonth" runat="server" Text="" class="sinput"></asp:TextBox>
                                            <cc1:CalendarExtender ID="txtFrom_CalendarExtender" runat="server" Enabled="true"
                                                TargetControlID="txtmonth" Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:FilteredTextBoxExtender ID="FTBEDOI" runat="server" Enabled="True" TargetControlID="txtmonth"
                                                ValidChars="/0123456789">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        </tr>
                                        
                                        <tr>
                                        <td>&nbsp;</td>
                                        <td>
                                            <asp:Button runat="server" ID="btn_Submit" Text="Submit" class="btn save" OnClick="btnsearch_Click" />
                                        </td>
                                        </tr>
                                        
                                        
                                </table>
                                </td>
                                </tr>
                                </table>
                                  <asp:Label ID="LblResult" runat="server" Text="" Style="color: Red"> </asp:Label>
                            </div>
                            
                            
                            <div class="rounded_corners" style="overflow:scroll">
                                <asp:GridView ID="GVListEmployees" runat="server" AutoGenerateColumns="False" Width="100%"
                                    CellSpacing="3" CellPadding="5" ForeColor="#333333" GridLines="None" 
                                    onpageindexchanging="GVListEmployees_PageIndexChanging" 
                                    onrowdatabound="GVListEmployees_RowDataBound">

                                    <RowStyle BackColor="#EFF3FB" Height="30" />
                                    <Columns>
                                        <asp:BoundField DataField="clientid" HeaderText="Client Id" />
                                        <asp:BoundField DataField="clientname" HeaderText="Name" />
                                        <asp:BoundField DataField="empid" HeaderText="Emp Id" />
                                        <asp:BoundField DataField="empmname" HeaderText="Name" />
                                        <asp:BoundField DataField="design" HeaderText="Desgn" />
                                        <asp:BoundField DataField="Noofduties" HeaderText="No OF Duties" />
                                        <asp:BoundField DataField="ot" HeaderText="No of Ots" />
                                        <asp:BoundField DataField="basic" HeaderText="Basic" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="da" HeaderText="DA" DataFormatString="{0:0.00}" />
                                         <asp:BoundField DataField="hra" HeaderText="HRA" DataFormatString="{0:0.00}" />
                                         <asp:BoundField DataField="conveyance" HeaderText="CONV" DataFormatString="{0:0.00}" />
                                         <asp:BoundField DataField="cca" HeaderText="CCA" DataFormatString="{0:0.00}" />
                                         <asp:BoundField DataField="otherallowance" HeaderText="OA" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="WashAllowance" HeaderText="Wash Allwn" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="Bonus" HeaderText="Bonus" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="LeaveEncashAmt" HeaderText="Leave Allwn" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="Gratuity" HeaderText="Gratuity" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="Incentivs" HeaderText="Incentive" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="Gross" HeaderText="Gross" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="otamt" HeaderText="OT Amt" DataFormatString="{0:0.00}" />
                                         <asp:BoundField DataField="pfwages" HeaderText="PF Wages" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="pf" HeaderText="PF" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="emprpf" HeaderText="PFEMPR" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="pftotal" HeaderText="PF Total" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="empepfno" HeaderText="PF No." DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="esiwages" HeaderText="ESI Wages" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="esi" HeaderText="ESI" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="empresi" HeaderText="ESIEmpr" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="esitotal" HeaderText="ESI Total" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="EmpESINo" HeaderText="ESINo." DataFormatString="&nbsp; {0}" />
                                        <asp:BoundField DataField="Proftax" HeaderText="PT Amt" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="owf" HeaderText="OWFDED" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="saladvded" HeaderText="SALADVDED" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="UniformDed" HeaderText="UniformDed" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="OtherDed" HeaderText="OtherDed" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="CanteenAdv" HeaderText="CanteenAdv" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="penalty" HeaderText="Penalty" DataFormatString="{0:0.00}" />
                                        <asp:BoundField DataField="actualamount" HeaderText="Net AMount" DataFormatString="{0:0.00}" />
                                        <asp:TemplateField HeaderText="Bank A/C No" >
                                        <ItemTemplate>
                                        <asp:Label ID="lblbankno" runat="server" Text='<%# Eval("Empbankacno") %>' ></asp:Label>
                                        </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                       <asp:BoundField DataField="EmpBankCardRef" HeaderText="Reference No." DataFormatString="&nbsp;{0}" />
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
