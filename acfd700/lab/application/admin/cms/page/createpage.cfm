
<cfscript>
	qtemplates = application.cfc.template.get();
	qdirectories = application.cfc.directory.get();
	qcategories = application.cfc.category.get();
</cfscript>

<cfif isdefined("form.btnSave")>
	<cfset theurl = application.cfc.page.pagecreate(filename = form.filename, templateid = form.templateid, directoryid = form.directoryid, pagetitle = form.pagetitle, keywords = form.keywords, description = form.description, bIncludeInSiteMap = form.bIncludeInSitemap, releasedate = form.releasedate, updateuser = "sdrucker")>
	
	<cfoutput>

	<script language="javascript">
		window.opener.location.href = '#left(application.basehref,len(application.basehref)-1)##theurl#?edit=1';
		window.close();
	</script>
	</cfoutput>
	<cfabort>
	
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Lab 8-1: Create New Page</title>
</head>
<body>


<!--- lab 8 starts here --->
	


</body>
</html>
