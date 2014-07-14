<cfcomponent>

	<!--- Walkthrough 11-2: Retrieving and Parsing an XML Document --->
	<cffunction name="ExternalXML_GetViaHTTP" access="public" returntype="xml">
		<cfargument name="url" 
		 type="string" required="yes" hint="URL of XML feed" 
		 default="http://p.moreover.com/page?o=rss002&c=Consumer:%20food%20and%20drink%20news">
	
		
		<cfset var xNews = "">
		<cfset var stValid = structnew()>
		
		<cfhttp method="get"
				url="#arguments.url#">
		</cfhttp>
		
		<cfset xNews = xmlParse(cfhttp.FileContent,"no")>
			
		<cfreturn xnews>
	</cffunction>
	
	<!--- Walkthrough 11-3: Validation --->
	<cffunction name="ExternalXML_GetFile" access="public" returntype="xml">
		<cfargument name="filespec"  
			type="string" 
			required="yes"
			hint="Full windows filepath to XML file" 
			default="#expandpath('.')#news.xml">
	
		<cfset var xNews = "">
		
		<cffile action="read" file="#arguments.filespec#" variable="xNews">
		
		<cfset xNews = xmlParse(xNews)>
		
		<cfreturn xnews>
	</cffunction>
	
</cfcomponent>