


<!--- get xml packet containing breakfast, lunch, or dinner specials based on time of day --->
<cfset aresult = application.cfc.specials.dailySpecials_GetCurrentAsXML()>

<cfset menutype = aresult[1].xmlAttributes.type>

<!--- output list of special entrees only --->
<cfif arraylen(aresult) gt 0>
	<cfoutput><h3>#variables.menutype# Entree Specials</h3></cfoutput>
</cfif>

<!--- use xpath to filter down so we only are left with an array of dishes --->
<cfset aEntrees = xmlSearch(aresult[1],"/restaurantspecials/menu/dishtype[@type='Entree']/dish/")>

<cfif arraylen(aEntrees) is  0>
	No specials today!
<cfelse>
	<!--- Build Array of Attributes --->
	<cfset anames = xmlSearch(aEntrees[1],"/restaurantspecials/menu[@type='#variables.menutype#']/dishtype[@type='Entree']/dish//name/text()")>
	<cfset aprices = xmlSearch(aEntrees[1],"/restaurantspecials/menu[@type='#variables.menutype#']/dishtype[@type='Entree']/dish//price/text()")>
	<cfset adescriptions = xmlSearch(aEntrees[1],"/restaurantspecials/menu[@type='#variables.menutype#']/dishtype[@type='Entree']/dish//description/text()")>
	 
	<!--- output results --->
	<cfoutput>
	<cfloop from="1" to="#arraylen(aNames)#" index="i">
		<strong>#anames[i].xmlvalue#</strong> - #dollarformat(aprices[i].xmlvalue)#<br />
		#paragraphformat(adescriptions[i].xmlvalue)#
	</cfloop>
	</cfoutput>
</cfif>


