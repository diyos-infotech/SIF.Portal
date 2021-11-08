﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoanReports.aspx.cs" Inherits="SIF.Portal.LoanReports" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>REPORT: LOAN REPORT</title>
    <link href="css/global.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1 {
            width: 135px;
        }
    </style>

    <script type="text/javascript">

        function dtval(d, e) {
            var pK = e ? e.which : window.event.keyCode;
            if (pK == 8) { d.value = substr(0, d.value.length - 1); return; }
            var dt = d.value;
            var da = dt.split('/');
            for (var a = 0; a < da.length; a++) { if (da[a] != +da[a]) da[a] = da[a].substr(0, da[a].length - 1); }
            if (da[0] > 31) { da[1] = da[0].substr(da[0].length - 1, 1); da[0] = '0' + da[0].substr(0, da[0].length - 1); }
            if (da[1] > 12) { da[2] = da[1].substr(da[1].length - 1, 1); da[1] = '0' + da[1].substr(0, da[1].length - 1); }
            if (da[2] > 9999) da[1] = da[2].substr(0, da[2].length - 1);
            dt = da.join('/');
            if (dt.length == 2 || dt.length == 5) dt += '/';
            d.value = dt;
        }

    </script>

</head>
<body>
    <form id="LoanReports1" runat="server">
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
                        <li class="first"><a href="Employees.aspx" id="EmployeesLink" runat="server"><span>Employees</span></a>
                        </li>
                        <li><a href="clients.aspx" id="ClientsLink" runat="server"><span>Clients</span></a>
                        </li>
                        <li><a href="companyinfo.aspx" id="CompanyInfoLink" runat="server"><span>Company Info</span></a>
                        </li>
                        <li><a href="ViewItems.aspx" id="InventoryLink" runat="server"><span>Inventory</span></a>
                        </li>
                        <li><a href="Reports.aspx" id="ReportsLink" runat="server" class="current"><span>Reports</span></a></li>
                        <li class="after"><a href="CreateLogin.aspx" id="SettingsLink" runat="server"><span>Settings</span></a> </li>
                        <li class="last"><a href="login.aspx" id="LogOutLink" runat="server"><span><span>Logout</span></span></a>
                        </li>
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
                                            <li class="current"><a href="ActiveEmployeeReports.aspx" id="ActiveEmployeesLink"
                                                runat="server"><span>Employees</span></a></li>
                                            <li><a href="ActiveClientReports.aspx" id="ClientsReportsLink" runat="server"><span>Clients</span></a> </li>
                                            <li><a href="ListOfItemsReports.aspx" id="InventoryReportsLink" runat="server"><span>Inventory</span></a> </li>
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
                        <li><a href="Reports.aspx" style="z-index: 8;">Employee Reports</a></li>
                        <li class="active"><a href="LoanReports.aspx" style="z-index: 7;" class="active_bread">LOANS</a></li>
                    </ul>
                </div>
                <!-- DASHBOARD CONTENT BEGIN -->
                <div class="contentarea" id="contentarea">
                    <div class="dashboard_center">
                        <div class="sidebox">
                            <div class="boxhead">
                                <h2 style="text-align: center">LOANS
                                </h2>
                            </div>
                            <div class="boxbody" style="padding: 5px 5px 5px 5px;">
                                <div class="boxin">
                                    <asp:ScriptManager runat="server" ID="ScriptEmployReports">
                                    </asp:ScriptManager>
                                    <div style="margin-left: 20px">
                                        <div class="dashboard_firsthalf" style="width: 100%; display: none;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="LblFromDate" runat="server" Text="From Date"> </asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtStrtDate" runat="server"></asp:TextBox>
                                                        <cc1:CalendarExtender ID="txtFrom_CalendarExtender" runat="server" Enabled="true"
                                                            TargetControlID="txtStrtDate" Format="MM/dd/yyyy">
                                                        </cc1:CalendarExtender>
                                                        <cc1:FilteredTextBoxExtender ID="FTBEDOI"
                                                            runat="server" Enabled="True" TargetControlID="txtStrtDate"
                                                            ValidChars="/0123456789">
                                                        </cc1:FilteredTextBoxExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Designation
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlDesignation" Width="155px"
                                                            OnSelectedIndexChanged="ddlDesignation_SelectedIndexChanged">
                                                            <asp:ListItem> Choose Designation</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>Loan Type<span style="color: Red">*</span>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlLoanType" Width="153px">
                                                            <asp:ListItem>--Select--</asp:ListItem>
                                                            <asp:ListItem>Sal. Adv</asp:ListItem>
                                                            <asp:ListItem>Uniform</asp:ListItem>
                                                            <asp:ListItem>Others</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>


                                                <tr>

                                                    <td colspan="2">

                                                        <asp:Label ID="LblResult" runat="server" Text="" Style="color: Red" />

                                                    </td>
                                                </tr>


                                            </table>
                                        </div>

                                        <div class="dashboard_secondhalf" style="display: none">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="LblToDate" runat="server" Text=" To Date"> </asp:Label></td>
                                                    <td>
                                                        <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" TargetControlID="txtEndDate"
                                                            Format="MM/dd/yyyy">
                                                        </cc1:CalendarExtender>
                                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1"
                                                            runat="server" Enabled="True" TargetControlID="txtEndDate"
                                                            ValidChars="/0123456789">
                                                        </cc1:FilteredTextBoxExtender>
                                                    </td>
                                                    <td>
                                                        <asp:Button runat="server" ID="btn_Submit" Text="Submit"
                                                            class="btn save" />
                                                    </td>
                                                </tr>



                                                <tr>
                                                    <td>Loan Amount : </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlAmount" runat="server" Width="155px">
                                                            <asp:ListItem>--Select-- </asp:ListItem>
                                                            <asp:ListItem>0-1000</asp:ListItem>
                                                            <asp:ListItem>1000-5000</asp:ListItem>
                                                            <asp:ListItem>5000-10000</asp:ListItem>
                                                            <asp:ListItem>10000-Above</asp:ListItem>

                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="dashboard_firsthalf" style="width: 850px; margin-right: 120px;">
                                            <table width="100%" cellpadding="5" cellspacing="5">
                                                <tr>
                                                    <td>
                                                        <div style="margin-bottom: 32px">
                                                            <asp:Label runat="server" ID="lblLoanOperation" Text="Loan Operations:" Width="125px"></asp:Label>

                                                            <asp:DropDownList ID="ddlloanoperations" runat="server" Width="175px" OnSelectedIndexChanged="ddlloanoperations_OnSelectedIndexChanged">
                                                                <asp:ListItem>--Select--</asp:ListItem>
                                                                <asp:ListItem>Issued Loans</asp:ListItem>
                                                                <asp:ListItem>Pending Loans</asp:ListItem>
                                                                <asp:ListItem>Deducted Loans</asp:ListItem>
                                                                <asp:ListItem>Search Options</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div style="margin-bottom: 32px;">
                                                            <asp:Label runat="server" ID="lblissuedloans" Text="Select Options:" Width="125px"></asp:Label>
                                                            <asp:DropDownList ID="ddlissuedloans" runat="server" Width="175px" OnSelectedIndexChanged="ddlissuedloans_OnSelectedIndexChanged">
                                                                <asp:ListItem>Monthly Wise</asp:ListItem>
                                                                <asp:ListItem>Loan Type Wise</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblLoantype" Text="Select Loan Type :" Width="125px"></asp:Label>
                                                        <asp:DropDownList ID="ddlloantypes" runat="server" Width="175px">
                                                            <asp:ListItem>ALL</asp:ListItem>
                                                            <asp:ListItem>Sal.Adv</asp:ListItem>
                                                            <asp:ListItem>Uniform</asp:ListItem>
                                                            <asp:ListItem>Other Loans</asp:ListItem>
                                                            <asp:ListItem>Mobile Deductions</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblSelectmonth" Text="Select Month:" Width="125px"></asp:Label>
                                                        <asp:TextBox ID="txtloanissue" runat="server" Width="145px"> </asp:TextBox>
                                                        <cc1:CalendarExtender ID="CEloanissue" runat="server" Enabled="true"
                                                            TargetControlID="txtloanissue" Format="dd/MM/yyyy">
                                                        </cc1:CalendarExtender>
                                                        <cc1:FilteredTextBoxExtender ID="FTBEloanissue" runat="server" Enabled="True"
                                                            TargetControlID="txtloanissue" ValidChars="/0123456789">
                                                        </cc1:FilteredTextBoxExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                       <div align="right">
                                                            <asp:Button ID="Btn_Search_Loans" runat="server" OnClick="Btn_Search_Loans_Click" Text="Search"
                                                                 class="btn save" />
                                                           <asp:LinkButton ID="lbtn_Export" runat="server" OnClick="lbtn_Export_Click">Export to Excel</asp:LinkButton>

                                                            
                                                        </div>


                                                    </td>
                                                </tr>
                                            </table>


                                        </div>
                                        <div class="rounded_corners" style="overflow: auto">
                                            <asp:GridView ID="GVListEmployees" runat="server" AutoGenerateColumns="False" Width="100%"
                                                CssClass="datagrid" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="GVListEmployees_RowDataBound" ShowFooter="true">
                                                <RowStyle BackColor="#EFF3FB" />
                                                <Columns>


                                                    <asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="10%">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSno" runat="server" Text="<%#Container.DataItemIndex+1 %>"></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:Label ID="lblSno" runat="server" Text="<%#Container.DataItemIndex+1 %>"></asp:Label>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>


                                                    <asp:TemplateField HeaderText="Loan Id">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblloanno" Text="<%# Bind('LoanNo') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Loan Type">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblloantype" Text="<%# Bind('TypeOfLoan') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>


                                                    <asp:TemplateField HeaderText="empid">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblempid" Text="<%# Bind('EmpId') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Name">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblempmname" Text="<%# Bind('Fullname') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Designation">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lbldesignation" Text="<%# Bind('Design') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Loan Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblloanamount" Text="<%# Bind('LoanAmount') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>


                                                    <asp:TemplateField HeaderText="No Of Installments">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblEmpLastName" Text="<%# Bind('NoInstalments') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Amount To Be Deducted">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblamounttobededucted" Text="<%# Bind('AmountTobeDeducted') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Amount Deducted">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblamountdeducted" Text="<%# Bind('AmountDeducted') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Due Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lbldueamount" Text="<%# Bind('DueAmount') %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Loan Issue Date">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblloanissuedate"
                                                                Text='<%#Eval("LoanIssedDate", "{0:dd/MM/yyyy}")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>


                                                    <asp:TemplateField HeaderText="Loan Cutting Month">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblloancuttingmonth"
                                                                Text='<%#Eval("LoanCuttingMonth", "{0:dd/MM/yyyy}")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <%-- <asp:TemplateField HeaderText="Loan Description">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblloandescription" Text="<%# Bind('LoanType') %>"></asp:Label>
                                            </ItemTemplate>
                                             </asp:TemplateField>--%>

                                                    <asp:TemplateField HeaderText="Deduction Details">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="linkloandetails" runat="server" Text="Deduction Details"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Loan Status">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblEmpDesignation" Text="<%# Bind('LoanStatus') %>"></asp:Label>
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
                                    </div>
                                    <div>
                                        <table width="100%">
                                            <tr style="width: 100%; font-weight: bold">
                                                <td style="width: 50%" align="right">
                                                    <asp:Label ID="lbltamttext" runat="server" Text="&nbsp;&nbsp;Total Amount :"></asp:Label>
                                                </td>
                                                <td style="width: 62%">
                                                    <asp:Label ID="lbltmt" runat="server" Text="" Style="margin-left: 2%"></asp:Label>
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
                        <a href="http://www.diyostech.Com" target="_blank">Powered by DIYOS©
                    <asp:Label ID="lblcname" runat="server" meta:resourcekey="lblcnameResource1"></asp:Label>
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
