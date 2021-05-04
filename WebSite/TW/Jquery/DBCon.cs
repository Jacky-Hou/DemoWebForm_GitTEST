using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebSite.Jquery
{
    public class DBCon
    {
        string ConStr = GetWebConfig.ConnectionString("dbConnectionString").ToString();
        DbProviderFactory _factory;
        string ServerPath = string.Empty;
        string providerType = string.Empty;

        public DbProviderFactory Factory
        {
            get { return _factory; }
        }

        public DBCon()
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


        public int GetCount(string CmdStr)
        {
            using (DbConnection dbCon = Factory.CreateConnection())
            {
                dbCon.ConnectionString = ConStr;
                if (dbCon.State != ConnectionState.Open)
                    dbCon.Open();

                using (DbCommand dbCmd = Factory.CreateCommand())
                {
                    dbCmd.Connection = dbCon;
                    dbCmd.CommandText = CmdStr;
                    return Convert.ToInt32(dbCmd.ExecuteScalar());
                }
            }
        }

        public DataTable GetSqlTable(string CmdStr)
        {
            DataTable dt = new DataTable();
            using (DbConnection dbCon = Factory.CreateConnection())
            {
                dbCon.ConnectionString = ConStr;
                if (dbCon.State != ConnectionState.Open)
                    dbCon.Open();

                using (DbCommand dbCmd = Factory.CreateCommand())
                {
                    dbCmd.Connection = dbCon;
                    dbCmd.CommandText = CmdStr;

                    using (DbDataAdapter da = Factory.CreateDataAdapter())
                    {
                        da.SelectCommand = dbCmd;
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        public int SqlCUD(string CmdStr, bool Identity = false)
        {
            int newId;
            using (DbConnection dbCon = Factory.CreateConnection())
            {
                dbCon.ConnectionString = ConStr;
                if (dbCon.State != ConnectionState.Open)
                    dbCon.Open();

                using (DbCommand dbCmd = Factory.CreateCommand())
                {
                    dbCmd.Connection = dbCon;
                    dbCmd.CommandText = CmdStr;

                    dbCmd.ExecuteNonQuery();

                    if (!Identity)
                        return 0;
                    else
                    {
                        dbCmd.CommandText = " Select @@IDENTITY AS WorkProjectsID ";
                        newId = Convert.ToInt32(dbCmd.ExecuteScalar());
                        return newId;
                    }
                }
            }
        }
    }

}