<cfcomponent>

	<cffunction name="init" access="public" returntype="Template" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		<cfset datasource = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="Get" access="public" returntype="query">
		<cfargument name="templateid" type="numeric" required="no" default="0">
	
		<cfset var qresult = "">
		
		<cfquery name="qresult" datasource="#datasource#">
			select *,  
			'#application.basehref#templates/' + templatethumbnail as templateThumbnailImageUrl, templatename + '-' + templatedescription as fulldescription
			from template
			where endtime is null
			<cfif arguments.templateid gt 0>
			   and templateid  = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.templateid#">
			<cfelseif arguments.templateid is -1>
				and templateid = -1
			</cfif>
		</cfquery>
	
		<cfreturn qResult>
	</cffunction>
</cfcomponent>