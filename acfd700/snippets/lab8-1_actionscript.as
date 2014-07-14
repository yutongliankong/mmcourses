	var validateGrid = function (){
	   if (isNaN(_root.templategrid.selectedIndex)) {
		  alert("You must select a template!","Warning");	
		  return false;
		} else {
		  return true;
		}
	}