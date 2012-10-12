<%@ Control language="C#" Inherits="Gooddogs.Modules.Dnn.BridgeMail.People" AutoEventWireup="false"  Codebehind="People.ascx.cs" %>

<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement"
    Assembly="DotNetNuke.Web.Client" %>

<dnn:dnnjsinclude priority="60" id="viewmodel" runat="server" filepath="~/DesktopModules/BridgeMail/ViewModels/People.js"
    forceprovider="DnnFormBottomProvider" />
	
<div class="container">

    <div class="row-fluid">

        <div class="span12">

            <h3>Mail Manager - People</h3>

            <div id="buttonbar">

                <div class="input-append">
                    <input class="input-medium" id="txtFilter" type="text"
                        data-bind="value: filterText">
                    <button class="btn btn-primary" type="button" data-bind="click: setLNFilter">Filter (Last Name)</button>
                    <button class="btn btn-primary" type="button" data-bind="click: setFNFilter">Filter (First Name)</button>

                    <button class="btn btn-secondary" type="button"
                    data-bind="click: clearFilter">Clear</button>
                    <button class="btn btn-success" type="button"
                        data-bind="click: addPerson">Add New Person</button>
                </div>
            </div>

            <div id="addpersonpanel"
                style="border: 1px solid #000; padding: 12px; 
                margin-top: 12px; margin-bottom: 12px;
                background-color: #f8f3bb; width:920px;">

                <h4 data-bind="text: addpanelheading">Add New Person</h4>
                <label>Name</label>
                <input type="text" placeholder="Last Name" data-bind="value: oLastName">
                <input type="text" placeholder="First Name" data-bind="value: oFirstName">
                <label>Email&nbsp;</label><input type="text" placeholder="Email" data-bind="value: oEMail">             
                <label>Phones</label>
                <input type="text" placeholder="Home Phone" data-bind="value: oPhone">
                <input type="text" placeholder="Cell Phone" data-bind="value: oCellPhone">        
                <label>Location</label>
                <input type="text" placeholder="City" data-bind="value: oCity">
                <input type="text" placeholder="State" data-bind="value: oState">             
                <label>ACBL Number</label>
                <input type="text" placeholder="ACBL Number" data-bind="value: oACBLNumber">
                <label>Notes</label>
                <input type="text" placeholder="Comment" data-bind="value: oComment">
                <br /><br />
                <button type="submit" class="btn btn-primary" data-bind="click: savePerson">Save</button>
                <button type="button" class="btn btn-secondary" data-bind="click: cancelAdd">Cancel</button>
                <button id="btnDeletePerson" type="button" class="btn btn-danger" data-bind="click: deletePerson"
                    style="margin-left: 36px;">Delete Person</button>
            </div>

            <div id="memberspanel" 
                style="border: 1px solid #000; padding: 12px; 
                margin-top: 12px; margin-bottom: 12px;
                background-color: #f8f3bb">
                <h4 data-bind="text: membersPanelHeader">Manage List Membership</h4>

                <div class="container">
                    <div class="span3">
                        <label>Non-Members</label>
                        <select multiple="true" width="50" size="12" 
                            data-bind="options: nonmembers, optionsText: 'GroupName', selectedOptions: selectedNonMembers"></select>
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
                            data-bind="options: members, optionsText: 'GroupName', selectedOptions: selectedMembers"></select>
                    </div>                  
                </div>
            </div>

            <table class="table table-bordered table-striped" style="margin-top: 12px;">
                <thead>
                    <tr>
                        <th></th>
                        <th>Last Name</th>
                        <th>FirstName</th>
                        <th>Email Address</th>
                        <th>Home Phone</th>
                        <th>Cell Phone</th>
                        <th>ACBL Number</th>
                        <th>Lists</th>
                    </tr>
                </thead>
                <tbody data-bind="foreach: lists">
                    <tr>
                        <td><a href="#" rel="tooltip" data-bind="click: $parent.EditPerson, attr: {title: Comment}">edit</a></td>
                        <td data-bind="text: LastName"></td>
                        <td data-bind="text: FirstName"></td>
                        <td data-bind="text: EMail"></td>
                        <td data-bind="text: Phone"></td>
                        <td data-bind="text: CellPhone"></td>
                        <td data-bind="text: ACBLNumber"></td>
                        <td style="text-align:center;"><a href="#" data-bind="click: $parent.EditGroups"><span data-bind="text: Lists.length"></span></a></td>
                    </tr>
                </tbody>
            </table>

            <div class="pagination">
                <ul>
                    <li><a href="#" data-bind="click: prevPage">Prev</a></li>
                    <li><a href="#" data-bind="click: nextPage">Next</a></li>
                </ul>
            </div>

            <span data-bind="text: itemCount() + ' Contacts'" style="position:relative; top:-50px; left: 140px;"></span>
            
        </div>

    </div>
    
</div>
