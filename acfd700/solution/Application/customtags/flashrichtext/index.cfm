<cfif parameterExists(form.submit_btn)>
<cfdump var="#form#">
<cfset myOldString = form.comments2>
<!--- do the replace looping --->
<cfset myNewString = myOldString>
<cfset baseFont = 12>
<cfloop from="6" to = "64" index="idx">
   <cfset myNewString = REReplaceNoCase(myNewString,'<font([^>]+)size="#idx#"([^>]*)>','<font\1size="+#Evaluate(idx-baseFont)#"\2>','all')>
</cfloop>
<cfoutput>#myNewString#</cfoutput>
</cfif>

<cfparam name="form.comments2" default="This <font color='##FF0000'>is</font> a <b>Start<i>Value</i></b>">
<cfform format="flash" name="myForm" skin="haloSilver" style="fontSize:9;fontFace:Helvetica;verticalGap:0;horizontalGap:0;marginLeft:0;marginRight:0;">
<cf_richTextArea name="comments2" width="280" height="150" value="#form.comments2#" style="cornerRadius:10;marginLeft:5;marginRight:5;dropShadow:true;shadowDistance:3;shadowDirection:right;themeColor:##FFFFFF;" buttonStyle="borderThickness:0;cornerRadius:0;" selectStyle="cornerRadius:0;"/>
<cfformgroup type="HORIZONTAL" style="indicatorGap:0;">
<cfinput type="submit" name="submit_btn" value="Submit form">
<cfinput type="button" name="download" value="Source files" onClick="getURL('richTextAreaIcons.zip','_blank')">
<cfinput type="button" name="prev" value="Previous version" onClick="getURL('http://cfpim.coffeeflower.com/richtextarea.cfm','_blank')">
</cfformgroup>
</cfform>


