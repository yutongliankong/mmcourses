<cfparam name="url.articleid" default="4">
<!--- lab 11 --->

<cfset qNews = application.cfc.Article.get(url.articleid)>

<cf_contentpage title="RSS News!">
	<cfoutput>
		<div class="menu_title">#qNews.title#</div>
		 	<div class="menu" align="center">#paragraphformat(qNews.fulltext)#
		</div>
	</cfoutput>
</cf_contentpage>