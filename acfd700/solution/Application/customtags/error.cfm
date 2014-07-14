<cfparam name="attributes.exception">
<cfparam name="attributes.eventname">

<cfoutput>
	<div style="font-family:Arial; font-size: 12px">
	<div>
	<img src="#application.basehref#/images/atomic.gif" align="left"><h1>An Error Occurred!</h1>
	Please try this feature later.  <br />
	

	<ul style="padding-left: 120px">
		<li>Authorities have been notified.</li>
		<li>This will not go on your permanent record.</li>
		<li>No live animals were harmed due to this action.</li>
	</ul>			
	</div>
	<br />
	<cfif listfind(application.lAdministratorIPs,cgi.REMOTE_ADDR) gt 0>
		<p>Since you are an administrator, here's some additional info:</p>
		Event: #attributes.eventname#<br />
		#attributes.exception.type# 
		<p>#attributes.exception.message#</p>
		
		<table style="font-family:Arial, Helvetica, sans-serif; font-size: 10px">
		<th>Line</th><th>id</th><th>Template</th>
		<cfloop from="1" to="#arraylen(attributes.exception.tagcontext)#" index="i">
			<tr valign="top" style="border-top: 1px solid black">
				<td>#attributes.exception.tagcontext[i].line#</td>
				<td>#attributes.exception.tagcontext[i].id#</td>
				<td>#attributes.exception.tagcontext[i].template#</td>
			</tr>	
		</cfloop>
		</table>	
		<hr>				
		<strong>Now, repeat after me: </strong><br />
		We are happy and content in our well-paying job....<br />
		We are happy and content in our well-paying job....<br />
		We are happy and content in our well-paying job....<br />
		</div>
	</cfif>
</cfoutput>