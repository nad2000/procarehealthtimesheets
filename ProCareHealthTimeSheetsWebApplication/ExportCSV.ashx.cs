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

            var res = context.Response;
            var req = context.Request;

            WorkSheetDataClassesDataContext db = new WorkSheetDataClassesDataContext();
            int? companyId = 
                String.IsNullOrEmpty( req.QueryString["CompanyId"] ) ?
                    null
                    : (int?)Convert.ToInt32(req.QueryString["CompanyId"]);
            string companyCode;
            if (companyId == null) companyCode = "";
            else {
                var comp = db.Companies.SingleOrDefault(c => c.Id == companyId);
                companyCode = comp.Code;
            }

            string fileName = String.Format(
                "TimeSheetSummary" + (String.IsNullOrEmpty(companyCode) ? "" : ("_" + companyCode )) + "_{0:yyyy'-'MM'-'dd}_{1:yyyy'-'MM'-'dd}",
                    Convert.ToDateTime(req.QueryString["DateFrom"]),
                    Convert.ToDateTime(req.QueryString["DateTo"]));

            res.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xls");
            context.Response.ContentType = "application/vnd.ms-excel";

            DateTime? dateFrom =  String.IsNullOrEmpty(req.QueryString["DateFrom"] ) ?
                null : (DateTime?)DateTime.Parse(req.QueryString["DateFrom"]);
            DateTime? dateTo =  String.IsNullOrEmpty(req.QueryString["DateTo"] ) ?
                null : (DateTime?)DateTime.Parse(req.QueryString["DateTo"]);
            Boolean? includeUnapproved = (Boolean?)(String.IsNullOrEmpty(req.QueryString["IncludeUnapproved"]) ?
                false : (req.QueryString["IncludeUnapproved"].ToLower() == "yes"));


            GetFullTimeSheetRecordsTableAdapter da = new GetFullTimeSheetRecordsTableAdapter();
            TimeSheetDataSet.GetFullTimeSheetRecordsDataTable dt =
                da.GetData( null, dateFrom, dateTo, includeUnapproved, companyId, null );

            var delimiter = "\t";
            res.Write(
                string.Join(
                    delimiter, 
                    new string[] { "Company", "Code", "FullName", "Date", "StartedAt", "EndedAt", "Break", "TotalTime", "Approved", "Comment" }
                ));
            res.Write("\n");
            foreach (TimeSheetDataSet.GetFullTimeSheetRecordsRow  dr in dt.Rows)
            {
                res.Write(
                    string.Join(delimiter, new string[] {
                        dr["CompanyCode"].ToString(),
                        ( dr["Code"] is DBNull ? "" : dr.Code ),
                        dr.FullName,
                        dr.Date.ToString("d"),
                        dr.StartedAt.ToString("hh':'mm"),
                        dr.EndedAt.ToString("hh':'mm"),
                        ( dr["BreakTypeName"] is DBNull ? "" : dr.BreakTypeName ),
                        ( dr.TotalTime/60 ).ToString()+":"+( dr.TotalTime%60 ).ToString("00"),
                        ( dr["IsApproved"] is DBNull ? "" : ( dr.IsApproved ? "yes" : "no" ) ),
                        ( dr["IsApproved"] is DBNull ? "" : dr.Comment )}));
                res.Write("\n");
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