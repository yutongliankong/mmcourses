<cfcomponent>	
	<!--- Unit 2 lab: Application preferences --->

	
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
		

		
		<cfreturn true>
	</cffunction>

	
	<cffunction name="onRequestStart" returntype="boolean">
		<!--- Unit 2 Lab --->
	
		<cfreturn true>
	</cffunction>
	
	
	<cffunction name="onSessionEnd" returntype="void">
		<cfargument name="SessionScope" required="True" />
	    <cfargument name="AppScope" required="False" />
		<!--- Unit 2 Lab --->
  
  	</cffunction>
	

	<cffunction name="onSessionStart" returntype="void">
		
		<!--- unit 2 lab --->
		
  
  	</cffunction>
	
	
</cfcomponent>	