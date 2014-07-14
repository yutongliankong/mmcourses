
<!--- write CMS code into page header --->
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

<!--- output dhtml left-side menu --->
<cfoutput>
<script language="javascript" src="#application.basehref#scripts/adminmenu.js"></script>

<!--- output hidden iframe used for "realtime" record locking --->
<cfif isdefined("url.edit") and isdefined("request.pageid")>
	<iframe src="#application.basehref#admin/cms/misc/updatelock.cfm?type=page&id=#request.pageid#" <cfif not isdefined("url.debug")>style="display:none"</cfif>></iframe>
</cfif>

</cfoutput>