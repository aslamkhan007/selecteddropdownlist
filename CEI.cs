using CEIHaryana.Contractor;
using CEIHaryana.Model.Industry;
using iTextSharp.text.pdf.parser;
using Newtonsoft.Json;
using Pipelines.Sockets.Unofficial.Arenas;
using QRCoder;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Sockets;
using System.Text;
using System.Web;
using System.Web.Helpers;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Media.TextFormatting;
using static iText.StyledXmlParser.Jsoup.Select.Evaluator;
using static System.Net.WebRequestMethods;

namespace CEI_PRoject
{

    public class CEI
    {

        public DataTable GetDocumentsForLiftRenewal(string ApplicantType, int InstallationTypeID, string InspectionType, string InstallationType)
        {
            return DBTask.ExecuteDataTable(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_GetDocumentsForLiftRenewal", ApplicantType, InstallationTypeID, InspectionType, InstallationType);
        }
        public DataSet GetRenewalLiftData(string Type, string RegistrationNo, string CreatedBy) //REPLACED
        {
            return DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_GetPeriodicRenewalData", Type, RegistrationNo, CreatedBy);
        }
        public DataSet GetApplicantTypeForLift(string Id)
        {
            return DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_GetApplicantTypeForLift", Id);
        }

        public string InsertPeriodicLiftData(string InstallationType, string RegistrationNo, string LastExpiryDate, string PreviousChallanUpload, string lastDateOfPayment, string ErectionDate, string Make,
  string SerialNo, string TypeOfLift, string TypeOfControl, string Capacity, Decimal Weight, string ApplicantDistrict, string MemoNo, string MemoDate, string SiteAddress, string CreatedBy, SqlTransaction transaction)
        {
            SqlCommand cmd = new SqlCommand("sp_InsertPeriodicLiftData", transaction.Connection, transaction);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@InstallationType", InstallationType);
            cmd.Parameters.AddWithValue("@RegistrationNo", RegistrationNo);
            cmd.Parameters.AddWithValue("@LastExpiryDate", LastExpiryDate);
            cmd.Parameters.AddWithValue("@PreviousChallanUpload", PreviousChallanUpload);
            //cmd.Parameters.AddWithValue("@lastDateOfPayment", lastDateOfPayment);
            if (string.IsNullOrWhiteSpace(lastDateOfPayment))
            {
                cmd.Parameters.AddWithValue("@lastDateOfPayment", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@lastDateOfPayment", Convert.ToDateTime(lastDateOfPayment));
            }
            cmd.Parameters.AddWithValue("@ErectionDate", ErectionDate);
            cmd.Parameters.AddWithValue("@Make", Make);
            cmd.Parameters.AddWithValue("@SerialNo", SerialNo);
            cmd.Parameters.AddWithValue("@TypeOfLift", TypeOfLift);
            cmd.Parameters.AddWithValue("@TypeOfControl", TypeOfControl);
            cmd.Parameters.AddWithValue("@Capacity", Capacity);
            cmd.Parameters.AddWithValue("@Weight", Weight);
            cmd.Parameters.AddWithValue("@ApplicantDistrict", ApplicantDistrict);
            cmd.Parameters.AddWithValue("@MemoNo", MemoNo);
            cmd.Parameters.AddWithValue("@MemoDate", MemoDate);
            cmd.Parameters.AddWithValue("@SiteAddress", SiteAddress);
            cmd.Parameters.AddWithValue("@CreatedBy", CreatedBy);
            SqlParameter outputParam = new SqlParameter("@GeneratedTestReportID", SqlDbType.NVarChar, 50);
            outputParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(outputParam);

            // Execute the command
            cmd.ExecuteNonQuery();
            string TRID = cmd.Parameters["@GeneratedTestReportID"].Value.ToString();
            return TRID;
        }
                public DataTable InsertReturnPeriodicLiftData(string TestReportId, string InstallationType, string RegistrationNo, string LastExpiryDate, string PreviousChallanUpload, string lastDateOfPayment, string ErectionDate, string Make,
 string SerialNo, string TypeOfLift, string TypeOfControl, string Capacity, Decimal Weight, string ApplicantDistrict, string MemoNo, string MemoDate, string SiteAddress, int InspectionID, string CreatedBy)
        {
            DateTime? lastDateOfPayment2 = null;

            if (!string.IsNullOrWhiteSpace(lastDateOfPayment))
            {
                lastDateOfPayment2 = Convert.ToDateTime(lastDateOfPayment);
            }
            return DBTask.ExecuteDataTable(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_InsertPeriodicReturnData", TestReportId, InstallationType, RegistrationNo, LastExpiryDate, PreviousChallanUpload, lastDateOfPayment2, ErectionDate, Make,
 SerialNo, TypeOfLift, TypeOfControl, Capacity, Weight, ApplicantDistrict, MemoNo, MemoDate, SiteAddress, InspectionID, CreatedBy);
        }

             public void UploadDocumentforLiftPeriodic(string TRID, string RegistrationNo, string InstallationType, string DocumentID, string DocSaveName, string FileName, string FilePath, string CreatedBy, SqlTransaction transaction)
     {
         string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
         using (SqlConnection connection = new SqlConnection(connectionString))
         {
             try
             {
                 using (SqlCommand cmd = new SqlCommand("sp_InsertLiftPeriodicAttachments", transaction.Connection, transaction))
                 {

                     cmd.CommandType = CommandType.StoredProcedure;
                     cmd.Parameters.AddWithValue("@TestReportId", TRID);
                     cmd.Parameters.AddWithValue("@RegistrationNo", RegistrationNo);
                     cmd.Parameters.AddWithValue("@InstallationType", InstallationType);
                     cmd.Parameters.AddWithValue("@DocumentID", DocumentID);
                     cmd.Parameters.AddWithValue("@DocSaveName", DocSaveName);
                     cmd.Parameters.AddWithValue("@FileName", FileName);
                     cmd.Parameters.AddWithValue("@FilePath", FilePath);
                     cmd.Parameters.AddWithValue("@CreatedBy", CreatedBy);
                     //con.Open();
                     cmd.ExecuteNonQuery();
                 }
             }
             catch (Exception ex)
             {
                 throw;
             }
         }
     }

        public DataTable GetDataForLiftRenewal(string District, string CreatedBy)
        {
            return DBTask.ExecuteDataTable(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "Sp_GetLiftRenewaldata", District, CreatedBy);
        }

        public void Update_LiftRenewalPeriodicInspection(string RegistrationNo, int InstallationTypeId, string CreatedBy)
        {
            DBTask.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "update_LiftRenewal_PeriodicInspection", RegistrationNo, InstallationTypeId, CreatedBy);
        }
        public DataSet TohandleUncheckedCheckbox(string RegistrationNo, string CreatedBy)
        {
            return DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "SP_TohandleUncheckedCheckbox", RegistrationNo, CreatedBy);
        }

