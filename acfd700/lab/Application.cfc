<cfcomponent>	
	<!--- Unit 2 lab: Application preferences --->
	<cfset this.name = "acfd700_lab">
	<cfset this.sessionmanagement = "true">
	
	<!--- findfile support function to location application.ini file on disk --->
	<cffunction name="findfile" access="private" returntype="string" output="false">
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
	
	<!--- lab 5: Initialize Component Instances  --->
	
	
	
	<cffunction name="onApplicationStart" returntype="boolean">
		
		<!--- Unit 2 Lab --->
		<cfset var iniPath = findfile("Application.ini")>
		<cfset application.basehref = trim(getProfileString(inipath, "Global", "basehref"))>
		
		<cfset application.datasource = trim(getProfileString(inipath,"Global","datasource"))>
		<cfset application.installdir = trim(getProfileString(inipath,"Global","installdir"))>
		<cfset application.lAdministratorIPs = trim(getProfileString(inipath,"Global","lAdministratorIPs"))>
		<cfset application.cfcpath = trim(getProfileString(inipath,"Global","cfcpath"))>
		<cfset application.basepath = left(getDirectoryFromPath(inipath),len(getDirectoryFromPath(inipath))-1) & "\application\">
		<cfset application.verityarticlecollection =  trim(getProfileString(inipath,"Verity","articles"))>
		<cfset application.veritypagecollection =  trim(getProfileString(inipath,"Verity","pages"))>

		<cfif NOT structKeyExists(application, "maintenancemode")>
			<cfset application.maintenancemode = "false">
		</cfif>
		<cfif NOT structKeyExists(application, "activeSessions")>
			<cfset application.activeSessions = "0">
		</cfif>
		<cfreturn true>
	</cffunction>

	
	<cffunction name="onRequestStart" returntype="boolean">
		<!--- Unit 2 Lab --->
		<cfargument name="targetpage" type="String" required="true" />
		<cfif isDefined("URL.init")>
			<cfset onApplicationStart()>
		</cfif>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="onRequest" returntype="boolean">
		<cfargument name="targetpage" type="String" required="true"/>
		<cfif NOT application.maintenancemode or application.lAdministratorIPs contains cgi.REMORE_ADDR>
			<cfinclude template="#arguments.targetpage#">
		<cfelse>
			<cfinclude template="#application.basehref#systemdown.cfm" >
		</cfif>
		<cfreturn true>
	</cffunction> 
	
	<cffunction name="onSessionEnd" returntype="void">
		<cfargument name="SessionScope" required="True" />
	    <cfargument name="AppScope" required="False" />
		<!--- Unit 2 Lab --->
  		<cflock name="cafetownsendlab_activesessions" type="exclusive" timeout="5">
			<cfset arguments.AppScope.activeSessions = arguments.AppScope.activeSessions - 1>
		</cflock>
  	</cffunction>
	

	<cffunction name="onSessionStart" returntype="void">
		<cflock name="cafetownsendlab_activesessions" type="exclusive" timeout="5">
			<cfset application.activeSessions = application.activeSessions + 1>
		</cflock>
		
		<!--- unit 2 lab --->
		
  
  	</cffunction>
	
	
</cfcomponent>	