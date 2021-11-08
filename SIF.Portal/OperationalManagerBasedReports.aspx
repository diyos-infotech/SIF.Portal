﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OperationalManagerBasedReports.aspx.cs" Inherits="SIF.Portal.OperationalManagerBasedReports" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>REPORT: OPM BASED REPORT</title>
    <link href="css/global.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 135px;
        }
    </style>
</head>

<body>
  <form id="OperationalManagerBasedReports1" runat="server">
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
                    <li class="first"><a href="Employees.aspx" id="employeeslink" runat="server"><span>Employees</span></a></li>
                    <li><a href="clients.aspx" id="ClientsLink" runat="server"><span>Clients</span></a></li>
                    <li><a href="companyinfo.aspx" id="CompanyInfoLink" runat="server"><span>Company Info</span></a></li>
                    <li><a href="ViewItems.aspx" id="InventoryLink" runat="server"><span>Inventory</span></a></li>
                    <li><a href="ActiveEmployeeReports.aspx" id="ReportsLink" runat="server" class="current"><span>Reports</span></a></li>
                    <li class="after" ><a href="CreateLogin.aspx" id="SettingsLink" runat="server" ><span>Settings</span></a></li>
                    <li class="last"><a href="login.aspx" id="LogOutLink" runat="server">
                        <span><span>Logout</span></span></a></li>
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
                                      <li><a href="ActiveEmployeeReports.aspx" id="saleslink" runat="server"><span>Employees</span></a></li>
                                      <li  class="current"><a href="ActiveClientReports.aspx" id="ClientsReportsLink" runat="server"><span>Clients</span></a></li>
                                      <li><a href="ActiveInventoryReports.aspx" id="InventoryReportsLink" runat="server"><span>Inventory</span></a></li>
                                   <li><a href="ExpensesReports.aspx" id="ExpensesReportsLink" runat="server"> <span>Companyinfo</span></a>  </li> 
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
            <h1>Settings Dashboard</h1>
            <!-- DASHBOARD CONTENT BEGIN -->
            <div class="contentarea" id="contentarea">
                <ul>
                   <li class="left leftmenu">
                       <ul>
                          <li><a href="ActiveClientReports.aspx"  >Active</a></li>
                          <li><a href="InActiveClientReports.aspx">InActive</a></li>
                          <li><a href="ResponseBasedReports.aspx">Response Base</a></li>
                          <li><a href="InvoiceSubmitedReports.aspx">Invoice Submitted</a></li>
                          <li><a href="SegmentReports.aspx">Segment</a></li>
                          <li><a href="SubmitsReports.aspx" >Submitted</a> </li>
                          <li><a href= "OperationalManagerBasedReports.aspx" class="sel">Operational Manager</a></li>
                          <li><a href="PendingAmountReports.aspx">Pending Amount From Client </a>   </li>
                          <li><a href= "CollectedAmountReports.aspx">Collected Amount </a>   </li>
                          <li><a href= "UnitWiseReports.aspx" >Unit Wise</a> </li>
                           
                     
                   
                      </ul>
                   </li>
                   <li class="right" style="min-height:200px; height:auto">
                       <div id="right_content_area" style="text-align:left; font:Tahoma; font-size:x-large; font-weight:bold">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="FormContainer">
                                     <tr>
                                         <td width="100%" class="FormSectionHead">Select Options</td>
                                     </tr>
                                     <tr>
                                     <td>
                                      
                                                <asp:GridView ID="gvSegment" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="datagrid" 
                                                   
                                                   >
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Segments">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSegName" runat="server" Text="<%#Bind('SegName') %>"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtSegName" runat="server" Text="<%#Bind('SegName') %>"></asp:TextBox>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="linkedit" runat="server" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Delete" Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:LinkButton ID="linkupdate" runat="server" CommandName="update" Text="Update"></asp:LinkButton>
                                                                <asp:LinkButton ID="linkcancel" runat="server" CommandName="cancel" Text="Cancel"></asp:LinkButton>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                       
                                     </td>
                                     </tr>
                                       <tr><td >
                                    <%--  <asp:Label ID="lblsegment" runat="server" Text="Segment" class="fontstyle"></asp:Label>
                                      
                                            <asp:TextBox ID="txtsegment1" runat="server"  Width="120px" class="fontstyle" ></asp:TextBox>
                                      
                                          <asp:Button ID="btnsegment" runat="server" Text="Add Segment" 
                                              class="btn save" Width="120px"  />--%> </td>
                                      </tr>
                                </table>
                              
                       </div>
                   </li>
                </ul>
                <div class="clear"></div>
            </div>
        </div>
            <!-- DASHBOARD CONTENT END -->
       
        <!-- FOOTER BEGIN -->
        <div id="footerouter">
            <div class="footer">
                <div class="footerlogo">
                    <a href="http://www.diyostech.Com" target="_blank">Powered by DIYOS </a>
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
