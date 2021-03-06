using System;
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
    public partial class ReportForMinimumWages : System.Web.UI.Page
    {
        AppConfiguration config = new AppConfiguration();
        GridViewExportUtil gve = new GridViewExportUtil();
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
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
                    LoadMinimumWages_Categories();
                }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Show alert", "alert('Your Session Expired');", true);
                Response.Redirect("~/Login.aspx");
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

        protected void btnsearch_Click(object sender, EventArgs e)
        {

            string date = string.Empty;

            #region Begin Code  For Validation as on [16-11-2013]
            if (Ddl_Minimum_Wages_Categories.SelectedIndex == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Please Select The Category Name');", true);
                return;
            }

            #endregion End  Code  For Validation as on [16-11-2013]

            #region  Begin Code For Variable Declaration   as on [16-11-2013]
            var SPName = "";
            var ReportType = 0;
            var CategoryId = "0";
            DataTable DtMinimum_Wages_Categories = null;
            Hashtable HtMinimum_Wages_Categories = new Hashtable();

            #endregion End  Code For Variable Declaration  as on [16-11-2013]

            #region  Begin Code For Assign Values to Variables   as on [16-11-2013]

            CategoryId = Ddl_Minimum_Wages_Categories.SelectedValue;
            if (Ddl_Minimum_Wages_Categories.SelectedIndex == 1)
            {
                CategoryId = "0";
            }

            ReportType = Ddl_Report_Type.SelectedIndex;
            HtMinimum_Wages_Categories.Add("@ReportType", ReportType);
            HtMinimum_Wages_Categories.Add("@CategoryID", CategoryId);

            SPName = "Reportfor_Minimum_Wages_Above_OR_Below ";
            #endregion End  Code For Assign Values to Variables  as on [16-11-2013]

            #region  Begin code For Calling Stored Procedue  and Data To Gridview  As on [16-11-2013]
            DtMinimum_Wages_Categories = config.ExecuteAdaptorAsyncWithParams(SPName, HtMinimum_Wages_Categories).Result;
            if (DtMinimum_Wages_Categories.Rows.Count > 0)
            {
                GV_ExpensesExpenditure.DataSource = DtMinimum_Wages_Categories;
                GV_ExpensesExpenditure.DataBind();
                lbtn_Export.Visible = true;
            }
            else
            {
                GV_ExpensesExpenditure.DataSource = null;
                GV_ExpensesExpenditure.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Details Not Avaialable');", true);
                lbtn_Export.Visible = false;
            }

            #endregion End Code For Calling Stored Procedue and Data To Gridview  As on [16-11-2013]

        }

        protected void lbtn_Export_Click(object sender, EventArgs e)
        {
            gve.Export("Expenses.xls", this.GV_ExpensesExpenditure);
        }

        protected void LoadMinimumWages_Categories()
        {

            DataTable DtBankNames = GlobalData.Instance.LoadMinimumWagesCategories();
            if (DtBankNames.Rows.Count > 0)
            {
                Ddl_Minimum_Wages_Categories.DataValueField = "id";
                Ddl_Minimum_Wages_Categories.DataTextField = "name";
                Ddl_Minimum_Wages_Categories.DataSource = DtBankNames;
                Ddl_Minimum_Wages_Categories.DataBind();

            }
            Ddl_Minimum_Wages_Categories.Items.Insert(0, "-Select-");
            Ddl_Minimum_Wages_Categories.Items.Insert(1, "ALL");

        }
    }
}