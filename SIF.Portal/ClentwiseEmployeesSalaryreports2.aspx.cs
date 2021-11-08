﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data;
using KLTS.Data;
using System.Globalization;
using SIF.Portal.DAL;
namespace SIF.Portal
{
    public partial class ClentwiseEmployeesSalaryreports2 : System.Web.UI.Page
    {
        AppConfiguration config = new AppConfiguration();
        GridViewExportUtil gve = new GridViewExportUtil();
        DataTable dt;
        string EmpIDPrefix = "";
        string CmpIDPrefix = "";
        string Elength = "";
        string Clength = "";
        string BranchID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetWebConfigdata();
                if (!IsPostBack)
                {
                    if (Session["UserId"] != null && Session["AccessLevel"] != null)
                    {
                        lblDisplayUser.Text = Session["UserId"].ToString();
                        PreviligeUsers(Convert.ToInt32(Session["AccessLevel"]));
                        lblcname.Text = SqlHelper.Instance.GetCompanyname();
                        switch (SqlHelper.Instance.GetCompanyValue())
                        {
                            case 0:// Write Omulance Invisible Links
                                break;
                            case 1://Write KLTS Invisible Links
                                ExpensesReportsLink.Visible = false;
                                break;
                            case 2://write Fames Link
                                ExpensesReportsLink.Visible = true;
                                break;


                            default:
                                break;
                        }
                    }
                    else
                    {
                        Response.Redirect("login.aspx");
                    }

                    LoadClientNames();
                    LoadClientList();
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void PreviligeUsers(int previligerid)
        {
            switch (previligerid)
            {
                case 1:
                    break;
                case 2:

                    break;
                case 3:
                    EmployeeReportLink.Visible = true;
                    ClientsReportLink.Visible = true;
                    InventoryReportLink.Visible = true;

                    EmployeesLink.Visible = true;
                    ClientsLink.Visible = true;
                    CompanyInfoLink.Visible = false;
                    InventoryLink.Visible = false;
                    ReportsLink.Visible = true;
                    SettingsLink.Visible = true;
                    break;

                case 4:
                    EmployeeReportLink.Visible = true;
                    ClientsReportLink.Visible = true;
                    InventoryReportLink.Visible = true;

                    EmployeesLink.Visible = true;
                    ClientsLink.Visible = true;
                    CompanyInfoLink.Visible = true;
                    InventoryLink.Visible = true;
                    ReportsLink.Visible = true;
                    SettingsLink.Visible = true;

                    break;
                case 5:
                    EmployeeReportLink.Visible = true;
                    ClientsReportLink.Visible = true;
                    InventoryReportLink.Visible = true;
                    EmployeesLink.Visible = true;
                    ClientsLink.Visible = true;
                    CompanyInfoLink.Visible = false;
                    InventoryLink.Visible = false;
                    ReportsLink.Visible = true;
                    ReportsLink.Visible = true;
                    SettingsLink.Visible = true;

                    break;
                case 6:
                    EmployeesLink.Visible = false;
                    ClientsLink.Visible = false;
                    CompanyInfoLink.Visible = false;
                    InventoryLink.Visible = true;
                    ReportsLink.Visible = true;
                    SettingsLink.Visible = false;
                    EmployeeReportLink.Visible = false;

                    break;
                default:
                    break;
            }
        }

        protected void GetWebConfigdata()
        {

            EmpIDPrefix = Session["EmpIDPrefix"].ToString();
            CmpIDPrefix = Session["CmpIDPrefix"].ToString();
            BranchID = Session["BranchID"].ToString();


        }

        protected void ddlcname_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            ClearData();
            if (ddlcname.SelectedIndex > 0)
            {
                txtmonth.Text = "";
                ddlclientid.SelectedValue = ddlcname.SelectedValue;
                ddlAttendance.SelectedIndex = 0;
            }
            else
            {
                ddlclientid.SelectedIndex = 0;
            }
        }

        protected void ddlclientid_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearData();

            if (ddlclientid.SelectedIndex > 0)
            {
                txtmonth.Text = "";
                ddlcname.SelectedValue = ddlclientid.SelectedValue;
                ddlAttendance.SelectedIndex = 0;

            }
            else
            {
                ddlcname.SelectedIndex = 0;
            }
        }

        protected void LoadClientNames()
        {
            DataTable DtClientids = GlobalData.Instance.LoadCNames(CmpIDPrefix,BranchID);
            if (DtClientids.Rows.Count > 0)
            {
                ddlcname.DataValueField = "Clientid";
                ddlcname.DataTextField = "clientname";
                ddlcname.DataSource = DtClientids;
                ddlcname.DataBind();
            }
            ddlcname.Items.Insert(0, "-Select-");
            ddlcname.Items.Insert(1, "ALL");

        }

