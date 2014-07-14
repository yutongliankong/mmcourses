<cfcomponent>

	<cffunction name="init" access="public" returntype="Directory" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		<cfset datasource = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="Get" access="public" returntype="query">
		<cfargument name="directoryid" type="numeric" required="no" default="0">
	
		<cfset var qresult = "">
		
		<cfquery name="qresult" datasource="#datasource#">
			select *
			from directory
			where endtime is null
			<cfif arguments.directoryid gt 0>
			   and directoryid  = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.directoryid#">
			</cfif>
		</cfquery>
	
		<cfreturn qresult>
	</cffunction>
</cfcomponent>