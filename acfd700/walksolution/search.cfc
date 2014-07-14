<cfcomponent>
	<cffunction name="googleSearch" access="public" returntype="array" output="false">
		<cfargument name="searchquery" required="yes" type="string" hint="Google Search Expression">
		<cfargument name="maxresults" required="no" type="numeric" default="10">
		
		<cfset var objGoogleSearchResult = "">
		<cfset var aResults = arraynew(1)>
		<cfset var aData = arraynew(1)>
		<cfset var stData = structnew()>
		
		<cfinvoke 
	 		webservice="http://localhost:8500/mmcourses/acfd700/walk/googlesearch.wsdl"
			method="doGoogleSearch"
	 		returnvariable="objGoogleSearchResult">
				<cfinvokeargument name="key" value="fqPS0exQFHK8HHOjNk0XXHgfXuNCu67o"/>
				<cfinvokeargument name="q" value="#arguments.searchquery#"/>
				<cfinvokeargument name="start" value="0"/>
				<cfinvokeargument name="maxResults" value="#arguments.maxresults#"/>
				<cfinvokeargument name="filter" value="false"/>
				<cfinvokeargument name="restrict" value=""/>
				<cfinvokeargument name="safeSearch" value="false"/>
				<cfinvokeargument name="lr" value=""/>
				<cfinvokeargument name="ie" value="latin1"/>
				<cfinvokeargument name="oe" value="latin1"/>
		</cfinvoke>
		
		<cfset aResults = objGoogleSearchResult.getResultElements()>
		<cfloop from="1" to="#arraylen(aresults)#" index="i">
			<cfset stData = structnew()>`
			<cfset obj = aresults[i]>
			<cfset stdata.title = obj.getTitle()>
			<cfset stData.url = obj.getUrl()>
			<cfset stData.description = obj.getSnippet()>
			<cfset arrayappend(adata,stData)>
		</cfloop>
		
		<cfreturn aData>
	</cffunction>
</cfcomponent>