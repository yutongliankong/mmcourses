

   <html>
   <head><title>Oops!  You encountered an error!</title></head>
   <body>
   
  Sorry, an error occurred!  Please try again!
  
  <cftry>

 <cflog  log="APPLICATION" 
	type="Error" 
	application="yes" 
    text="#error.diagnostics#, #error.httpReferer#, #error.template##error.querystring#">
   
  <cfif isdefined("application.lAdministratorIPs") and listfind(application.lAdministratorIPs,cgi.REMOTE_ADDR) gt 0>
		<div style="font-family:Arial; font-size: 10px">
		<CFOUTPUT>     
			<h3>Diagnostic Information:</h3>
			#error.diagnostics#
			<h3>Generated Content</h3>
			#error.generatedContent#
			<h3>Referring Page:</h3>
			#error.httpReferer#
			<h3>Template in Error:</h3>
			#error.template#?#error.querystring#
		</CFOUTPUT>
		</div>
	</cfif>
	
	<cfcatch type="any"><!--- nowhere to go -- complete system failure --->
	</cfcatch>
</cftry>
</body>
</html>
