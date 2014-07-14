<!---
	Name:			flashUpload.cfm
	Author:			Nahuel Foronda & Laura Arguello
	Created:		August 07, 2005
	This work is licensed under the Creative Commons Attribution-ShareAlike License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/2.5/ or send a letter to Creative Commons, 543 Howard Street, 5th Floor, San Francisco, California, 94105, USA.

Please keep this notice to comply with license
------------------------------------------------------------------------------------------------------------------------------------------------
	
	Attributes:
			inputWidth: with of the text input where file name is shown
			buttonStyle: style applied to choose and upload buttons
			uploadButton: true/false, default true. Adds an upload button. If you set it false, you must put the generated variable called "theNameOfYourInput_uploadScript" in some other button ("theNameOfYourInput" is the name assigned in the flashUpload tag name attribute)
			progressBar: true/false default true. Adds a progress bar.
			progressInfo: true/false default true. Adds an output area to show progress info
			progressBarStyle: style of progress bar
			uploadButtonLabel: label of "Upload" button
			chooseButtonLabel: label of "File browse" button

--->

<cfparam name="attributes.inputWidth" default="" />
<cfparam name="attributes.buttonStyle" default="" />
<cfparam name="attributes.uploadButton" default="true" type="boolean" />
<cfparam name="attributes.progressBar" default="true" type="boolean" />
<cfparam name="attributes.progressInfo" default="true" type="boolean" />
<cfparam name="attributes.progressBarStyle" default="border-thickness:0;corner-radius: 0;fill-colors: ##00CCFF, ##0075D9;theme-color: ##00CCFF; border-color:##00CCFF;" />
<cfparam name="attributes.uploadButtonLabel" default="Upload" />
<cfparam name="attributes.chooseButtonLabel" default="Choose File" />

<cfset data = GetBaseTagData("cf_flashUpload")/>

<cfset name = data.attributes.name />
<cfset fileDescription = data.attributes.fileDescription />
<cfset fileTypes = data.attributes.fileTypes />
<cfset label = data.attributes.label />
<cfset actionFile = data.attributes.actionFile />
<cfset maxSize = data.attributes.maxSize />
<cfset swf = data.attributes.swf />
<cfset width = data.attributes.width />

<cfsavecontent variable="uploadScript">
	<cfoutput>var uploadSwf = #name#_textArea.label.upload;
	uploadSwf.upload("#actionFile#");</cfoutput>
</cfsavecontent>

<cfsavecontent variable="swftag"><cfoutput><p><img id="upload" hspace="0" vspace="0" src="#swf#"></p></cfoutput></cfsavecontent>

