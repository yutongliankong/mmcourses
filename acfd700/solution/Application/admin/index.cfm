<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="Cafe Townsend Administration">

	<h2>Administrative Utilities</h2>
	<cfinvoke component="Application"
		method="getProperties"
		returnvariable="stData">
		
	<cfdump var="#stData#">
</cfmodule>