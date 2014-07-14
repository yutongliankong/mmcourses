<!--- Unit 2: application.cfc --->

<cfcomponent>
	<!--- walkthrough 2-1: Configure application settings --->
	
	
	
	
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