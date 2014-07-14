<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<!--- Walkthrough 6-4 --->
<cftry>
	<cfinclude template="nopage.cfm">
	<cfcatch type="any">
		<cfthrow type="ACFD700.#cfcatch.type#" message="#cfcatch.message#" detail="#cfcatch.detail#">
	</cfcatch>
</cftry>


</body>
</html>
