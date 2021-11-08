﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using KLTS.Data;
using System.Globalization;
using System.Collections;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using System.Drawing;
using SIF.Portal.DAL;
namespace SIF.Portal
{

    public partial class ReportForBulkpaysheetforclients : System.Web.UI.Page
    {
        AppConfiguration config = new AppConfiguration();
        GridViewExportUtil gve = new GridViewExportUtil();
        DataTable dt;
        string EmpIDPrefix = "";
        string CmpIDPrefix = "";
        string Elength = "";
        string Clength = "";
        string Fontstyle = "";
        string CFontstyle = "";


        protected void Page_Load(object sender, EventArgs e)
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
            EmpIDPrefix = GlobalData.Instance.GetEmployeeIDPrefix();
            Elength = (EmpIDPrefix.Trim().Length + 1).ToString();
            CmpIDPrefix = GlobalData.Instance.GetClientIDPrefix();
            Clength = (CmpIDPrefix.Trim().Length + 1).ToString();
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            LblResult.Text = "";
            GVListEmployees.DataSource = null;
            GVListEmployees.DataBind();

            if (txtmonth.Text.Trim().Length == 0)
            {
                LblResult.Text = "Please Select Month";
                return;
            }

            var testDate = 0;
            if (txtmonth.Text.Trim().Length > 0)
            {
                testDate = GlobalData.Instance.CheckEnteredDate(txtmonth.Text);
                if (testDate > 0)
                {
                    LblResult.Text = "You Are Entered Invalid Date.Date Format Should be [DD/MM/YYYY].Ex.01/01/1990";
                    return;
                }

            }
            string date = DateTime.Parse(txtmonth.Text.Trim(), CultureInfo.GetCultureInfo("en-gb")).ToString();
            string month = DateTime.Parse(date).Month.ToString();
            string Year = DateTime.Parse(date).Year.ToString();


            #region Begin Variable Declaration as on [04-07-2014]
            var Month = "";
            var SPName = "";
            var clientids = "";
            DataTable DtClientListBasedonSelectedMonth = null;
            Hashtable HtClientListBasedonSelectedMonth = new Hashtable();
            #endregion End  Variable Declaration as on [04-07-2014]

            #region Begin Assign Values To Vriables as on [04-07-2014]
            Month = month + Year.Substring(2, 2);

            SPName = "GEtAllclientsListForPaysheetBulkprints";
            #endregion  End Assing Values to The Variables as on [04-07-2014]

            #region Begin  Pass Values To the Hash table as on [04-07-2014]
            HtClientListBasedonSelectedMonth.Add("@month", Month);
            //HtClientListBasedonSelectedMonth.Add("@clientids", clientids);
            #endregion end Pass Values To the Hash table as on [04-07-2014]

            #region  Begin Call Sp on [04-07-2014]
            DtClientListBasedonSelectedMonth = config.ExecuteAdaptorAsyncWithParams(SPName, HtClientListBasedonSelectedMonth).Result;
            GVListEmployees.DataSource = DtClientListBasedonSelectedMonth;
            GVListEmployees.DataBind();
            #endregion  end Call Sp on [04-07-2014]
        }

        protected void Bindata(string Sqlqry)
        {
            DataTable dt = config.ExecuteAdaptorAsyncWithQueryParams(Sqlqry).Result;
            if (dt.Rows.Count > 0)
            {
                GVListEmployees.DataSource = dt;
                GVListEmployees.DataBind();
                // Fillpfandesidetails();
            }
            else
            {
                LblResult.Text = "There Is No Salary Details For The Selected client";
            }
        }



