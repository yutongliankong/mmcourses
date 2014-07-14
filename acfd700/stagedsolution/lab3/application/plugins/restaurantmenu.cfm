
<!--- lab 3 --->

<cfparam name="url.date" default="#dateformat(now(),"mm/dd/yyyy")#">

<!--- as a best practice, the query would be embedded within a CFC (unit 5)
<cfset qmenu = application.cfc.restaurantmenu.get(menudate = url.date)>
--->

<cfquery name="qmenu" datasource="acfd700-lab">
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
	order by menutype.menutype,dishtype.dishtypesortorder, dishname
</cfquery>

<!---
<cfdump var="#qmenu#">
--->

<!--- Output MenuType --->
<cfoutput query="qmenu" group="menutype">
	<h1 class="menu_title" align="center">Cafe Townsend #qmenu.menutype# Menu for #url.date#</h1>
	<cfoutput group="dishtypename">
		<div class="menu_title">#qmenu.dishtypename#</div>
		<cfoutput>
			<div class="menu" align="center">
				<em>#qmenu.dishname# - #qmenu.specialprice#</em> <br />
				#paragraphformat(qmenu.dishdescription)#
			</div>
		</cfoutput>
		<div align="center">
			<cfif qmenu.currentrow is not decrementvalue(qmenu.recordcount)>
			<img src="/mmcourses/acfd700/lab/application/images/menu_divider.gif">
			</cfif>
		</div>
	</cfoutput>
</cfoutput>