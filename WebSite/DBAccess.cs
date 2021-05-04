using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
//using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace WebSite
{
    public class DBAccess
    {
        string ConStr = GetWebConfig.ConnectionString("dbConnectionString").ToString();
        DbProviderFactory _factory;
        string ServerPath = string.Empty;
        string providerType = string.Empty;
        DbParameterCollection paraCollection;

        public DbProviderFactory Factory
        {
            get { return _factory; }
        }

        public DBAccess()
        {
            if (ServerPath.Equals(""))
            {
                ConnectionStringSettings css = ConfigurationManager.ConnectionStrings["dbConnectionString"];
                if (css != null)
                    ServerPath = css.ConnectionString;
                //DbProviderFactory factory = CreateFactory(GetWebConfig.AppStting("SqlType"));
                DbProviderFactory factory = CreateFactory();
                _factory = factory;
            }

        }

        //public DbProviderFactory CreateFactory(string PrName)
        public DbProviderFactory CreateFactory()
        {
            //if (_factory != null && providerType == PrName)
            if (_factory != null)
                return _factory;

            //DataRow dr = null;
            //DataTable _dt = null;
            string ConnType = string.Empty;

            #region 方法一
            ConnectionStringSettings connectionString = GetWebConfig.ConnectionString("dbConnectionString");
            _factory = DbProviderFactories.GetFactory(connectionString.ProviderName); //提供DbProviderFactories InvariantName名稱
            #endregion

            #region 方法二 預設Odbc、OleDb、Oracle、SqlClient 
            //if (PrName == "MSSQL")
            //    ConnType = "System.Data.SqlClient";
            //else if (PrName == "OLEDB")
            //    ConnType = "System.Data.OleDb";

            //using (_dt = DbProviderFactories.GetFactoryClasses())
            //{
            //    foreach (DataRow _dr in _dt.Rows)
            //    {
            //        if (_dr["InvariantName"].ToString().Contains(ConnType))
            //        {
            //            dr = _dr;
            //            break;
            //        }
            //    }
            //}

            //try
            //{
            //        if (dr == null && _dt != null)
            //        {
            //            dr = _dt.NewRow();

            //            if (PrName == "MSSQL")
            //            {
            //                dr["Name"] = "SqlClient Data Provider";
            //                dr["Description"] = ".Net Framework Data Provider for SqlServer";
            //                dr["InvariantName"] = "System.Data.SqlClient";
            //                dr["AssemblyQualifiedName"] = "System.Data.SqlClient.SqlClientFactory,System.Data,Version = 2.0.0.0, Culture = neutral, PublicKeyToken = b77a5c561934e089";
            //            }
            //            else if (PrName == "OLEDB")
            //            {
            //                dr["Name"] = "OleDb Data Provider";
            //                dr["Description"] = ".Net Framework Data Provider for OleDb";
            //                dr["InvariantName"] = "System.Data.OleDb";
            //                dr["AssemblyQualifiedName"] = "System.Data.OleDb.OleDbFactory, System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089";
            //            }
            //        }

            //    _factory = DbProviderFactories.GetFactory(dr);
            //}
            //catch (Exception ex)
            //{
            //    ;
            //}
            //_dt.Clear();
            #endregion

            return _factory;
        }

        //回傳DbParameter
        public DbParameter BuildDbParameter(string par, object val)
        {
            DbCommand dbc = Factory.CreateCommand();
            DbParameter dbParameter = dbc.CreateParameter();
            dbParameter.ParameterName = par;
            dbParameter.Value = val;
            return dbParameter;
        }

        //取資料
        public DataTable GetDBData(string CmdStr, List<DbParameter> paralist = null)
        {
            DataTable dt = new DataTable();
            using (DbConnection dbCon = Factory.CreateConnection())
            {
                dbCon.ConnectionString = ConStr;
                if (dbCon.State == ConnectionState.Closed)
                    dbCon.Open();
                using (DbCommand dbCmd = Factory.CreateCommand())
                {
                    dbCmd.Connection = dbCon;
                    dbCmd.CommandText = CmdStr;

                    #region 處理Parameters list
                    if (paralist != null && paralist.Count > 0)
                    {
                        paraCollection = dbCmd.Parameters;
                        foreach (DbParameter para in paralist)
                            paraCollection.Add(para);
                    }
                    #endregion

                    using (DbDataAdapter da = Factory.CreateDataAdapter())
                    {
                        da.SelectCommand = dbCmd;
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        //讀取
        public bool ReaderDB(string CmdStr, List<DbParameter> paralist = null)
        {
            using (DbConnection OldCon = Factory.CreateConnection())
            {
                OldCon.ConnectionString = ConStr;
                if (OldCon.State == ConnectionState.Closed)
                    OldCon.Open();

                using (DbCommand OldCmd = Factory.CreateCommand())
                {
                    OldCmd.Connection = OldCon;
                    OldCmd.CommandText = CmdStr;

                    #region 處理Parameters list
                    if (paralist != null && paralist.Count > 0)
                    {
                        paraCollection = OldCmd.Parameters;
                        foreach (DbParameter para in paralist)
                            paraCollection.Add(para);
                    }
                    #endregion

                    var dr = OldCmd.ExecuteReader();
                    return dr.Read();
                }
            }
        }

        public int CUD(string CmdStr, List<DbParameter> paralist = null,bool GetIdentity = false)
        {
            using (DbConnection OldCon = Factory.CreateConnection())
            {
                OldCon.ConnectionString = ConStr;
                if (OldCon.State == ConnectionState.Closed)
                    OldCon.Open();

                using (DbCommand OldCmd = Factory.CreateCommand())
                {
                    OldCmd.Connection = OldCon;
                    OldCmd.CommandText = CmdStr;

                    #region 處理Parameters list
                    if (paralist != null && paralist.Count > 0)
                    {
                        paraCollection = OldCmd.Parameters;
                        foreach (DbParameter para in paralist)
                            paraCollection.Add(para);
                    }
                    #endregion

                    if (!GetIdentity)
                        return OldCmd.ExecuteNonQuery();
                    else
                    {
                        OldCmd.CommandText = "Select @@IDENTITY AS UserID";
                        int newId = (int)OldCmd.ExecuteScalar();
                        return newId;
                    }
                }
            }
        }

        //更新
        public int CUD(List<CmdParameter> CmdParameter)
        {
            int result = 1;

            using (DbConnection OldCon = Factory.CreateConnection())
            {
                try
                {
                    OldCon.ConnectionString = ConStr;
                    if (OldCon.State == ConnectionState.Closed)
                        OldCon.Open();

                    var tx = OldCon.BeginTransaction();
                    try
                    {
                        foreach (CmdParameter muilt in CmdParameter)
                        {
                            using (DbCommand OldCmd = Factory.CreateCommand())
                            {
                                try
                                {
                                    OldCmd.Connection = OldCon;
                                    OldCmd.Transaction = tx;
                                    OldCmd.CommandText = muilt.Cmd;

                                    #region 處理Parameters list
                                    if (muilt.Par != null && muilt.Par.Count > 0)
                                    {
                                        paraCollection = OldCmd.Parameters;
                                        foreach (DbParameter para in muilt.Par)
                                            paraCollection.Add(para);
                                    }
                                    #endregion

                                    OldCmd.ExecuteNonQuery();

                                    paraCollection.Clear();  //需要清除否則會出現 另一个 OleDbParameterCollection 中已包含 OleDbParameter 錯誤分析及解決辦法
                                }
                                catch (Exception ex)
                                {
                                    tx.Rollback();
                                    result = 0;
                                    break; //Rollback後尚未執行之SQL不應繼續執行
                                }
                            }
                        }
                        if (result > 0)
                        {
                            tx.Commit();
                        }
                    }
                    catch (Exception ex)
                    {
                        tx.Rollback();
                        result = 0;
                    }
                }
                catch (Exception ex)
                {
                    result = 0;
                }
                finally
                {
                    CmdParameter.Clear();
                    OldCon.Close();
                }
            }
            return result;
        }
    }
}

public class CmdParameter : ICloneable
{
    public string Cmd;
    public List<DbParameter> Par;
    public object Clone()
    {
        return this.MemberwiseClone();
    }
}
