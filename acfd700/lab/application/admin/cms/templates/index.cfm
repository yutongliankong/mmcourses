
<cfset qtemplates = application.cfc.template.get()>
<cfparam name="form.templateid" default="0">
<cfif isdefined("url.templateid")>
  <cfset form.templateid = url.templateid>
</cfif>

<cfif isdefined("form.btnSubmit")>
	
</cfif>

<cfset qtemplate = application.cfc.template.get(form.templateid)>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Edit Templates</title>
<script language="javascript">
	function fnChangeRecord(templateid) {
		alert(templateid);
	}
</script>
</head>

<body>

<cfform format="flash" width="700" height="500" name="myform">

<cfformitem type="script">
	var fnChangeRecord = function(templateid) {
		getURL('index.cfm?templateid=' + templateid);
	}
</cfformitem>

<cfformgroup type="panel" label="Edit Templates" width="670" height="405">

	
	<cfselect name="templateid" 
				query="qtemplates"
				display="templatename" 
				value="templateid" 
				label="Select Template" onchange="fnChangeRecord(_root.templateid.value)"
				queryPosition="below" width="200" selected="#form.templateid#" >
		<option value="-1">New Template</option>
	</cfselect>
	 
	 <cfformgroup type="tabnavigator">
	 
	 <cfformgroup type="page" label="Name / Image Thumbnail" height="250">
	 
	 <cfinput type="text" name="templatename"  maxlength="50" label="Template Name" value="#qtemplate.templatename#" required="yes" validateat="onsubmit" width="200">

	 <cf_flashupload
	 				name="templatethumbnail"
					actionfile="thumbnailupload.cfm"
					filetypes="*.jpg;"
					maxsize="50"
					swf="#application.basehref#customtags/flashupload/fileupload.swf"
					label="Thumbnail Upload"
					width="600">

				<cf_flashUploadInput
				 uploadButton="true" 
				 uploadButtonLabel="Upload Image" 
				 chooseButtonLabel="Choose file"
				 progressBar="true"
				 progressInfo="true"
				 inputwidth="100"
				 value="#application.basehref#templates/#qtemplate.templatethumbnail#" 
				/>
				 
    </cf_flashupload>

	</cfformgroup>
	
	<cfformgroup type="page" label="Description" height="250">
	<cfmodule template="#application.basehref#customtags/flashrichtext/richtextarea.cfm"
		 inputname="templatedescription"
		 width="600" height="150"
		 value="#qtemplate.templatedescription#"
		 imagepath="#application.basehref#customtags/flashrichtext/"
		 style="cornerRadius:10;marginLeft:5;marginRight:5;dropShadow:true;shadowDistance:3;shadowDirection:right;themeColor:##FFFFFF;" buttonStyle="borderThickness:0;cornerRadius:0;" selectStyle="cornerRadius:0;" />
	  </cfformgroup>
	  </cfformgroup>
		 
	 <cfformgroup type="horizontal" style="horizontalAlign:right;">
		<cfinput type="submit" name="btnSubmit"  value="Save">
		<cfinput type="reset"   name="btnReset" value="Reset">
	 </cfformgroup>
 
 </cfformgroup>  

</cfform>

</body>
</html>
