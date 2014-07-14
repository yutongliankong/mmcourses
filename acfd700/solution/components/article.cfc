<cfcomponent>
	
	<!--- article initialize --->
	<cffunction name="init" access="public" returntype="Article" output="false">
		<cfargument name="dsn" type="string" hint="Datasource" required="yes">
		<cfargument name="xsldirectory" type="string" hint="Full path to XSL directory containing render handlers for articles">
		<cfargument name="veritycollection" type="string" hint="Name of verity collection">
		
		<cfset var qxslfiles = "">
		<cfset var theXSLfile = "">
		
		<cfset instance = structnew()>
		<cfset instance.datasource = arguments.dsn>
		<cfset instance.xsldirectory = arguments.xsldirectory>
		<cfset instance.veritycollection = arguments.veritycollection>
		<cfset instance.stArticleXSL = structnew()>
		
		<!--- cache up xsl files in local memory structure --->
		<cfdirectory action="list" directory="#arguments.xsldirectory#" name="qxslfiles" filter="*.xsl">
		<cfloop query="qxslfiles">
			<cfif qxslfiles.type is "FILE">
				<cffile action="read" file="#arguments.xsldirectory##qxslfiles.name#" variable="thexslfile">
				<cfset instance.stArticleXSL[qxslfiles.name] = thexslfile>
			</cfif>
		</cfloop>
		
		<cfreturn this>
	</cffunction>
	
	
	<!--- article delete --->
	<cffunction name="delete" access="public" returntype="boolean" hint="Virtually delete record">
		<cfargument name="articleid" type="numeric" required="yes">
		<cfargument name="updateuser" type="string" required="yes">
		
		<cfquery datasource="#instance.datasource#">
			update article
			set endtime = <cfqueryparam value="#now()#" cfsqltype="cf_sql_date">,
				updateuser = <cfqueryparam value="#arguments.updateuser#" cfsqltype="cf_sql_varchar">
			where articleid = <cfqueryparam value="#arguments.articleid#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfreturn true>
	</cffunction>
	
	<!---- article get --->
	<cffunction name="get" access="public" returntype="query" hint="Retrieve record">
		<cfargument name="articleid" type="numeric" required="no" default="0">
		<cfargument name="maxrows" type="numeric" required="no" default="0">
		<cfargument name="orderby" type="string" required="no" default="begintime desc">
		
		<cfset var qresult = "">
		
		<cfquery name="qresult" datasource="#instance.datasource#">
			select  <cfif arguments.maxrows is not "0"> top #arguments.maxrows# </cfif> *
			from article
			where endtime is null
			<cfif arguments.articleid is not "0">
			and articleid = #arguments.articleid#
			</cfif>
			order by #arguments.orderby#
		</cfquery>
		
		<cfreturn qresult>
	</cffunction>	 	
	
	<!--- Lab 11 --->
	<cffunction name="GetAsRSS" access="public" returntype="XML" hint="Get recent articles and convert to XML">
		<cfset var qArticles = Get(0,3)>
		<cfset var xArticles = "">
	
	 	<cfxml variable="xArticles">
		<?xml version="1.0" encoding="UTF-8"?>
		<rdf:RDF xmlns="http://purl.org/rss/1.0/" xmlns:admin="http://webns.net/mvcb/" xmlns:ag="http://purl.org/rss/1.0/modules/aggregation/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
		
		<channel rdf:about="Cafe Townsend News">
		<title>Cafe Townsend News</title>
		<link>http://localhost:8500/mmcourses/acfd700/lab/Application/News/index.cfm</link>
		<description>
		Cafe Townsend - In the News
		</description>
		
		<cfoutput query="qArticles">
		<item rdf:about="http://localhost:8500/mmcourses/acfd700/lab/Application/news/newsdisplay.cfm?articleid=#qArticles.ArticleID#">
		<title>#xmlformat(qArticles.Title)#</title>
		<link>http://localhost:8500/mmcourses/acfd700/lab/Application/news/newsdisplay.cfm?articleid=#qArticles.ArticleID#</link>
		<description>
		<![CDATA[#xmlFormat(qArticles.Teaser)#]]>
		</description>
		</item>
		</cfoutput>
						
		</channel>
		</rdf:RDF>
	
		</cfxml>
	
		<cfreturn xArticles>
	</cffunction>
	
		
	<!--- get articles to display on a specific page --->
	<cffunction name="ArticlesPageGet" access="public" returntype="query" hint="Get all articles for a specific page">
		<cfargument name="pageid" type="numeric" required="yes">
		
		<cfset var qArticles = "">
		<cfquery name="qarticles" datasource="#instance.datasource#">
			select article.articleid, title, teaser, fulltext, teaserimage, displayhandlerfilename
			from articlepage, article, displayhandler
			where 
			articlepage.displayhandlerid = displayhandler.displayhandlerid
			and article.articleid = articlepage.articleid
			and articlepage.pageid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pageid#">
			and article.endtime is null
			order by articlepage.sortorder
		</cfquery>
		
		<cfreturn qarticles>
			
	</cffunction>
	
	<!--- transform article using xslt --->
	<cffunction name="articleXSLTFormat" access="public" returntype="string" hint="Transform XML for Article" output="false">
		<cfargument name="xarticle" type="xml" required="yes" hint="Article(s) in XML format">
		<cfargument name="xslfilename" type="string" required="yes" hint="Name of XSL file to use in transformation">
		
		<cfset var output = xmlTransform(arguments.xarticle,instance.stArticleXSL[arguments.xslfilename])>
				
		<cfreturn output>
	
	</cffunction>
	
	
	<!--- format article as XML --->
	<cffunction name="ArticlesPageGetFormat" access="public"	 returntype="string"
																		 hint="Format Data for Output" output="false">
		<cfargument name="pageid" type="numeric" required="yes">
		<cfargument name="beditable" type="boolean" required="yes">
		
		<!--- step 1: Get Data --->
		<cfset var result = "">
		<cfset var qArticles = articlesPageGet(arguments.pageid)>
		<cfset var xArticle = "">
		<cfset var stData = structnew()>
		<cfset var temp = "">
		
		<!--- step 2: Loop, convert to XML, and then transform using XSLT --->
		<cfloop query="qArticles">
			<cfif listgetat(qarticles.displayhandlerfilename,2,'.') is "xsl"> <!--- use xsl to format article --->
				<cfxml  variable="xArticle">
					<cfoutput>
					<articles>
						<article id="#qarticles.articleid#">
							<title>#xmlFormat(qarticles.title)#</title>
							<teaser>#xmlFormat(qarticles.teaser)#</teaser>
							<fulltext>#xmlFormat(qarticles.fulltext)#</fulltext>
							<teaserimage>#qarticles.teaserimage#</teaserimage>
						</article>
					</articles>
					</cfoutput>
				</cfxml>
	
				<!--- autobots, transform! --->
				<cfset temp  =  articleXSLTFormat(xArticle,qarticles.displayhandlerfilename)>
	
			<cfelse> <!--- use ColdFusion to format output --->
				<cfscript>
					stData = structnew();
					stData.title = qarticles.title;
					stData.teaser = qarticles.teaser;
					stData.fulltext = qarticles.fulltext;
					stData.teaserimage = qarticles.teaserimage;
				</cfscript>
				<cfsavecontent variable = "temp">
						<cfmodule template="#application.basehref#displayhandlers/#qarticles.displayhandlerfilename#" stData = "#stData#">
				</cfsavecontent>
			</cfif> 
		
			<!--- wrap article with Javascript UI --->
			<cfif arguments.beditable>
				<cfset result = result & "<div style=""display:block;"" onClick=""fnArticleMenu(#qarticles.articleid#,#arguments.pageid#)"" onMouseOver=""this.style.border='3px green dashed'; this.style.cursor='hand';"" onMouseLeave=""this.style.border='0px'"">" & temp & "</div>">
			<cfelse>
				<cfset result = result & temp>
			</cfif>	
		</cfloop>
		
		<cfset result = application.cfc.toolbox.XMLUnFormat(result)>
			
		<cfreturn result>
	</cffunction>
	
	
	<!--- insert record into database --->
	<cffunction name="recordInsert" access="public" returntype="numeric" hint="Insert Record">
		<cfargument name="title" required="yes" type="string">
		<cfargument name="teaser" required="no" type="string" default="">
		<cfargument name="teaserimage" required="no" type="string" default="">
		<cfargument name="fulltext" required="no" type="string" default="">
		<cfargument name="larticlecategoryids" required="yes" type="numeric">
		<cfargument name="publishdate" required="yes" type="string">
		<cfargument name="expdate" required="yes" type="string" >
		<cfargument name="updateuser" required="yes" type="string">
		
		<cfset var qarticle = "">
		
		<cftransaction>
			<cfquery datasource="#instance.datasource#">
				insert into Article (title, teaser, teaserimage, fulltext, publishdate,expdate,updateuser)
				values (
						<cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#arguments.teaser#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#arguments.teaserimage#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#arguments.fulltext#" cfsqltype="cf_sql_longvarchar">,
					
						<cfif arguments.publishdate is "">
							<cfqueryparam value="#arguments.publishdate#" cfsqltype="cf_sql_timestamp" null="yes">,
						<cfelse>
							<cfqueryparam value="#arguments.publishdate#" cfsqltype="cf_sql_timestamp">,
						</cfif>
					
						<cfif arguments.expdate is "">
								<cfqueryparam value="#arguments.expdate#" cfsqltype="cf_sql_timestamp" null="yes">,
						<cfelse>
							<cfqueryparam value="#arguments.expdate#" cfsqltype="cf_sql_timestamp">,
						</cfif>
						
						<cfqueryparam value="#arguments.updateuser#" cfsqltype="cf_sql_varchar">
				)
			</cfquery>
			<cfquery name="qarticle" datasource="#instance.datasource#">
				select max(articleid) as thearticleid
				from article
			</cfquery>
			<cfif arguments.larticlecategoryids is not "">		
				<cfquery datasource="#instance.datasource#">
						insert into articlecategory (articleid, categoryid)
						select #qarticle.thearticleid# as articleid, categoryid
						from category
						where categoryid in (<cfqueryparam value="#arguments.larticlecategoryids#" list="yes">)
				</cfquery>
			</cfif>
		</cftransaction>
		
		<cfreturn qarticle.thearticleid>			
		
	</cffunction>	
	
	<!--- update article in db, regenerate associated pages --->	
	<cffunction name="update" access="public" returntype="numeric" hint="Update record">
		<cfargument name="articleid" required="yes" type="numeric" hint="Primary Key">
		<cfargument name="title" required="yes" type="string">
		<cfargument name="teaser" required="no" type="string" default="">
		<cfargument name="teaserimage" required="no" type="string" default="">
		<cfargument name="fulltext" required="no" type="string" default="">
		<cfargument name="larticlecategoryids" required="yes" type="numeric">
		<cfargument name="publishdate" required="yes" type="string">
		<cfargument name="expdate" required="yes" type="string" >
		<cfargument name="updateuser" required="yes" type="string">
		
		
		<cftransaction>
		
		<cfquery datasource="#instance.datasource#">
			update article
			set
				title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
				teaser = <cfqueryparam value="#arguments.teaser#" cfsqltype="cf_sql_varchar">,
				<cfif arguments.teaserimage is not "">
				teaserimage = <cfqueryparam value="#arguments.teaserimage#" cfsqltype="cf_sql_varchar">,
				</cfif>
				fulltext = <cfqueryparam value="#arguments.fulltext#" cfsqltype="cf_sql_longvarchar">,
			
				<cfif arguments.publishdate is "">
					publishdate = <cfqueryparam value="#arguments.publishdate#" cfsqltype="cf_sql_timestamp" null="yes">,
				<cfelse>
					publishdate = <cfqueryparam value="#arguments.publishdate#" cfsqltype="cf_sql_timestamp">,
				</cfif>
			
				<cfif arguments.expdate is "">
						expdate = <cfqueryparam value="#arguments.expdate#" cfsqltype="cf_sql_timestamp" null="yes">,
				<cfelse>
					expdate = <cfqueryparam value="#arguments.expdate#" cfsqltype="cf_sql_timestamp">,
				</cfif>
				updateuser = <cfqueryparam value="#arguments.updateuser#" cfsqltype="cf_sql_varchar">,
				updatedate = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
				
			where articleid = <cfqueryparam value="#arguments.articleid#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfquery datasource="#instance.datasource#">
			delete
			from articlecategory
			where articleid = <cfqueryparam value="#arguments.articleid#">
		</cfquery>
		
		<cfif arguments.larticlecategoryids is not "">		
			<cfquery datasource="#instance.datasource#">
					insert into articlecategory (articleid, categoryid)
					select #arguments.articleid# as articleid, categoryid
					from category
					where categoryid in (<cfqueryparam value="#arguments.larticlecategoryids#" list="yes">)
			</cfquery>
		</cfif>
		
		</cftransaction>
		
		<cfreturn true>
	</cffunction>
	
	<cffunction name="pageBind" access="public" hint="Binds article to page" returntype="boolean">
		<cfargument name="articleid" required="yes" type="numeric">
		<cfargument name="pageid" required="yes" type="numeric">
		<cfargument name="sortorder" required="no" default="-1">
		<cfargument name="displayhandlerid" required="no" default="-1">
		
		<cfset var qdisplayhandler = "">
		<cfset var qlastitem = "">
		<cfset var thesortorder = arguments.sortorder>
		<cfset var thedisplayhandlerid = arguments.displayhandlerid>
		
		<cfif thedisplayhandlerid is -1>
			<cfquery name="qdisplayhandler" datasource="#instance.datasource#">
				select displayhandlerid
				from displayhandler
				where bIsDefault <> 0
			</cfquery>
			<cfset thedisplayhandlerid = qdisplayhandler.displayhandlerid>
		</cfif>
		
		<cftransaction>
			<cfquery datasource="#instance.datasource#">
				delete
				from articlepage
				where pageid = <cfqueryparam value="#arguments.pageid#" cfsqltype="cf_sql_integer">
				and articleid = <cfqueryparam value="#arguments.articleid#" cfsqltype="cf_sql_integer">
			</cfquery>
			
			<cfif arguments.sortorder is -1>
				<cfquery name="qlastitem" datasource="#instance.datasource#">
					select max(sortorder) as sortorder
					from articlepage
					where pageid =  <cfqueryparam value="#arguments.pageid#" cfsqltype="cf_sql_integer">
				</cfquery>
				<cfif qlastitem.sortorder is "">
					<cfset querysetcell(qlastitem,"sortorder",0,1)>
				</cfif>
				<cfset thesortorder = qlastitem.sortorder + 1>
			</cfif>
			
			<!--- make sure the position to insert is clear --->
			<cfquery datasource="#instance.datasource#">
				update articlepage
				set sortorder = sortorder - 1
				where sortorder <= #arguments.sortorder#
				and pageid = <cfqueryparam value="#arguments.pageid#" cfsqltype="cf_sql_integer">
			</cfquery>
			
			<cfquery datasource="#instance.datasource#">
				insert into articlepage (pageid,articleid,sortorder,displayhandlerid)
				values (<cfqueryparam value="#arguments.pageid#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#arguments.articleid#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#thesortorder#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#thedisplayhandlerid#" cfsqltype="cf_sql_integer">)
			</cfquery>
		</cftransaction>
		
		<cfreturn true>
	</cffunction>
	
	<cffunction name="displayhandlerget" access="public" returntype="numeric">
		<cfargument name="articleid" type="numeric" required="yes">
		<cfargument name="pageid" type="numeric" required="yes">
		
		<cfset q = "">
		
		<cfquery name="q" datasource="#instance.datasource#">
			select displayhandlerid
			from articlepage
			where pageid = <cfqueryparam value="#arguments.pageid#" cfsqltype="cf_sql_integer">
			and articleid = <cfqueryparam value="#arguments.articleid#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfreturn q.displayhandlerid>
		
	</cffunction>
	
	
	<cffunction name="displayhandlerchange" access="public" returntype="boolean">
		<cfargument name="pageid" type="numeric" required="yes">
		<cfargument name="articleid" type="numeric" required="yes">
		<cfargument name="displayhandlerid" type="numeric" required="yes">
	
		<cfquery datasource="#instance.datasource#">
			update articlepage
			set displayhandlerid = <cfqueryparam value="#arguments.displayhandlerid#" cfsqltype="cf_sql_integer">
			where pageid = <cfqueryparam value="#arguments.pageid#" cfsqltype="cf_sql_integer">
			and articleid = <cfqueryparam value="#arguments.articleid#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfreturn true>
	</cffunction>
	
	<cffunction name="pagepositionget" access="public" returntype="numeric">
		<cfargument name="pageid" type="numeric" required="yes">
		<cfargument name="articleid" type="numeric" required="yes">
		
		
		<cfset var q = "">
		
		<cfquery name="q" datasource="#instance.datasource#">
			select sortorder
			from articlepage
			where pageid = #arguments.pageid#
			and articleid = #arguments.articleid#
		</cfquery>
		
		<cfreturn q.sortorder>
		
	</cffunction>
	
	<cffunction name="ArticlePageReOrder" access="public" returntype="boolean" output="false">
		<cfargument name="pageid" type="numeric" required="yes">
		<cfargument name="articleid" type="numeric" required="yes">
		<cfargument name="mode" type="string" required="yes">
	
		<cfset var q = "">
		<cfset var Aarticles = "">
		<cfset var pos = 0>
		<cfset var lsequence = "">
		<cfset var temp = "">
		<cfset var i = 0>
		
		<cfquery name="q" datasource="#instance.datasource#">
			select articleid
			from articlepage
			where pageid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pageid#">
			order by sortorder	
		</cfquery>
		
		<cfset Aarticles = listToArray(valuelist(q.articleid))>
		
		<cfset pos = listfind(valuelist(q.articleid),arguments.articleid)>
		
		<cfif mode is "up" and pos gt 1>
				<cfset temp = aArticles[pos - 1]>
				<cfset aArticles[pos - 1] = arguments.articleid>
				<cfset aArticles[pos] = temp>
		<cfelseif mode is "down" and pos lt q.recordcount>
				<cfset aArticles[pos] = aArticles[pos + 1]>
				<cfset aArticles[pos + 1] = arguments.articleid>
		</cfif>
		
		<cfloop from="1" to="#arraylen(aArticles)#" index="i">
			<cfquery datasource="#instance.datasource#">
				update articlepage
				set sortorder = #i#
				where articleid = #aArticles[i]#
				and pageid =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pageid#">
			</cfquery>
		</cfloop>
		
	
		<cfreturn true>
	</cffunction>
	
	<cffunction name="articleRemoveFromPage" access="public" output="false" returntype="boolean">
		<cfargument name="pageid" type="numeric" required="yes">
		<cfargument name="articleid" type="numeric" required="yes">
		
		<cfquery datasource="#instance.datasource#">
			delete
			from articlepage
			where pageid = <cfqueryparam value="#arguments.pageid#" cfsqltype="cf_sql_integer">
			and articleid = <cfqueryparam value="#arguments.articleid#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfreturn true>
	</cffunction>

	<cffunction name="verityindex" access="public" output="false" returntype="boolean">
		
			<cfset var q = get()>
			
			<cftry>
				<cfindex action="purge" collection="#instance.veritycollection#">
				<cfcatch type="any">
					<cfcollection action="create" collection="#instance.veritycollection#" path="#expandpath('.')#">
				</cfcatch>
			</cftry>
			
			<cfindex action="update" 
						 collection="#instance.veritycollection#"
						 query="q"
						 key="articleid"
						 body="title,teaser,fulltext"
						 type="custom"> 
			
			<cfreturn true>
			
	</cffunction>
 	
	<cffunction name="veritysearch" access="public" output="false" returntype="struct">
		<cfargument name="searchterm" type="string" required="no" default="">
		
		<cfset var qresult = "">
		<cfset var stResult = structnew()>
		<cfset var akeys = "">
		
		<cfif arguments.searchterm is not "">
		
			<cftry>
			<cfsearch 	name="qresult"
							collection="#instance.veritycollection#"
						 	criteria="#arguments.searchterm#"
							maxrows="100"
							type="internet">
							
			<cfcatch type="any">
				<cfcollection action="CREATE" collection="#instance.veritycollection#" path="#expandpath('.')#">
				
				<cfset qresult = get()>
				
				<cfindex action="UPDATE" 
				    collection="#instance.veritycollection#"
					type="CUSTOM"
					query="qresult"
					key="articleid"
					body="teaser,fulltext"
					title="title"
					custom1="updatedate">
				
				<cfsearch 	name="qresult"
							collection="#instance.veritycollection#"
						 	criteria="#arguments.searchterm#"
							maxrows="100"
							type="internet">
			</cfcatch>
			</cftry>
		<cfelse> <!--- no search term, display most recent 50 --->
			<cfquery name="qresult" datasource="#instance.datasource#" maxrows="50">
				select  articleid as  thekey,
						 title,
						 teaser as summary,
						 updatedate as custom1,
						 '' as context,
						 '' as url,
						 '' as rank,
						 updateuser as author
				from article
				where endtime is null
				order by updatedate desc
			</cfquery>
			<cfset akeys = listtoarray(valuelist(qresult.thekey))>
			<cfset queryaddcolumn(qresult,"key","integer",akeys)>
		</cfif>
		
		<cfset stResult.qresult = qresult>
		
		<cfreturn stResult>
	</cffunction>
	
	
</cfcomponent>


