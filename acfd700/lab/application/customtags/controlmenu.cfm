

<cfsavecontent variable="headercontent">
	<cfoutput>
	<link href="#application.basehref#style/system.css" type="text/css" rel="stylesheet" />	
	<script language="javascript">
		basehref = '#application.basehref#';
	</script>
	<script language="javascript" src="#application.basehref#scripts/adminmenuactions.js"></script>
	</cfoutput>
</cfsavecontent>

<cfhtmlhead text="#variables.headercontent#">

<cfoutput>
<script language="javascript" src="#application.basehref#scripts/adminmenu.js"></script>
</cfoutput>