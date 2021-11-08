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
using KLTS.Data;
using System.Globalization;
using SIF.Portal.DAL;
namespace SIF.Portal
{
    public partial class EmpInvReport : System.Web.UI.Page
    {
        AppConfiguration config = new AppConfiguration();
        GridViewExportUtil gve = new GridViewExportUtil();
        string EmpIDPrefix = "";
        string CmpIDPrefix = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            int i = 0;
            GetWebConfigdata();
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["AccessLevel"] != null)
                {
                    //PreviligeUsers(Convert.ToInt32(Session["AccessLevel"]));
                    string PID = Session["AccessLevel"].ToString();
                    //PreviligeUsers(PID);
                    lblDisplayUser.Text = Session["UserId"].ToString();
                    lblcname.Text = SqlHelper.Instance.GetCompanyname();

                }
                else
                {
                    Response.Redirect("login.aspx");
                }

            }
        }

        protected void GetWebConfigdata()
        {
            EmpIDPrefix = Session["EmpIDPrefix"].ToString();
            CmpIDPrefix = Session["CmpIDPrefix"].ToString();
        }
        protected void Btn_Submit_OnClick(object sender, EventArgs e)
        {
            var testDate = 0;
            var FromDate = DateTime.Now;
            var ToDate = DateTime.Now;

            if (Txt_From_Date.Text.Trim().Length == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Please Select the From Date');", true);
                return;
            }
            else
            {
                testDate = GlobalData.Instance.CheckEnteredDate(Txt_From_Date.Text);
                if (testDate > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('You have Entered Invalid DATE.Date Format Should be [DD/MM/YYYY].Ex.01/01/1990');", true);
                    return;
                }

                FromDate = DateTime.Parse(Txt_From_Date.Text.Trim(), CultureInfo.GetCultureInfo("en-GB"));

            }
            if (Txt_ToDate.Text.Trim().Length == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Please Select the To Date');", true);
                return;
            }
            else
            {
                testDate = GlobalData.Instance.CheckEnteredDate(Txt_ToDate.Text);
                if (testDate > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('You have Entered Invalid DATE.Date Format Should be [DD/MM/YYYY].Ex.01/01/1990');", true);
                    return;
                }

                ToDate = DateTime.Parse(Txt_ToDate.Text.Trim(), CultureInfo.GetCultureInfo("en-GB"));
            }




            string Spname = "EmpInvReport";
            Hashtable ht = new Hashtable();
            ht.Add("@fromdate", FromDate);
            ht.Add("@todate", ToDate);

            DataTable envReports =config.ExecuteAdaptorAsyncWithParams(Spname, ht).Result;
            if (envReports.Rows.Count > 0)
            {
                GVListOfItems.DataSource = envReports;
                GVListOfItems.DataBind();
            }
            else
            {
                GVListOfItems.DataSource = null;
                GVListOfItems.DataBind();
            }
        }

        protected void Lnkbtnexcel_Click(object sender, EventArgs e)
        {
            var testDate = 0;
            var FromDate = DateTime.Now;
            var ToDate = DateTime.Now;

            if (Txt_From_Date.Text.Trim().Length == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Please Select the From Date');", true);
                return;
            }
            else
            {
                testDate = GlobalData.Instance.CheckEnteredDate(Txt_From_Date.Text);
                if (testDate > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('You have Entered Invalid DATE.Date Format Should be [DD/MM/YYYY].Ex.01/01/1990');", true);
                    return;
                }

                FromDate = DateTime.Parse(Txt_From_Date.Text.Trim(), CultureInfo.GetCultureInfo("en-GB"));

            }
            if (Txt_ToDate.Text.Trim().Length == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Please Select the To Date');", true);
                return;
            }
            else
            {
                testDate = GlobalData.Instance.CheckEnteredDate(Txt_ToDate.Text);
                if (testDate > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('You have Entered Invalid DATE.Date Format Should be [DD/MM/YYYY].Ex.01/01/1990');", true);
                    return;
                }

                ToDate = DateTime.Parse(Txt_ToDate.Text.Trim(), CultureInfo.GetCultureInfo("en-GB"));
            }


            string companyName = "Your Company Name";
            string VendorName = "";

            string strQry = "Select * from CompanyInfo   where   ClientidPrefix='" + CmpIDPrefix + "'";
            DataTable compInfo =config.ExecuteAdaptorAsyncWithQueryParams(strQry).Result;
            if (compInfo.Rows.Count > 0)
            {
                companyName = compInfo.Rows[0]["CompanyName"].ToString();
            }




            string Spname = "EmpInvReport";
            Hashtable ht = new Hashtable();
            ht.Add("@fromdate", FromDate);
            ht.Add("@todate", ToDate);


            string line = companyName;
            string line1 = "From Date :  " + FromDate.ToString("dd/MM/yyyy") + "         " + "To Date :  " + ToDate.ToString("dd/MM/yyyy");
            string line2 = "InvReport";

            DataTable envReports = config.ExecuteAdaptorAsyncWithParams(Spname, ht).Result;


            if (envReports.Rows.Count > 0)
            {

                gve.ExporttoExcel1(envReports, line, line1, line2);

            }
            else
            {
                GVListOfItems.DataSource = null;
                GVListOfItems.DataBind();
            }


        }
    }
}