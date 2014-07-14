var handleValidation = function (errors){
			
	if (errors['title'] != undefined) {
		tab1.selectedIndex = 0;
		_root.title.setFocus();
		return;
	}
			
	if (errors['fulltext'] != undefined) {
		tab1.selectedIndex=1;
		_root.fulltext.setFocus();
		return;
	}
}