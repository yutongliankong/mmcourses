<cfparam name="attributes.title" default="">
<!--- Lab 7: Step 5--->
<cfinclude template="menutext.cfm">
<cfoutput>
<cfif thistag.executionmode is "Start">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>#attributes.title#</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="#application.basehref#style/cafetownsend.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="##000000">

  <cf_controlmenu>	

  <table width="700" border="0" cellpadding="0" cellspacing="0">
    <tr>
    <td><img src="#application.basehref#images/header.jpg"></td>
  </tr>

  <tr>
      <td><img src="#application.basehref#images/body_main_header.gif" width="700" height="25"></td>
  </tr>
  </table>
  <table width="700" border="0" cellpadding="0" cellspacing="0">
  <tr>
      <td bgcolor="##993300" width="140" valign="top">
	  <!--- Lab 7: Step 8--->
	  	<cfloop query="qmenuchoices">
		<a href="#application.basehref##qmenuchoices.link#" class="# qmenuchoices.class#">#qmenuchoices.display#
		</cfloop>

 	  	<!---<a href="#application.basehref#index.cfm" class="navigation">Cuisine</a>
		<a href="#application.basehref#about/chefipsum.cfm" class="navigation">Chef Ipsum</a>
		<a href="#application.basehref#news/index.cfm" class="navigation">Articles</a>
		<a href="#application.basehref#about/specialevents.cfm" class="navigation">Special Events</a>
		<a href="#application.basehref#about/menu.cfm" class="navigation">Menu</a>
		<a href="#application.basehref#sitemap/index.cfm" class="navigation">Site Map</a>
		<a href="#application.basehref#about/search.cfm" class="navigation">Search</a>--->
	  </td>
	 
	  <td width="560" valign="top" bgcolor="##F7EEDF">
	  <div style="padding-left: 5px">
<cfelse><!--- thistag.executionmode is end --->

		</div>	
	  </td>
  </tr>

  </table>
  <table width="700" border="0" cellpadding="0" cellspacing="0">
  <tr>
      <td><img src="#application.basehref#images/body_main_footer.gif" width="700" height="25"></td>
  </tr>
</table>

</body>
</html>
</cfif>
</cfoutput>