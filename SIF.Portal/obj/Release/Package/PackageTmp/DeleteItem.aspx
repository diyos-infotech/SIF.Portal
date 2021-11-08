﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteItem.aspx.cs" Inherits="SIF.Portal.DeleteItem" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>DELETE ITEM</title>
    <link href="css/global.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 135px;
        }
    </style>
</head>
<body>
    <form id="DeleteItem1" runat="server">
    <!-- HEADER SECTION BEGIN -->
    <div id="headerouter">
        <!-- LOGO AND MAIN MENU SECTION BEGIN -->
        <div id="header">
            <!-- LOGO BEGIN -->
            <div id="logo">
                <a href="default.aspx">
                    <img border="0" src="assets/logo.png" alt="FACILITY MANAGEMENT SOFTWARE" title="FACILITY MANAGEMENT SOFTWARE"></a></div>
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
                    <li><a href="ViewItems.aspx" id="InventoryLink" runat="server" class="current"><span>
                        Inventory</span></a></li>
                    <li class="after"><a href="ActiveEmployeeReports.aspx" id="ReportsLink" runat="server">
                        <span>Reports</span></a></li>
                    <li><a href="Settings.aspx" id="SettingsLink" runat="server"><span>Settings</span></a></li>
                    <li class="last"><a href="login.aspx" id="LogOutLink" runat="server"><span><span>logout</span></span></a></li>
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
                            <div style="display: inline;">
                                <div id="submenu" class="submenu">
                                    <div class="submenubeforegap">
                                        &nbsp;</div>
                                    <div class="submenuactions">
                                        &nbsp;</div>
                                    <ul>
                                        <li class="current"><a href="ViewItems.aspx" id="saleslink" runat="server"><span>Items</span></a>
                                        </li>
                                        <li><a href="ViewStock.aspx" id="A1" runat="server"><span>Stock</span></a> </li>
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
        <div class="content-holder" style="height: auto">
            <h1 class="dashboard_heading">
                Items Dashboard</h1>
            <!-- DASHBOARD CONTENT BEGIN -->
            <div class="contentarea" id="contentarea">
                <div class="dashboard_full">
                    <div class="sidebox">
                        <div class="boxhead">
                            <h2 style="text-align: center">
                                Delete Item
                            </h2>
                        </div>
                        <div class="contentarea" id="Div1">
                            <div class="boxinc">
                                <ul>
                                    <li class="left leftmenu">
                                        <ul>
                                            <li><a href="ViewItems.aspx" id="ViewAllItemLink" runat="server">View All Items</a></li>
                                            <li><a href="AddnewItem.aspx" id="AddNewItemLink" runat="server">Add New Item</a></li>
                                            <li><a href="ModifyItem.aspx" id="ModifyItemLink" runat="server">Modify Item</a></li>
                                            <li><a href="DeleteItem.aspx" id="DeleteItemLink" runat="server" class="sel">Delete
                                                Item</a></li>
                                        </ul>
                                    </li>
                                    <li class="right">
                                        <table width="50%" border="0" cellpadding="5" cellspacing="5" class="FormContainer">
                                            <tr>
                                                <td>
                                                    <b>Item Name</b>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtsearch" runat="server" class="sinput"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" class=" btn save" OnClick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </li>
                                </ul>
                                <div class="rounded_corners">
                                    <asp:GridView ID="gvitems" runat="server" Width="100%" AutoGenerateColumns="False"
                                        Style="text-align: center" CellPadding="4" CellSpacing="3" ForeColor="#333333"
                                        GridLines="None" OnRowDeleting="gvitems_RowDeleting" AllowPaging="True" OnPageIndexChanging="gvitems_PageIndexChanging"
                                        PageSize="15">
                                        <RowStyle BackColor="#EFF3FB" Height="30" />
                                        <Columns>
                                            <asp:TemplateField HeaderText=" Item Id" ItemStyle-Width="60px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblitemid" runat="server" Text=" <%#Bind('itemid')%>"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="60px"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Item Name" ItemStyle-Width="50px" DataField="itemname">
                                                <ItemStyle Width="50px"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="unti Mesure" ItemStyle-Width="50px" DataField="unitmeasure">
                                                <ItemStyle Width="50px"></ItemStyle>
                                            </asp:BoundField>
                                            <%-- <asp:BoundField HeaderText="Price" ItemStyle-Width="50px" DataField="UnitPrice">
                                          <ItemStyle Width="50px"></ItemStyle>
                                      </asp:BoundField>
                                     --%>
                                            <%--     <asp:BoundField  HeaderText="BillDesc" ItemStyle-Width="60px"  DataField="BillDesc"/>--%>
                                            <%--     <asp:BoundField  HeaderText="Minimum Quantity" ItemStyle-Width="50px"  DataField="MinQuantity"/>--%>
                                            <%--<asp:BoundField HeaderText="Quantity" ItemStyle-Width="50px" DataField="Quantity">
                                          <ItemStyle Width="50px"></ItemStyle>
                                      </asp:BoundField>
                                      --%><asp:TemplateField ItemStyle-Width="50px">
                                          <ItemTemplate>
                                              <asp:LinkButton ID="linkdelete" runat="server" CommandName="delete" Text="Delete"
                                                  OnClientClick='return confirm("Are you sure you want to delete the item?");'></asp:LinkButton>
                                          </ItemTemplate>
                                          <ItemStyle Width="50px"></ItemStyle>
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
                                <asp:Label ID="lblresult" runat="server" Text="" Visible="false" Style="color: Red;
                                    margin-left: 350px"></asp:Label>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                    </div>
                    <%--   </div>--%>
                </div>
                <div class="clear">
                </div>
                <!-- DASHBOARD CONTENT END -->
            </div>
        </div>
        <!-- CONTENT AREA END -->
        <!-- FOOTER BEGIN -->
        <div id="footerouter">
            <div class="footer">
                <div class="footerlogo">
                    <a href="http://www.diyostech.Com" target="_blank">Powered by DIYOS </a>
                </div>
                <!--    <div class="footerlogo">&nbsp;</div> -->
                <div class="footercontent">
                    <a href="#">Terms &amp; Conditions</a> | <a href="#">Privacy Policy</a> | &copy;
                    <asp:Label ID="lblcname" runat="server"></asp:Label>.</div>
                <div class="clear">
                </div>
            </div>
        </div>
        <!-- FOOTER END -->
    </form>
</body>
</html>
