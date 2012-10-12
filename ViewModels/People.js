$(document).ready(function () {

    $("#buttonbar").show();
    $("#addpersonpanel").hide();
    $("#memberspanel").hide();

    var vm = {

        itemCount: ko.observable(0),
        pageSize: ko.observable(10),
        pageCount: ko.observable(0),
        currentPage: ko.observable(1),

        nonmembers: ko.observableArray([]),
        members: ko.observableArray([]),
        selectedNonMembers: ko.observableArray([]),
        selectedMembers: ko.observableArray([]),
        membersPanelHeader: ko.observable(""),

        lists: ko.observableArray([]),
        filterText: ko.observable(""),
        filter: ko.observable(""),
        addpanelheading: ko.observable("Add New Person"),
        
        oID: ko.observable(-1),
        oLastName: ko.observable(""),
        oFirstName: ko.observable(""),
        oEMail: ko.observable(""),
        oComment: ko.observable(""),
        oPhone: ko.observable(""),
        oCellPhone: ko.observable(""),
        oACBLNumber: ko.observable(""),
        oCity: ko.observable(""),
        oState: ko.observable(""),
        oLists: ko.observableArray([]),

        person: ko.observable({}),

        isLoading: ko.observable(false),

        getItemCount: function (pg) {

            var _filter = vm.filter();
            if (_filter !== "") {
                _filter = "?" + _filter.substring(1);
            }

            OData.read(_serviceURL + "/GoupMail_Person"+ _filter, function (data) {
                vm.itemCount(data.results.length);
                vm.pageCount(vm.itemCount() / vm.pageSize());

                if (pg === 1) {
                    vm.currentPage(1);
                    vm.loadData();
                }
            });


        },

        loadData: function () {

            var _skip = (vm.currentPage() - 1) * vm.pageSize();

            vm.lists.removeAll();

            OData.read(_serviceURL + "/GoupMail_Person?$skip=" + _skip + "&$top=" + vm.pageSize() + "&$orderby=LastName,FirstName&$expand=Lists" + vm.filter(), function (data) {
                var array = vm.lists();
                ko.utils.arrayPushAll(array, data.results);
                vm.lists.valueHasMutated();
            });

        },

        nextPage: function () {
            if (vm.currentPage() < vm.pageCount()) {
                vm.currentPage(vm.currentPage() + 1);
                vm.loadData();
            }
        },

        prevPage: function() {
            if (vm.currentPage() > 1) {
                vm.currentPage(vm.currentPage() - 1);
                vm.loadData();
            }
        },

        addPerson: function () {
            vm.addpanelheading("Add New Person");
            $("#btnDeletePerson").hide();

            $("#buttonbar").hide();
            $("#addpersonpanel").show("fast");
        },

        cancelAdd: function () {
            vm.clearFields();
            $("#addpersonpanel").hide("fast");
            $("#memberspanel").hide("fast");
            $("#buttonbar").show();
            $("#txtFilter").addClass("input-medium");
        },

        EditPerson: function (item) {
            vm.person(item);
            vm.addpanelheading("Edit Person");
            $("#btnDeletePerson").show();

            vm.oID(item.ItemID);
            vm.oLastName(item.LastName);
            vm.oFirstName(item.FirstName);
            vm.oEMail(item.EMail);
            vm.oComment(item.Comment);
            vm.oPhone(item.Phone);
            vm.oCellPhone(item.CellPhone);
            vm.oACBLNumber(item.ACBLNumber);
            vm.oCity(item.City);
            vm.oState(item.State);
            vm.oLists(item.Lists);

            $("#buttonbar").hide();
            $("#addpersonpanel").show("fast");
        },

        EditGroups: function (item) {
            vm.person(item);
            vm.loadGroupListBoxes(item.ItemID);
            vm.membersPanelHeader("List Membership for " + item.FirstName + " " + item.LastName);
            $("#buttonbar").hide();
            $("#memberspanel").show("fast");
        },

        loadGroupListBoxes: function (pid) {
            vm.isLoading(true);
            vm.nonmembers.removeAll();
            vm.members.removeAll();

            // get all the members for the current group
            OData.read(_serviceURL + "/GoupMail_Person(" + pid + ")?$expand=Lists", function (data) {
                var array = vm.members();
                ko.utils.arrayPushAll(array, data.Lists);
                vm.members.valueHasMutated();

                // now load all the non-members
                OData.read(_serviceURL + "/GroupMail_Groups?$orderby=GroupName", function (data) {
                    var array2 = vm.nonmembers();
                    $.each(data.results, function (idx, item) {
                        if (vm.findMember(item.GroupName) === null) {
                            array2.push(item);
                        }
                    });
                    vm.nonmembers.valueHasMutated();
                    vm.isLoading(false);
                });
            });
        },

        findMember: function (name) {
            return ko.utils.arrayFirst(vm.members(), function (item) {
                return item.GroupName === name;
            });
        },

        addSome: function () {
            var _msg = "";
            $.each(vm.selectedNonMembers(), function (idx, item) {
                var personid = vm.person().ItemID;
                var groupid = item.ItemID;               
                OData.read(_serviceURL + "/AssignToGroup?pid='" + personid + "'&gid='" + groupid + "'", function (data) {
                    vm.members.valueHasMutated();
                    vm.nonmembers.valueHasMutated();
                    if (vm.isLoading() === false) {
                        vm.loadGroupListBoxes(vm.person().ItemID);
                    }
                });
            });
            
            vm.loadData();
        },

        removeSome: function () {
            var _msg = "";
            $.each(vm.selectedMembers(), function (idx, item) {
                var personid = vm.person().ItemID;
                var groupid = item.ItemID;
                OData.read(_serviceURL + "/RemoveFromGroup?pid='" + personid + "'&gid='" + groupid + "'", function (data) {
                    vm.members.valueHasMutated();
                    vm.nonmembers.valueHasMutated();
                    if (vm.isLoading() === false) {
                        vm.loadGroupListBoxes(vm.person().ItemID);
                    }
                });
            });
            
            vm.loadData();
        },

        deletePerson: function() {
            var _method = "DELETE";
            var _url = _serviceURL + "/GoupMail_Person(" + vm.oID() + ")";

            var data = {
                Id: vm.oID()
            };

            var request = {
                requestUri: _url,
                method: _method,
                data: data
            };

            var _confirm = confirm("Delete " + vm.oFirstName() + " " + vm.oLastName() + "?")
            if (_confirm) {
                OData.request(request, function (data) {
                    vm.currentPage(1);
                    vm.cancelAdd();
                    vm.loadData();
                });
            }
        },

        savePerson: function() {
    
            var _method = "POST";
            var _url = _serviceURL + "/GoupMail_Person";

            if (vm.oID()!==-1) {
                _method = "MERGE";
                _url = _serviceURL + "/GoupMail_Person(" + vm.oID() + ")";
            }

            var data = {
                ItemID: vm.oID,
                ModuleID: 0,
                CreatedDate: new Date(),
                CreatedByUser: 1,
                FirstName: vm.oFirstName(),
                LastName: vm.oLastName(),
                EMail: vm.oEMail(),
                Comment: vm.oComment(),
                Phone: vm.oPhone(),
                City: vm.oCity(),
                State: vm.oState(),
                CellPhone: vm.oCellPhone(),
                ACBLNumber: vm.oACBLNumber()
            };

            var request = {
                requestUri: _url,
                method: _method,
                data: data
            };

            OData.request(request, function (data) {
                vm.currentPage(1);
                vm.cancelAdd();
                vm.loadData();
            });

        },

        setLNFilter: function () {
            if (vm.filterText()!=="") {
                vm.filter("&$filter=startswith(LastName,'" + vm.filterText() + "') eq true");
                vm.currentPage(1);
                vm.loadData();
            }
        },

        setFNFilter: function () {
            if (vm.filterText() !== "") {
                vm.filter("&$filter=startswith(FirstName,'" + vm.filterText() + "') eq true");
                vm.currentPage(1);
                vm.loadData();
            }
        },

        clearFilter: function () {
            vm.filterText("");
            vm.filter("");
            vm.currentPage(1);
            vm.loadData();
        },

        clearFields: function () {
            vm.oID(-1);
            vm.oLastName("");
            vm.oFirstName("");
            vm.oEMail("");
            vm.oComment("");
            vm.oPhone("");
            vm.oCellPhone("");
            vm.oACBLNumber("");
            vm.oCity("");
            vm.oState("");
        }

    };

    // Activates knockout.js
    ko.applyBindings(vm);

    vm.getItemCount(1);
});