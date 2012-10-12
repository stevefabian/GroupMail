using System;
using System.Collections.Generic;
using System.Data.Services;
using System.Data.Services.Common;
using System.Linq;
using System.ServiceModel.Web;
using System.Web;
using System.Runtime.Serialization;
using System.Reflection;
using System.Web.Script.Serialization;
using DotNetNuke.Services.Localization;
using System.Data.Objects;
using DotNetNuke.Common.Utilities;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.EntityClient;
using Gooddogs.Modules.Dnn.BridgeMail.Data;

namespace Gooddogs.Modules.Dnn.BridgeMail.Service
{
    public class BridgeMailDataService : DataService<Data.BridgeMailContainer>
    {
        // This method is called only once to initialize service-wide policies.
        public static void InitializeService(DataServiceConfiguration config)
        {
            // TODO: set rules to indicate which entity sets and service operations are visible, updatable, etc.
            // Examples:
            config.SetEntitySetAccessRule("*", EntitySetRights.All);
            config.SetServiceOperationAccessRule("*", ServiceOperationRights.All);
            config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V2;
        }

        protected override Data.BridgeMailContainer CreateDataSource()
        {
            return CreateModuleDataSource();
        }

        [WebGet]
        public string GetVersion()
        {
            var ver = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version;
            return String.Format("{0}.{1}.{2}.{3}",
                ver.Major, ver.Minor, ver.Build, ver.Revision);
        }

        [WebGet]
        public void AssignToGroup(string pid, string gid)
        {
            var _pid = Int32.Parse(pid);
            var _gid = Int32.Parse(gid);

            var _person = CurrentDataSource.GoupMail_Person.Where(x => x.ItemID == _pid).FirstOrDefault();
            var _group = CurrentDataSource.GroupMail_Groups.Where(x => x.ItemID == _gid).FirstOrDefault();

            if (_person != null && _group != null)
            {
                _person.Lists.Add(_group);
                CurrentDataSource.SaveChanges();
            }
        }

        [WebGet]
        public void RemoveFromGroup(string pid, string gid)
        {
            var _pid = Int32.Parse(pid);
            var _gid = Int32.Parse(gid);

            var _person = CurrentDataSource.GoupMail_Person.Where(x => x.ItemID == _pid).FirstOrDefault();
            var _group = CurrentDataSource.GroupMail_Groups.Where(x => x.ItemID == _gid).FirstOrDefault();

            if (_person != null && _group != null)
            {
                _person.Lists.Remove(_group);
                CurrentDataSource.SaveChanges();
            }
        }

        [WebGet]
        public string GetResourceString(string key)
        {
            return Localization.GetString(key, "/DesktopModules/BridgeMail/Views/App_LocalResources/SharedResources.resx");
        }

        private Data.BridgeMailContainer CreateModuleDataSource()
        {
            try
            {
                // first check the cache, we only want to do this once
                const string STR_BridgeMail_EF_ConnectionString_Key = "BridgeMail_EF_ConnectionString_Key";

                if (DataCache.GetCache(STR_BridgeMail_EF_ConnectionString_Key) == null)
                {
                    // if not in the cache, construct the entity connection and cache it
                    using (var SiteSQLConnection = new SqlConnection(
                        ConfigurationManager.ConnectionStrings["SiteSQLServer"].ConnectionString))
                    {
                        //check if the connection string has integrated security enabled
                        {
                            bool isIntergratedEnabled = SiteSQLConnection.ConnectionString.Contains("Integrated Security");

                            //Build the Entity Framework connection string from the derived settings
                            var NewSQLConnectionString = new SqlConnectionStringBuilder();
                            var _with1 = NewSQLConnectionString;
                            _with1.DataSource = SiteSQLConnection.DataSource;
                            _with1.InitialCatalog = SiteSQLConnection.Database;
                            if (!isIntergratedEnabled)
                            {
                                string _uid, _pwd = string.Empty;
                                GetUserCredentialsFromConfigFile(SiteSQLConnection.ConnectionString, out _uid, out _pwd);
                                _with1.UserID = _uid;
                                _with1.Password = _pwd;
                            }
                            else
                            {
                                _with1.IntegratedSecurity = isIntergratedEnabled;
                                //.UserInstance = True
                            }
                            _with1.MultipleActiveResultSets = true;

                            var EFConnectionStringBuilder = new EntityConnectionStringBuilder();
                            var _with2 = EFConnectionStringBuilder;
                            _with2.Provider = "System.Data.SqlClient";
                            _with2.ProviderConnectionString = NewSQLConnectionString.ToString();
                            _with2.Metadata = "res://*/Data.BridgeMail.csdl|res://*/Data.BridgeMail.ssdl|res://*/Data.BridgeMail.msl";

                            DataCache.SetCache(STR_BridgeMail_EF_ConnectionString_Key, EFConnectionStringBuilder.ToString());
                        }

                    }
                }

                // now establish the connection from the cache
                return new Data.BridgeMailContainer(new EntityConnection(DataCache.GetCache(STR_BridgeMail_EF_ConnectionString_Key).ToString()));
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }

        }

        private static void GetUserCredentialsFromConfigFile(string strConn, out string userid, out string password)
        {
            var s = new SqlConnectionStringBuilder(strConn);
            userid = s.UserID;
            password = s.Password;
            return;
        }
    }
}
