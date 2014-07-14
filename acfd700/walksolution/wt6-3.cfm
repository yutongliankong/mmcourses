<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<!--- Walkthrough 6-3 --->
<cftry>
	<!--- <cfinclude template="nofile.cfm"> --->
	<cfset a = b + c>
	<cfcatch type="any">
		<!--- <cfdump var="#cfcatch#"> --->
		Sorry, there was an error. <br />
	</cfcatch>
	
</cftry>
</body>
</html>
