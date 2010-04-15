Joose.Storage.Unpacker.patchJSON();

Class("Fragment", {
    does: Joose.Storage,
    has: {
        html: {
            is: "rw",
            init: "&nbsp"
        },
        id: {
            is: "rw"
        },
        after_fragment: {
            is: "rw"
        }
    },
});
Class("SaveResponse", {
    does: Joose.Storage,
    has: {
        id: {
            is: "ro"
        },
        old_id: {
            is: "ro",
            predicate: "has_old_id"
        },
        status: {
            is: "ro"
        }
    },
    methods: {
        forPanel: function () {
            if (this.status == 'DELETED') {
                return "<div>Deleted <b>" + this.id + "</b></div>";
            }
            else if (this.status == 'OK') {
                return "<div>Saved <b>" + this.id + "</b></div>";
            }
            return JSON.stringify(this);
        }
    }
});

// define wysiwyg areas
$(document).ready(function(){
    // register the mau5 toolbar extension
    nicEditors.registerPlugin(nicPlugin,nicExampleOptions);
    // define the buttons in the toolbar
    myEditor = new nicEditor(
        {buttonList : ['fontSize','bold','italic','underline','strikeThrough','subscript','superscript','example']}
    );
    myEditor.setPanel('toolbar'); 
    // store the starting instance content when the page is loaded 
    // this is used later to decide whether to trigger a save or not 
    $('div.editFragment div.editArea').each(function(intIndex){
        myEditor.addInstance($(this).attr('id'));
    });
    // list of things to save
	contentBeforeSave = new Array;
    for (i=0; i<myEditor.nicInstances.length; i++) {
        contentBeforeSave[i]=myEditor.nicInstances[i].getContent();
    }
    // show + hide controls when wysiwyg instances are being edited
	myEditor.addEvent('focus', function() {
		activeInst = myEditor.selectedInstance.elm.id;
		jQuery("#editControl-" + activeInst).show();
	});
	myEditor.addEvent('blur', function() {
		jQuery(".editControl").hide();
	});
    $('.addFragment').mousedown(function(){
        var fragmentCount = $('div.editFragment').size();
        var editorName = '__NEW__' + fragmentCount;
        var text = '<div id="edit-__NEW__" class="editFragment">'
            + $('#edit-__NEW__').html()
            + '</div>';
        text = text.replace(/__NEW__/g, editorName);
        $(this).parents().filter('[class=editFragment]').append(text);
        myEditor.addInstance(editorName);
    });
    $('.deleteFragment').mousedown(function(){
        var to_nuke = $(this).parents().filter('[class=editFragment]');
        //children().filter('[class=editArea]');
        to_nuke.html('');
        doSave();
    });
    $(".moveFragmentUp").mousedown(function(event){
        move($(this).parents().filter('[class=editFragment]').attr("id"), $(this).attr("class"));
    });
    $(".moveFragmentDown").mousedown(function(event){
        move($(this).parents().filter('[class=editFragment]').attr("id"), $(this).attr("class"));
    });
});

// save function
function doSave() {
    // only trigger a save if the content has changed
    var j;
    var editAreas = $('div.editFragment div.editArea');
    for (j=0; j < editAreas.size(); j++) {
        //myNicEditor.instanceById(';
        var editor = myEditor.instanceById($(editAreas[j]).attr('id'));
        var fragment=editor.getContent();
        if (fragment!=contentBeforeSave[j]) {
            var myFragment = new Fragment();
            myFragment.setHtml(fragment);
            myFragment.setId(editor.elm.id);
            myFragment.setAfter_fragment($(editAreas[j-1]).attr('id'));
            $.ajax({  
                type: "POST",  
                //url: "bin/process.php",  
                data: JSON.stringify(myFragment),  
                contentType: "application/json",
                success: function(json) { 
                    var response = JSON.parse(json);
                    if (response.has_old_id()) { // Something in the document got its ID reassigned by the backend, deal with it.
                        $("#" + response.old_id).attr('id', response.id);
                    }
                    $('#feedbackArea').append(response.forPanel())  
                    // reset item just saved
                    contentBeforeSave[j]=fragment;
                },
                error: function (xhr, ajaxOptions, thrownError){
                    alert(xhr.statusText);
                }   
            });  
        } 
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
// move function
function move(id, action) {
	var pos = getOrder(id);
	var order = getOrder();
	if (action=="moveFragmentUp") {
		// only move up if item is not already at top
		if (pos>0) {
			var newPos = pos-1;
			// feed("<div>move [<b>" + id + "</b>] " + direction + " wrt " + order[pos-1].id + "</div>");
			swap(id, order[newPos].id);
		}
	} else if (action=="moveFragmentDown") {
		// only move down if item is not already at bottom
		if (pos<order.length-1) {
			var newPos = pos+1;
			// as there's no insertAfter use insertBefore but move the item following the one we had
			// ie. instead of moving item2 above item4, move item2+1 (ie. item3) above item2
			swap(order[pos+1].id, id);
		}
	}
}
function swap(itemToMove, itemToMoveAbove) {
	// https://developer.mozilla.org/En/DOM/Node.insertBefore
	// var insertedElement = parentElement.insertBefore(newElement, referenceElement);
	var moveItem = document.getElementById(itemToMove);
	var referenceItem = document.getElementById(itemToMoveAbove);
	var parentDiv = referenceItem.parentNode;
	// parentElement.insertBefore(moveItem, referenceItem);
	parentDiv.insertBefore(moveItem, referenceItem);
	//alert(parentDiv.id + ".insertBefore(" + moveItem.id + ", " + referenceItem.id + ")");	
}
// get order of fragments
function getOrder(who) {
	var fragments = $("#section-1").find("div").filter('[class=editFragment]');
	if (who) {
	// when getOrder takes a parameter it works like a getPosition instead
		for (m=0; m<fragments.length; m++) {
			if (fragments[m].id==who) {
				return(m);
			}
		} 
	} else {
		// print order
		/* un-comment to print out the order
		for (k=0; k<fragments.length; k++) {
			feed("<div>fragment #" + (k+1) + " = " + fragments[k].id + "</div>");
		}
		*/
		// return order
		return(fragments);
	}
}
