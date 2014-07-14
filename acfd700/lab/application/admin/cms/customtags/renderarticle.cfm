<cfparam name="attributes.pageid">

<cfif isdefined("url.edit")>
	<cfset beditable = 1>
<cfelse>
	<cfset beditable = 0>
</cfif>
 
 
<cfset output = application.cfc.article.ArticlesPageGetFormat(attributes.pageid, beditable)>

<cfoutput>
<cfif isdefined("url.edit")><cfif variables.output is ""><a href="javascript:fnNewArticle(#attributes.pageid#)">[New Article]</a></cfif>

<div id="articlemenu" 
	style="position:absolute; font-family: Arial, Helvetica, sans-serif; font-size: 10px; font-weight: bold; background-color: Silver; padding-left: 2px; padding-top: 2px; width: 170px; height: 220px; z-index:100; display:none" onMouseleave="this.style.display='none'">
		<a href="javascript:fnEditArticle()" class="editarticlelink">Edit this Article</a><br  />
		<hr />
		<a href="javascript:fnSelectDisplayTemplate()" class="editarticlelink">Select Display Template</a>
		<hr />
		<a href="javascript:fnMoveUp()" class="editarticlelink">Move Article Up</a><br />
		<a href="javascript:fnMoveDown()" class="editarticlelink">Move Article Down</a><br />
		<hr />
		<a href="javascript:fnNewArticleBefore()" class="editarticlelink">Insert New Article Before</a><br />
		<a href="javascript:fnNewArticleAfter()" class="editarticlelink">Insert New Article After</a><br />
		<hr />
		<a href="javascript:fnArticleSelectBefore()" class="editarticlelink">Add Existing Article Before</a><br />
		<a href="javascript:fnArticleSelectAfter()" class="editarticlelink">Add Existing Article After</a><br />
		<hr />
		<a href="javascript:fnRemoveArticle()" class="editarticlelink">Remove Article</a><br  />
		<a href="javascript:fnDeleteArticle()" class="editarticlelink">Delete Article</a>
</div>
</cfif>
#output#
</cfoutput>

