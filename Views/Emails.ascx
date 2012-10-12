<%@ Control language="C#" Inherits="Gooddogs.Modules.Dnn.BridgeMail.Emails" AutoEventWireup="false"  Codebehind="Emails.ascx.cs" %>

<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement"
    Assembly="DotNetNuke.Web.Client" %>

<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>

<dnn:dnnjsinclude priority="60" id="viewmodel" runat="server" filepath="~/DesktopModules/BridgeMail/ViewModels/Emails.js"
    forceprovider="DnnFormBottomProvider" />
	
<div class="container">

    <div class="row-fluid">

        <div class="span12">

            <h3>Mail Manager - Emails</h3>

            <div id="buttonbar">
                <div class="input-append">
                    <input class="input-medium" id="txtFilter" type="text"
                        data-bind="value: filterText">
                    <button class="btn btn-primary" type="button" data-bind="click: setFilter">Filter (Title)</button>

                    <button class="btn btn-secondary" type="button"
                    data-bind="click: clearFilter">Clear</button>
                    <button class="btn btn-success" type="button"
                        data-bind="click: compose">Compose</button>
                </div>
            </div>

            <div id="composepanel"
                style="border: 1px solid #000; padding: 12px; 
                margin-top: 12px; margin-bottom: 12px;
                background-color: #f8f3bb">
                <div style="position: relative; left: 24px;">
                    <h4 data-bind="text: addpanelheading">Compose Email</h4>
                    <select data-bind="options: groups, optionsText: 'GroupName', optionsValue: 'ItemID', value: selectedGroup,
                    optionsCaption: 'Select List...'">
                    </select>
                    <label><b>From</b></label>
                    <input type="text" class="input-xxlarge" placeholder="EMail Address" data-bind="value: oFrom">
                    <label><b>Title</b></label>
                    <input type="text" class="input-xxlarge" placeholder="Mail Subject" data-bind="value: oTitle">
                    <br />
                </div>
                <dnn:TextEditor id="txtBody" runat="server" width="600" Height="250"/>
                <br />
                <div style="position: relative; left: 24px;">
                    <label><b>File Attachment</b></label>
                    <asp:FileUpload ID="fileAttachment" runat="server" />
                    <br /><br />
                </div>
                <button type="submit" class="btn btn-primary" data-bind="click: saveMail">SEND</button>
                <button type="button" class="btn btn-secondary" data-bind="click: cancelAdd">Cancel</button>
            </div>

            <div id="sendprogress"
                style="border: 1px solid #000; padding: 12px; 
                margin-top: 12px; margin-bottom: 12px;
                background-color: #f8f3bb">
                <h4>Sending Mail....</h4>
            </div>

             <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Date Sent</th>
                        <th>Subject</th>
                        <th>List</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody data-bind="foreach: lists">
                    <tr>
                        <td data-bind="dateString: CreatedDate" style="width: 160px;"></td>
                        <td><a href="#" data-bind="text: Message, click: $parent.editMail"></a></td>
                        <td data-bind="text: List.GroupName"></td>
                        <td><a href="#">More...</a></td>
                    </tr>
                </tbody>
            </table>

            <div class="pagination">
                <ul>
                    <li><a href="#" data-bind="click: prevPage">Prev</a></li>
                    <li><a href="#" data-bind="click: nextPage">Next</a></li>
                </ul>
            </div>

        </div>

    </div>
    
</div>
