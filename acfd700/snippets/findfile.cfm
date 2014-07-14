<cffunction name="findfile" access="private" returntype="string" hint="Creeps up directory tree looking for specified file name">
	<cfargument type="string" name="filename" required="yes">

	<cfset var root = listfirst(expandpath('.'),"\") & "\">
	<cfset var path = "">
	<cfset var filespec = expandpath('.') & "\" & arguments.filename>
	
	<cfif not fileExists(filespec)>
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
	