<cf_accelerate cachedwithin="#createtimespan(0,0,1,0)#" secondarykey="restaurantmenuoutput">

<cfparam name="url.date" default="#dateformat(now(),"mm/dd/yyyy")#">

<cfset qmenu = application.cfc.restaurantmenu.get(menudate = url.date)>

<cfoutput query="qmenu" group="menutype">
	
	<h1 align="center" class="menu_title">Cafe Townsend #qmenu.menutype# Menu for #url.date#</h1>

	<cfoutput group="dishtypename">
	<div class="menu_title">#qmenu.dishtypename#</div>
		<cfoutput>
	 	<div class="menu" align="center"><em>#qmenu.dishname# - #qmenu.specialprice#</em><br />
				#paragraphformat(qmenu.DishDescription)#
		</div>
		</cfoutput>
		<cfif qmenu.currentrow is not  (qmenu.recordcount - 1)>
			<div align="center"><img src="#application.basehref#images/menu_divider.gif"></div>
		</cfif>
	</cfoutput>
</cfoutput>

</cf_accelerate>
