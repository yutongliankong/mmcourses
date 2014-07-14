<cfcomponent>
	<cffunction name="init" access="public" returntype="administrator" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		
		<cfset instance = structnew()>
		<cfset instance.datasource = arguments.dsn>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="authenticate" access="public" returntype="struct" output="false">
		<cfargument name="username" type="string" required="Yes">
		<cfargument name="password" type="string" required="Yes">
		
		<cfset var q = "">
		<cfset var stResult = structnew()>
		
		<cfquery name="q" datasource="#instance.datasource#">
			select	 administrator.username, 
						administrator.password, 
						administrator.administratorRole,
						administrator.contactid,
						contact.lastname,
						contact.firstname,
						contact.email,
						contact.bizphone
			from 	administrator, contact
			where 	administrator.contactid = contact.contactid
						and administrator.username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.username#">
						and administrator.password =  <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.password#">
						and administrator.endtime is null
						and contact.endtime is null
		</cfquery>
				
		<cfif q.recordcount is 1>
			<cfscript>
					session.user = structnew();
					session.user.userid = arguments.username;
					session.user.name = q.firstname & " " & q.lastname;
					session.user.email = q.email;
					session.user.firstname = q.firstname;
					session.user.lastname = q.lastname;			
					session.user.contactid = q.contactid;
			</cfscript>
			<cfset stResult.status = "True">
			<cfset stResult.lroles = q.administratorRole>
		<cfelse>
			<cfset stResult.status = "False">
		</cfif>
		
		<cfreturn stResult>
	
	</cffunction>
	
</cfcomponent>

