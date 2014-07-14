<cfcomponent extends="mmcourses.acfd700.solution.ApplicationProxy">

 	<cffunction name="onRequest" returntype="boolean">
		<cfargument type="String" name="targetPage" required="true" />
	
		<cfif not application.maintenancemode or application.lAdministratorIPs CONTAINS cgi.REMOTE_ADDR>
				<cfinclude template="#arguments.targetpage#">
		<cfelse>
				<cfinclude template="#application.basehref#systemdown.cfm">
		</cfif>
			
		<cfreturn true>
	</cffunction> 

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
  		   <cfif arguments.exception.rootcause.type contains 
                              "cafetownsend.search.googlesearch">
				<cfoutput>
				Google search could not be run. Please contact your system administrator
				</cfoutput>

			</cfif>
		  </cfif>
	</cffunction>

</cfcomponent>