﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Division.aspx.cs" Inherits="SIF.Portal.Division" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>DIVISION</title>
    <link href="css/global.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1 {
            width: 135px;
        }
    </style>
</head>
<body>
    <form id="division1" runat="server">
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
                        <li><a href="Reports.aspx" id="ReportsLink" runat="server"><span>Reports</span></a></li>
                        <li><a href="CreateLogin.aspx" id="SettingsLink" runat="server" class="current"><span>Settings</span></a></li>
                        <li class=" after last"><a href="login.aspx" id="LogOutLink" runat="server"><span><span>Logout</span></span></a></li>
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
                                            <li class="current"><a href="Designation.aspx" id="saleslink" runat="server"><span>Main</span></a>
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
                        <li class="first"><a href="Settings.aspx" style="z-index: 9;"><span></span>Settings</a></li>
                        <li class="active"><a href="#" style="z-index: 7;" class="active_bread">Division</a></li>
                    </ul>
                </div>
                <!-- DASHBOARD CONTENT BEGIN -->
                <div class="contentarea" id="contentarea">
                    <div class="dashboard_center">
                        <div class="sidebox">
                            <div class="boxhead">
                                <h2 style="text-align: center">Division
                                </h2>
                            </div>
                            <div class="boxbody" style="padding: 5px 5px 5px 5px;">
                                <div class="boxin">
                                    <div class="dashboard_firsthalf" style="width: 100%">
                                        <table width="45%" cellpadding="5" cellspacing="5">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbldivision" runat="server" Text="Division :" class="fontstyle"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="Txt_division" runat="server" class="sinput"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Button ID="Btndivision" runat="server" Text="Add Division" class="btn save" Width="120px"
                                                         OnClientClick='return confirm(" Are you sure you want to add the Division?");' OnClick="Btndivision_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="rounded_corners">
                                        <asp:GridView ID="gvdivision" runat="server" AutoGenerateColumns="false" Width="100%"
                                            
                                            PageSize="15" CellPadding="5" CellSpacing="3" ForeColor="#333333" GridLines="None" OnPageIndexChanging="gvdivision_PageIndexChanging" OnRowCancelingEdit="gvdivision_RowCancelingEdit" OnRowEditing="gvdivision_RowEditing" OnRowUpdating="gvdivision_RowUpdating">
                                            <RowStyle BackColor="#EFF3FB" />
                                            <RowStyle BackColor="#EFF3FB" Height="30" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSno" runat="server" Text="<%#Container.DataItemIndex+1 %>"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:Label ID="lblSno" runat="server" Text="<%#Container.DataItemIndex+1 %>"></asp:Label>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Division">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDivisionName" runat="server" Text='<%#Bind("DivisionName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtDivisionName" runat="server" Text='<%#Bind("DivisionName") %>' Width="500px"></asp:TextBox>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Division Id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDivisionid" runat="server" Text='<%#Bind("DivisionId") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:Label ID="txtDivisionid" runat="server" Text='<%#Bind("DivisionId") %>'></asp:Label>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Operations">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="linkedit" runat="server" CommandName="Edit" Text="Edit">
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:LinkButton ID="linkupdate" runat="server" CommandName="update" Text="Update"
                                                            OnClientClick='return confirm(" Are you  sure you  want to update  the Division?");' Style="color: Black"></asp:LinkButton>
                                                        <asp:LinkButton ID="linkcancel" runat="server" CommandName="cancel" Text="Cancel"
                                                            OnClientClick='return confirm(" Are you  sure you  want to cancel  the Division?");' Style="color: Black"></asp:LinkButton>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="#2461BF" HorizontalAlign="Center" BorderWidth="1px" CssClass="GridPager" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Height="30" />
                                            <EditRowStyle ForeColor="#000" BackColor="#C2D69B" />
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
                        <a href="http://www.diyostech.com" target="_blank">Powered by DIYOS </a>
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
