<cfcomponent extends="mmcourses.acfd700.lab.ApplicationProxy">

	<cffunction name="onRequest" returntype="boolean">
		<!--- Unit 2 Lab --->
		<cfargument name="targetpage" type="string" required="true" />
		
		<cfif not application.maintenancemode or application.lAdministratorIP contains cgi.remote_addr>
			<cfinclude template="#arguments.targetpage#">
		<cfelse>
			<cfinclude template="#application.basehref#systemdown.cfm">
		</cfif>
		
		<cfreturn true>
	</cffunction>

</cfcomponent>