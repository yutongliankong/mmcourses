<cfcomponent>

	<cffunction name="init" access="public" returntype="DisplayHandler" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		
		<cfset instance = structnew()>
		<cfset instance.datasource = arguments.dsn>
	
		<cfreturn this>
	</cffunction>
	
		
	<cffunction name="get" access="public" returntype="query">
		<cfargument name="displayhandlerid" type="numeric"  required="no" default="-1">
		
		<cfset var qresult = "">
		
		<cfquery name="qresult" datasource="#instance.datasource#">
			select *
			from displayhandler
			where endtime is null
			<cfif arguments.displayhandlerid gt -1>
				and displayhandlerid = #arguments.displayhandlerid#
			</cfif>
		</cfquery>
		
		<cfreturn qresult>
	</cffunction>
</cfcomponent>