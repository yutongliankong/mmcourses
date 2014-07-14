<cfset application.cfc.page.rebuildpage(url.pageid)>
<cfset qpage = application.cfc.page.get(url.pageid)>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Publish Page</title>
<script language="javascript">
	<cfoutput>
	window.opener.location.href = '#left(application.basehref,len(application.basehref)-1)##qpage.url##qpage.filename#.cfm';
	window.close();
	</cfoutput>
</script>
</head>

<body>

</body>
</html>
