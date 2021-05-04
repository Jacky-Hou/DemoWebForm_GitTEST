using ClosedXML.Excel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace ClassLibrary
{
    public class ExcelHelper
    {
        private string _FileName = "";
        public string FileName
        {
            get { return getFileName(); }
            set { _FileName = value; }
        }

        public string getFileName()
        {
            if (string.IsNullOrEmpty(_FileName))
            {
                return DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
            }
            else
            {
                return _FileName;
            }
        }

        public void ExportToExcel(ArrayList mAllData, bool mFirstIsHeader = true)
        {
            bool isHeader = mFirstIsHeader;
            StringBuilder sb = new StringBuilder();
            sb.Append("<table width='100%' border='1' cellspacing='2' cellpadding='2'>");
            foreach (string[] alCell in mAllData)
            {
                if (isHeader)
                {
                    sb.Append("<tr style='background-color:#006; color:white; font-weight:bold;'>");
                    isHeader = false;
                }
                else
                {
                    sb.Append("<tr>");
                }

                for (int i = 0; i < alCell.Length; i++)
                {
                    sb.Append("<td>");
                    sb.Append(alCell[i]);
                    sb.Append("</td>");
                }
                sb.Append("</tr>");
            }
            sb.Append("</table>");
            sb.Append("</html>");

            HttpResponse httpResponse = HttpContext.Current.Response;

            httpResponse.Clear();
            httpResponse.Buffer = true;
            httpResponse.AddHeader("content-disposition", "attachment;filename=" + getFileName());
            httpResponse.Charset = "utf-8";
            httpResponse.ContentType = "application/vnd.ms-excel";    //for .xls
            //httpResponse.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";     //for .xlsx but not working
            string style = @"<style>td {mso-number-format: \@} br{mso-data-placement:same-cell;}</style>";
            httpResponse.Write(style);
            httpResponse.Output.Write(sb.ToString());
            httpResponse.Flush();
            httpResponse.End();
        }



        public void ExportToExcelWithClosedXML(XLWorkbook workbook)
        {
            //for (int Len = 0; Len < sheetName.Count; Len++)
            //{
            //    workbook.Worksheets.Add(dt[Len], "sheet1");
            //}

            foreach (IXLWorksheet worksheet in workbook.Worksheets)
            {
                var wsData = workbook.Worksheet(worksheet.Name);

                //欄位有使用才調整樣式
                //Setting borders to each used cell in excel
                //worksheet.CellsUsed(). Style.Border.BottomBorder = ClosedXML.Excel.XLBorderStyleValues.Thin;
                //worksheet.CellsUsed().Style.Border.BottomBorderColor = ClosedXML.Excel.XLColor.Black;

                //worksheet.CellsUsed().Style.Border.TopBorder = ClosedXML.Excel.XLBorderStyleValues.Thin;
                //worksheet.CellsUsed().Style.Border.TopBorderColor = ClosedXML.Excel.XLColor.Black;

                //worksheet.CellsUsed().Style.Border.LeftBorder = ClosedXML.Excel.XLBorderStyleValues.Thin;
                //worksheet.CellsUsed().Style.Border.LeftBorderColor = ClosedXML.Excel.XLColor.Black;

                //worksheet.CellsUsed().Style.Border.RightBorder = ClosedXML.Excel.XLBorderStyleValues.Thin;
                //worksheet.CellsUsed().Style.Border.RightBorderColor = ClosedXML.Excel.XLColor.Black;

                //區間樣式(標題)
                //var rango = worksheet.Range("A1:Z1");
                //rango.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin); //Generamos las lineas exteriores
                //rango.Style.Border.SetInsideBorder(XLBorderStyleValues.Thin); //Generamos las lineas interiores
                //rango.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                //rango.Style.Font.FontSize = 11; //Indicamos el tamaño de la fuente
                
                //區間樣式(資料)
                //var rang2 = worksheet.Range("A2:Z16");
                //rang2.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin); //Generamos las lineas exteriores
                //rang2.Style.Border.SetInsideBorder(XLBorderStyleValues.Thin); //Generamos las lineas interiores
                //rang2.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                //rang2.Style.Font.FontSize = 11; //Indicamos el tamaño de la fuente

                wsData.Columns().AdjustToContents();
                wsData.Rows().AdjustToContents();
            }

            using (var ms = new MemoryStream())
            {
                HttpResponse httpResponse = HttpContext.Current.Response;

                httpResponse.Clear();
                workbook.SaveAs(ms);

                httpResponse.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                httpResponse.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", "MemberDate_" + DateTime.Now.ToString("yyyy_MM_dd") + ".xlsx"));
                httpResponse.BinaryWrite(ms.ToArray());

                httpResponse.End();
                ms.Close();
                ms.Dispose();
                workbook = null;
            }
        }

        public void SetExcelStyle(IXLCell Cell, XLAlignmentHorizontalValues Align)
        {
            Cell.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin); //Generamos las lineas exteriores
            Cell.Style.Border.SetInsideBorder(XLBorderStyleValues.Thin); //Generamos las lineas interiores
            Cell.Style.Alignment.Horizontal = Align;
            Cell.Style.Font.FontSize = 11; //Indicamos el tamaño de la fuente
        }


        //public void WithNPOI(List<string> reqFType, List<DataTable> dt, List<string[]> ColumnName, List<string> sheetName, string ExcelFormat)
        //{
        //    IWorkbook workbook;

        //    if (ExcelFormat == "xlsx")
        //        workbook = new XSSFWorkbook();
        //    else if (ExcelFormat == "xls")
        //        workbook = new HSSFWorkbook();
        //    else
        //        throw new Exception("This format is not supported");

        //    for (int Len = 0; Len < sheetName.Count; Len++)
        //    {
        //        ISheet sheet = workbook.CreateSheet(sheetName[Len]);

        //        //設定欄位名稱的cell style
        //        ICellStyle style1 = workbook.CreateCellStyle();
        //        style1.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;
        //        style1.BorderBottom = NPOI.SS.UserModel.BorderStyle.Thin;//粗
        //        style1.BorderLeft = NPOI.SS.UserModel.BorderStyle.Thin;//細實線
        //        style1.BorderRight = NPOI.SS.UserModel.BorderStyle.Thin;//虛線
        //        style1.BorderTop = NPOI.SS.UserModel.BorderStyle.Thin;//...  

        //        ICellStyle style2 = workbook.CreateCellStyle();
        //        style2.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Left;
        //        style2.BorderBottom = NPOI.SS.UserModel.BorderStyle.Thin;//粗
        //        style2.BorderLeft = NPOI.SS.UserModel.BorderStyle.Thin;//細實線
        //        style2.BorderRight = NPOI.SS.UserModel.BorderStyle.Thin;//虛線
        //        style2.BorderTop = NPOI.SS.UserModel.BorderStyle.Thin;//...  

        //        IFont font = workbook.CreateFont();
        //        font.FontName = "新細明體";
        //        font.FontHeightInPoints = 10;

        //        //make a header row
        //        IRow row1 = sheet.CreateRow(0);
        //        for (int j = 0; j < ColumnName[Len].Length; j++)
        //        {
        //            ICell cell = row1.CreateCell(j);
        //            string columnName = ColumnName[Len][j].ToString();
        //            cell.SetCellValue(columnName);
        //            style1.SetFont(font);
        //            row1.GetCell(j).CellStyle = style1;
        //            sheet.AutoSizeColumn(j);
        //        }

        //        switch (reqFType[Len])
        //        {
        //            case "ExportByDefault":
        //                //loops through data
        //                for (int i = 0; i < dt[Len].Rows.Count; i++)
        //                {
        //                    IRow row2 = sheet.CreateRow(i + 1);
        //                    for (int j = 0; j < dt[Len].Columns.Count; j++)
        //                    {
        //                        ICell cell = row2.CreateCell(j);
        //                        cell.SetCellValue(dt[Len].Rows[i][dt[Len].Columns[j].ToString()].ToString());
        //                        if (j < dt[Len].Columns.Count - 1)
        //                        {
        //                            style2.SetFont(font);
        //                            row2.GetCell(j).CellStyle = style2;
        //                        }
        //                        sheet.AutoSizeColumn(j);
        //                    }
        //                }
        //                break;
        //            case "ExportByAcct":
        //                //loops through data
        //                for (int i = 0; i < dt[Len].Rows.Count; i++)
        //                {
        //                    IRow row2 = sheet.CreateRow(i + 1);
        //                    for (int j = 0; j < dt[Len].Columns.Count; j++)
        //                    {
        //                        ICell cell = row2.CreateCell(j);

        //                        if (j == 0 || j == 25) //j == 25 dt啟動在報名次數前面
        //                            cell.SetCellValue(dt[Len].Rows[i][dt[Len].Columns[j].ToString()].ToString());
        //                        else if (j == 1)
        //                        {
        //                            //※ Excel第二欄位用了dt的2 + 3欄位資料(使用期限)、後面取欄位的值都加1※
        //                            string ColumnData1 = dt[Len].Rows[i][dt[Len].Columns[j].ToString()].ToString();
        //                            string ColumnData2 = dt[Len].Rows[i][dt[Len].Columns[j + 1].ToString()].ToString();

        //                            if (ColumnData1 != "" && ColumnData2 != "")
        //                                cell.SetCellValue(ColumnData1 + " ~ " + ColumnData2);
        //                        }
        //                        else if (j > 1 && j < dt[Len].Columns.Count - 1)
        //                        {
        //                            if (j == 3)
        //                                cell.SetCellValue("Z" + dt[Len].Rows[i][dt[Len].Columns[j + 2].ToString()].ToString().PadLeft(5, '0'));
        //                            else if (j == 24) //j == 24 報名次數另外加入dt在啟動後面
        //                                cell.SetCellValue(dt[Len].Rows[i][dt[Len].Columns[j + 2].ToString()].ToString());
        //                            else
        //                                cell.SetCellValue(dt[Len].Rows[i][dt[Len].Columns[j + 1].ToString()].ToString());
        //                        }

        //                        if (j < dt[Len].Columns.Count - 1)
        //                        {
        //                            style2.SetFont(font);
        //                            row2.GetCell(j).CellStyle = style2;
        //                        }
        //                        sheet.AutoSizeColumn(j);
        //                    }
        //                }
        //                break;
        //        }
        //    }


        //    using (var ms = new MemoryStream())
        //    {
        //        HttpResponse httpResponse = HttpContext.Current.Response;

        //        httpResponse.Clear();
        //        workbook.Write(ms);
        //        if (ExcelFormat == "xlsx") //xlsx file format
        //        {
        //            httpResponse.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        //            httpResponse.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", "MemberDate_" + DateTime.Now.ToString("yyyy_MM_dd") + ".xlsx"));
        //            httpResponse.BinaryWrite(ms.ToArray());
        //        }
        //        else if (ExcelFormat == "xls")  //xls file format
        //        {
        //            httpResponse.ContentType = "application/vnd.ms-excel";
        //            httpResponse.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", "MemberDate_" + DateTime.Now.ToString("yyyy_MM_dd") + ".xls"));
        //            httpResponse.BinaryWrite(ms.GetBuffer());
        //        }
        //        //Response.Redirect("ugA_Acct.aspx");

        //        httpResponse.End();
        //        ms.Close();
        //        ms.Dispose();
        //        workbook = null;
        //    }
        //}


    }
}
