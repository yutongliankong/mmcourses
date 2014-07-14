<cfcomponent>
	
	<cffunction name="init" access="public" returntype="Page" output="false">
		<cfargument name="dsn" type="string" hint="datasource" required="yes">
		<cfargument name="basepath" type="string" hint="Absolute Path to website, i.e. C:\inetpub\wwwroot\mysite\" required="yes">
		<cfargument name="basehref" type="string" hint="URL Path to website, i.e. http://localhost/" required="yes">
		
		<cfset instance = structnew()>
		<cfset instance.datasource = arguments.dsn>
		<cfset instance.basepath = arguments.basepath>
		<cfset instance.basehref = arguments.basehref>
		
		<cfreturn this>
	</cffunction>
	
	<!--- walkthrough 9-5: Async Processes --->
	<cffunction name="rebuildallpages" output="no">
		<cfargument name="cfevent" type="struct" required="yes">
		
		<cfset var qpages = "">
			
		<!--- I would like to introduce myself ... to ... myself --->
		<cfset  init(dsn = arguments.cfevent.data.datasource, basepath = arguments.cfevent.data.basepath, basehref = arguments.cfevent.data.basehref)>
	
	   <cfset qpages = get()>
	   <cfloop query="qpages">
		   <cfset rebuildpage(qpages.pageid)>
	   </cfloop>
	   
	   <cflog text="All pages rebuilt successfully">
	   
	</cffunction>
	
	
	<cffunction name="recordInsert" access="private" returntype="numeric">
		<cfargument name="filename" type="string" required="yes">
		<cfargument name="templateid" type="numeric" required="yes">
		<cfargument name="directoryid" type="numeric" required="yes">
		<cfargument name="pagetitle" type="string" required="yes">
		<cfargument name="keywords" type="string" required="no" default="">
		<cfargument name="description" type="string" required="no" default="">
		<cfargument name="bIncludeInSiteMap" type="boolean" required="no" default="0">
		<cfargument name="releasedate" type="date" required="no" default="#now()#">
		<cfargument name="updateuser" type="string" required="yes">
		
		<cftransaction>
			<cfquery datasource="#instance.datasource#">
				insert into page (filename,templateid,directoryid,pagetitle,keywords,description,bincludeinsitemap,releasedate,updateuser)
				values (
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filename#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.templateid#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.directoryid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pagetitle#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.keywords#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.description#">,
						<cfqueryparam cfsqltype="cf_sql_bit" 		value="#arguments.bincludeinsitemap#">,
						<cfqueryparam cfsqltype="cf_sql_timestamp"		value="#arguments.releasedate#">,
						<cfqueryparam cfsqltype="cf_sql_varchar"	 value="#arguments.updateuser#">
						)
			</cfquery>
			<cfquery name="qgetid" datasource="#instance.datasource#">
					select max(pageid) as thepageid
					from page
			</cfquery>
		</cftransaction>
		
		<cfreturn qgetid.thepageid>
	
	</cffunction>
	
	
	<cffunction name="rebuildpage" access="public" returntype="boolean">
			<cfargument name="pageid" type="string" required="yes">
			
			<cfset var qpage = get(arguments.pageid)>
			<cfset pageBuild(arguments.pageid,qpage.templateid)>
			
			<cfreturn true>
	</cffunction>
	
	
	<cffunction name="pageBuild" access="public" returntype="string">
		<cfargument name="pageid" type="string" required="yes">
		<cfargument name="templateid" type="numeric" required="yes">
		
		<cfset var stemplate = ""> <!--- template contents --->
		<cfset var qtemplate = application.cfc.template.get(arguments.templateid)>
		<cfset var out = "">
		<cfset var output = "">
		
		<cfset qpageinfo = get(arguments.pageid)>
		<cffile action="read" file="#instance.basepath#templates\#qtemplate.templatepath#" variable="sTemplate">
		
		<!--- generate temp file --->
		<cfscript>
			out = '<cfsetting showdebugoutput="No">';
			out = out & "<cfset request.pageid = ""#arguments.pageid#"">#chr(10)#";
			out = out & "<cfset request.pagetitle = ""#qpageinfo.pagetitle#"">#chr(10)#";
			out = out & "<cfhtmlhead text='<script language=""javascript"">pageid = #arguments.pageid#;</script>'>";
			out = out &  sTemplate;
		</cfscript>
	
		<cffile action="write" 
			file="#instance.basepath##replace(mid(qpageinfo.url,2,len(qpageinfo.url) - 1),"/","\","ALL")##qpageinfo.filename#.cfm" 
			output="#out#" nameconflict="overwrite">
		
		<cfhttp url="#instance.basehref##qpageinfo.url##qpageinfo.filename#.cfm" method="get"></cfhttp>
		
		
		
		<!--- now generate full code version of file --->
		<cfscript>
			out = "<cfset request.pageid = ""#arguments.pageid#"">#chr(10)#";
			out = out & "<cfset request.pagetitle = ""#qpageinfo.pagetitle#"">#chr(10)#";
			out = out & "<cfhtmlhead text='<script language=""javascript"">pageid = #arguments.pageid#;</script>'>";
			out = out &  "<cfif isdefined('url.edit')>" & sTemplate & "<cfelse>" & cfhttp.filecontent & "</cfif>";
		</cfscript>
		
		<cfset out = application.cfc.toolbox.HTMLCompressFormat(out)>
	
		<cffile action="write" 
			file="#instance.basepath##replace(mid(qpageinfo.url,2,len(qpageinfo.url) - 1),"/","\","ALL")##qpageinfo.filename#.cfm" 
			output="#out#" nameconflict="overwrite">
		
		<cfreturn qpageinfo.url & qpageinfo.filename & ".cfm">
		
	</cffunction>
	
	
	<cffunction name="pageCreate" access="public" returntype="string">
		<cfargument name="filename" type="string" required="yes">
		<cfargument name="templateid" type="numeric" required="yes">
		<cfargument name="directoryid" type="numeric" required="yes">
		<cfargument name="pagetitle" type="string" required="yes">
		<cfargument name="keywords" type="string" required="no" default="">
		<cfargument name="description" type="string" required="no" default="">
		<cfargument name="bIncludeInSiteMap" type="boolean" required="no" default="0">
		<cfargument name="releasedate" type="date" required="no" default="#now()#">
		<cfargument name="updateuser" type="string" required="yes">
		
		<cfset var url = "">
		
		<cfset var pageid = recordInsert(filename,templateid,directoryid,pagetitle,keywords,description,bincludeinsitemap,releasedate,updateuser)>
		
		<cfset url = pageBuild(pageid = pageid, templateid = arguments.templateid)>
		
		<cfreturn url>
	</cffunction>
	
	<cffunction name="Delete" access="private" returntype="boolean">
		<cfargument name="pageid" required="yes">
		<cfargument name="updateuser" required="yes">
		
		<cfquery datasource="#instance.datasource#">
			update page
			set endtime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
				 updateuser = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.updateuser#">
			where pageid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pageid#">
		</cfquery>
	
		<cfreturn true>
	
	</cffunction>
	
	
	
	<cffunction name="pageDelete" access="public" returntype="boolean">
		<cfargument name="pageid" required="yes">
		<cfargument name="updateuser" required="yes">
	
		<cfset delete(arguments.pageid, arguments.updateuser)>
		
		<!--- go delete stub file --->
		
		<cfreturn true>
	</cffunction>
	
	
	<cffunction name="get" access="public" returntype="query">
		<cfargument name="pageid" required="no" default="">
		
		<cfset var q = "">
		<cfquery name="q" datasource="#instance.datasource#">
			select page.*, directory.directoryname, directory.url
			from page, directory
			where page.directoryid = directory.directoryid
			and directory.endtime is null
			and page.endtime is null
			<cfif arguments.pageid is not "">
				and pageid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pageid#">
			</cfif>
		</cfquery>
		<cfreturn q>
	</cffunction>
</cfcomponent>