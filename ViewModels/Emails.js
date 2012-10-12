$(document).ready(function () {

    $("#buttonbar").show();
    $("#composepanel").hide();
    $("#sendprogress").hide();

    var vm = {

        itemCount: ko.observable(0),
        pageSize: ko.observable(10),
        pageCount: ko.observable(0),
        currentPage: ko.observable(1),

        groups: ko.observableArray([]),
        selectedGroup: ko.observable(-1),

        lists: ko.observableArray([]),
        filterText: ko.observable(""),
        filter: ko.observable(""),
        addpanelheading: ko.observable("Compose"),

        oID: ko.observable(-1),
        oModuleID: ko.observable(0),
        oCreatedDate: ko.observable(new Date()),
        oCreatedByUser: ko.observable(1),
        oGroupID: ko.observable(-1),
        oTitle: ko.observable(""),
        oMessage: ko.observable(""),
        oSentTo: ko.observable(-1),
        oFrom: ko.observable("debi@fabianbridge.com"),

        getItemCount: function (pg) {

            var _filter = vm.filter();
            if (_filter !== "") {
                _filter = "?" + _filter.substring(1);
            }

            OData.read(_serviceURL + "/GroupMail_History" + _filter, function (data) {
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

            OData.read(_serviceURL + "/GroupMail_History?$skip=" + _skip + "&$top=" + vm.pageSize() + "&$orderby=CreatedDate desc&$expand=List" + vm.filter(), function (data) {
                var array = vm.lists();
                ko.utils.arrayPushAll(array, data.results);
                vm.lists.valueHasMutated();
            });

        },

        loadGroups: function () {

            vm.groups.removeAll();

            OData.read(_serviceURL + "/GroupMail_Groups?$orderby=GroupName", function (data) {
                var array = vm.groups();
                ko.utils.arrayPushAll(array, data.results);
                vm.groups.valueHasMutated();
            });
        },

        nextPage: function () {
            if (vm.currentPage() < vm.pageCount()) {
                vm.currentPage(vm.currentPage() + 1);
                vm.loadData();
            }
        },

        prevPage: function () {
            if (vm.currentPage() > 1) {
                vm.currentPage(vm.currentPage() - 1);
                vm.loadData();
            }
        },

        compose: function () {
            vm.addpanelheading("Compose New Email");

            $("#buttonbar").hide();
            $("#composepanel").show("fast");
        },

        cancelAdd: function () {
            vm.clearFields();
            $("#composepanel").hide("fast");
            $("#buttonbar").show();
            $("#txtFilter").addClass("input-medium");
        },

        editMail: function (item) {
            vm.addpanelheading("Edit Email");

            vm.oID(item.ItemID);
            vm.oModuleID(item.ModuleID),
            vm.oCreatedDate(item.CreatedDate),
            vm.oCreatedByUser(item.CreatedByUser),
            vm.oGroupID(item.GroupID),
            vm.oTitle(item.Title),
            vm.oMessage(item.Message),
            vm.oSentTo(item.Message),

            $("#buttonbar").hide();
            $("#composepanel").show("fast");
        },

        saveMail: function () {

            $("#composepanel").hide();
            $("#sendprogress").show();

            //var _method = "POST";
            //var _url = _serviceURL + "/GroupMail_History";

            //if (vm.oID() !== -1) {
            //    _method = "MERGE";
            //    _url = _serviceURL + "/GroupMail_History(" + vm.oID() + ")";
            //}

            //var data = {
            //    ItemID: vm.oID,
            //    ModuleID: 0,
            //    CreatedDate: new Date(),
            //    CreatedByUser: 1,
            //    GroupID: vm.oGroupID,
            //    Title: vm.oTitle,
            //    Message: vm.oMessage,
            //    SentTo: vm.oSentTo
            //};

            //var request = {
            //    requestUri: _url,
            //    method: _method,
            //    data: data
            //};

            //OData.request(request, function (data) {
            //    vm.currentPage(1);
            //    vm.cancelAdd();
            //    vm.loadData();
            //});

        },

        setFilter: function () {
            if (vm.filterText() !== "") {
                vm.filter("&$filter=startswith(Title,'" + vm.filterText() + "') eq true");
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
            vm.oModuleID(0);
            vm.oCreatedDate(new Date());
            vm.oCreatedByUser(1);
            vm.oGroupID(-1);
            vm.oTitle("");
            vm.oMessage("");
            vm.oSentTo(-1);
            vm.selectedGroup(-1);
        }

    };

    // Activates knockout.js
    ko.applyBindings(vm);

    vm.getItemCount(1);
    vm.loadGroups();
});