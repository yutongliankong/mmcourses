<cfcomponent>
	<cffunction name="googleSearch" access="public" returntype="array" output="false">
		<cfargument name="searchquery" required="yes" type="string" hint="Google Search Expression">
		<cfargument name="maxresults" required="no" type="numeric" default="10">
		
		<cfset var objGoogleSearchResult = "">
		<cfset var aResults = arraynew(1)>
		<cfset var aData = arraynew(1)>
		<cfset var stData = structnew()>
		
		<!--- lab 11 starts here --->
		<cfinvoke 
	 		webservice="http://localhost:8500/mmcourses/acfd700/solution/components/googlesearch.wsdl"
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
	

	<cffunction name="veritySearch" access="remote" returntype="array" output="false">
		<cfargument name="searchquery" required="yes" type="string" hint="Verity Search Expression">
		<cfargument name="maxrows" required="no" type="numeric" default="10">
		<cfargument name="collection" required="no" type="string" default="#application.veritypagecollection#">
		
		<cfset var qresults = "">
		
		<cftry>
		<cfsearch collection="#arguments.collection#"
					 criteria="#arguments.searchquery#"
					 maxrows="#arguments.maxrows#"
					 name="qresults">
		
				 
		<cfcatch type="any"> <!--- reindex and search --->
		
			<cfcollection action="CREATE" 
					collection="#arguments.collection#"
					path="#expandpath('.')#">		
			
			<cfindex type="PATH"
				 collection="#arguments.collection#"
				 action="update"
				 key="#application.basepath#"
				 urlpath="#application.basehref#"
				 recurse="yes">
				 
			<cfsearch collection="#arguments.collection#"
					 criteria="#arguments.searchquery#"
					 maxrows="#arguments.maxrows#"
					 name="qresults">
		</cfcatch>
		</cftry>
		
		<cfreturn application.cfc.toolbox.query2array(qresults)>
		
	</cffunction>
	
	
</cfcomponent>