<cfsavecontent variable="browseScript">
	<cfoutput>var uploadSwf = #name#_textArea.label.upload;
	<cfif attributes.progressInfo>var output = #name#_output;</cfif>
	var uploadListener = {};
	<cfif attributes.progressBar>var progressBar = #name#_progressBar;
	var totalWidth = #name#_progressBarBackground.width;</cfif>
	var fileNameField = #name#;
	<cfif attributes.uploadButton>var uploadBtn = #name#_uploadBtn;</cfif>
	<cfif maxSize EQ -1>var maxSize;<cfelse>var maxSize = 1024*#maxSize#;</cfif>
	uploadSwf.addListener(uploadListener);
	uploadSwf.browse([{description: "#fileDescription#", extension: "#fileTypes#"}]);
	
	_global.MathNumberParse= function(n)
	{
		return (n >> 0)+"."+ (Math.round(n*100)%100);
	}
	uploadListener.onSelect = function(selectedFile)
	{
		if(selectedFile.size < maxSize || maxSize == undefined)
		{
			<cfif attributes.uploadButton>uploadBtn.enabled = true;</cfif>
			<cfif attributes.progressInfo>output.text = "";</cfif>
		}
		else 
		{
			<cfif attributes.progressInfo>output.text = "The file selected exceeds maximum allowed size";</cfif>
			<cfif attributes.uploadButton>uploadBtn.enabled = false;</cfif>
		}
		fileNameField.text = selectedFile.name;
	}
	<cfif attributes.progressInfo>
	
	var fileNameField = fileNameField;
	var myform = myform;
	
	uploadListener.onComplete = function()
	{
		output.text = "Upload complete";
		// display uploaded image
		myform.picture = fileNameField.text;
	}
	</cfif>
	uploadListener.onProgress = function(fileRef, bytesLoaded, bytesTotal)
	{
		<cfif attributes.progressBar>progressBar.visible = true;</cfif>
		var kLoaded = bytesLoaded/1024;
		var kTotal = bytesTotal/1024;
		var loaded = (kLoaded < 1024) ? _global.MathNumberParse(kLoaded) + " KB": _global.MathNumberParse(kLoaded/1024) + " MB";
		var total = (kTotal < 1024) ? _global.MathNumberParse(kTotal) + " KB": _global.MathNumberParse(kTotal/1024) + " MB";
		var percentage = Math.round(bytesLoaded * 100 / bytesTotal);
		<cfif attributes.progressInfo>output.text = percentage+ "% uploaded - ";
		output.text += loaded + " of " + total;
		</cfif>
		<cfif attributes.progressBar>progressBar.width = totalWidth / 100 * percentage;</cfif>
	}
	<cfif attributes.progressInfo>
	uploadListener.onSecurityError = function(fileRef,errorString)
	{
		output.text = "Security Error: "+ errorString;
	}
	uploadListener.onIOError = function(fileRef)
	{
		output.text = "IO Error";
	}
	uploadListener.onHTTPError = function(fileRef,errorNumber)
	{
		output.text = "HTTP Error number:" + errorNumber;

	}
	uploadListener.onCancel = function()
	{
		output.text = "Action cancelled";
	}</cfif>
	</cfoutput>
</cfsavecontent>

<cfswitch expression="#ThisTag.ExecutionMode#">

<!--- Start tag processing --->
	<cfcase value="start">
	<cfformgroup type="horizontal" width="#width#"  label="#label#">
		
			<cfif len(attributes.inputWidth)>
				<cfinput type="text" name="#name#" width="#attributes.inputWidth#" />
			<cfelse>
				<cfinput type="text" name="#name#"  />
			</cfif>		
						
			<cfinput type="button"  
				name="#name#_browseBtn"  
				onclick="#browseScript#"
				value="#attributes.chooseButtonLabel#" style="#attributes.buttonStyle#" />
				
			<cfif attributes.uploadButton>
					<cfinput type="button" 
					name="#name#_uploadBtn"
					 disabled="true" 
					 style="#attributes.buttonStyle#" 
					 onclick="#uploadScript#" value="#attributes.uploadButtonLabel#" />
			</cfif>
			<cftextarea name="#name#_textArea" disabled="true" visible="false" width="0" bind="{(#name#_textArea.html = true) ? '#swftag#' : ''}" height="0"></cftextarea>
					
					<!---- display uploaded image here --->
					<cfformitem type="html"
						height="100" 
						width="75" bind="<img src='{myform.picture}'>"></cfformitem>
	
					<cfinput type="hidden" name="picture" value="#attributes.value#" />
		</cfformgroup>
		
		<cfif attributes.progressBar OR attributes.progressInfo>
			<cfformgroup type="vbox" style="verticalGap:0; indicatorGap:0; marginLeft:12;">
				<cfif attributes.progressBar><cfinput type="text" height="1" visible="false" name="#name#_progressBarBackground">
				<cfinput type="button"  height="16" width="0" visible="false" name="#name#_progressBar" style="#attributes.progressbarStyle#"/></cfif>		
				<cfif attributes.progressInfo><cfinput type="text" name="#name#_output" disabled="true" style="borderStyle:none; disabledColor:##333333;backgroundAlpha:0;"></cfif>
			</cfformgroup>
		</cfif>
		
	
	
	</cfcase>
	
	
	  
 <!--- End tag processing --->
  <cfcase value="end">
  	<!--- just in case they need to put the upload button somewhere else --->
	<cfset varName = name & "_uploadScript" />
  	<cfset caller[varName] = uploadScript />
  </cfcase>
  
  </cfswitch>
  