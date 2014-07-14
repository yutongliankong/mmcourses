<cfif thisTag.ExecutionMode is 'start'>
<cfparam name="attributes.width" default="400">
<cfparam name="attributes.height" default="300">
<cfparam name="attributes.inputname" default="">
<cfparam name="attributes.label" default="">
<cfparam name="attributes.buttonStyle" default="">
<cfparam name="attributes.selectStyle" default="">
<cfparam name="attributes.value" default="">
<cfparam name="attributes.visible" default="true">
<cfparam name="attributes.onChange" default="">
<cfparam name="attributes.imagepath" default="">

<cfif attributes.inputname eq "">
<cfthrow message="You must provide a name for your textarea">
</cfif>

<cffunction name="getFormat" output="yes">
<cfargument name="name">
<cfsaveContent variable="mReturn">
var sStart=Selection.getBeginIndex();
var sEnd=Selection.getEndIndex();
if (sStart != sEnd){
_global.currentTextFormat = #name#.label.getTextFormat(sStart, sEnd);
	for(var a=0; a < #name#_font_select.dataProvider.length; a++){
		if(#name#_font_select.dataProvider[a].label == _global.currentTextFormat.font)
		#name#_font_select.selectedIndex = a;
	}
	for(var a=0; a < #name#_size_select.dataProvider.length; a++){
		if(int(#name#_size_select.dataProvider[a].label) == int(_global.currentTextFormat.size))
		#name#_size_select.selectedIndex = a;
	}
	for(var a=0; a < #name#_color_select.dataProvider.length; a++){
		if(Number(_global.currentTextFormat.color).toString(16) == Number(#name#_color_select.dataProvider[a].data).toString(16)){
		#name#_color_select.selectedIndex = a;
		}
	}
}
</cfsavecontent>
<cfreturn mReturn>
</cffunction>

<cffunction name="setFormat" output="yes">
<cfargument name="mType">
<cfargument name="mValue">
<cfargument name="contentField">
<cfsaveContent variable="mReturn">
//if the source control is a button we simply catch the selection indexes
//if the source control is a select we catch the selection indexes from the global variables that have been set by the onClick event of the select
if('#mType#' == 'font' || '#mType#' == 'size' || '#mType#' == 'color'){
var sStart=_global.sStart;
var sEnd=_global.sEnd;
}
else{
var sStart=Selection['lastBeginIndex'];
var sEnd=Selection['lastEndIndex'];
}
_global.currentTextFormat = #contentField#.getTextFormat(sStart, sEnd);
if (sStart != sEnd && _global.currentTextFormat.#mType# != true){
	if('#mType#' == 'font' || '#mType#' == 'size' || '#mType#' == 'color') 
	//we get the selected value from the select passed as argument
	_global.currentTextFormat.#mType# = _root.#mValue#.selectedItem.data;
	else
	_global.currentTextFormat.#mType# = '#mValue#';
}			
else _global.currentTextFormat.#mType# = false;
#contentField#.setTextFormat(sStart, sEnd, _global.currentTextFormat);
#contentField#._parent.dispatchEvent({type:'change'});
if (!('#mType#' == 'font' || '#mType#' == 'size' || '#mType#' == 'color')){
    Selection.setFocus('#contentField#');
    Selection.setSelection(sStart,sEnd);
}
</cfsavecontent>
<cfreturn mReturn>
</cffunction>
<cfset buttonWidth="18">
<cfset buttonHeight="18">
<cfset selectWidth="90">

<cfformgroup type="vertical">
			<!--- BUTTONS GROUP --->
			<cfformgroup type="horizontal" style="indicatorGap:0;">
				<!--- STYLES BUTTONS --->
				<cfinput type="Image" name="#attributes.inputname#_bold_btn" src="#attributes.imagepath#b.jpg" width="#buttonWidth#" height="#buttonHeight#" style="#attributes.buttonStyle#" onclick="#setFormat('bold','true','#attributes.inputname#.label')#;">
				<cfinput type="Image" name="#attributes.inputname#_italic_btn" src="#attributes.imagepath#i.jpg" width="#buttonWidth#" height="#buttonHeight#" style="#attributes.buttonStyle#" onclick="#setFormat('italic','true','#attributes.inputname#.label')#;">
				<cfinput type="Image" name="#attributes.inputname#_underline_btn" src="#attributes.imagepath#u.jpg" width="#buttonWidth#" height="#buttonHeight#" style="#attributes.buttonStyle#" onclick="#setFormat('underline','true','#attributes.inputname#.label')#;">
				<cfformitem  type="vrule" height="20" width="8" />
				<cfinput type="Image" name="#attributes.inputname#_left_btn" src="#attributes.imagepath#left.jpg" width="#buttonWidth#" height="#buttonHeight#" style="#attributes.buttonStyle#" onclick="#setFormat('align','left','#attributes.inputname#.label')#;">
				<cfinput type="Image" name="#attributes.inputname#_center_btn" src="#attributes.imagepath#center.jpg" width="#buttonWidth#" height="#buttonHeight#" style="#attributes.buttonStyle#" onclick="#setFormat('align','center','#attributes.inputname#.label')#;">
				<cfinput type="Image" name="#attributes.inputname#_right_btn" src="#attributes.imagepath#right.jpg" width="#buttonWidth#" height="#buttonHeight#" style="#attributes.buttonStyle#" onclick="#setFormat('align','right','#attributes.inputname#.label')#;">
				<cfformitem  type="vrule" height="20" width="8" />
				<cfinput type="Image" name="#attributes.inputname#_bullet_btn" src="#attributes.imagepath#bullet.jpg" width="#buttonWidth#" height="#buttonHeight#" style="#attributes.buttonStyle#" onclick="#setFormat('bullet','true','#attributes.inputname#.label')#;">
			</cfformGroup>
			
			<cfformgroup type="horizontal" style="indicatorGap:0;">
				<cfselect name="#attributes.inputname#_font_select" width="#selectWidth#" style="#attributes.selectStyle#" 	onmousedown="_global.sStart=Selection['lastBeginIndex'];_global.sEnd=Selection['lastEndIndex'];"
onchange="#setFormat('font','#attributes.inputname#_font_select','#attributes.inputname#.label')#;">
				<!--- the selectedIndex is reset to 0 at the end of the onChange event, we do this because the select uses the onChanged event to apply the style, which wouldn't be triggered if we wanted to apply the same style to another selection --->
					<cfset fontList="_sans,_serif,_typewriter,Arial,Arial Black,Verdana,Impact, Courier New,Georgia,Helvetica,Times New Roman">
					<cfloop list="#fontList#" index="i">
					<option value="<cfoutput>#i#</cfoutput>"><cfoutput>#i#</cfoutput></OPTION>
					</cfloop>
				</cfselect>
				<!--- SIZE SELECT --->
				<cfselect name="#attributes.inputname#_size_select" width="40" style="#attributes.selectStyle#"	
				onmousedown="_global.sStart=Selection['lastBeginIndex'];_global.sEnd=Selection['lastEndIndex'];"
				onchange="#setFormat('size','#attributes.inputname#_size_select','#attributes.inputname#.label')#;">
					<cfloop from="6" to="64" index="i" step="1">
					<option value="<cfoutput>#i#</cfoutput>"><cfoutput>#i#</cfoutput></OPTION>
					</cfloop>
				</cfselect>
				<!--- COLOR SELECT --->
				<cfselect name="#attributes.inputname#_color_select" label="Color" width="#selectWidth#"	style="#attributes.selectStyle#"
				onmousedown="_global.sStart=Selection['lastBeginIndex'];_global.sEnd=Selection['lastEndIndex'];"
				onchange="#setFormat('color','#attributes.inputname#_color_select','#attributes.inputname#.label')#;">
					<cfset colorList="0x0B333C,0xFF0000,0x00FF00,0x0000FF,0x000000,0xEDEDED,0xAEAEAE">
					<cfset colorNames="DEFAULT,RED,GREEN,BLUE,BLACK,LIGHT GRAY,DARK GRAY">
					<cfset x=1>
					<cfloop list="#colorList#" index="i">
					<cfoutput><option value="#i#">#listGetat(colorNames, x)#</OPTION></cfoutput>
					<cfset x = x + 1>
					</cfloop>
				</cfselect>
			</cfformgroup>
				<!--- TEXTAREA FOR EDITING --->
			<cfformgroup type="horizontal" width="#attributes.width#" style="indicatorGap:0;">
				<cftextarea name="#attributes.inputname#" height="#attributes.height#" label="#attributes.label#" style="#attributes.style#" 
onMouseUp="#getFormat(attributes.inputname)#;" onChange="#attributes.onChange#;"><cfoutput>#attributes.value#</cfoutput></cftextarea>
/>
				<cfinput type="hidden" name="#attributes.inputname#_trigger" bind="{(1 != 2) ? #attributes.inputname#.html=true : null}">
			</cfformgroup>
		</cfformgroup>
</cfif>		
