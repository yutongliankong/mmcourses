
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Advanced Query Handling: Walkthrough 2</title>
</head>

<body>

<!--- note -- normally this query would be embedded within a CFC (discussed in unit 5) --->
<cfquery name="qgetspecials" datasource="acfd700-lab">
			select dish.dishname, 
				   dish.dishid,
				   dish.dishDescription,
				   dishtype.dishtypename,
				   menutype.menutype,
				   menudish.price,
				   menudish.specialprice
				   
			
			from	dish, dishtype, menudish, menutype
			
			where  dish.dishtypeid = dishtype.dishtypeid
					  and menudish.dishid = dish.dishid
					  and menudish.menutypeid = menutype.menutypeid
					  and menudish.bspecial=1
			
			order by menutype.menutypesortorder, dishtype.dishtypesortorder
	
</cfquery>



<!--- wt 3-2 code starts here --->


</body>
</html>
