<cfset request.pageid = "3">
<cfset request.pagetitle = "About Chef Ipsum">
<cfhtmlhead text='<script language="javascript">pageid = 3;</script>'><cfif isdefined('url.edit')>
<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="#request.pagetitle#">
<cf_renderArticle pageid="#request.pageid#">
</cfmodule>
<cfelse>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>About Chef Ipsum</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/mmcourses/acfd700/lab/Application/style/cafetownsend.css" rel="stylesheet" type="text/css">
<script language="javascript">pageid = 3;</script>
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
<div class="articledisplayfull"><div class="italicsbold">Chef Ipsum releases a new DVD</div><div class="main"><!--StartFragment -->In his fourth DVD, the cooking legend Chef Ipsum shows you how to be a world-class chef! This specially staged performance showcases some of Chef Ispsum&rsquo;s favorite recipes, and provides solid instruction to give you the confidence you need to bring out your inner chef! You&rsquo;ll receive the same training that Chef Ipsum provides for chefs in his famous Caf&eacute; Townsend restaurants. Don&rsquo;t miss out as Chef Ispum whips up ten of his award-winning recipes before a sell-out crowd! The DVD includes a revealing 15-minute bonus interview where Chef Ipsum talks about his humble beginnings and his culinary roots. This DVD has something for everyone!</div></div>
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