        protected void btnDownload_Click(object sender, EventArgs e)
        {
            var list = new List<string>();

            if (GVListEmployees.Rows.Count > 0)
            {
                for (int i = 0; i < GVListEmployees.Rows.Count; i++)
                {
                    CheckBox chkclientid = GVListEmployees.Rows[i].FindControl("chkindividual") as CheckBox;
                    Label lblclientid = GVListEmployees.Rows[i].FindControl("lblclientid") as Label;

                    if (chkclientid.Checked == true)
                    {
                        list.Add("'" + lblclientid.Text + "'");
                    }
                }
            }

            string Clientids = string.Join(",", list.ToArray());

            string Spname = "";
            Hashtable HtClients = new Hashtable();
            //Spname = "Storebulkclientids";
            //HtClients.Add("@Clietnids", Clientids);
            //DataTable dtcliens = SqlHelper.Instance.ExecuteStoredProcedureWithParams(Spname, HtClients);

            var testDate = 0;

            if (txtmonth.Text.Trim().Length == 0)
            {
                return;
            }

            if (txtmonth.Text.Trim().Length > 0)
            {
                testDate = GlobalData.Instance.CheckEnteredDate(txtmonth.Text);
                if (testDate > 0)
                {
                    LblResult.Text = "You Are Entered Invalid Date.Date Format Should be [DD/MM/YYYY].Ex.01/01/1990";
                    return;
                }

            }
            string date = DateTime.Parse(txtmonth.Text.Trim(), CultureInfo.GetCultureInfo("en-gb")).ToString();
            string month = DateTime.Parse(date).Month.ToString();
            string Year = DateTime.Parse(date).Year.ToString();

            var Month = month + Year.Substring(2, 2);

            //GridViewExportUtil.Export("AllUnitsEsiReport.xls", this.GVListEmployees);

            if (GVListEmployees.Rows.Count > 0)
            {

                string sqlqry = "Select  EP.Empid,EP.Clientid,C.Clientname,(E.Empfname + E.EmpMname + E.emplname) as EmpMname ," +
                             " ''''+( rtrim(ltrim(E.Empbankacno)) ) as Empbankacno,E.EmpBankCardRef, EP.basic,EP.da,EP.HRA,d.Design, " +
                             " EP.CCA,EP.Conveyance,EP.Washallowance,EP.OtherAllowance,EP.noofduties,EA.ot,EP.Proftax, " +
                             " EP.gross as totalgross,EP.otamt,EP.pf,EP.esi,EP.penalty,EP.actualamount,EP.owf,EP.saladvded,EP.CanteenAdv,EP.UniformDed,EP.OtherDed, " +
                             " EP.HRA,EP.CCA,EP.Conveyance,EP.OtherDed,EP.WashAllowance as  wa,  " +
                             " EP.OtherAllowance as  oa,EP.LeaveEncashAmt,EP.CLPLAmt,EP.WOAmt,isnull(EP.PFESIContribution,0) as PFESIContribution,EP.TotalDeductions   from  emppaysheet EP " +
                             " inner join Clients C on  C.Clientid = EP.Clientid " +
                             " inner join  empdetails E on E.Empid=EP.Empid   " +
                        " inner join  Empattendance EA on EA.Empid=EP.Empid  " +
                        " inner join Designations d on EP.Desgn=d.DesignId " +
                        "   and    EP.noofduties<>0  and EP.month='" + month + Year.Substring(2, 2) +
                        " '  and  EP.month=EA.Month  and  EP.Clientid=EA.Clientid   and  EP.Desgn=EA.Design where  ep.clientid in (" + Clientids + ")" +
                        "   order By   Right(EP.Clientid,4)";

                //string sqldata = "select * from emppaysheet where clientid in (" + Clientids + ") and month='" + Month + "' order by clientid";
                DataTable dt = config.ExecuteAdaptorAsyncWithQueryParams(sqlqry).Result;
                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    if (ddlOptions.SelectedIndex == 0)
                    {
                        gve.Export("Allpayments.xls", this.GridView1);
                    }
                }
            }

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                e.Row.Cells[33].Attributes.Add("class", "text");
            }
        }

        protected void Bulkpayshreetdownload()
        {

        }
    }
}