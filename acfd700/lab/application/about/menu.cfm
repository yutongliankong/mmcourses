<cfset request.pageid = "6">
<cfset request.pagetitle = "Cafe Townsend Menu">
<cfhtmlhead text='<script language="javascript">pageid = 6;</script>'><cfif isdefined('url.edit')><cfif isdefined("url.edit")>
<cfset mode="edit">
<cfelse>
<cfset mode="view">
</cfif>
<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="#request.pagetitle#">
<cf_renderArticle pageid="#request.pageid#">
<cf_renderPlugin plugin="restaurantmenu.cfm" mode="#mode#" cache="true">
</cfmodule>
<cfelse>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cafe Townsend Menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/mmcourses/acfd700/lab/Application/style/cafetownsend.css" rel="stylesheet" type="text/css">
<script language="javascript">pageid = 6;</script>
<link href="/mmcourses/acfd700/lab/Application/style/system.css" type="text/css" rel="stylesheet" />
<script language="javascript">
basehref = '/mmcourses/acfd700/lab/Application/';
</script>
<script language="javascript" src="/mmcourses/acfd700/lab/Application/scripts/adminmenuactions.js"></script>
</head>
<body bgcolor="#000000">
<script language="javascript" src="/mmcourses/acfd700/lab/Application/scripts/adminmenu.js"></script>
<table width="700" border="0" cellpadding="0" cellspacing="0">
<tr>
<td><img src="/mmcourses/acfd700/lab/Application/images/header.jpg"></td>
</tr>
<tr>
<td><img src="/mmcourses/acfd700/lab/Application/images/body_main_header.gif" width="700" height="25"></td>
</tr>
</table>
<table width="700" border="0" cellpadding="0" cellspacing="0">
<tr>
<td bgcolor="#993300" width="140" valign="top">
<a href="/mmcourses/acfd700/lab/Application/index.cfm" class="navigation">Cuisine</a>
<a href="/mmcourses/acfd700/lab/Application/about/chefipsum.cfm" class="navigation">Chef Ipsum</a>
<a href="/mmcourses/acfd700/lab/Application/news/index.cfm" class="navigation">Articles</a>
<a href="/mmcourses/acfd700/lab/Application/about/specialevents.cfm" class="navigation">Special Events</a>
<a href="/mmcourses/acfd700/lab/Application/about/menu.cfm" class="navigation">Menu</a>
<a href="/mmcourses/acfd700/lab/Application/sitemap/index.cfm" class="navigation">Site Map</a>
<a href="/mmcourses/acfd700/lab/Application/about/search.cfm" class="navigation">Search</a>
</td>
<td width="560" valign="top" bgcolor="#F7EEDF">
<div style="padding-left: 5px">
<h1 align="center" class="menu_title">Cafe Townsend Dinner Menu for #dateformat(now()#</h1>
<div class="menu_title">Appetizer</div>
<div class="menu" align="center"><em>Pancetta-wrapped Sea Scallops - 8</em><br />
Drizzled with tarragon puree. Served with baked cauliflower au gratin in a tangy Gruyere sauce <P>
</div>
<div class="menu" align="center"><em>Roasted Tomato Soup - 9</em><br />
Served with goat cheese croutons and basil puree <P>
</div>
<div class="menu" align="center"><em>Summer Salad - 20</em><br />
Gorgonzola, tossed with raspberry vinaigrette <P>
</div>
<div align="center"><img src="/mmcourses/acfd700/lab/Application/images/menu_divider.gif"></div>
<div class="menu_title">Entrée</div>
<div class="menu" align="center"><em>Cajun Seafood Bouillabaisse - 10</em><br />
With crawfish, scallops, catfish, crab, and mussels. Served with Southern-style cornbread and honey butter. <P>
</div>
<div class="menu" align="center"><em>Cavatappi Pasta with Spicy Chickpea Sauce - 13</em><br />
Tossed with grilled eggplant, green olives, and sun dried tomatoes. Topped with Mediterranean feta. <P>
</div>
<div class="menu" align="center"><em>Sage-rubbed Double-cut Pork Chop - 16</em><br />
Topped with a ragout of mushrooms and chunky pancetta. Served with griddle corn cakes. <P>
</div>
<div align="center"><img src="/mmcourses/acfd700/lab/Application/images/menu_divider.gif"></div>
<div class="menu_title">Dessert</div>
<div class="menu" align="center"><em>Baked Pears with Caramel Sauce - 5</em><br />
Topped with house-made vanilla-bean ice cream. <P>
</div>
<div class="menu" align="center"><em>Chocolate Mousse Granita - 4</em><br />
Served in a martini glass with a spiced-orange meringue cookie. <P>
</div>
</div>
</td>
</tr>
</table>
<table width="700" border="0" cellpadding="0" cellspacing="0">
<tr>
<td><img src="/mmcourses/acfd700/lab/Application/images/body_main_footer.gif" width="700" height="25"></td>
</tr>
</table>
</body>
</html>
</cfif>
