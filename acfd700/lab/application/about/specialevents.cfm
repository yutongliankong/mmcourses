<cfset request.pageid = "4">
<cfset request.pagetitle = "Cafe Townsend Special Events">
<cfhtmlhead text='<script language="javascript">pageid = 4;</script>'><cfif isdefined('url.edit')>
<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="#request.pagetitle#">
<cf_renderArticle pageid="#request.pageid#">
</cfmodule>
<cfelse>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cafe Townsend Special Events</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/mmcourses/acfd700/lab/Application/style/cafetownsend.css" rel="stylesheet" type="text/css">
<script language="javascript">pageid = 4;</script>
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
<div class="articledisplayfull"><div class="italicsbold">Our Invitation to you</div><div class="main"><p>Set in a unique, historic building in San Francisco, our private dining room is available to host your corporate events, parties, weddings, and more.</p>
<p>Our special events manager, sommelier, and executive chef will work with you to make sure your special event is truly special. We offer multiple menu options, or we can customize a menu for you.&nbsp; In keeping with the award-winning cuisine and exceptional service you expect, we provide place cards, personally printed menus, and candles. We are also happy to help you arrange other services.</p>
<p>Our unique setting, highly personalized service, and memorable dining are the perfect combination for your special event! Please contact us for more information! </p></div></div><?xml version="1.0" encoding="UTF-8"?>
<div class="articledisplayfull"><div class="italicsbold">Take a closer look</div><div class="main"><img src="/mmcourses/acfd700/lab/application/images/seating_chart.jpg" align="left" alt=""/>Our private dining room provides a warm, intimate setting for your event. We can accommodate 60 seated guests for dinner or up to 100 guests for a standing reception.</div></div>
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
