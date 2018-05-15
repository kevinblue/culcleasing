var dragenable=false;
var x;
var y;
var w;
var h;
var obj;
function init() {

x=event.clientX+document.body.scrollLeft;
obj=event.srcElement;
w=event.srcElement.offsetWidth;
obj.setCapture();
if(x>event.srcElement.offsetLeft+w-5 && x<event.srcElement.offsetLeft+w) {dragenable=true;obj.style.cursor='e-resize';}
}

function drag() {
 if(event.clientX+document.body.scrollLeft>event.srcElement.offsetLeft+event.srcElement.offsetWidth-5 && event.clientX+document.body.scrollLeft<event.srcElement.offsetLeft+event.srcElement.offsetWidth) {event.srcElement.style.cursor='e-resize';}
 else event.srcElement.style.cursor='default';
if(dragenable==true) {
 if(event.clientX+document.body.scrollLeft-x+w>0) {
 var i=obj.cellIndex;
 var j;
 for(j=0;j<obj.parentNode.parentNode.rows.length;j++) {
  obj.parentNode.parentNode.rows[j].cells[i].width=event.clientX+document.body.scrollLeft-x+w;
  }
 }
 else {
  var i=obj.cellIndex;
  var j;
  for(j=0;j<obj.parentNode.parentNode.rows.length;j++) {
   obj.parentNode.parentNode.rows[j].cells[i].width=1;
   }
  }
 }
}

function end() {
dragenable=false;
obj.releaseCapture();
obj.style.cursor='default';
}