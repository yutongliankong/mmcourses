<!--- Unit 2: application.cfc --->

<cfcomponent>
	<!--- walkthrough 2-1: Configure application settings --->
	<cfset this.name="acfd700_walkthrough3" >
	<cfset this.sessionManagement="true" >
	<cfset this.sessionTimeout=createTimeSpan(0, 0, 20, 0) >
	<cfset this.clientManagement="false" >
	<cfset this.loginStorage="Session" >
	<cfset this.setDomainCookies="Yes" >
	<cfset this.scriptprotect="None" >
	<cfset this.applicationTimeout=createTimeSpan(0, 1, 0, 0) >

	
	


	
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
	<cffunction name="cfcInitialize" access="private" hint="Cache CFCS in memory" returntype="void">
		<cfset application.cfc = structNew()>
		<cfobject component="#application.cfcpath#specials" name="application.cfc.specials">
		<cfset application.cfc.specials.init(application.datasource)>
	</cffunction>

	<!--- walkthrough 2-2: Initialize Application Variables from an .INI file --->
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

		<cfif not isDefined("application.activesessions")>
			<cfset application.activesessions = 0>
		</cfif>
		<cflog type="information" file="#this.name#" text="application startup">
		<cfset cfcInitialize()>
		<cfreturn true>
	</cffunction>

	<!--- onApplicationEnd event--->
	<cffunction name="onApplicationEnd" returnType="void">
		<cfargument name="AppScope" required="true">
		<cflog file="#this.name#" type="information" text="application shutdown">
	</cffunction>
	
	<!--- walkthrough 2-3: Using Request Events --->
	<!--- onRequestStart event--->
	<cffunction name="onRequestStart" returntype="Boolean">
		<cfargument name="targetpage" type="String" required="true">
		<cfif isDefined("URL.init")>
			<cfset onApplicationStart()>

		</cfif>
		<cfreturn true>
	</cffunction>

	<!--- onrequest event--->
	<cffunction name="onRequest" returntype="Boolean">
		<cfargument name="targetpage" type="String" required="true">
		<cfif NOT application.maintenancemode OR application.lAdministratorIPs CONTAINS cgi.REMOTE_ADDR>
			<cfinclude template="#arguments.targetpage#">
		<cfelse>
			<cfinclude template="#application.basehref#/systemdown.cfm">
		</cfif>
		<cfreturn true>
	</cffunction>
	
	<!--- Walkthrough 2-4.: Using onSessionStart, onSessionEnd --->
	<!--- onsessionstart --->
	<cffunction name="onSessionStart" returntype="void">
		<cflock name="cafetownsendwalk_activesessions" timeout="5" type="exclusive">
			<cfset application.activesessions = application.activesessions + 1>
		</cflock> 
	</cffunction>
	<!--- onsessionend event--->
	<cffunction name="onSessionEnd" returntype="void">
		<cfargument name="SessionScope" required="true" />
		<cfargument name="AppScope" required="false" />
		<cflock name="cafetownsendwalk_activesessions" timeout="5" type="exclusive">
	
		</cflock>
		<cfset arguments.AppScope.activesessions = arguments.AppScope.activesessions - 1>
	</cffunction>
	<!--- Walkthrough 6-4:  Exception Handling Framework --->
	<cffunction name="onError" returntype="void">
		<cfargument name="Exception" required="true">
		<cfargument name="EventName" required="true" type="string">
		<cflog file="ACFD700Lab" type="error" text="#arguments.eventname#|#arguments.exception.message#">
		<cfif arguments.EventName NEQ "onSessionEnd" AND arguments.EventName NEQ "onApplicationEnd">
			<cfoutput>
				ERROR TYPE: #exception.rootcause.type#<BR><BR>
				ERROR MESSAGE:#exception.rootcause.message#<br><BR>
				ERROR DETAIL: #exception.rootcause.detail#
			</cfoutput>
		</cfif>
		<cfif structkeyexists(arguments.exception,"rootcause")>
			<cfif arguments.exception.rootcause.type contains "cafetownsend.search.googlesearch">
				<cfoutput>
				Google Search could not be run. Please contact your system Administrator
				</cfoutput>
			</cfif>
		</cfif>
	</cffunction>
	
</cfcomponent>