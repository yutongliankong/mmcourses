<cfcomponent>
	<cffunction name="maintenancemodeSet" access="public" returntype="void">
		<cfargument name="maintenancemode" type="boolean" required="yes">
		
		<cfset application.maintenancemode = arguments.maintenancemode>
		
	</cffunction>
</cfcomponent>