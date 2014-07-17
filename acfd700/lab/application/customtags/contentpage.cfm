<cfparam name="attributes.title" default="">
<cfoutput>
  <cfif thistag.executionmode EQ "Start">
  <!--- Lab 7: Step 5--->
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
        <a href="#application.basehref#index.cfm" class="navigation">Cuisine</a>
      <a href="#application.basehref#" class="navigation">Articles</a>
      <a href="#application.basehref#" class="navigation">Special Events</a>
      <a href="#application.basehref#" class="navigation">Location</a>
      <a href="#application.basehref#" class="navigation">Menu</a>
      <a href="#application.basehref#contact_us.cfm" class="navigation">Contact Us</a>
      <a href="#application.basehref#sitemap/index.cfm" class="navigation">Site Map</a>
      </td>
     
      <td width="560" valign="top" bgcolor="##F7EEDF">
      <div style="padding-left: 5px">
</cfif>
        <!--- page content goes here --->
  <cfif thistag.executionmode EQ "end">
  
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