        protected void LoadClientList()
        {
            DataTable DtClientNames = GlobalData.Instance.LoadCIds(CmpIDPrefix,BranchID);
            if (DtClientNames.Rows.Count > 0)
            {
                ddlclientid.DataValueField = "Clientid";
                ddlclientid.DataTextField = "Clientid";
                ddlclientid.DataSource = DtClientNames;
                ddlclientid.DataBind();
            }
            ddlclientid.Items.Insert(0, "-Select-");
            ddlclientid.Items.Insert(1, "ALL");
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            LblResult.Text = "";
            GVListEmployees.DataSource = null;
            GVListEmployees.DataBind();

            if (ddlclientid.SelectedIndex == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showlalert", "alert('Please Select Client Id/Name');", true);
                return;
            }

            if (txtmonth.Text.Trim().Length == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showlalert", "alert('Please Select Month');", true);

                return;
            }
            loadallsalarydetails();
        }

        protected void loadallsalarydetails()
        {
            string Clientid = ddlclientid.SelectedValue;

            string date = string.Empty;
            if (txtmonth.Text.Trim().Length > 0)
            {
                date = DateTime.Parse(txtmonth.Text.Trim(), CultureInfo.GetCultureInfo("en-gb")).ToString();
            }

            string month = DateTime.Parse(date).Month.ToString();
            string Year = DateTime.Parse(date).Year.ToString();
            string sqlqrywithbankacno = string.Empty;
            string sqlqrywithoutbankacno = string.Empty;


            if (ddlclientid.SelectedIndex == 1)
            {
                if (ddlAttendance.SelectedIndex == 0)
                {
                    sqlqrywithbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname + ' ' + E.EmpMname +' ' + E.emplname) as EmpMname ,D.Design," +
                              " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                              " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                              " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                              " EP.ESIEmpr as  Empresi," +
                              "EP.PFEmpr as  Emprpf,   " +
                              "(EP.ESIEmpr +EP.esi) as  Esitotal, " +
                              " (EP.PFEmpr+EP.pf) as  pftotal  " +
                              "  from  emppaysheet EP " +
                              " inner join Clients C on  C.Clientid = EP.Clientid " +
                              " inner join  empdetails E on E.Empid=EP.Empid   " +
                              " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                              " inner join Designations D on D.DesignId = EP.Desgn " +
                              "  " +
                              " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                              " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                              "  and  EP.noofduties<>0  and EP.month='" + month + Year.Substring(2, 2) +
                               " ' and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid  and  EP.Desgn=EA.Design    and  len(E.Empbankacno)<>0 ";

                    sqlqrywithoutbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname + ' ' + E.EmpMname +' ' + E.emplname) as EmpMname ,D.Design," +
                            " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                            " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                            " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                            " EP.ESIEmpr as  Empresi," +
                            "EP.PFEmpr as  Emprpf,   " +
                            "(EP.ESIEmpr +EP.esi) as  Esitotal, " +
                            " (EP.PFEmpr+EP.pf) as  pftotal  " +
                            "  from  emppaysheet EP " +
                            " inner join Clients C on  C.Clientid = EP.Clientid " +
                            " inner join  empdetails E on E.Empid=EP.Empid   " +
                            " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                            " inner join Designations D on D.DesignId = EP.Desgn  " +
                            "  " +
                            " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                            " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                            "  and  EP.noofduties<>0  and EP.month='" + month + Year.Substring(2, 2) +
                             " ' and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid  " +
                             " and  EP.Desgn=EA.Design   and  (len( E.EmpBankAcNo)=0  or  E.EmpBankAcNo is null) ";

                    string subquerywithbankacno = string.Empty;
                    string subquerywithoutbankacno = string.Empty;
                    if (ddlpfesioptions.SelectedIndex == 0)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + " and  EP.pf>0    " +
                         "  order By   right(EP.Clientid, 4), EP.Empid";



                        subquerywithoutbankacno = sqlqrywithoutbankacno + " and  EP.pf>0    " +
                         "  order By   right(EP.Clientid,4) , EP.Empid";


                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }


