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
using System.Globalization;
using KLTS.Data;
using SIF.Portal.DAL;
namespace SIF.Portal
{
    public partial class SalaryPeriodReport : System.Web.UI.Page
    {
        AppConfiguration config = new AppConfiguration();
        GridViewExportUtil gve = new GridViewExportUtil();
        string EmpIDPrefix = "";
        string CmpIDPrefix = "";
        string BranchID = "";

        string Elength = "";
        string Clength = "";

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
                    FillClientList();
                    FillClientNameList();
                }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Show alert", "alert('Your Session Expired');", true);
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void GetWebConfigdata()
        {
            CmpIDPrefix = Session["CmpIDPrefix"].ToString();
            BranchID = Session["BranchID"].ToString();

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


        protected void FillClientList()
        {
            DataTable dt = GlobalData.Instance.LoadCIds(CmpIDPrefix,BranchID);
            if (dt.Rows.Count > 0)
            {
                ddlClientId.DataValueField = "clientid";
                ddlClientId.DataTextField = "clientid";
                ddlClientId.DataSource = dt;
                ddlClientId.DataBind();
            }
            ddlClientId.Items.Insert(0, "--Select--");
            ddlClientId.Items.Insert(1, "All");

        }

        protected void FillClientNameList()
        {

            DataTable dt = GlobalData.Instance.LoadCNames(CmpIDPrefix,BranchID);
            if (dt.Rows.Count > 0)
            {
                ddlcname.DataValueField = "clientid";
                ddlcname.DataTextField = "Clientname";
                ddlcname.DataSource = dt;
                ddlcname.DataBind();
            }
            ddlcname.Items.Insert(0, "--Select--");
            ddlcname.Items.Insert(1, "All");

        }

        protected void ddlcname_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            ClearData();
            if (ddlcname.SelectedIndex == 1)
            {
                ddlClientId.SelectedIndex = 1;
            }
            if (ddlcname.SelectedIndex > 1)
            {
                ddlClientId.SelectedValue = ddlcname.SelectedValue;
            }
            if (ddlcname.SelectedIndex == 0)
            {
                ddlClientId.SelectedIndex = 0;
            }

        }

        protected void ddlClientId_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearData();
            if (ddlClientId.SelectedIndex == 1)
            {
                ddlcname.SelectedIndex = 1;
            }
            if (ddlClientId.SelectedIndex > 1)
            {
                ddlcname.SelectedValue = ddlClientId.SelectedValue;
            }
            if (ddlClientId.SelectedIndex == 0)
            {
                ddlcname.SelectedIndex = 0;
            }

        }

        protected void Binddata()
        {
            string sqlquery = "";
            DataTable dt = null;
            string Procedurename = "";
            string Clientid = "";
            Hashtable HtSalaryperiod = new Hashtable();

            string day = DateTime.Parse(txtmonth.Text, CultureInfo.GetCultureInfo("en-gb")).ToString();
            string sqlqry = string.Empty;
            DateTime date = Convert.ToDateTime(day);

            string mon = string.Format("{0}{1:yy}", date.Month.ToString("00"), (date.Year - 2000).ToString());
            int month = Convert.ToInt32(mon);
            if (ddlClientId.SelectedIndex > 1)
            {
                Clientid = ddlClientId.SelectedValue;
            }
            Procedurename = "ReportforSalaryPeriod";
            HtSalaryperiod.Add("@Clientid", Clientid);
            HtSalaryperiod.Add("@month", month);


            dt =config.ExecuteAdaptorAsyncWithParams(Procedurename, HtSalaryperiod).Result;
            if (dt.Rows.Count > 0)
            {
                GVListEmployees.DataSource = dt;
                GVListEmployees.DataBind();
            }
            else
            {
                GVListEmployees.DataSource = null;
                GVListEmployees.DataBind();
            }
        }
        protected void ClearData()
        {
            GVListEmployees.DataSource = null;
            GVListEmployees.DataBind();
        }
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            if (ddlClientId.SelectedIndex == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Select Clientid');", true);
                return;
            }
            if (txtmonth.Text.Trim().Length == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Select Date');", true);
                return;
            }
            Binddata();
        }

        protected void lbtn_Export_Click(object sender, EventArgs e)
        {
            gve.Export("Salary Paid.xls", this.GVListEmployees);
        }
    }
}