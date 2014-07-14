<cfif isdefined("form.btnSubmit")>

	<cfset application.cfc.article.displayhandlerchange(pageid = form.pageid, articleid = form.articleid, displayhandlerid = form.displayhandlerid)>
	
	<script language="javascript">
		window.opener.location.href = window.opener.location.href;
		window.close();
	</script>
	<cfabort>
</cfif>



<cfparam name="url.articleid">
<cfparam name="url.pageid">

<cfset displayhandlerid = application.cfc.article.displayhandlerget(pageid = url.pageid, articleid = url.articleid)>
<cfset qArticleTemplates = application.cfc.displayhandler.get()>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Select Display Template</title>
</head>

<body leftmargin="0" topmargin="2">

<cfform>

	<table style="width: 100%; background-color:Navy">
	<tr><td style="color: White; font-family: Arial; font-weight:bold; font-size: 12px">Select Article Template</td></tr></table>

	<cfinput type="hidden" name="articleid" value="#url.articleid#">
	<cfinput type="hidden" name="pageid" value="#url.pageid#">
	<br />
	<div align="center">
	<cfselect query="qArticleTemplates"
			name="displayhandlerid"
			value="displayhandlerid"
			display="displayhandlername"
			selected="#variables.displayhandlerid#"
			label="Select Display Template:"></cfselect>
			 
	<cfinput type="submit" name="btnSubmit" value="Save">
	</div>
</cfform>

</body>
</html>
