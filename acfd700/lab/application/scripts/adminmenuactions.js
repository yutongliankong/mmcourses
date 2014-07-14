// JavaScript Document

var pageid;
var articleid;


function fnOpenWin(url,winname,width,height) {
	
	LeftPosition = (screen.width) ? (screen.width-width)/2 : 0;
	TopPosition = (screen.height) ? (screen.height-height)/2 : 0;
	settings = 'height='+height+',width='+width+',top='+TopPosition+',left='+LeftPosition+',resizable';
	win = window.open(url,winname,settings);
	win.focus();
}

function fnReservations() {
	fnOpenWin(basehref + '../../walk/wt8-8.cfm','reservations',640,480);
}

function fnSystemStatus() {
	fnOpenWin(basehref + 'admin/cms/misc/systemstatus.cfm','SystemStatus',640,480);
}

function fnNewPage() {
	fnOpenWin(basehref + 'admin/cms/page/createpage.cfm','CreateNewPage',550,380);		
}

function fnNewArticle(pageid) {
	fnOpenWin(basehref + 'admin/cms/article/index.cfm?pageid=' + pageid,'NewArticle',800,360);
}

function fnEditArticle() {
	fnOpenWin(basehref + 'admin/cms/article/index.cfm?articleid=' + articleid,'NewArticle',800,360);
}


function fnSelectDisplayTemplate() {
		fnOpenWin(basehref + 'admin/cms/article/selectdisplaytemplate.cfm?articleid=' + articleid + '&pageid=' + pageid,'SelectDisplayTemplate',400,200);
}

function fnNewArticleAfter() {
		fnOpenWin(basehref + 'admin/cms/article/index.cfm?pageid=' + pageid + '&after=' + articleid,'NewArticle',800,360);
}

function fnNewArticleBefore() {
		fnOpenWin(basehref + 'admin/cms/article/index.cfm?pageid=' + pageid + '&before=' + articleid,'NewArticle',800,360);
}

function fnMoveUp() {
		fnOpenWin(basehref + 'admin/cms/article/move.cfm?articleid=' + articleid + '&pageid=' + pageid + '&mode=up','moveArticle',100,100);
}

function fnMoveDown() {
		fnOpenWin(basehref + 'admin/cms/article/move.cfm?articleid=' + articleid + '&pageid=' + pageid + '&mode=down','moveArticle',100,100);
}


function fnRemoveArticle() {
	fnOpenWin(basehref + 'admin/cms/article/remove.cfm?articleid=' + articleid + '&pageid=' + pageid,'moveArticle',100,100);
}

function fnDeleteArticle() {
	fnOpenWin(basehref + 'admin/cms/article/delete.cfm?articleid=' + articleid,'moveArticle',100,100);
}

function fnArticleSelectBefore() {
		fnOpenWin(basehref + 'admin/cms/article/select.cfm?articleid=' + articleid + '&pageid=' + pageid + '&mode=before','selectArticle',830,390);
}

function fnArticleSelectAfter() {
		fnOpenWin(basehref + 'admin/cms/article/select.cfm?articleid=' + articleid + '&pageid=' + pageid + '&mode=after','selectArticle',830,390);
}

function fnArticleMenu(a, p) {
	
	articleid = a;
	pageid = p;
	
	var obj = document.getElementById('articlemenu');
	if (document.all) {
		obj.style.top = event.clientY + document.body.scrollTop;
		obj.style.left = event.clientX;
	} else {
		obj.style.left = nsX ;
		obj.style.top = nsY;
	}
	obj.style.display = 'block';

}

function PublishPage() {
	fnOpenWin(basehref + 'admin/cms/page/publish.cfm?pageid=' +pageid,'publishpage',100,100);
}

function fnEditPage() {
	//location.href = location.href + '?edit=1';
	fnOpenWin(basehref + 'admin/cms/page/editmode.cfm?type=page&id=' +pageid,'editpage',325,150);
}

function fnReInitialize() {
	var apage = location.href.split('?');
	location.href = apage[0] + '?init=1';
}

function fnViewPage(url) {
	location.href	= url;
}

function fnEditTemplates() {
	fnOpenWin(basehref + 'admin/cms/templates/index.cfm','EditTemplates',700,450);
}

function fnReCache() {
	fnOpenWin(basehref + 'admin/cms/page/publishallpages.cfm','publishpage',640,480);
}

/* Mozilla Mouse Positioning */

function fnNSmousetrack(e) {

	nsX = e.layerX;
	nsY = e.layerY;

}

if (!document.all) {
  var nsX = 0;
  var nsY = 0; 
  document.onmousemove = fnNSmousetrack;
}
