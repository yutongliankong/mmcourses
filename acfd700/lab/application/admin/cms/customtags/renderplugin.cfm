<cfparam name="attributes.plugin">
<cfparam name="attributes.mode">
<cfparam name="attributes.cache" default="true">


<cfif attributes.mode is "Edit">
		<cftry>
		<cfmodule template="#application.basehref#plugins/#attributes.plugin#">
		<cfcatch type="missinginclude">
			File not found
		</cfcatch>
		</cftry>
<cfelse>
	<cfif attributes.cache>
		<cfmodule template="#application.basehref#plugins/#attributes.plugin#">
	<cfelse>
		<cfscript>
			writeOutput("<cftry><cfmodule template=""#application.basehref#plugins/#attributes.plugin#""><cfcatch type=""any"">An Error Occurred</cfcatch></cftry>");		
		</cfscript>
	</cfif>
</cfif>