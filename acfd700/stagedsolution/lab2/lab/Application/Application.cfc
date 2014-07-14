<cfcomponent extends="mmcourses.acfd700.lab.ApplicationProxy">

	<cffunction name="onRequest" returntype="boolean">
		<!--- Unit 2 Lab --->
		<cfargument name="targetpage" type="string" required="true">
		
		<cfif not application.maintenanceMode or application.lAdministratorIPs contains cgi.REMOTE_ADDR>
			<cfinclude template="#arguments.targetpage#">
		<cfelse>
			<cfinclude template="#application.basehref#systemdown.cfm">
		</cfif>
		
		<cfreturn true>
	</cffunction>

	<!--- Walkthrough 6-2 --->


</cfcomponent>