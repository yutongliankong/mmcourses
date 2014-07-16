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
	<cffunction name="onError" returntype="void">
		<cfargument	 name="Exception" required="true">
		<cfargument name="EventName" required="true" type="String">
		<cflog file="#this.name#" type="error" text="#arguments.EventName# | #arguments.Exception.message#">
		<cfif arguments.EventName NEQ "onSessionEnd" AND arguments.EventName NEQ "onApplicationEnd">
			<cfmodule template="customtags/error.cfm" Exception="Exception" EventName="EventName">
		</cfif>

	</cffunction>

</cfcomponent>