<cfif structkeyexists(form,"Filedata")>
    <!--- upload file with whatever attributes you need, additional variables may come in url scope --->
	<cffile action="UPLOAD" filefield="Filedata" destination="#expandpath(".")#" nameconflict="MAKEUNIQUE">  
</cfif>
