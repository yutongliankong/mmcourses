
<!--- lab 3 --->

<cfparam name="url.date" default="#dateformat(now(),"mm/dd/yyyy")#">

<!--- as a best practice, the query would be embedded within a CFC (unit 5)
<cfset qmenu = application.cfc.restaurantmenu.get(menudate = url.date)>
--->

<cfquery name="qmenu" datasource="#application.datasource#">
	select 	dish.dishname, 
				dish.dishdescription,
				menudish.price,
				menudish.specialprice,
				menutype.menutype,
				dishtype.dishtypename
	from dishtype, menutype, dish, menudish
	where menudish.dishtypeid = dishtype.dishtypeid
	and menudish.dishid = dish.dishid
	and menudish.menutypeid = menutype.menutypeid
	and menudish.menudate = <cfqueryparam cfsqltype="cf_sql_date" value="#url.date#">
	and menudish.endtime is null
	order by menutype.menutypesortorder,dishtype.dishtypesortorder, dishname
</cfquery>

<!--- Output MenuType --->

<cfoutput query="qmenu" group="menutype">
	<h1 class="menu_title" align="center">
		Cafe Townsend #qmenu.menutype# Menu for #url.date#
	</h1>
	<cfoutput group="dishtypename">
		<div class="menu_title">#qmenu.dishtypename#</div>
		<cfoutput>
			<div>
			<em>#qmenu.dishname# - #qmenu.specialprice#</em> <br />
			#paragraphformat(qmenu.dishdescription)#	
			</div>
		</cfoutput>
		<cfif qmenu.currentrow is not (qmenu.recordcount - 1)>
		<div align="center">
			<img src="#application.basehref#images/menu_divider.gif">
		</div>
		</cfif>
	</cfoutput>
	
</cfoutput>