        public DataTable GetDocumentforLiftPeriodicRenewal()
        {
            return DBTask.ExecuteDataTable(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_GetDocumentforLiftPeriodicRenewal");
        }

        public DataTable Get_DocumentGridwithOutChallan()
        {
            return DBTask.ExecuteDataTable(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_Get_DocumentGridwithOutChallan");
        }
        public DataTable Payment_LiftPeriodic(string selectedTypeIds, int? LiftQaunatity, int? EscaltorQaunatity, int? LiftCountForPayment, int? EscalatorCountForPayment)
        {
            DataTable result = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("Sp_Calculate_InspectionPayment_Amount_LiftEscaltor_Periodic", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@InspectionType", "Periodic");
                command.Parameters.AddWithValue("@InstallationTypeIds", selectedTypeIds);
                command.Parameters.AddWithValue("@QuantityLift", LiftQaunatity == 0 ? null : LiftQaunatity);
                command.Parameters.AddWithValue("@QuantityEscalator", EscaltorQaunatity == 0 ? null : EscaltorQaunatity);
                command.Parameters.AddWithValue("@LiftCountForPayment", LiftCountForPayment == 0 ? null : LiftCountForPayment);
                command.Parameters.AddWithValue("@EscalatorCountForPayment", EscalatorCountForPayment == 0 ? null : EscalatorCountForPayment);

                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(result);
            }

            return result;
        }
        public DataSet GetDivisionByDistrict(string AreaCovered)
        {
            return DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "Sp_GetDivisionByDistrict", AreaCovered);
        }

        public DataSet ToGetStaffIdforPeriodic(string Division, string Staff, string District)
        {
            return DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_GetStaffIdforPeriodic", Division, Staff, District);
        }

                public string InsertInspectionDataForPeriodic_LiftInspection(string ApplicantType, string InstallationType, string District, string Division,
 string PaymentMode, string InspectionRemarks, string CreatedBy, decimal TotalAmount, string para_Assigned,
 string transcationId, string TranscationDate, int InspectID, int ServiceType, SqlTransaction transaction)
        {
            SqlCommand cmd = new SqlCommand("sp_InsertInspectionDataForPeriodic_LiftInspection", transaction.Connection, transaction);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@ApplicantType", ApplicantType);
            cmd.Parameters.AddWithValue("@InstallationType", InstallationType);
            cmd.Parameters.AddWithValue("@District", District);
            cmd.Parameters.AddWithValue("@Division", Division);
            cmd.Parameters.AddWithValue("@PaymentMode", PaymentMode);
            cmd.Parameters.AddWithValue("@InspectionRemarks", InspectionRemarks);
            cmd.Parameters.AddWithValue("@CreatedBy", CreatedBy);

            cmd.Parameters.AddWithValue("@TransactionId", String.IsNullOrEmpty(transcationId) ? DBNull.Value : (object)transcationId);
            cmd.Parameters.AddWithValue("@TotalAmount", TotalAmount);
            cmd.Parameters.AddWithValue("@AssignTo", para_Assigned);
            //cmd.Parameters.AddWithValue("@TransctionDate", TranscationDate);
            if (String.IsNullOrEmpty(TranscationDate))
            {
                cmd.Parameters.AddWithValue("@TransctionDate", DBNull.Value);
            }
            else
            {
                DateTime transactionDateValue;
                if (DateTime.TryParse(TranscationDate, out transactionDateValue))
                {
                    cmd.Parameters.AddWithValue("@TransctionDate", transactionDateValue);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@TransctionDate", DBNull.Value);
                }
            }
            cmd.Parameters.AddWithValue("@InspectID", InspectID);
            cmd.Parameters.AddWithValue("@ServiceType", ServiceType);

            SqlParameter outputParam = new SqlParameter("@GeneratedCombinedIdDetails", SqlDbType.NVarChar, 500);
            outputParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(outputParam);

            // Execute the command
            cmd.ExecuteNonQuery();
            string k = cmd.Parameters["@GeneratedCombinedIdDetails"].Value.ToString();
            return k;

        }
		
		        #region Lift Periodic Renewal New Process

        public DataSet GetRenewalLiftDataGridOfExpiredAllRecords(string Type, string CreatedBy)
        {
            return DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "SP_GetLiftEscalatorExpiringList", CreatedBy, 1, Type);
        }

