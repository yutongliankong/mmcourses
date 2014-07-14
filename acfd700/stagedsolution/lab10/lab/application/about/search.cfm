<cfparam name="form.searchtype" default="0">
<cfparam name="form.searchterms" default="">

<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="Search our site">

<div style="font-family: arial; font-size: 10px;">
	<cfform>
		<cfinput type="radio" name="searchtype" value="0" checked="#iif(form.searchtype is 0,de("true"),de("false"))#">Search Google
		<cfinput type="radio" name="searchtype" value="1" checked="#iif(form.searchtype is 1,de("true"),de("false"))#">Search this site (Verity) <br >
		
		Enter search term(s): 
		<cfinput type="text" name="searchterms" required="Yes" message="You must enter search terms" value="#form.searchterms#"> 
		<cfinput type="submit" name="btnSubmit" value="Search">
	
	</cfform>

	<cfif isdefined("form.btnSubmit")>
		
		<hr>		
		<cfif form.searchtype is 0><!--- google search --->
				
				<!--- lab 11: Step 4 starts here --->
			   <cfobject component="#application.cfcpath#search"
						  name="cfcSearch">
				
			   <cfset aResults = cfcSearch.googleSearch(searchquery = form.searchterms)>
						
			   <cfoutput>
					<ol style="font-family:Arial, Helvetica, sans-serif">
					<cfloop from="1" to="#arraylen(aresults)#" index="i">
						<li><a href="#aresults[i].url#">#aresults[i].title#</a>
						#paragraphformat(aresults[i].description)#
						</li>
					</cfloop>	
					</ol>	
			</cfoutput>
		<cfelse> <!--- verity search --->

			<!--- Lab 11: Step 12 starts here --->
			
			<cfinvoke webservice="http://localhost:8500/mmcourses/acfd700/lab/components/search.cfc?wsdl"
				method="veritysearch"
				returnvariable="aResults">
			
				<cfinvokeargument name="maxrows" value="3" />
				<cfinvokeargument name="collection" value="#application.veritypagecollection#" />
				
			</cfinvoke>
			
			<cfset alength = arraylen(aResults)>
			<cfoutput>
			<cfloop from="1" to="#alength#" index="i">
				<a href="#aResults[i].url#">#aResults[i].title#</a><br />
				#aResults[i].summary# <br /><br />
			</cfloop>
			</cfoutput>
		</cfif>
	</cfif>
</div>

</cfmodule>
