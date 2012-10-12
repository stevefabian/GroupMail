/*
' Copyright (c) 2011 Gooddogs
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System.Collections.Generic;
//using System.Xml;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Search;

namespace Gooddogs.Modules.Dnn.BridgeMail
{

    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The Controller class for BridgeMail
    /// </summary>
    /// -----------------------------------------------------------------------------
    public class FeatureController : IPortable, ISearchable, IUpgradeable
    {

        #region Public Methods



        #endregion

        #region Optional Interfaces

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// ExportModule implements the IPortable ExportModule Interface
        /// </summary>
        /// <param name="ModuleID">The Id of the module to be exported</param>
        /// -----------------------------------------------------------------------------
        public string ExportModule(int ModuleID)
        {
            //string strXML = "";

            //List<BridgeMailInfo> colBridgeMails = GetBridgeMails(ModuleID);
            //if (colBridgeMails.Count != 0)
            //{
            //    strXML += "<BridgeMails>";

            //    foreach (BridgeMailInfo objBridgeMail in colBridgeMail)
            //    {
            //        strXML += "<BridgeMail>";
            //        strXML += "<content>" + DotNetNuke.Common.Utilities.XmlUtils.XMLEncode(objBridgeMail.Content) + "</content>";
            //        strXML += "</BridgeMail>";
            //    }
            //    strXML += "</BridgeMails>";
            //}

            //return strXML;

            throw new System.NotImplementedException("The method or operation is not implemented.");
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// ImportModule implements the IPortable ImportModule Interface
        /// </summary>
        /// <param name="ModuleID">The Id of the module to be imported</param>
        /// <param name="Content">The content to be imported</param>
        /// <param name="Version">The version of the module to be imported</param>
        /// <param name="UserId">The Id of the user performing the import</param>
        /// -----------------------------------------------------------------------------
        public void ImportModule(int ModuleID, string Content, string Version, int UserID)
        {
            //XmlNode xmlBridgeMails = DotNetNuke.Common.Globals.GetContent(Content, "BridgeMails");
            //foreach (XmlNode xmlBridgeMail in xmlBridgeMails.SelectNodes("BridgeMail"))
            //{
            //    BridgeMailInfo objBridgeMail = new BridgeMailInfo();
            //    objBridgeMail.ModuleId = ModuleID;
            //    objBridgeMail.Content = xmlBridgeMail.SelectSingleNode("content").InnerText;
            //    objBridgeMail.CreatedByUser = UserID;
            //    AddBridgeMail(objBridgeMail);
            //}

            throw new System.NotImplementedException("The method or operation is not implemented.");
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// GetSearchItems implements the ISearchable Interface
        /// </summary>
        /// <param name="ModInfo">The ModuleInfo for the module to be Indexed</param>
        /// -----------------------------------------------------------------------------
        public DotNetNuke.Services.Search.SearchItemInfoCollection GetSearchItems(DotNetNuke.Entities.Modules.ModuleInfo ModInfo)
        {
            //SearchItemInfoCollection SearchItemCollection = new SearchItemInfoCollection();

            //List<BridgeMailInfo> colBridgeMails = GetBridgeMails(ModInfo.ModuleID);

            //foreach (BridgeMailInfo objBridgeMail in colBridgeMails)
            //{
            //    SearchItemInfo SearchItem = new SearchItemInfo(ModInfo.ModuleTitle, objBridgeMail.Content, objBridgeMail.CreatedByUser, objBridgeMail.CreatedDate, ModInfo.ModuleID, objBridgeMail.ItemId.ToString(), objBridgeMail.Content, "ItemId=" + objBridgeMail.ItemId.ToString());
            //    SearchItemCollection.Add(SearchItem);
            //}

            //return SearchItemCollection;

            throw new System.NotImplementedException("The method or operation is not implemented.");
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// UpgradeModule implements the IUpgradeable Interface
        /// </summary>
        /// <param name="Version">The current version of the module</param>
        /// -----------------------------------------------------------------------------
        public string UpgradeModule(string Version)
        {
            throw new System.NotImplementedException("The method or operation is not implemented.");
        }

        #endregion

    }

}
