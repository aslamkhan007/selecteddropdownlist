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
        private int tCounter = 1;
        private int lCounter = 1;
        private SqlParameter outputParam;
 
        public DataSet NeWRequestInspectionForAdmin(string LoginId, string Division = null, string InstallationType = null, string searchText = null)
        {
            return DBTask.ExecuteDataset(ConfigurationManager.ConnectionStrings["DBConnection"].ToString(), "sp_NewRequestReceivedForAdmin", LoginId, string.IsNullOrEmpty(Division) ? (object)DBNull.Value : Division, string.IsNullOrEmpty(InstallationType) ? (object)DBNull.Value : InstallationType, string.IsNullOrEmpty(searchText) ? (object)DBNull.Value : searchText);
        }     

    }
}


