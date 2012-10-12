<%@ Control language="C#" Inherits="Gooddogs.Modules.Dnn.BridgeMail.View" AutoEventWireup="false"  Codebehind="View.ascx.cs" %>

<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement"
    Assembly="DotNetNuke.Web.Client" %>

<dnn:dnnjsinclude priority="60" id="viewmodel" runat="server" filepath="~/DesktopModules/BridgeMail/ViewModels/View.js"
    forceprovider="DnnFormBottomProvider" />
	
<div class="container">

    <div class="row-fluid">

        <div class="span12">

            <h3>Mail Manager - Mailing Lists</h3>

            <div id="buttonbar">

                <div class="input-append">
                    <input class="input-medium" id="txtFilter" type="text"
                        data-bind="value: filterText">
                    <button class="btn btn-primary" type="button" data-bind="click: setFilter">Filter</button>

                    <button class="btn btn-secondary" type="button"
                    data-bind="click: clearFilter">Clear</button>
                    <button class="btn btn-success" type="button"
                        data-bind="click: addList">Add New Mailing List</button>
                </div>
            </div>

            <div id="addpanel" 
                style="border: 1px solid #000; padding: 12px; 
                margin-top: 12px; margin-bottom: 12px;
                background-color: #f8f3bb">
                <h4 data-bind="text: addpanelheading">Add Mailing List</h4>
                <label>List Name</label>
                <input type="text" placeholder="Mailing List Name" data-bind="value: oListName">
                <br /><br />
                <button type="submit" class="btn btn-primary" data-bind="click: saveList">Save</button>
                <button type="button" class="btn btn-secondary" data-bind="click: cancelAdd">Cancel</button>
            </div>

            <div id="memberspanel" 
                style="border: 1px solid #000; padding: 12px; 
                margin-top: 12px; margin-bottom: 12px;
                background-color: #f8f3bb">
                <h4 data-bind="text: memberspanelheading">Manage List Members</h4>

                <div class="container">
                    <div class="span3">
                        <label>Non-Members</label>
                        <select multiple="true" width="50" size="12" 
                            data-bind="options: nonmembers, optionsText: function(item){ return item.LastName + ', ' + item.FirstName; }, selectedOptions: selectedNonMembers"></select>
                        <br />
                        <button type="button" class="btn btn-primary" data-bind="click: cancelAdd">Close</button>
                    </div>
                    <div class="span2" style="text-align: center;">
                        <br /><br />
                        <button type="button" class="btn btn-mini" style="width:100px;" data-bind="click: addSome">Add</button><br /><br />
                        <button type="button" class="btn btn-mini" style="width:100px;">Add All</button><br /><br />
                        <button type="button" class="btn btn-mini" style="width:100px;">Remove All</button><br /><br />
                        <button type="button" class="btn btn-mini" style="width:100px;" data-bind="click: removeSome">Remove</button><br />
                    </div>
                    <div class="span3">
                        <label>Members</label>
                        <select id="lbNonMembers" multiple="true" width="50" size="12" 
                            data-bind="options: members, optionsText: function(item){ return item.LastName + ', ' + item.FirstName; }, selectedOptions: selectedMembers"></select>
                    </div>                  
                </div>
            </div>

             <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>List Name</th>
                        <th>Members</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody data-bind="foreach: lists">
                    <tr>
                        <td><a href="#" data-bind="text: GroupName, click: $parent.editList"></a></td>
                        <td data-bind="text: People.length"></td>
                        <td><a href="#" data-bind="click: $parent.manageMembers">Manage Members</a></td>
                    </tr>
                </tbody>
            </table>

        </div>

    </div>
    
</div>
