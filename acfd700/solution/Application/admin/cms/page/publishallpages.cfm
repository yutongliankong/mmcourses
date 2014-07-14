<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

<cfTimer label="Building all pages inline">
<cfset qpages = application.cfc.page.get()>
<cfloop query="qpages">
	<cfset application.cfc.page.rebuildpage(qpages.pageid)>
</cfloop>
</cftimer>

<cftimer label="Building all pages asynchronously">
<h1>Rebuild Asynchronously</h1>
<cfscript>
	stEvent = structnew();
	stEvent.datasource = application.datasource;
	stEvent.basehref = "http://localhost:8500#application.basehref#";
	stEvent.basepath = application.basepath;
</cfscript>
<!--- kick off event --->
<cfset stEvent.method = "rebuildallpages">
<cfset sendGatewayMessage("PublishPages-Solution",stEvent)>
</cftimer>

</body>
</html>
