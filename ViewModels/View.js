$(document).ready(function () {

    $("#buttonbar").show();
    $("#addpanel").hide();
    $("#memberspanel").hide();

    var vm = {

        lists: ko.observableArray([]),
        group: ko.observable({}),

        nonmembers: ko.observableArray([]),
        members: ko.observableArray([]),
        selectedNonMembers: ko.observableArray([]),
        selectedMembers: ko.observableArray([]),

        filterText: ko.observable(""),
        filter: ko.observable(""),
        addpanelheading: ko.observable("Add New Mailing List"),
        memberspanelheading: ko.observable("Manage Members"),

        oID: ko.observable(-1),
        oListName: ko.observable(""),

        loadData: function () {

            vm.lists.removeAll();
            OData.read(_serviceURL + "/GroupMail_Groups?$expand=People&$orderby=GroupName" + vm.filter(), function (data) {
                var array = vm.lists();
                ko.utils.arrayPushAll(array, data.results);
                vm.lists.valueHasMutated();
            });

        },

        setFilter: function () {
            if (vm.filterText() !== "") {
                vm.filter("&$filter=startswith(GroupName,'" + vm.filterText() + "') eq true");
                vm.loadData();
            }
        },

        clearFilter: function () {
            vm.filterText("");
            vm.filter("");
            vm.loadData();
        },

        addList: function () {
            vm.addpanelheading("Add New Mailing List");
            $("#btnDeletePerson").hide();

            $("#buttonbar").hide();
            $("#addpanel").show("fast");
        },

        editList: function (item) {
            vm.addpanelheading("Edit List Name");
            $("#btnDeletePerson").show();

            vm.oID(item.ItemID);
            vm.oListName(item.GroupName);

            $("#buttonbar").hide();
            $("#addpanel").show("fast");
        },

        manageMembers: function(item) {
            vm.memberspanelheading("Manage '" + item.GroupName + "' Members");

            vm.oID(item.ItemID);
            vm.oListName(item.GroupName);

            vm.loadListBoxes();

            $("#buttonbar").hide();
            $("#memberspanel").show("fast");
        },

        loadListBoxes: function () {
            vm.nonmembers.removeAll();
            vm.members.removeAll();

            // get all the members for the current group
            OData.read(_serviceURL + "/GroupMail_Groups(" + vm.oID() + ")?$expand=People", function (data) {
                vm.group(data);
                var array = vm.members();
                ko.utils.arrayPushAll(array, data.People);
                vm.members.valueHasMutated();

                // now load all the non-members
                OData.read(_serviceURL + "/GoupMail_Person?$expand=Lists&$orderby=LastName,FirstName", function (data) {
                    var array2 = vm.nonmembers();
                    $.each(data.results, function (idx, item) {
                        if (vm.findMember(item.LastName + ", " + item.FirstName) === null) {
                            array2.push(item);
                        }
                    });
                    vm.nonmembers.valueHasMutated();
                });
            });
        },

        findMember: function(name) {
            return ko.utils.arrayFirst(vm.members(), function(item) {
                return item.LastName + ", " + item.FirstName === name;
            });
        },

        addSome: function () {
            var _msg = "";
            $.each(vm.selectedNonMembers(), function (idx, item) {
                var personid = item.ItemID;
                var groupid = vm.group().ItemID;
                OData.read(_serviceURL + "/AssignToGroup?pid='" + personid + "'&gid='" + groupid + "'", function (data) {
                    vm.members.valueHasMutated();
                    vm.nonmembers.valueHasMutated();
                });
            });
            vm.loadListBoxes();
            vm.loadData();
        },

        removeSome: function () {
            var _msg = "";
            $.each(vm.selectedMembers(), function (idx, item) {
                var personid = item.ItemID;
                var groupid = vm.group().ItemID;
                OData.read(_serviceURL + "/RemoveFromGroup?pid='" + personid + "'&gid='" + groupid + "'", function (data) {
                    vm.members.valueHasMutated();
                    vm.nonmembers.valueHasMutated();
                });
            });
            vm.loadListBoxes();
            vm.loadData();
        },

        saveList: function () {
            
            var _method = "POST";
            var _url = _serviceURL + "/GroupMail_Groups";

            if (vm.oID() !== -1) {
                _method = "MERGE";
                _url = _serviceURL + "/GroupMail_Groups(" + vm.oID() + ")";
            }

            var data = {
                ItemID: vm.oID(),
                ModuleID: 0,
                CreatedDate: new Date(),
                CreatedByUser: 1,
                GroupName: vm.oListName()
            };

            var request = {
                requestUri: _url,
                method: _method,
                data: data
            };

            OData.request(request, function (data) {
                vm.cancelAdd();
                vm.loadData();
            }, function (err) {
                alert("Unable to save new list: " + err);
            });

        },

        cancelAdd: function () {
            vm.clearFields();
            $("#addpanel").hide("fast");
            $("#memberspanel").hide("fast");
            $("#buttonbar").show();
            $("#txtFilter").addClass("input-medium");
        },

        clearFields: function () {
            vm.oID(-1);
            vm.oListName("");
        }

    };

    // Activates knockout.js
    ko.applyBindings(vm);

    vm.loadData();
	
});