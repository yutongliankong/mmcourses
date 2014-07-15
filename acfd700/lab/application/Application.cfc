<cfcomponent extends="mmcourses.acfd700.lab.ApplicationProxy">

	<cffunction name="onRequest" returntype="boolean">
		<!--- Unit 2 Lab --->
		<cfargument name="targetpage" type="String" required="true"/>
		<cfif NOT application.maintenancemode or application.lAdministratorIPs contains cgi.REMORE_ADDR>
			<cfinclude template="#arguments.targetpage#">
		<cfelse>
			<cfinclude template="#application.basehref#systemdown.cfm" >
		</cfif>
		<cfreturn true>
	</cffunction>

	<!--- Walkthrough 6-2 --->


</cfcomponent>