﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="About.ascx.cs" Inherits="Gooddogs.Modules.Dnn.BridgeMail.Views.About" %>

<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement"
    Assembly="DotNetNuke.Web.Client" %>

<dnn:dnnjsinclude priority="60" id="viewmodel" runat="server" filepath="~/DesktopModules/BridgeMail/ViewModels/About.js"
    forceprovider="DnnFormBottomProvider" />
	
<div class="container">

    <div class="row-fluid">
    
        <div class="mbClear span8">

            <span class="Head">BridgeMail</span><br />
            <p>(c) Copyright 2012 Gooddogs.com<br />
            All Rights Reserved.<br /><br />
            Change the text above, and this text to reflect whatever information you want to provide your Users
            when they visit this 'About' page. You could also use this page to display Latest Development News
            or Release Notes. I would also suggest displaying links to support resources for your module.
            </p>

        </div>

   
        <div class="mbClear span4">

            <span class="Head">MODULE INFO</span><br />
            Module Asssembly Verison <span data-bind="text: version"></span>

        </div>

    </div>

</div>