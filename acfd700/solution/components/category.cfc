<cfcomponent>

	<cffunction name="init" access="public" returntype="Category" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		<cfset datasource = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="Get" access="public" returntype="query">
		<cfargument name="categoryid" type="numeric" required="no" default="0">
	
		<cfset var qresult = "">
		
		<cfquery name="qresult" datasource="#datasource#">
			select *
			from category
			where endtime is null
			<cfif arguments.categoryid gt 0>
			   and categoryid  = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.categoryid#">
			</cfif>
			order by categoryname
		</cfquery>
	
		<cfreturn qResult>
	</cffunction>
</cfcomponent>