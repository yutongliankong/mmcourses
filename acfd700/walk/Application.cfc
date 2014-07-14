<!--- Unit 2: application.cfc --->

<cfcomponent>
	<!--- walkthrough 2-1: Configure application settings --->
	<cfset this.name="acfd700_walkthrough2" >
	<cfset this.sessionManagement="true" >
	<cfset this.sessionTimeout=createTimeSpan(0, 0, 20, 0) >
	<cfset this.clientManagement="false" >
	<cfset this.loginStorage="Session" >
	<cfset this.setDomainCookies="Yes" >
	<cfset this.scriptprotect="None" >
	<cfset this.applicationTimeout=createTimeSpan(0, 1, 0, 0) >

	<!--- onApplicationStart event --->
	<cffunction name="onApplicationStart" returnTyoe="Boolean">
		<cfset var inipath=findfile("Application.ini")>
		<cfset application.basehref = trim(getProfileString(inipath, "Global", "basehref")) >
		
		<cfset application.datasource = trim(getProfileString(inipath,"Global","datasource"))>
		<cfset application.installdir = trim(getProfileString(inipath,"Global","installdir"))>
		<cfset application.lAdministratorIPs = trim(getProfileString(inipath,"Global","lAdministratorIPs"))>
		<cfset application.cfcpath = trim(getProfileString(inipath,"Global","cfcpath"))>
		<cfset application.basepath = left(getDirectoryFromPath(inipath),len(getDirectoryFromPath(inipath))-1) & "application\">
		<cfset application.verityarticlecollection =  trim(getProfileString(inipath,"Verity","articles"))>
		<cfset application.veritypagecollection =  trim(getProfileString(inipath,"Verity","pages"))>
		<cfset application.maintenancemode = "true">

		<cflog type="information" file="#this.name#" text="application startup">
		<cfreturn true>
	</cffunction>

	<!--- onApplicationEnd event--->
	<cffunction name="onApplicationEnd" returnType="void">
		<cfargument name="AppScope" required="true">
		<cflog file="#this.name#" type="information" text="application shutdown">
	</cffunction>
	
	<!--- general support function --->
	<cffunction name="findfile" access="private" returntype="string">
		<cfargument type="string" name="filename" required="yes">
	
		<cfset var root = listfirst(expandpath('.'),"\") & "\">
		<cfset var path = "">
		<cfset var filespec = expandpath('.') & "\" & arguments.filename>
		
		<cfif not fileexists(filespec)>
			<cfloop condition="true">
				<cfset path = path & "..\">
				<cfset filespec = expandpath(path) & "\" & arguments.filename>
				<cfif fileExists(filespec)>
					<cfbreak>
				</cfif>
				<cfif path is root>
					<cfthrow message="File #arguments.filename# not found">
				</cfif>
			</cfloop>
		</cfif>
		<cfreturn filespec>
	</cffunction>  
	
	<!--- walkthrough 5-4: Persisting CFC instances --->
	

	<!--- walkthrough 2-2: Initialize Application Variables from an .INI file --->

	
	<!--- walkthrough 2-3: Using Request Events --->
	
	
	<!--- Walkthrough 2-4.: Using onSessionStart, onSessionEnd --->


	<!--- Walkthrough 6-4:  Exception Handling Framework --->

	
</cfcomponent>