<cfif isdefined("url.edit")>
	<cfset mode="edit">
<cfelse>
	<cfset mode="view">
</cfif>

<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="#request.pagetitle#">

	<table border="0" width="555">
	<tr valign="top">
	<td width="350" style="border-right: 1px solid black"><cf_renderArticle pageid="#request.pageid#"></td>
	<td width="205"><cf_renderPlugin plugin="news.cfm" mode="#mode#" cache="false"></td>
	</tr>
	</table>

</cfmodule>
