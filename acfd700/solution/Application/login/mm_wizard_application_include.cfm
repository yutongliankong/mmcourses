

<cflogin>
   <cfif not isdefined("cflogin")>
   		<cfinclude template="mm_wizard_login.cfm">
		<cfabort>	
  <cfelse>
  		<cfset stStatus = application.cfc.administrator.authenticate(form.j_username, form.j_password)>
		<cfif stStatus.status>
			<cfloginuser name="#form.j_username#" password="#form.j_password#" roles="#stStatus.lroles#">
		<cfelse>
			<cfset loginmsg="You entered an invalid username/password">
			<cfinclude template="mm_wizard_login.cfm">
			<cfabort>	
		</cfif>
   </cfif>
</cflogin>

<cfif isdefined("form.j_username")>
	<cfset stStatus = application.cfc.administrator.authenticate(form.j_username, form.j_password)>
</cfif>

