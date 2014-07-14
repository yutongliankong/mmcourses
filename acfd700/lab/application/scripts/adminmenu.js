// JavaScript Document

/***********************************************
* Sliding Menu Bar Script- © Dynamic Drive (www.dynamicdrive.com)
* Visit http://www.dynamicdrive.com/ for full source code
* This notice must stay intact for use
***********************************************/

/***********************************************

Modified by Steve Drucker, Fig Leaf Software www.figleaf.com
(keepMenuInView effect)

***********************************************/

var slidemenu_width='160px' //specify width of menu (in pixels)
var slidemenu_reveal='12px' //specify amount that menu should protrude initially
var slidemenu_top='170px'   //specify vertical offset of menu on page

var ns4=document.layers?1:0
var ie4=document.all
var ns6=document.getElementById&&!document.all?1:0

if (ie4||ns6)
document.write('<div id="slidemenubar2" style="left:'+((parseInt(slidemenu_width)-parseInt(slidemenu_reveal))*-1)+'px; top:'+slidemenu_top+'; width:'+slidemenu_width+'" onMouseover="pull()" onMouseout="draw()">')
else if (ns4){
document.write('<style>\n#slidemenubar{\nwidth:'+slidemenu_width+';}\n<\/style>\n')
document.write('<layer id="slidemenubar" left=0 top='+slidemenu_top+' width='+slidemenu_width+' onMouseover="pull()" onMouseout="draw()" visibility=hide>')
}

var cLocation = location.href.split('?');
cLocation = cLocation[0];

if (location.href.indexOf('?edit') >= 0) {
  editmode=1;	
} else {
  editmode = 0;	
}

var sitems=new Array()

///////////Edit below/////////////////////////////////

//siteitems[x]=["Item Text", "Optional URL associated with text"]

sitems[0]=["CMS Menu", ""]
sitems[1]=["Create New Page", "javascript:fnNewPage()",true]

if  ((pageid) && !editmode) {
	sitems[2]=["Edit Current Page", "javascript:fnEditPage()",true]
} else {
	sitems[2]=["Edit Current Page", "javascript:fnEditPage()",false]
}

if ((pageid) && editmode) {
	sitems[3]=["View Current Page", "javascript:fnViewPage(cLocation)",true]
} else {
	sitems[3]=["View Current Page", "javascript:fnViewPage(cLocation)",false]
}

if (pageid) {
	sitems[4]=["Publish Changes","javascript:PublishPage()",true];
} else {
	sitems[4]=["Publish Changes","javascript:PublishPage()",false];
}

sitems[5]=["Templates", ""];
sitems[6]=["Edit Templates", "javascript:fnEditTemplates()", true]

sitems[7]=["Restaurant Admin", ""]
sitems[8]=["Reservations", "javascript:fnReservations()", true]
sitems[9]=["General", ""]
sitems[10]=["System Status", "javascript:fnSystemStatus()",true]
sitems[11]=["Reinitialize System", "javascript:fnReInitialize()",true]
sitems[12]=["Rebuild All Pages", "javascript:fnReCache()",true]
//If you want the links to load in another frame/window, specify name of target (ie: target="_new")
var target=""

/////////////////////////////////////////////////////////

if (ie4||ns4||ns6){
for (i=0;i<sitems.length;i++){
if (sitems[i][1])
  if (sitems[i][2]) {
        document.write('<a class="cmsmenulink" href="'+sitems[i][1]+'" target="'+target+'">');
  } else {
	 	 document.write('<a class="cmsmenulinkdisabled">');
  }
document.write(sitems[i][0])
if (sitems[i][1])
document.write('</a>')
document.write('<br>\n')
}
}

function regenerate(){
window.location.reload()
}
function regenerate2(){
if (ns4){
document.slidemenubar.left=((parseInt(slidemenu_width)-parseInt(slidemenu_reveal))*-1)
document.slidemenubar.visibility="show"
setTimeout("window.onresize=regenerate",400)
}
}
window.onload=regenerate2

rightboundary=0
leftboundary=(parseInt(slidemenu_width)-parseInt(slidemenu_reveal))*-1

if (ie4||ns6){
document.write('</div>')
themenu=(ns6)? document.getElementById("slidemenubar2").style : document.all.slidemenubar2.style
}
else if (ns4){
document.write('</layer>')
themenu=document.layers.slidemenubar
}

function pull(){
if (window.drawit)
clearInterval(drawit)
pullit=setInterval("pullengine()",10)
}

function draw(){
clearInterval(pullit)
drawit=setInterval("drawengine()",10)
}


function pullengine(){
if ((ie4||ns6)&&parseInt(themenu.left)<rightboundary)
themenu.left=parseInt(themenu.left)+10+"px"
else if(ns4&&themenu.left<rightboundary)
themenu.left+=10
else if (window.pullit){
themenu.left=0
clearInterval(pullit)
}
}

function drawengine(){
if ((ie4||ns6)&&parseInt(themenu.left)>leftboundary)
themenu.left=parseInt(themenu.left)-10+"px"
else if(ns4&&themenu.left>leftboundary)
themenu.left-=10
else if (window.drawit){
themenu.left=leftboundary
clearInterval(drawit)
}
}


function keepMenuInView() {

	var adjustment = document.body.scrollTop;
	var menuobj = document.getElementById('slidemenubar2');
	
	var currentposition = parseInt(menuobj.offsetTop);
	var lockedposition = document.body.scrollTop + 170;
	
	if (currentposition != lockedposition) {
		if (currentposition > lockedposition) {
			menuobj.style.top = (currentposition - 10) + 'px';	
		} else {
			menuobj.style.top = (currentposition + 10) + 'px';	
		}
		if (Math.abs(parseInt(menuobj.style.top) - lockedposition) < 10) {
			menuobj.style.top = lockedposition + 'px';	
		} else {
			setTimeout("keepMenuInView()",10);
		}
	}
	
}


setInterval("keepMenuInView();",2000);
