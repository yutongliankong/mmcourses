
<!--- application.cfc --->

<cfcomponent>
	<cfset this.name="acfd700Solution">
	<cfset this.sessionmanagement = "True">
	<cfset this.sessiontimeout = "#createtimespan(0,0,10,0)#">
	<cfset this.ClientManagement = "No">
	<cfset this.LoginStorage="Session">
	<cfset this.setdomainCookies = "Yes">
	<cfset this.scriptProtect = "Yes">
	<cfset this.ApplicationTimeout = "#createtimespan(0,1,0,0)#">
	
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
	

	<cffunction name="CFCInitialize" access="private" returntype="void" hint="Cache CFC in memory" output="false">
	
		<cfset application.cfc = structnew()>
		
		<cfscript>
		   application.cfc.specials = createObject("component","#application.cfcpath#specials").init(application.datasource);
		   application.cfc.reservation = createObject("component","#application.cfcpath#reservation").init(application.datasource);
		   application.cfc.restaurantmenu = createObject("component","#application.cfcpath#restaurantmenu").init(application.datasource);
		   application.cfc.contact = createObject("component","#application.cfcpath#contact").init(application.datasource);
		   application.cfc.reservationorder = createObject("component","#application.cfcpath#reservationorder").init(application.datasource);
	       application.cfc.template = createObject("component","#application.cfcpath#template").init(application.datasource);
		   application.cfc.directory = createObject("component","#application.cfcpath#directory").init(application.datasource);
		   application.cfc.category = createObject("component","#application.cfcpath#category").init(application.datasource);
		   application.cfc.displayhandler = createObject("component","#application.cfcpath#displayhandler").init(application.datasource);
		   application.cfc.page = createObject("component","#application.cfcpath#page").init(application.datasource, application.basepath, "http://" & cgi.http_host & application.basehref);
		   application.cfc.recordlock = createObject("component","#application.cfcpath#recordlock").init();
		   application.cfc.administrator = createObject("component","#application.cfcpath#administrator").init(application.datasource);

		   application.cfc.article = createObject("component","#application.cfcpath#article").init(application.datasource, application.basepath & "xsl\", application.verityarticlecollection);
		</cfscript>
		
		<cfobject component="#application.cfcpath#toolbox" name="application.cfc.toolbox">
		<cfobject component="#application.cfcpath#ExternalSystems" name="application.cfc.ExternalSystems">
		<cfobject component="#application.cfcpath#system" name="application.cfc.system">
		

	</cffunction>

	<cffunction name="datesReset" access="public" output="false" returntype="void">

			<!--- FOR COURSEWARE --->
			<cfquery name="qdates" datasource="#application.datasource#">
				update menudish
				set menudate = '#dateformat(now(),"mm/dd/yyyy")#'
			</cfquery>
	</cffunction>
	
	<cffunction name="onApplicationStart" returntype="boolean" output="false">
		
		<cfset var inipath = findfile("application.ini")>
				
		<cfif not isdefined("application.basehref")>
			<cflog text="Application Startup"
 				type="information"
 				file="#this.name#">
		<cfelse>
			<cflog text="Application Reinitialization"
 				type="information"
 				file="#this.name#">
		</cfif>
		
		<cfset application.basehref = trim(getProfileString(inipath,"Global","basehref"))>
		<cfset application.datasource = trim(getProfileString(inipath,"Global","datasource"))>
		<cfset application.installdir = trim(getProfileString(inipath,"Global","installdir"))>
		<cfset application.lAdministratorIPs = trim(getProfileString(inipath,"Global","lAdministratorIPs"))>
		<cfset application.cfcpath = trim(getProfileString(inipath,"Global","cfcpath"))>
		<cfset application.basepath = left(getDirectoryFromPath(inipath),len(getDirectoryFromPath(inipath))) & "application\">
		<cfset application.verityarticlecollection =  trim(getProfileString(inipath,"Verity","articles"))>
		<cfset application.veritypagecollection =  trim(getProfileString(inipath,"Verity","pages"))>
		
		<cfif not isdefined("application.maintenancemode")>
			<cfset application.maintenancemode = "false">
		</cfif>
		<cfif not isdefined("application.activesessions")>
			<cfset application.activesessions = 0>
		</cfif>
	
		
		<cfset CFCInitialize()>
		<cfset DatesReset()>
		
		<cfreturn true>
	</cffunction>
	

	<cffunction name="onApplicationEnd"  returntype="void" output="false">
  			<cfargument name="AppScope" required="True" />
 
 			 <cflog file="#this.name#" type="information"
						text="Application Shutdown">
	
	</cffunction>

	

	<cffunction name="onRequestStart" returntype="boolean" output="false">
		<cfargument type="String" name="targetPage" required="true" />
		
			<cfif isdefined("url.edit") or cgi.script_name contains "/admin/">
				<cfinclude template="#application.basehref#login/mm_wizard_application_include.cfm">
			</cfif>
			
			<cfif isdefined("url.logout")>
				<cflogout>
			</cfif>
			
			<cfif isdefined("url.init") and url.init is "True">
				<cfset onApplicationStart()>
			</cfif>
		
		<cfreturn true>
	</cffunction>


	
	<cffunction name="onSessionStart" returntype="void" output="false">
		
		<cflock name="CafeTownsendSolution_ActiveSessions"  type="EXCLUSIVE" timeout="5">
			<cfset application.activeSessions = application.ActiveSessions + 1>
  		</cflock>
		
  	</cffunction>
	
	
	<cffunction name="onSessionEnd" returntype="void" output="false">
		<cfargument name="SessionScope" required="True" />
	    <cfargument name="AppScope" required="False" />
	   
		<cflock name="CafeTownsendSolution_ActiveSessions" type="Exclusive" timeout="5">
			<cfset arguments.AppScope.activeSessions = arguments.AppScope.ActiveSessions - 1>
  		</cflock>
		
  	</cffunction>
	
	
</cfcomponent>