<cflog type="error" log="application" application="yes" text="#error.diagnostics#, #error.httpreferer#, #error.template#, #error.querystring#">
<cfif structKeyExists(application,"lAdministratorIPs") and listFind(application.lAdministratorIPs,cgi.REMOTE_ADDR) gt 0>
	<cfoutput>
		<h3>Diagnostic Information:</h3>
		#error.diagnostics#
		<h3>Generated Content:</h3>
		#error.generatedContent#
		<h3>Referring Page:</h3>
		#error.httpReferer#
		<h3>Template in Error:</h3>
		#error.template#?#error.querystring#
	</cfoutput>
</cfif>
<html>
   <head><title>Oops!  You encountered an error!</title></head>
   <body>
	   
  	Sorry, an error occurred!  Please try again!
  
	globalerrorhandler

	</body>
</html>
<cfdump var="#error#">