                    if (ddlpfesioptions.SelectedIndex == 1)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + " and  EP.esi>0  " +
                        "  order By   right(EP.Clientid,4) ,  EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + " and  EP.esi>0  " +
                        "  order By   right(EP.Clientid,4) ,  EP.Empid";


                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }





                    if (ddlpfesioptions.SelectedIndex == 2)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + "  and  EP.pf <=0 " +
                         "  order By   right(EP.Clientid,4) ,EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + "  and  EP.pf <=0 " +
                      "  order By   right(EP.Clientid,4) , EP.Empid";
                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }
                    if (ddlpfesioptions.SelectedIndex == 3)
                    {


                        subquerywithbankacno = sqlqrywithbankacno + "  and  EP.esi <=0 " +
                        "  order By  right(EP.Clientid,4),EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + "  and  EP.esi <=0 " +
                     "  order By   right(EP.Clientid,4) , EP.Empid";
                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }


                }

                if (ddlAttendance.SelectedIndex == 1)
                {
                    sqlqrywithbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname + ' ' + E.EmpMname +' ' + E.emplname) as EmpMname ,D.Design," +
                             " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                             " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                             " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                             " EP.ESIEmpr as  Empresi," +
                             "EP.PFEmpr as  Emprpf,   " +
                             "(EP.ESIEmpr +EP.esi) as  Esitotal, " +
                             " (EP.PFEmpr+EP.pf) as  pftotal  " +
                             "  from  emppaysheet EP " +
                             " inner join Clients C on  C.Clientid = EP.Clientid " +
                             " inner join  empdetails E on E.Empid=EP.Empid   " +
                             " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                             " inner join Designations D on D.DesignId = EP.Desgn  " +
                             "  " +
                             " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                             " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                             "  and  EP.noofduties>=10  and EP.month='" + month + Year.Substring(2, 2) +
                              " ' and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid  and  EP.Desgn=EA.Design    and  len(E.Empbankacno)<>0 ";

                    sqlqrywithoutbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname + ' ' + E.EmpMname +' ' + E.emplname) as EmpMname ,D.Design," +
                            " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                            " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                            " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                            " EP.ESIEmpr as  Empresi," +
                            "EP.PFEmpr as  Emprpf,   " +
                            "(EP.ESIEmpr +EP.esi) as  Esitotal, " +
                            " (EP.PFEmpr+EP.pf) as  pftotal  " +
                            "  from  emppaysheet EP " +
                            " inner join Clients C on  C.Clientid = EP.Clientid " +
                            " inner join  empdetails E on E.Empid=EP.Empid   " +
                            " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                            " inner join Designations D on D.DesignId = EP.Desgn  " +
                            "  " +
                            " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                            " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                            "  and  EP.noofduties>=10  and EP.month='" + month + Year.Substring(2, 2) +
                             " ' and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid  " +
                             " and  EP.Desgn=EA.Design   and  (len( E.EmpBankAcNo)=0  or  E.EmpBankAcNo is null) ";

                    string subquerywithbankacno = string.Empty;
                    string subquerywithoutbankacno = string.Empty;
                    if (ddlpfesioptions.SelectedIndex == 0)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + " and  EP.pf>0    " +
                         " order By   right(EP.Clientid, 4), EP.Empid";



                        subquerywithoutbankacno = sqlqrywithoutbankacno + " and  EP.pf>0    " +
                         " order By   right(EP.Clientid, 4), EP.Empid";


                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }


                    if (ddlpfesioptions.SelectedIndex == 1)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + " and  EP.esi>0  " +
                        " order By   right(EP.Clientid, 4), EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + " and  EP.esi>0  " +
                        " order By   right(EP.Clientid, 4), EP.Empid";


                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }


                    if (ddlpfesioptions.SelectedIndex == 2)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + "  and  EP.pf <=0 " +
                         "  order By   right(EP.Clientid, 4), EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + "  and  EP.pf <=0 " +
                      " order By   right(EP.Clientid, 4), EP.Empid";
                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }
                    if (ddlpfesioptions.SelectedIndex == 3)
                    {


                        subquerywithbankacno = sqlqrywithbankacno + "  and  EP.esi <=0 " +
                        "  order By   right(EP.Clientid, 4), EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + "  and  EP.esi <=0 " +
                     " order By   right(EP.Clientid, 4), EP.Empid";
                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }
                }
                if (ddlAttendance.SelectedIndex == 2)
                {
                    sqlqrywithbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname + ' ' + E.EmpMname +' ' + E.emplname) as EmpMname ,D.Design," +
                             " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                             " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                             " EP.gross,EP.otamt,EP.pf,EP.esi,EP.penalty,EP.pfwages,EP.esiwages,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                             " EP.ESIEmpr as  Empresi," +
                             "EP.PFEmpr as  Emprpf,   " +
                             "(EP.ESIEmpr +EP.esi) as  Esitotal, " +
                             " (EP.PFEmpr+EP.pf) as  pftotal  " +
                             "  from  emppaysheet EP " +
                             " inner join Clients C on  C.Clientid = EP.Clientid " +
                             " inner join  empdetails E on E.Empid=EP.Empid   " +
                             " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                             " inner join Designations D on D.DesignId = EP.Desgn " +
                             "  " +
                             " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                             " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                             "  and  EP.noofduties<10  and EP.month='" + month + Year.Substring(2, 2) +
                              " ' and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid  and  EP.Desgn=EA.Design    and  len(E.Empbankacno)<>0 ";

                    sqlqrywithoutbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname + ' ' + E.EmpMname +' ' + E.emplname) as EmpMname ,D.Design," +
                            " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                            " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                            " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                            " EP.ESIEmpr as  Empresi," +
                            "EP.PFEmpr as  Emprpf,   " +
                            "(EP.ESIEmpr +EP.esi) as  Esitotal, " +
                            " (EP.PFEmpr+EP.pf) as  pftotal  " +
                            "  from  emppaysheet EP " +
                            " inner join Clients C on  C.Clientid = EP.Clientid " +
                            " inner join  empdetails E on E.Empid=EP.Empid   " +
                            " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                            " inner join Designations D on D.DesignId = EP.Desgn " +
                            "  " +
                            " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                            " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                            "  and  EP.noofduties<10  and EP.month='" + month + Year.Substring(2, 2) +
                             " ' and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid  " +
                             " and  EP.Desgn=EA.Design   and  (len( E.EmpBankAcNo)=0  or  E.EmpBankAcNo is null) ";

                    string subquerywithbankacno = string.Empty;
                    string subquerywithoutbankacno = string.Empty;
                    if (ddlpfesioptions.SelectedIndex == 0)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + " and  EP.pf>0    " +
                         "   order By   right(EP.Clientid, 4), EP.Empid";



                        subquerywithoutbankacno = sqlqrywithoutbankacno + " and  EP.pf>0    " +
                         "   order By   right(EP.Clientid, 4), EP.Empid";


                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }


                    if (ddlpfesioptions.SelectedIndex == 1)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + " and  EP.esi>0  " +
                        "   order By   right(EP.Clientid, 4), EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + " and  EP.esi>0  " +
                        "   order By   right(EP.Clientid, 4), EP.Empid";


                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }


                    if (ddlpfesioptions.SelectedIndex == 2)
                    {

                        subquerywithbankacno = sqlqrywithbankacno + "  and  EP.pf <=0 " +
                         "   order By   right(EP.Clientid, 4), EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + "  and  EP.pf <=0 " +
                      "   order By   right(EP.Clientid, 4), EP.Empid";
                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }
                    if (ddlpfesioptions.SelectedIndex == 3)
                    {


                        subquerywithbankacno = sqlqrywithbankacno + "  and  EP.esi <=0 " +
                        "   order By   right(EP.Clientid, 4), EP.Empid";

                        subquerywithoutbankacno = sqlqrywithoutbankacno + "  and  EP.esi <=0 " +
                     "   order By   right(EP.Clientid, 4), EP.Empid";
                        Bindata(subquerywithbankacno, subquerywithoutbankacno);
                        return;
                    }
                }


            }
            if (ddlAttendance.SelectedIndex == 0)
            {
                sqlqrywithbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname +' ' + E.EmpMname + ' ' +  E.emplname) as EmpMname ,D.Design," +
                           " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                           " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                           " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                           " EP.ESIEmpr as  Empresi," +
                           "EP.PFEmpr as  Emprpf ,   " +
                           "(EP.ESIEmpr+EP.esi) as  Esitotal, " +
                           " (EP.PFEmpr+EP.pf) as  pftotal  " +
                           "  from  emppaysheet EP " +
                           " inner join Clients C on  C.Clientid = EP.Clientid " +
                           " inner join  empdetails E on E.Empid=EP.Empid   " +
                      " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                      "   inner join Designations D on D.DesignId = EP.Desgn " +
                      "  " +
                     " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                      " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                      "  and    EP.Clientid='" + ddlclientid.SelectedValue + "'  and  EP.noofduties<>0  and EP.month='" + month + Year.Substring(2, 2) +
                      " '  and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid   and  EP.Desgn=EA.Design and len(E.Empbankacno)<>0 ";



                sqlqrywithoutbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname +' ' + E.EmpMname + ' ' +  E.emplname) as EmpMname ,D.Design," +
                         " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                         " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                         " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                         " EP.ESIEmpr as  Empresi," +
                         "EP.PFEmpr as  Emprpf ,   " +
                         "(EP.ESIEmpr+EP.esi) as  Esitotal, " +
                         " (EP.PFEmpr+EP.pf) as  pftotal  " +
                         "  from  emppaysheet EP " +
                         " inner join Clients C on  C.Clientid = EP.Clientid " +
                         " inner join  empdetails E on E.Empid=EP.Empid   " +
                    " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                    "   inner join Designations D on D.DesignId = EP.Desgn " +
                    "  " +
                   " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                    " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                    "  and    EP.Clientid='" + ddlclientid.SelectedValue + "'  and  EP.noofduties<>0  and EP.month='" + month + Year.Substring(2, 2) +
                    " '  and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid   and  EP.Desgn=EA.Design  and  (len( E.EmpBankAcNo)=0  or  E.EmpBankAcNo is null) ";

                string SUBQUERY2withbankacno = string.Empty;
                string SUBQUERY2withoutbankacno = string.Empty;

                if (ddlpfesioptions.SelectedIndex == 0)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and  EP.pf>0     order By   right(EP.Clientid, 4), EP.Empid";


                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and  EP.pf>0      order By   right(EP.Clientid, 4), EP.Empid";
                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }




                if (ddlpfesioptions.SelectedIndex == 1)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + "   and EP.esi>0   order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + "   order By   right(EP.Clientid, 4), EP.Empid";


                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }

                if (ddlpfesioptions.SelectedIndex == 2)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and  EP.pf<=0      order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and  EP.pf<=0      order By   right(EP.Clientid, 4), EP.Empid";
                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }
                if (ddlpfesioptions.SelectedIndex == 3)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and   EP.esi<=0    order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and   EP.esi<=0    order By   right(EP.Clientid, 4), EP.Empid";

                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }
            }
            if (ddlAttendance.SelectedIndex == 1)
            {
                sqlqrywithbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname +' ' + E.EmpMname + ' ' +  E.emplname) as EmpMname ,D.Design," +
                           " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                           " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                           " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                           " EP.ESIEmpr as  Empresi," +
                           "EP.PFEmpr as  Emprpf ,   " +
                           "(EP.ESIEmpr+EP.esi) as  Esitotal, " +
                           " (EP.PFEmpr+EP.pf) as  pftotal  " +
                           "  from  emppaysheet EP " +
                           " inner join Clients C on  C.Clientid = EP.Clientid " +
                           " inner join  empdetails E on E.Empid=EP.Empid   " +
                      " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                      "  inner join Designations D on D.DesignId = EP.Desgn  " +
                      "  " +
                     " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                      " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                      "  and    EP.Clientid='" + ddlclientid.SelectedValue + "'  and  EP.noofduties>=10  and EP.month='" + month + Year.Substring(2, 2) +
                      " '  and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid   and  EP.Desgn=EA.Design and len(E.Empbankacno)<>0 ";



                sqlqrywithoutbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname +' ' + E.EmpMname + ' ' +  E.emplname) as EmpMname ,D.Design," +
                         " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                         " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                         " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                         " EP.ESIEmpr as  Empresi," +
                         "EP.PFEmpr as  Emprpf ,   " +
                         "(EP.ESIEmpr+EP.esi) as  Esitotal, " +
                         " (EP.PFEmpr+EP.pf) as  pftotal  " +
                         "  from  emppaysheet EP " +
                         " inner join Clients C on  C.Clientid = EP.Clientid " +
                         " inner join  empdetails E on E.Empid=EP.Empid   " +
                    " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                    "  inner join Designations D on D.DesignId = EP.Desgn  " +
                    "  " +
                   " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                    " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                    "  and    EP.Clientid='" + ddlclientid.SelectedValue + "'  and  EP.noofduties>=10  and EP.month='" + month + Year.Substring(2, 2) +
                    " '  and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid   and  EP.Desgn=EA.Design  and  (len( E.EmpBankAcNo)=0  or  E.EmpBankAcNo is null) ";

                string SUBQUERY2withbankacno = string.Empty;
                string SUBQUERY2withoutbankacno = string.Empty;

                if (ddlpfesioptions.SelectedIndex == 0)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and  EP.pf>0      order By   right(EP.Clientid, 4), EP.Empid";


                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and  EP.pf>0     order By   right(EP.Clientid, 4), EP.Empid";
                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }




                if (ddlpfesioptions.SelectedIndex == 1)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + "   and EP.esi>0    order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + "   and EP.esi>0    order By   right(EP.Clientid, 4), EP.Empid";


                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }

                if (ddlpfesioptions.SelectedIndex == 2)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and  EP.pf<=0     order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and  EP.pf<=0      order By   right(EP.Clientid, 4), EP.Empid";
                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }
                if (ddlpfesioptions.SelectedIndex == 3)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and   EP.esi<=0    order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and   EP.esi<=0    order By   right(EP.Clientid, 4), EP.Empid";

                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }
            }
            if (ddlAttendance.SelectedIndex == 2)
            {
                sqlqrywithbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname +' ' + E.EmpMname + ' ' +  E.emplname) as EmpMname ,D.Design," +
                           " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                           " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                           " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                           " EP.ESIEmpr as  Empresi," +
                           "EP.PFEmpr as  Emprpf ,   " +
                           "(EP.ESIEmpr+EP.esi) as  Esitotal, " +
                           " (EP.PFEmpr+EP.pf) as  pftotal  " +
                           "  from  emppaysheet EP " +
                           " inner join Clients C on  C.Clientid = EP.Clientid " +
                           " inner join  empdetails E on E.Empid=EP.Empid   " +
                      " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                      "  inner join Designations D on D.DesignId = EP.Desgn  " +
                      "  " +
                     " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                      " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                      "  and    EP.Clientid='" + ddlclientid.SelectedValue + "'  and  EP.noofduties<10  and EP.month='" + month + Year.Substring(2, 2) +
                      " '  and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid   and  EP.Desgn=EA.Design and len(E.Empbankacno)<>0 ";



                sqlqrywithoutbankacno = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname +' ' + E.EmpMname + ' ' +  E.emplname) as EmpMname ,D.Design," +
                         " E.Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.hra,EP.Conveyance,EP.CCA,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, ESC.EmpESINo , EPC.empepfno, " +
                         " EP.WashAllowance, EP.Bonus, EP.LeaveEncashAmt, EP.Incentivs, EP.Gratuity, " +
                         " EP.gross,EP.otamt,EP.pf,EP.esi,EP.pfwages,EP.esiwages,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed," +
                         " EP.ESIEmpr as  Empresi," +
                         "EP.PFEmpr as  Emprpf ,   " +
                         "(EP.ESIEmpr+EP.esi) as  Esitotal, " +
                         " (EP.PFEmpr+EP.pf) as  pftotal  " +
                         "  from  emppaysheet EP " +
                         " inner join Clients C on  C.Clientid = EP.Clientid " +
                         " inner join  empdetails E on E.Empid=EP.Empid   " +
                    " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                    "  inner join Designations D on D.DesignId = EP.Desgn  " +
                    "  " +
                   " inner join  EMPESICodes ESC on ESC.Empid=EP.Empid   " +
                    " inner join  EMPEPFCodes EPC on EPC.Empid=EP.Empid  " +
                    "  and    EP.Clientid='" + ddlclientid.SelectedValue + "'  and  EP.noofduties<10  and EP.month='" + month + Year.Substring(2, 2) +
                    " '  and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid   and  EP.Desgn=EA.Design  and  (len( E.EmpBankAcNo)=0  or  E.EmpBankAcNo is null) ";

                string SUBQUERY2withbankacno = string.Empty;
                string SUBQUERY2withoutbankacno = string.Empty;

                if (ddlpfesioptions.SelectedIndex == 0)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and  EP.pf>0     order By   right(EP.Clientid, 4), EP.Empid";


                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and  EP.pf>0      order By   right(EP.Clientid, 4), EP.Empid";
                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }




                if (ddlpfesioptions.SelectedIndex == 1)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + "   and EP.esi>0    order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + "   and EP.esi>0    order By   right(EP.Clientid, 4), EP.Empid";


                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }

                if (ddlpfesioptions.SelectedIndex == 2)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and  EP.pf<=0      order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and  EP.pf<=0      order By   right(EP.Clientid, 4), EP.Empid";
                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }
                if (ddlpfesioptions.SelectedIndex == 3)
                {
                    SUBQUERY2withbankacno = sqlqrywithbankacno + " and   EP.esi<=0    order By   right(EP.Clientid, 4), EP.Empid";

                    SUBQUERY2withoutbankacno = sqlqrywithoutbankacno + " and   EP.esi<=0    order By   right(EP.Clientid, 4), EP.Empid";

                    Bindata(SUBQUERY2withbankacno, SUBQUERY2withoutbankacno);
                    return;
                }
            }
        }

        protected void Bindata(string Sqlqrywithbankacno, string Sqlqrywithoutbankacno)
        {
            DataTable dtwithbankacno = config.ExecuteAdaptorAsyncWithQueryParams(Sqlqrywithbankacno).Result;
            DataTable dtwithoutbankacno = config.ExecuteAdaptorAsyncWithQueryParams(Sqlqrywithoutbankacno).Result;

            if (dtwithbankacno.Rows.Count > 0 || dtwithoutbankacno.Rows.Count > 0)
            {

                //if (dtwithoutbankacno.Rows.Count>0)
                //{

                //    foreach(DataRow dr in dtwithoutbankacno.Rows)
                //    {
                //        dtwithbankacno.Rows.Add(dr);
                //    }
                //}
                dtwithbankacno.Merge(dtwithoutbankacno);

                DataSet Dtbank = new DataSet();
                Dtbank.Tables.Add(dtwithbankacno);
                Dtbank.Tables.Add(dtwithoutbankacno);

                int Bankacnowith = dtwithbankacno.Rows.Count;
                int Bankacnowithout = dtwithoutbankacno.Rows.Count;

                GVListEmployees.DataSource = dtwithbankacno;
                //GVListEmployees.DataSource = dtwithoutbankacno;
                GVListEmployees.DataBind();
                lbtn_Export.Visible = true;
            }
            else
            {
                GVListEmployees.DataSource = null;
                GVListEmployees.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "showlalert", "alert('There Is No Salary Details For The Selected client');", true);

            }
        }

        protected void Fillpfandesidetails()
        {
            string Clientid = ddlclientid.SelectedValue;
            string date = string.Empty;
            if (txtmonth.Text.Trim().Length > 0)
            {
                date = DateTime.Parse(txtmonth.Text.Trim(), CultureInfo.GetCultureInfo("en-gb")).ToString();
            }

            string month = DateTime.Parse(date).Month.ToString();
            string Year = DateTime.Parse(date).Year.ToString();
            for (int i = 0; i < GVListEmployees.Rows.Count; i++)
            {
                string empidforempname = GVListEmployees.Rows[i].Cells[2].Text;
                string Sqlqry = "Select E.Empmname,EA.ot from Empdetails E inner join Empattendance   " +
                       "  EA on E.empid=EA.empid and   E.Empid='" + empidforempname + "' and EA.Clientid='" +
                        ddlclientid.SelectedValue + "' and month='" + month + Year.Substring(2, 2)
                        + "' and  EA.ClientId='" + ddlclientid.SelectedValue + "'";
                DataTable dtempname = config.ExecuteAdaptorAsyncWithQueryParams(Sqlqry).Result;

                if (dtempname.Rows.Count > 0)
                {

                }

                string sqlqryforemprpfesi = "select pf.emprpf,esi.empresi from emppaysheet EP inner join Epfded pf" +
                    " on pf.empid=EP.Empid  inner join Esided esi on esi.empid=EP.empid  and EP.clientid='" + ddlclientid.SelectedValue + "'";
                DataTable dtemprpfandesi = config.ExecuteAdaptorAsyncWithQueryParams(sqlqryforemprpfesi).Result;
                if (dtemprpfandesi.Rows.Count > 0)
                {
                    Label emprpf = GVListEmployees.Rows[i].FindControl("lblpfempr") as Label;
                    emprpf.Text = dtemprpfandesi.Rows[0]["emprpf"].ToString();

                    float temprpf = 0;
                    if (emprpf.Text.Trim().Length != 0)
                    {
                        temprpf = float.Parse(emprpf.Text);
                    }

                    string Epf = GVListEmployees.Rows[i].Cells[10].Text;
                    float emppf = 0;
                    if (String.IsNullOrEmpty(Epf.Trim()) != null)
                    {
                        if (Epf.Trim().Length != 0)
                        {
                            emppf = float.Parse(Epf);
                        }
                    }

                    float totalpf = temprpf + emppf;
                    Label ttotalpf = GVListEmployees.Rows[i].FindControl("lblpftotal") as Label;
                    ttotalpf.Text = totalpf.ToString();

                    Label empresi = GVListEmployees.Rows[i].FindControl("lblempresi") as Label;
                    empresi.Text = dtemprpfandesi.Rows[0]["empresi"].ToString();

                    float tempresi = 0;
                    if (empresi.Text.Trim().Length != 0)
                    {
                        tempresi = float.Parse(empresi.Text);
                    }
                    string Eesi = GVListEmployees.Rows[i].Cells[14].Text;
                    float empesi = 0;
                    if (String.IsNullOrEmpty(Eesi.Trim()) != null)
                    {
                        if (Eesi.Trim().Length != 0)
                        {
                            empesi = float.Parse(Eesi);
                        }
                    }
                    float ttotalesi = tempresi + empesi;
                    Label totalesi = GVListEmployees.Rows[i].FindControl("lblesitotal") as Label;
                    totalesi.Text = ttotalesi.ToString();
                }

                string sqlqryforesipfacno = "Select  EMPEPFCodes.EmpEpfNo,   EMPESICodes.EmpESINo, Empdetails.EmpBankAcNo   FRom Empdetails,EMPEPFCodes,EMPESICodes where   Empdetails.empid='" + empidforempname + "'";
                DataTable dtforpfesinos = config.ExecuteAdaptorAsyncWithQueryParams(sqlqryforesipfacno).Result;

                if (dtforpfesinos.Rows.Count > 0)
                {
                    Label pfno = GVListEmployees.Rows[i].FindControl("lblpfno") as Label;
                    pfno.Text = dtforpfesinos.Rows[0]["EmpEpfNo"].ToString();
                    Label esino = GVListEmployees.Rows[i].FindControl("lblpfno") as Label;
                    esino.Text = dtforpfesinos.Rows[0]["EmpESINo"].ToString();
                    Label acno = GVListEmployees.Rows[i].FindControl("lblacno") as Label;
                    acno.Text = dtforpfesinos.Rows[0]["EmpBankAcNo"].ToString();
                }
            }
        }

        protected void ClearData()
        {
            LblResult.Text = "";
            GVListEmployees.DataSource = null;
            GVListEmployees.DataBind();
            lbtn_Export.Visible = false;
        }

        protected void lbtn_Export_Click(object sender, EventArgs e)
        {
            gve.Export("AllUnitsEsiReport.xls", this.GVListEmployees);
        }

        protected void GVListEmployees_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GVListEmployees.PageIndex = e.NewPageIndex;
            loadallsalarydetails();
        }

        float totalNoOfDuties = 0;
        float totalOTs = 0;
        float totalBasic = 0;
        float totalDA = 0;
        float GROSS = 0;
        float totalOTAmt = 0;
        float totalPF = 0;
        float totalESI = 0;
        float totalProfitTax = 0;
        float totalOWF = 0;
        float totalSalAdvanced = 0;
        float totalPenality = 0;
        float totalActualAmount = 0;
        protected void GVListEmployees_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            // string empno = GVListEmployees.Rows[e.Row.RowIndex].Cells[0].Text;


            //if(IsPostBack)
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{

            //    string empno = e.Row.Cells[2].Text;
            //    Label lblpfno = (Label)e.Row.FindControl("lblpfno");
            //    Label lblesino = (Label)e.Row.FindControl("lblesino");
            //    string sqlqry = " Select  EP.empepfno,ES.EmpEsino from EMPESICodes as ES,EMPEPFCodes as  EP where ES.Empid='" + empno +
            //        "' or EP.Empid='" + empno + "'";


            //    DataTable dtpfesinos = SqlHelper.Instance.GetTableByQuery(sqlqry);
            //    if (dtpfesinos.Rows.Count > 0)
            //    {
            //        lblpfno.Text = dtpfesinos.Rows[0]["empepfno"].ToString();
            //        lblesino.Text = dtpfesinos.Rows[0]["EmpEsino"].ToString();
            //    }
            //    else
            //    {
            //        lblpfno.Text = "NA";
            //        lblesino.Text = "NA";

            //    }
            //}
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    float NoOfDuties = float.Parse(((Label)e.Row.FindControl("lblNoofduties")).Text);
            //    totalNoOfDuties += NoOfDuties;
            //    float OTs = float.Parse(((Label)e.Row.FindControl("lblot")).Text);
            //    totalOTs += OTs;
            //    float basic = float.Parse(((Label)e.Row.FindControl("lblbasic")).Text);
            //    totalBasic += basic;
            //    float da = float.Parse(((Label)e.Row.FindControl("lblda")).Text);
            //    totalDA += da;
            //    float totalgross = float.Parse(((Label)e.Row.FindControl("lbltotalgross")).Text);
            //    totalGROSS += totalgross;
            //    float otamt = float.Parse(((Label)e.Row.FindControl("lblotamt")).Text);
            //    totalOTAmt += otamt;
            //    float pf = float.Parse(((Label)e.Row.FindControl("lblpf")).Text);
            //    totalPF += pf;
            //    float ESI = float.Parse(((Label)e.Row.FindControl("lblESI")).Text);
            //    totalESI += ESI;
            //    float Proftax = float.Parse(((Label)e.Row.FindControl("lblProftax")).Text);
            //    totalProfitTax += Proftax;
            //    //float owf = float.Parse(((Label)e.Row.FindControl("lblowf")).Text);
            //    //totalOWF += owf;
            //    float saladvded = float.Parse(((Label)e.Row.FindControl("lblsaladvded")).Text);
            //    totalSalAdvanced += saladvded;
            //    float Penalty = float.Parse(((Label)e.Row.FindControl("lblPenalty")).Text);
            //    totalPenality += Penalty;
            //    float actualamount = float.Parse(((Label)e.Row.FindControl("lblactualamount")).Text);
            //    totalActualAmount += actualamount;


            //}
            //if (e.Row.RowType == DataControlRowType.Footer)
            //{
            //    ((Label)e.Row.FindControl("lblTotalNoofduties")).Text = totalNoOfDuties.ToString();
            //    ((Label)e.Row.FindControl("lblTotalots")).Text = totalOTs.ToString();
            //    ((Label)e.Row.FindControl("lblTotalbasic")).Text = totalBasic.ToString();
            //    ((Label)e.Row.FindControl("lblTotalda")).Text = totalDA.ToString();
            //    ((Label)e.Row.FindControl("lblTotalGross")).Text = totalGROSS.ToString();
            //    ((Label)e.Row.FindControl("lblTotalotamt")).Text = totalOTAmt.ToString();
            //    ((Label)e.Row.FindControl("lblTotalpf")).Text = totalPF.ToString();
            //    ((Label)e.Row.FindControl("lblTotalESI")).Text = totalESI.ToString();
            //    ((Label)e.Row.FindControl("lblTotalProftax")).Text = totalProfitTax.ToString();
            //    //((Label)e.Row.FindControl("lblTotalowf")).Text = totalOWF.ToString();
            //    ((Label)e.Row.FindControl("lblTotalsaladvded")).Text = totalSalAdvanced.ToString();
            //    ((Label)e.Row.FindControl("lblTotalpenalty")).Text = totalPenality.ToString();
            //    ((Label)e.Row.FindControl("lblTotalactualamount")).Text = totalActualAmount.ToString();



            //}
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //If the first template field of gridview contains
                //numeric or floting point data then use this code

                e.Row.Cells[34].Attributes.Add("class", "text");
                e.Row.Cells[35].Attributes.Add("class", "text");


            }
        }

    }
}