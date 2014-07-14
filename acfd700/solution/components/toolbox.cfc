<cfcomponent>
	<cffunction name="query2array" access="public" returntype="array" output="false">
		<cfargument name="qdata" type="query" required="yes">
		
		<cfset var i = "0">
		<cfset var stdata = structnew()>
		<cfset var thiscolumn = "">
		<cfset var aresult = arraynew(1)>
		
		<cfloop from="1" to="#qdata.recordcount#" index="i">
			<cfset stdata = structnew()>
			<cfloop list="#qdata.columnlist#" index="thiscolumn">
				<cfset stdata[thiscolumn] = qdata[thiscolumn][i]>
			</cfloop>
			<cfset arrayAppend(aresult,stdata)>
		</cfloop>
		
		<cfreturn aResult>
	</cffunction>
	
	
	<cffunction name="xmlUnFormat" access="public" returntype="string" output="false">
		<cfargument name="sInput" type="string" required="yes">
		
		<cfset var result = sInput>
		
		<cfscript>
		result=ReplaceNoCase(result,"&apos;","'","ALL");
		result=ReplaceNoCase(result,"&quot;","""","ALL");
		result=ReplaceNoCase(result,"&lt;","<","ALL");
		result=ReplaceNoCase(result,"&gt;",">","ALL");
		result=ReplaceNoCase(result,"&amp;","&","ALL");
		</cfscript>
		
		<cfreturn result>
	</cffunction>

	<cffunction name="htmlCompressFormat" access="Public" returntype="string" output="false">
		<cfargument name="sInput" type="string" required="Yes">

		<cfset var level = 2>
   		<cfif arrayLen( arguments ) GE 2 AND isNumeric(arguments[2])>
			level = arguments[2];
		</cfif>
   		<cfset sInput = trim(sInput)>
   		<cfswitch expression="#level#">
			<cfcase value="3">
			 <cfscript>
			  sInput = reReplace( sInput, "[[:space:]]{2,}", " ", "all" );
        			  sInput = replace( sInput, "> <", "><", "all" );
         			  sInput = reReplace( sInput, "<!--[^>]+>", "", "all" );
 			 </cfscript>
			</cfcase>
			<cfcase value="2">
			  <cfset sInput = reReplace( sInput, "[[:space:]]{2,}", chr( 13 ), "all" )>
			</cfcase>
			<cfcase value="1">
			   <cfset sInput = reReplace( sInput, "(" & chr( 10 ) & "|" & chr( 13 ) & ")+[[:space:]]{2,}", chr( 13 ), "all" )>
			</cfcase>
		</cfswitch>
        		<cfreturn sInput>
	</cffunction>
	
</cfcomponent>