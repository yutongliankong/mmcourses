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
	<cffunction name="cfcInitialize" access="private" returnType="Void">
		
		<cfset application.cfc = structnew()>
		<cfset application.cfc.specials = createObject("component","#application.cfcpath#specials").init(application.datasource)>
		<cfset application.cfc.reservation = createObject("component","#application.cfcpath#reservation").init(application.datasource)>
		<cfset application.cfc.restaurantmenu = createObject("component","#application.cfcpath#restaurantmenu").init(application.datasource)>
		<cfset application.cfc.contact = createObject("component","#application.cfcpath#contact").init(application.datasource)>
		<cfset application.cfc.reservationorder = createObject("component","#application.cfcpath#reservationorder").init(application.datasource)>
		<cfset application.cfc.template = createObject("component","#application.cfcpath#template").init(application.datasource)>
		<cfset application.cfc.directory = createObject("component","#application.cfcpath#directory").init(application.datasource)>
		<cfset application.cfc.category = createObject("component","#application.cfcpath#category").init(application.datasource)>
		<cfset application.cfc.displayhandler = createObject("component","#application.cfcpath#displayhandler").init(application.datasource)>
		<cfset application.cfc.page = createObject("component","#application.cfcpath#page").init(application.datasource, application.basepath, "http://" & cgi.http_host & application.basehref)>
		<cfset application.cfc.recordlock = createObject("component","#application.cfcpath#recordlock").init()>
		<cfset application.cfc.administrator = createObject("component","#application.cfcpath#administrator").init(application.datasource)>
		<cfset application.cfc.article = createObject("component","#application.cfcpath#article").init(application.datasource, application.basepath & "xsl\", application.verityarticlecollection)>
		
		<cfobject component = "#application.cfcpath#toolbox"
				  name="application.cfc.toolbox">
				  
		<cfobject component="#application.cfcpath#ExternalSystems" 	name="application.cfc.ExternalSystems">
		<cfobject component="#application.cfcpath#system" 			name="application.cfc.system">

	</cffunction>
	
	
	<cffunction name="onApplicationStart" returntype="boolean">
		
		<!--- Unit 2 Lab --->
		<cfset iniPath = findFile("Application.ini")>
		<cfset application.basehref = trim(getProfileString(inipath,"Global","basehref"))>
		<cfset application.datasource = trim(getProfileString(inipath,"Global","datasource"))>
		<cfset application.installdir = trim(getProfileString(inipath,"Global","installdir"))>
		<cfset application.lAdministratorIPs = trim(getProfileString(inipath,"Global","lAdministratorIPs"))>
		<cfset application.cfcpath = trim(getProfileString(inipath,"Global","cfcpath"))>
		<cfset application.basepath = left(getDirectoryFromPath(inipath),len(getDirectoryFromPath(inipath))-1) & "\application\">
		<cfset application.verityarticlecollection =  trim(getProfileString(inipath,"Verity","articles"))>
		<cfset application.veritypagecollection =  trim(getProfileString(inipath,"Verity","pages"))>

		<cfif not isdefined("application.maintenancemode")>
			<cfset application.maintenancemode = "false">
		</cfif>	
		
		<cfif not isdefined("application.activeSessions")>
			<cfset application.activeSessions = 0>
		</cfif>

		<cfset cfcInitialize()>
		
		<cfreturn true>
	</cffunction>

	
	<cffunction name="onRequestStart" returntype="boolean">
		<!--- Unit 2 Lab --->
		<cfargument name="targetpage" type="string" required="true" />
		
		<cfif isdefined("url.edit") or cgi.script_name contains "/admin/">
			<cfinclude template="#application.basehref#login/mm_wizard_application_include.cfm">
		</cfif>
		
		<cfif isdefined("url.logout")>
			<cflogout>
		</cfif>
		
		<cfif isdefined("url.init")>
			<cfset onApplicationStart()>
		</cfif>
		
		<cfreturn true>
	</cffunction>
	
	
	<cffunction name="onSessionEnd" returntype="void">
		<cfargument name="SessionScope" required="True" />
	    <cfargument name="appScope" required="False" />
		<!--- Unit 2 Lab --->
  		<cflock name="cafetownsendlab_activesessions" type="exclusive" timeout="5">
			<cfset arguments.appScope.activeSessions = arguments.appScope.activeSessions - 1>
		</cflock>
  	</cffunction>
	

	<cffunction name="onSessionStart" returntype="boolean">
		
		<!--- unit 2 lab --->
		<cflock name="cafetownsendlab_activesessions" type="exclusive" timeout="5">
			<cfset application.activeSessions = application.activeSessions + 1>
  		</cflock>
		
  		<cfreturn "True">
  	</cffunction>
	
	
</cfcomponent>	