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

namespace SIF.Portal
{
    public partial class M_AddingSourceofLeads : System.Web.UI.Page
    {
        private void Displaydata()
        {
            Txt_Bank_Name.Text = "";
            DataTable DtSourceofLeads = GlobalData.Instance.LoadSourceofLeads();
            if (DtSourceofLeads.Rows.Count > 0)
            {
                gvbank.DataSource = DtSourceofLeads;
                gvbank.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Source of Lead Are Not Avialable');", true);
                return;
            }

        }

        protected void PreviligeUsers(int previligerid)
        {

            switch (previligerid)
            {

                case 1:
                    break;
                case 2:
                    EmployeesLink.Visible = false;
                    ClientsLink.Visible = false;
                    CompanyInfoLink.Visible = false;
                    InventoryLink.Visible = false;
                    ReportsLink.Visible = false;
                    SettingsLink.Visible = false;

                    break;

                case 3:
                    EmployeesLink.Visible = false;
                    ClientsLink.Visible = false;
                    CompanyInfoLink.Visible = false;
                    InventoryLink.Visible = false;
                    ReportsLink.Visible = false;
                    SettingsLink.Visible = false;

                    break;

                case 4:
                    EmployeesLink.Visible = true;
                    ClientsLink.Visible = true;
                    CompanyInfoLink.Visible = true;
                    InventoryLink.Visible = true;
                    ReportsLink.Visible = true;
                    SettingsLink.Visible = true;


                    break;
                case 5:
                    SettingsLink.Visible = true;


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
                    InventoryLink.Visible = false;
                    ReportsLink.Visible = false;
                    SettingsLink.Visible = false;

                    break;
                default:
                    break;


            }
        }

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
                    }
                    else
                    {
                        Response.Redirect("login.aspx");
                    }

                    Displaydata();
                }

            }
            catch (Exception ex)
            {

            }
        }

        protected void Btn_Bank_Name_Add_Click(object sender, EventArgs e)
        {
            try
            {


                #region Begin Code For  Validations   as [12-10-2013]
                if (Txt_Bank_Name.Text.Trim().Length == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Please Enter Source of Lead.');", true);
                    return;
                }
                #endregion Begin Code For  Validations as [12-10-2013]

                #region Begin Code For Variable Declaration as [12-10-2013]
                var SourceofLead = string.Empty;
                var IRecordStatus = 0;

                #endregion Begin Code For Variable Declaration as [12-10-2013]

                #region Begin Code For  Assign Values to Variable  as [12-10-2013]
                SourceofLead = Txt_Bank_Name.Text.Trim().ToUpper();

                #endregion Begin Code For Assign Values to Variable as [12-10-2013]


                #region  Begin Code For Stored Procedure Parameters  as on [12-10-2013]

                Hashtable HtSPParameters = new Hashtable();
                var ProcedureName = "AddSourceofLead";
                #endregion End Code For Stored Procedure Parameters  as on [12-10-2013]

                #region  Begin Code For Assign Values to the Stored Procedure Parameters as on [12-10-2013]
                HtSPParameters.Add("@SourceofLead", SourceofLead);

                #endregion  End  Code For Assign Values to the Stored Procedure Parameters as on [12-10-2013]

                #region  Begin Code For Calling Stored Procedure As on [12-10-2013]
                IRecordStatus = SqlHelper.Instance.ExecuteQuery(ProcedureName, HtSPParameters);
                #endregion  End Code For Calling Stored Procedure As on [12-10-2013]

                #region  Begin Code For Display Status Of the Record as on [12-10-2013]
                if (IRecordStatus > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Source of Lead Added SucessFully.');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Source of Lead Not  Added.Because  The Name Already Exist. NOTE:Source of Lead Are UNIQUE');", true);
                }
                #endregion  End Code For Display Status Of the Record as on [12-10-2013]

                #region  Begin Code For Re-Call All the Departments As on [12-10-2013]
                Displaydata();
                #endregion End Code For Re-Call All the Departments As on [12-10-2013]

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert(' Please Contact Your Admin..');", true);
                return;
            }




        }

        protected void gvbank_RowUpdating1(object sender, GridViewUpdateEventArgs e)
        {


            try
            {

                #region  Begin  Code  for  Retrive  Data From  Gridview as on [14-10-2013]
                Label bankid = gvbank.Rows[e.RowIndex].FindControl("lblbankid") as Label;
                TextBox bankname = gvbank.Rows[e.RowIndex].FindControl("txtbankName") as TextBox;
                #endregion End  Code  for  Retrive  Data From  Gridview as on [14-10-2013]


                #region  Begin  Code  for  validaton as on [14-10-2013]
                if (bankname.Text.Trim().Length == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Please Enter the Source of Lead');", true);
                    return;
                }
                #endregion End  Code  for  validaton as on [14-10-2013]


                #region  Begin  Code  for  Variable  Declaration as on [14-10-2013]
                var SourceofLead = string.Empty;
                var ProcedureName = string.Empty;
                var IRecordStatus = 0;
                Hashtable HtSPParameters = new Hashtable();
                #endregion End  Code  for  Variable  Declaration as on [14-10-2013]

                #region  Begin  Code  for  Assign Values to  Variables as on [14-10-2013]
                SourceofLead = bankname.Text.Trim().ToUpper();
                ProcedureName = "ModifySourceofLead";
                #endregion End  Code  for  Assign Values to  Variables as on [14-10-2013]

                #region  Begin  Code  for  Assign Values to  SP Parameters as on [14-10-2013]
                HtSPParameters.Add("@SourceofLead", SourceofLead);
                HtSPParameters.Add("@SourceId", bankid.Text);
                #endregion End  Code  for  Assign Values to  SP Parameters as on [14-10-2013]

                #region  Begin Code For Calling Stored Procedure As on [14-10-2013]
                IRecordStatus = SqlHelper.Instance.ExecuteQuery(ProcedureName, HtSPParameters);
                #endregion  End Code For Calling Stored Procedure As on [14-10-2013]

                #region  Begin Code For Display Status Of the Record as on [14-10-2013]
                if (IRecordStatus > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Source of Lead  Updated  SucessFully.');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Source of Lead Not  Updated.Because  The Name Already Exist. NOTE:Source of Lead Are UNIQUE');", true);
                }
                #endregion  End Code For Display Status Of the Record as on [14-10-2013]

                #region  Begin Code For Re-Call All the Departments As on [14-10-2013]
                gvbank.EditIndex = -1;
                Displaydata();
                #endregion End Code For Re-Call All the Departments As on [14-10-2013]

            }

            catch (Exception ex)
            {

                ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Please Contact Admin.');", true);
                return;
            }




        }

        protected void gvbank_RowEditing1(object sender, GridViewEditEventArgs e)
        {
            gvbank.EditIndex = e.NewEditIndex;
            Displaydata();
        }

        protected void gvbank_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvbank.EditIndex = -1;
            Displaydata();
        }

        protected void gvbank_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvbank.PageIndex = e.NewPageIndex;
            Displaydata();
        }
    }
}