<cfcomponent>	
	<!--- Unit 2 lab: Application preferences --->
	<cfset this.name = "acfd700-lab">
	<cfset this.sessionmanagement = "true">
	
	<!--- findfile support function to location application.ini file on disk --->
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
				<cfif thedir is root>
					<cfthrow message="File #arguments.filename# not found">
				</cfif>
			</cfloop>
		</cfif>
		<cfreturn filespec>
	</cffunction>  
	
	
	<cffunction name="onApplicationStart" returntype="boolean">
		
		<!--- Unit 2 Lab --->
		<cfset var iniPath = findFile("Application.ini")>
		<cfset application.basehref = trim(getProfileString(iniPath,"Global","basehref"))>
		<cfset application.datasource = trim(getProfileString(inipath,"Global","datasource"))>
		<cfset application.installdir = trim(getProfileString(inipath,"Global","installdir"))>
		<cfset application.lAdministratorIPs = trim(getProfileString(inipath,"Global","lAdministratorIPs"))>
		<cfset application.cfcpath = trim(getProfileString(inipath,"Global","cfcpath"))>
		<cfset application.basepath = left(getDirectoryFromPath(inipath),len(getDirectoryFromPath(inipath))-1) & "application\">
		<cfset application.verityarticlecollection =  trim(getProfileString(inipath,"Verity","articles"))>
		<cfset application.veritypagecollection =  trim(getProfileString(inipath,"Verity","pages"))>

		<cfif not isdefined("application.maintenancemode")>
			<cfset application.maintenancemode = "False">
		</cfif>
		
		<cfif not isdefined("application.activesessions")>
			<cfset application.activeSessions = 0>
		</cfif>
		<!--- Walkthrough 5-4 --->		
		
		<cfreturn true>
	</cffunction>

	
	<cffunction name="onRequestStart" returntype="boolean">
		<!--- Unit 2 Lab --->
		<cfargument type="string" name="targetpage" required="true" />
		
		<cfif isdefined("url.init")>
			<cfset onApplicationStart()>
		</cfif>
		
		<cfreturn true>
	</cffunction>
	
	
	<cffunction name="onSessionEnd" returntype="void">
		<cfargument name="SessionScope" required="True" />
	    <cfargument name="ApplicationScope" required="False" />
		<!--- Unit 2 Lab --->
  	
		<cflock name="cafetownsendlab" timeout="5" type="exclusive">
		<cfset arguments.applicationscope.activesessions = arguments.applicationscope.activesessions - 1>
  		</cflock>	
  	</cffunction>
	

	<cffunction name="onSessionStart" returntype="void">
		
		<!--- unit 2 lab --->
		<cflock name="cafetownsendlab" timeout="5" type="exclusive">
		<cfset application.activeSessions = application.activeSessions + 1>
  		</cflock>
  	</cffunction>
	
	
</cfcomponent>	