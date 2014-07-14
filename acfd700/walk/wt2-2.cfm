 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cafe Townsend</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="#application.basehref#style/cafetownsend.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="##000000">
  <cfoutput>


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
	  	<a href="" class="navigation">Cuisine</a>

		<a href="chef_ipsum.html" class="navigation">Chef Ipsum</a>
		<a href="" class="navigation">Articles</a>
		<a href="specialevents.html" class="navigation">Special Events</a>
		<a href="" class="navigation">Location</a>
		<a href="menu.html" class="navigation">Menu</a>
		<a href="contact_us.cfm" class="navigation">Contact Us</a>

	  </td>
	  </td>
	  <td bgcolor="##F7EEDF" width="230" align="center" valign="top">
        <!-- Begin Flash Video for Progressive download --> <!-- -->
        <img src="#application.basehref#images/street_sign.jpg" width="202" height="136" hspace="0" vspace="12" border="0">
	  </td>
	  <td width="330" valign="top" bgcolor="##F7EEDF">
	  	<!--- content goes here --->
      <cfoutput>#application.datasource#</cfoutput>
	  </td>
  </tr>

  </table>
  <table width="700" border="0" cellpadding="0" cellspacing="0">
  <tr>
      <td><img src="#application.basehref#images/body_main_footer.gif" width="700" height="25"></td>
  </tr>
</table>

</cfoutput>
</body>
</html>

