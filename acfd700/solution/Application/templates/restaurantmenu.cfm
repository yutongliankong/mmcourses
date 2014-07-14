<cfif isdefined("url.edit")>
	<cfset mode="edit">
<cfelse>
	<cfset mode="view">
</cfif>

<cfmodule template="#application.basehref#customtags/contentpage.cfm" title="#request.pagetitle#">

	<cf_renderArticle pageid="#request.pageid#">
	<cf_renderPlugin plugin="restaurantmenu.cfm" mode="#mode#" cache="false">

</cfmodule>
