using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SoftwareAssociates.ProCareHealth.TimeSheetDataSetTableAdapters;
using SoftwareAssociates.ProCareHealth;
using System.Data.SqlClient;
using System.Data;


namespace SoftwareAssociates.ProCareHealth
{
    /// <summary>
    /// Summary description for ExportCSV
    /// </summary>
    public class ExportCSV : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.Buffer = context.Response.BufferOutput = true;
            //context.Response.ClearContent();

            WorkSheetDataClassesDataContext db = new WorkSheetDataClassesDataContext();
            int? companyId = 
                String.IsNullOrEmpty( context.Request.QueryString["CompanyId"] ) ?
                    null
                    : (int?)Convert.ToInt32(context.Request.QueryString["CompanyId"]);
            string companyCode;
            if (companyId == null) companyCode = "";
            else {
                var comp = db.Companies.SingleOrDefault(c => c.Id == companyId);
                companyCode = comp.Code;
            }

            string fileName = String.Format(
                "TimeSheetSummary" + (String.IsNullOrEmpty(companyCode) ? "" : ("_" + companyCode )) + "_{0:yyyy'-'MM'-'dd}_{1:yyyy'-'MM'-'dd}",
                    Convert.ToDateTime(context.Request.QueryString["DateFrom"]),
                    Convert.ToDateTime(context.Request.QueryString["DateTo"]));

            context.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xls");
            context.Response.ContentType = "application/vnd.ms-excel";

            DateTime? dateFrom =  String.IsNullOrEmpty( context.Request.QueryString["DateFrom"] ) ?
                null : (DateTime?)DateTime.Parse(context.Request.QueryString["DateFrom"]);
            DateTime? dateTo =  String.IsNullOrEmpty( context.Request.QueryString["DateTo"] ) ?
                null : (DateTime?)DateTime.Parse(context.Request.QueryString["DateTo"]);
            Boolean? includeUnapproved = (Boolean?)(String.IsNullOrEmpty(context.Request.QueryString["IncludeUnapproved"]) ?
                false : (context.Request.QueryString["IncludeUnapproved"].ToLower() == "yes"));


            GetFullTimeSheetRecordsTableAdapter da = new GetFullTimeSheetRecordsTableAdapter();
            TimeSheetDataSet.GetFullTimeSheetRecordsDataTable dt =
                da.GetData( null, dateFrom, dateTo, includeUnapproved, companyId, null );

            context.Response.Write("Company\tCode\tFullName\tDate\tStartedAt\tEndedAt\tBreak\tTotalTime\tApproved\tComment\n");

            foreach (TimeSheetDataSet.GetFullTimeSheetRecordsRow  dr in dt.Rows)
            {
                context.Response.Write(
                    dr["CompanyCode"].ToString() + "\t"
                    + ( dr["Code"] is DBNull ? "" : dr.Code ) + "\t"
                    + dr.FullName+"\t"
                    + dr.Date.ToString("d")+"\t"
                    + dr.StartedAt.ToString("hh':'mm")+"\t"
                    + dr.EndedAt.ToString("hh':'mm")+"\t"
                    + ( dr["BreakTypeName"] is DBNull ? "" : dr.BreakTypeName ) + "\t"
                    + ( dr.TotalTime/60 ).ToString()+":"+( dr.TotalTime%60 ).ToString("00") + "\t"
                    + ( dr["IsApproved"] is DBNull ? "" : ( dr.IsApproved ? "yes" : "no" ) ) + "\t"
                    + ( dr["IsApproved"] is DBNull ? "" : dr.Comment ) + "\n" );
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}