        public DataSet GetLiftRenewalDrafts(string CreatedBy)
        {
            return DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_GetLiftRenewalDrafts", CreatedBy);
        }

        public void SaveLiftRenewalDraft(string createdBy, string regNo, string type, DateTime? lastPay,
                                         int? docId, string docName, string fileName, string path)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            using (SqlCommand cmd = new SqlCommand("sp_SaveLiftRenewalDraft", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CreatedBy", createdBy);
                cmd.Parameters.AddWithValue("@RegistrationNo", regNo);
                cmd.Parameters.AddWithValue("@InstallationType", type);
                cmd.Parameters.AddWithValue("@LastPaymentDate", lastPay.HasValue ? (object)lastPay.Value : DBNull.Value);
                cmd.Parameters.AddWithValue("@DocumentID", docId.HasValue ? (object)docId.Value : DBNull.Value);
                cmd.Parameters.AddWithValue("@DocumentName", (object)docName ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@FileName", (object)fileName ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@DocumentPath", (object)path ?? DBNull.Value);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void DeleteLiftRenewalDraft(string createdBy, string regNo, string type)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnection"].ToString()))
            using (SqlCommand cmd = new SqlCommand("sp_DeleteLiftRenewalDraft", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CreatedBy", createdBy);
                cmd.Parameters.AddWithValue("@RegistrationNo", regNo);
                cmd.Parameters.AddWithValue("@InstallationType", type);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
        public string GetLatestLiftRenewalDistrict(string CreatedBy)
        {
            DataSet ds = DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_GetLatestLiftRenewalDistrict", CreatedBy);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                return Convert.ToString(ds.Tables[0].Rows[0][0]);
            return string.Empty;
        }
        #endregion
		
		

    }
}


