<!--- Unit 2: application.cfc --->

<cfcomponent>
	<!--- walkthrough 2-1: Configure application settings --->
	<cfset this.name = "acfd700_walkthrough">
	<cfset this.sessionmanagement = "True">
	<cfset this.sessiontimeout = createtimespan(0,0,20,0)>
	<cfset this.clientmanagement = "False">
	<cfset this.loginstorage = "Session">
	<cfset this.setDomainCookies = "Yes">
	<cfset this.scriptProtect="None">
	<cfset this.ApplicationTimeout=createtimespan(0,1,0,0)>
		
	<!--- general support function --->
	<cffunction name="findfile" access="private" returntype="string">
		<cfargument type="string" name="filename" required="yes" />
	
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
	
	
	<!--- walkthrough 2-2: Initialize Application Variables from an .INI file --->
	<cffunction name="onApplicationStart" returntype="Boolean">
		
		<cfset var iniPath = findfile("Application.ini")>
		<cfset application.basehref = trim(getProfileString(iniPath,"Global","basehref"))>
		<cfset application.datasource = trim(getProfileString(inipath,"Global","datasource"))>
		<cfset application.installdir = trim(getProfileString(inipath,"Global","installdir"))>
		<cfset application.lAdministratorIPs = trim(getProfileString(inipath,"Global","lAdministratorIPs"))>
		<cfset application.cfcpath = trim(getProfileString(inipath,"Global","cfcpath"))>
		<cfset application.basepath = left(getDirectoryFromPath(inipath),len(getDirectoryFromPath(inipath))-1) & "application\">
		<cfset application.verityarticlecollection =  trim(getProfileString(inipath,"Verity","articles"))>
		<cfset application.veritypagecollection =  trim(getProfileString(inipath,"Verity","pages"))>
	
		<cfset application.maintenancemode = "true">
		
		<cflog text="Application Startup" type="Information" file="#this.name#">
		
		<cfif not isdefined("application.activesessions")>
			<cfset application.activesessions = 0>
		</cfif>
		
		<cfreturn "true">
	
	</cffunction>
	
	<cffunction name="onApplicationEnd" returntype="Void">
		<cfargument name="ApplicationScope" required="True" />
		
		<cflog text="Application Shutdown" type="Information" file="#this.name#">
	
	</cffunction>	
	
	
	<!--- walkthrough 2-3: Using Request Events --->
	<cffunction name="onRequestStart" returntype="Boolean">
		<cfargument name="targetpage" type="string" required="true" />
	
		<cfif isdefined("url.init")>
			<cfset onApplicationStart()>
		</cfif>
		
		<cfreturn "true">
	</cffunction>
	
	<cffunction name="onRequest" returntype="boolean">
		<cfargument name="targetpage" type="string" required="true" />
		
		<cfif not application.maintenancemode or
				application.ladministratorips contains cgi.remote_addr>
				<cfinclude template="#arguments.targetpage#">
		<cfelse>		
			<cfinclude template="#application.basehref#systemdown.cfm">
		</cfif>
	
		<cfreturn "true">
	</cffunction>
	

	
	<!--- Walkthrough 2-4.: Using onSessionStart, onSessionEnd --->
	
	<cffunction name="onSessionStart" returntype="void">
		<cflock name="CafeTownsendWalk_ActiveSessions" type="Exclusive" timeout="5">
			<cfset application.activesessions = application.activesessions + 1>
		</cflock>
	</cffunction>
	
	<cffunction name="onSessionEnd" returntype="Void">
		<cfargument name="sessionscope" required="true" />
		<cfargument name="applicationscope" required="false" />
		
		<cflock name="CafeTownsendWalk_ActiveSessions" type="Exclusive" timeout="5">
			<cfset arguments.applicationscope.activesessions = arguments.applicationscope.activesessions - 1>
		</cflock>
	</cffunction>

	<!--- Walkthrough 6-4:  Exception Handling Framework --->
	
	<cffunction name="onError" returntype="void">
			 <cfargument name="Exception" required="true"/>
			 <cfargument name="EventName" type="String" required="true"/>
	
			 <!--- lab 6 --->
			 <cflog file="acfd700lab" type="error"
			 		text="#arguments.eventname#|#arguments.exception.message#">

			 <!--- log the error --->
			 <cfif structkeyexists(arguments.exception,"rootcause")>
				  <cfif arguments.exception.rootcause.type is "ACFD700.MissingInclude">
					  <cfoutput>
						ERROR TYPE: #exception.rootcause.type#<BR><BR>
						ERROR MESSAGE:#exception.rootcause.message#<br><BR>
						ERROR DETAIL: #exception.rootcause.detail#
					  </cfoutput>							
				  </cfif>
				  <cfif arguments.exception.rootcause.type contains "cafetownsend.search.googlesearch">
				  	<cfoutput>Google search could not be run. Please contact your system administrator</cfoutput>
				  </cfif>
			  </cfif>

	</cffunction>

</cfcomponent>