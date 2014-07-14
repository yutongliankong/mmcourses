<cfset request.pageid = "2">
<cfset request.pagetitle = "Welcome to Cafe Townsend">
<cfhtmlhead text='<script language="javascript">pageid = 2;</script>'><cfif isdefined('url.edit')>
<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="#request.pagetitle#">
<cf_renderArticle pageid="#request.pageid#">
</cfmodule>
<cfelse>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Welcome to Cafe Townsend</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/mmcourses/acfd700/lab/Application/style/cafetownsend.css" rel="stylesheet" type="text/css">
<script language="javascript">pageid = 2;</script>
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
<?xml version="1.0" encoding="UTF-8"?>
<div class="articledisplayfull"><div class="italicsbold">Welcome to Cafe Townsend</div><div class="main"><p>Caf&eacute; Townsend&rsquo;s visionary chef and founder leads the way in a culinary revolution. Proclaimed by many to be the best chef in the world today, Chef Ipsum blends earthy seasonal flavors and bold ingredients to create exquisite contemporary cuisine.</p>
<p>The name Caf&eacute; Townsend comes from our first restaurant, located in a historic building on Townsend Street in San Francisco, where we opened the doors in 1992. We&rsquo;ve replicated the elegant interior, exceptional service, and world class cuisine in our restaurants around the country.</p></div></div>
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
