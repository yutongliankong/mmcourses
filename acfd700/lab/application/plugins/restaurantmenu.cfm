
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

<cfdump var="#qmenu#">

<!--- Output MenuType --->
