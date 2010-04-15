/*
nicExample
@description: An example button plugin for nicEdit
@requires: nicCore, nicPane, nicAdvancedButton
@author: Brian Kirchoff
@version: 0.9.0
http://wiki.nicedit.com/Creating+a+Plugin
*/

/* START CONFIG */
var nicExampleOptions = {
    buttons : {
        'example' : {name : __('Some alt text for the button'), type : 'nicEditorExampleButton'}
    }/* NICEDIT_REMOVE_START */,iconFiles : {'example' : '/static/nicEdit/src/mau5ToolbarExtension/icons/save.gif'}/* NICEDIT_REMOVE_END */
};
/* END CONFIG */

var nicEditorExampleButton = nicEditorButton.extend({   
  mouseClick : function() {
	doSave();
  }
});
