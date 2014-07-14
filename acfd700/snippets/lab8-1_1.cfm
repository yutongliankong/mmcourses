<cfformgroup type="horizontal" label="Release Date">
		<cfinput type="datefield" required="yes" name="releasedateselector" value="#dateformat(now(),"mm/dd/yyyy")#" width="100">
		<cfselect name="releasedatehour" width="40" >
			<cfloop from="1" to="12" index="i">
				<cfoutput>
					<option value="#i#"  <cfif i is hour(now()) or (hour(now()) - 12 is i)>selected</cfif>>#i#</option>
				</cfoutput>
			</cfloop>
		</cfselect>
			
		<cfselect name="releasedateminute" width="40">
			<cfloop from="0" to="59" index="i">
				<cfoutput>
					<option value="#iif(i lt 10,"0 & i",DE(i))#" <cfif i is minute(now())>selected</cfif>>#iif(i lt 10,"0 & i",DE(i))#</option>
				</cfoutput>
			</cfloop>
		</cfselect>

		<cfselect name="releasedateampm" width="45">
				<option value="AM" <cfif hour(now()) lt 12>selected</cfif>>AM</option>
				<option value="PM" <cfif hour(now()) ge 12>selected</cfif>>PM</option>
		</cfselect>
		
		<cfinput type="hidden" name="releasedate" bind="{releasedateselector.text} {releasedatehour.value}:{releasedateminute.value} {releasedateampm.value}">
		
</cfformgroup>