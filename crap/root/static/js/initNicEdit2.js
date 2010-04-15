//<![CDATA[
$(document).ready(function(){
	// SETUP NICEDIT
	nicEditors.registerPlugin(nicPlugin,nicExampleOptions);
	myEditor = new nicEditor(
		{buttonList : ['fontSize','bold','italic','underline','strikeThrough','subscript','superscript','example']}
	);
	myEditor.setPanel('toolbar'); 
	// loop through instances and register them with nicEdit
	var fragments = $("#section-1 div").filter('[class=editArea]');
	gOriginalContent = new Array();
	gNewFragmentCount = 0;
	for (m=0; m<fragments.length; m++) {
		myEditor.addInstance(fragments[m].id);
		// remember the content before its saved
		gOriginalContent[fragments[m].id] = fragments[m].innerHTML;
		feed("<div>start '" + fragments[m].id +"': '" + gOriginalContent[fragments[m].id] + "'</div>");
	}
	// FOCUS+BLUR EDITOR EVENTS
	myEditor.addEvent('focus', function() {
		// $("#controls").appendTo("#" + myEditor.selectedInstance.elm.id);
		$("#controls").insertAfter("#" + myEditor.selectedInstance.elm.id);
		$("#controls").show();
	});
	myEditor.addEvent('blur', function() {
		if($("#controls").parent('div').attr('id')!="restore") {
		// to avoid firefox crashing, only call hide controls if they haven't been moved to "restore" div (ie. user clicked "delete")
			$("#controls").hide();
		}
	});
	
	// CONTROLS
	// variables created when a .icon is clicked, used by all 4 icons (up/down/add/delete)
	$(".icon").mousedown(function(event){
		previousFragmentObj = $(this).parents('.editFragment').prev();
		currentFragmentObj = $(this).parents('.editFragment');
		nextFragmentObj = $(this).parents('.editFragment').next();
		previousFragmentId = previousFragmentObj.children('.editArea').attr("id");
		currentFragmentId = currentFragmentObj.children('.editArea').attr("id");
		nextFragmentId = nextFragmentObj.children('.editArea').attr("id");
	});
	// up
	$("#iconUp").mousedown(function(event){
		// only perform switch if previousFragmentObj has the right class, ie. is a fragment
		if (previousFragmentObj.attr("class")=='editFragment') {
			previousFragmentObj.insertAfter(currentFragmentObj);
			updateListThingsToSave("move '" + previousFragmentId + "' below '" + currentFragmentId + "'");
		}
	});
	// down
	$("#iconDown").mousedown(function(event){
		// only perform switch if nextFragmentObj has the right class, ie. is a fragment
		if (nextFragmentObj.attr("class")=='editFragment') {
			nextFragmentObj.insertBefore(currentFragmentObj);
			updateListThingsToSave("move '" + nextFragmentId + "' above '" + currentFragmentId + "'");
		}
		// insertAfter seems to crash firefox
	});
	// add
	$("#iconAdd").mousedown(function(event){
		newFragment = $('.blankFragment').clone(true).insertAfter(currentFragmentObj);
		// change class of newFragment
		newFragment.attr("class", "editFragment");
		var newRef = "newEditArea-1-" + gNewFragmentCount;
		gNewFragmentCount++;
		// change id and class of child
		newFragment.children('.editBlank').attr("id", newRef);
		newFragment.children('.editBlank').attr("class", "editArea");
		// register child with nicedit so its editable
		myEditor.addInstance(newRef);
		gOriginalContent.push(newRef);
		updateListThingsToSave("add '" + newRef + "' below '" + currentFragmentId + "'");
	});
	// delete
	$("#iconDelete").mousedown(function(event){
		$('#controls').appendTo('#restore');
		// set html to ""
		currentFragmentObj.children('.editArea').html('');
		// then remove fragment container
		gOriginalContent.splice(currentFragmentId);
		myEditor.removeInstance(currentFragmentId);
		currentFragmentObj.remove();
		updateListThingsToSave("remove '" + currentFragmentId + "'");
	});
});
listThingsToSave = new Array;
// listThingsToSave function
function updateListThingsToSave(message) {
	listThingsToSave[listThingsToSave.length]=message;
}
// save function
function doSave() {
	for (i=0; i<listThingsToSave.length; i++) {
		feed("<div>" + listThingsToSave[i] + "</div>");
	}
	listThingsToSave = new Array;
	// rather than loop through fragments loop through nicEditor instances
	for (k=0; k<myEditor.nicInstances.length; k++) {
		//feed("<div>test '" + myEditor.nicInstances[k].id + ", " + myEditor.nicInstances[k].innerHTML + "': '" + gOriginalContent[k] + "'</div>");
		if (gOriginalContent[myEditor.nicInstances[k].elm.id] != myEditor.nicInstances[k].getContent()) {
			feed("<div>save '" + myEditor.nicInstances[k].elm.id +"': '" + myEditor.nicInstances[k].getContent() + "'</div>");
			gOriginalContent[myEditor.nicInstances[k].elm.id] = myEditor.nicInstances[k].getContent();
		};
	}
}
// feedback function
function feed(message) {
	if (message=="clear") {
		document.getElementById('feedbackArea').innerHTML = "";
	} else {
		document.getElementById('feedbackArea').innerHTML += message;
	}
}
//]]>