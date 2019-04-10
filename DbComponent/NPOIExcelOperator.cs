namespace DbComponent
{
    using NPOI.HSSF.UserModel;
    using NPOI.HSSF.Util;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.IO;

    public enum NPOIExcelType
    {
        STRING,DATETIME,NUMBERIC,NONE
    }
    public class NPOIExcelOperator
    {
        private int _index;
        private ushort _startcol;
        private ushort _startrow;
        public string FileName;
        public string FilePath;
        public HSSFCellStyle HeaderStyle;
        private HSSFWorkbook hssfworkbook;
        public HSSFCellStyle HyperStyle;
        Dictionary<string, Dictionary<string, NPOIExcelType>> dic = new Dictionary<string, Dictionary<string, NPOIExcelType>>();

        

        public NPOIExcelOperator()
        {
            this._index = 1;
            this._startrow = 0;
            this._startcol = 0;
            this.hssfworkbook = new HSSFWorkbook();
            this.HeaderStyle = this.hssfworkbook.CreateCellStyle();
            this.HeaderStyle.Alignment = CellHorizontalAlignment.CENTER;
            this.HyperStyle = this.hssfworkbook.CreateCellStyle();
            HSSFFont font = this.hssfworkbook.CreateFont();
            font.Underline = HSSFFont.U_SINGLE;
            font.Color = HSSFColor.BLUE.index;
            this.HyperStyle.SetFont(font);
        }

        public NPOIExcelOperator(Stream s)
        {
            this._index = 1;
            this._startrow = 0;
            this._startcol = 0;
            this.hssfworkbook = new HSSFWorkbook(s);
            this.HeaderStyle = this.hssfworkbook.CreateCellStyle();
            this.HeaderStyle.Alignment = CellHorizontalAlignment.CENTER;
            this.HyperStyle = this.hssfworkbook.CreateCellStyle();
            HSSFFont font = this.hssfworkbook.CreateFont();
            font.Underline = HSSFFont.U_SINGLE;
            font.Color = HSSFColor.BLUE.index;
            this.HyperStyle.SetFont(font);
        }

        public NPOIExcelOperator(string targetpath, string filename)
        {
            this._index = 1;
            this._startrow = 0;
            this._startcol = 0;
            if (!Directory.Exists(targetpath))
            {
                Directory.CreateDirectory(targetpath);
            }
            this.FilePath = targetpath;
            this.FileName = filename;
            this.hssfworkbook = new HSSFWorkbook();
            this.HeaderStyle = this.hssfworkbook.CreateCellStyle();
            this.HeaderStyle.Alignment = CellHorizontalAlignment.CENTER;
            this.HyperStyle = this.hssfworkbook.CreateCellStyle();
            HSSFFont font = this.hssfworkbook.CreateFont();
            font.Underline = HSSFFont.U_SINGLE;
            font.Color = HSSFColor.BLUE.index;
            this.HyperStyle.SetFont(font);
        }

        public NPOIExcelOperator(string targetpath, string filename, FileMode mode)
        {
            this._index = 1;
            this._startrow = 0;
            this._startcol = 0;
            if (!Directory.Exists(targetpath))
            {
                Directory.CreateDirectory(targetpath);
            }
            this.FilePath = targetpath;
            this.FileName = filename;
            switch (mode)
            {
                case FileMode.Open:
                case FileMode.OpenOrCreate:
                {
                    FileStream s = new FileStream(targetpath + "/" + filename, FileMode.Open);
                    this.hssfworkbook = new HSSFWorkbook(s);
                    s.Close();
                    break;
                }
                default:
                    this.hssfworkbook = new HSSFWorkbook();
                    break;
            }
            this.HeaderStyle = this.hssfworkbook.CreateCellStyle();
            this.HeaderStyle.Alignment = CellHorizontalAlignment.CENTER;
            this.HyperStyle = this.hssfworkbook.CreateCellStyle();
            HSSFFont font = this.hssfworkbook.CreateFont();
            font.Underline = HSSFFont.U_SINGLE;
            font.Color = HSSFColor.BLUE.index;
            this.HyperStyle.SetFont(font);
        }

        public DataSet GetAllTableFromWorkBook()
        {
            int sheetCount = this.GetSheetCount();
            DataSet set = new DataSet();
            for (int i = 0; i < sheetCount; i++)
            {
                set.Tables.Add(this.GetTableFromSheetByID(i));
            }
            return set;
        }

        public int GetSheetCount()
        {
            int index = 0;
            try
            {
                HSSFSheet sheet = null;
                while ((sheet = this.hssfworkbook.GetSheetAt(index)) != null)
                {
                    index++;
                }
            }
            catch (ArgumentException)
            {
                return index;
            }
            return index;
        }

        public int GetSheetIndex(string sheetname)
        {
            return hssfworkbook.GetSheetIndex(sheetname);
        }
        public string GetSheetName(int index)
        {
            return hssfworkbook.GetSheetName(index);
        }

        public void SetColumnType(string sheetname, string colname, NPOIExcelType type)
        {
            if (dic.ContainsKey(sheetname))
            {
                dic[sheetname][colname] = type;
            }
            else
            {
                dic[sheetname]=new Dictionary<string,NPOIExcelType>();
                dic[sheetname][colname] = type;
            }

        }

        public NPOIExcelType GetColumnType(string sheetname, string colname)
        {
            if (dic.ContainsKey(sheetname))
            {
                if (dic[sheetname].ContainsKey(colname))
                {
                    return dic[sheetname][colname];
                }


            }


            return NPOIExcelType.NONE;
        }

        public string ErrorMessage = "";

        public DataTable GetTableFromSheet(HSSFSheet sheet)
        {
            ErrorMessage = "";
            int rowIndex = 0;
            int num2 = 0;
            while (sheet.GetRow(rowIndex) == null)
            {
                rowIndex++;
                if (rowIndex > 50)
                {
                    throw new Exception("Excel 开头空行太多");
                }
            }
            while (((num2 < sheet.GetRow(rowIndex).Cells.Count) && (sheet.GetRow(rowIndex).Cells[num2] != null)) && string.IsNullOrEmpty(sheet.GetRow(rowIndex).Cells[num2].ToString()))
            {
                num2++;
                if (num2 > 50)
                {
                    rowIndex++;
                    num2 = 0;
                }
            }
            DataTable table = new DataTable(this.hssfworkbook.GetSheetName(this.hssfworkbook.GetSheetIndex(sheet)));
            HSSFRow row = sheet.GetRow(rowIndex);
            string tablename = table.TableName;
            int num3 = num2;
            int num4 = rowIndex;
            int num5 = num2;
            while (num3 < row.Cells.Count&&!string.IsNullOrEmpty(row.Cells[num3].ToString()))
            {
                
                    table.Columns.Add(new DataColumn(row.Cells[num3].ToString().Trim()));
      
                num3++;
            }
            num5 = ((num3 - 1) < 0) ? 0 : (num3 - 1);
            num4++;
            while (num4 <= sheet.LastRowNum)
            {
                HSSFRow row2 = sheet.GetRow(num4);
                if (row2 != null)
                {
                    try
                    {
                        DataRow row3 = table.NewRow();
                        for (num3 = num2; (num3 < row2.Cells.Count) && (num3 <= num5); num3++)
                        {

                            NPOIExcelType type = this.GetColumnType(tablename, row3.Table.Columns[num3 - num2].ColumnName);
                            if (type == NPOIExcelType.DATETIME)
                            {

                                row3[num3 - num2] = row2.Cells[num3].DateCellValue;
                            }
                            else if (type == NPOIExcelType.NUMBERIC)
                            {
                                row2.Cells[num3].SetCellType(HSSFCellType.NUMERIC);
                                row3[num3 - num2] = row2.Cells[num3].NumericCellValue;
                            }
                            else if (type == NPOIExcelType.STRING)
                            {
                                row2.Cells[num3 - num2].SetCellType(HSSFCellType.STRING);
                                row3[num3 - num2] = row2.Cells[num3].ToString();
                            }
                            else
                            {
                                if (row2.Cells[num3].CellType == HSSFCellType.NUMERIC)
                                {
                                    row3[num3 - num2] = row2.Cells[num3].NumericCellValue;
                                }
                                else
                                {
                                    row3[num3 - num2] = row2.Cells[num3].ToString();
                                }
                            }



                        }
                        table.Rows.Add(row3);
                    }
                    catch (Exception ex)
                    {
                        ErrorMessage += "第" + num4+1 + "行格式不正确," + ex.Message;
                    }
                }
                else
                {
                    break;
                }
                num4++;
            }
            return table;
        }

        public DataTable GetTableFromSheetByID(int index)
        {
            return this.GetTableFromSheet(this.hssfworkbook.GetSheetAt(index));
        }

        public DataTable GetTableFromSheetByName(string name)
        {
            return this.GetTableFromSheet(this.hssfworkbook.GetSheet(name));
        }

        public static NPOIExcelOperator Load(string filePath)
        {
            FileStream s = new FileStream(filePath, FileMode.Open);
            NPOIExcelOperator @operator = new NPOIExcelOperator(s);
            s.Close();
            return @operator;
        }

        public void OutputExcelForBack(DataTable dt, string sheetName)
        {
            HSSFSheet sheet = this.hssfworkbook.CreateSheet(sheetName);
            ushort startCol = this.StartCol;
            ushort startRow = this.StartRow;
            HSSFRow row = sheet.CreateRow(startRow);
            foreach (DataColumn column in dt.Columns)
            {
                HSSFCell cell = row.CreateCell(startCol, HSSFCellType.STRING);
                cell.CellStyle = this.HeaderStyle;
                cell.SetCellValue(column.ColumnName);
                startCol = (ushort) (startCol + 1);
            }
            foreach (DataRow row2 in dt.Rows)
            {
                startRow = (ushort) (startRow + 1);
                startCol = this.StartCol;
                HSSFRow row3 = sheet.CreateRow(startRow);
                foreach (DataColumn column in dt.Columns)
                {
                    row3.CreateCell(startCol, HSSFCellType.STRING).SetCellValue(row2[column.ColumnName].ToString());
                    startCol = (ushort) (startCol + 1);
                }
            }
            for (int i = this.StartCol; i < startCol; i++)
            {
                sheet.SetColumnWidth(i, 0x1400);
            }
        }

        public void OutputExcelForHeader(DataTable dt, string sheetName)
        {
            HSSFSheet sheet = this.hssfworkbook.CreateSheet(sheetName);
            ushort startCol = this.StartCol;
            ushort startRow = this.StartRow;
            HSSFRow row = sheet.CreateRow(startRow);
            foreach (DataColumn column in dt.Columns)
            {
                HSSFCell cell = row.CreateCell(startCol, HSSFCellType.STRING);
                cell.CellStyle = this.HeaderStyle;
                cell.SetCellValue(column.Caption);
                startCol = (ushort) (startCol + 1);
            }
            foreach (DataRow row2 in dt.Rows)
            {
                startRow = (ushort) (startRow + 1);
                startCol = this.StartCol;
                HSSFRow row3 = sheet.CreateRow(startRow);
                foreach (DataColumn column in dt.Columns)
                {
                    row3.CreateCell(startCol, HSSFCellType.STRING).SetCellValue(row2[column.ColumnName].ToString());
                    startCol = (ushort) (startCol + 1);
                }
            }
            for (int i = this.StartCol; i < startCol; i++)
            {
                sheet.SetColumnWidth(i, 0x1400);
            }
        }

        public void Save()
        {
            if (string.IsNullOrEmpty(this.FileName))
            {
                throw new Exception("文件名未指定");
            }
            FileStream stream = new FileStream(this.FilePath + "/" + this.FileName, FileMode.Create);
            this.hssfworkbook.Write(stream);
            stream.Close();
        }

        public void Save(string path)
        {
            if (string.IsNullOrEmpty(path))
            {
                throw new Exception("文件名未指定");
            }
            FileStream stream = new FileStream(path, FileMode.Create);
            this.hssfworkbook.Write(stream);
            stream.Close();
        }

        private string[] Split(string value)
        {
            string[] strArray = value.Split(new char[] { ';' });
            List<string> list = new List<string>();
            foreach (string str in strArray)
            {
                if (str.Trim().Length > 0)
                {
                    list.Add(str);
                }
            }
            return list.ToArray();
        }

        public HSSFWorkbook HssfWorkbook
        {
            get
            {
                return this.hssfworkbook;
            }
        }

        private string NextColName
        {
            get
            {
                return ("Column_" + this._index++);
            }
        }

        public ushort StartCol
        {
            get
            {
                return this._startcol;
            }
            set
            {
                this._startcol = value;
            }
        }

        public ushort StartRow
        {
            get
            {
                return this._startrow;
            }
            set
            {
                this._startrow = value;
            }
        }
    }
}

