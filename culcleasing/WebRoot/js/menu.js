// JavaScript Document
/*//////////////////////////////////////////////////
扩展式菜单函数 05.003 SOMAX 05.05.27
expmode=0|1,默认为0
HTML结构及初始化代码如下
<div id="menu1" expmode=0> 
  <div id="menunode"> 
    <div id="menutit" onClick="expThis()">tit</div> 
    <div id="menusub">...</div> 
  </div>
  ...
</div>
<script>initMenu(menu1,0);</script>
*/////////////////////////////////////////////////



function expMenu(menusub){
	if(menusub.style.display!="none"){
		menusub.style.display="none";
	}else{
		menusub.style.display="";
	}
}

function setAllMenu(menu,disp){
	var arrMenusub=menu.all.menusub;
	for (i=0;i<arrMenusub.length;i++){
		arrMenusub[i].style.display=disp;
	}
	
}

function closeAll(menu){
	setAllMenu(menu,"none");
}

function expAll(menu){
	setAllMenu(menu,"");
}

function expThis(){
	var theMenu =event.srcElement.parentNode.parentNode;
	var theMenusub = event.srcElement.parentNode.all.menusub;
	if (theMenu.expmode==1 )closeAll(theMenu);
	expMenu(theMenusub);
}

function initMenu(menu,index){
	closeAll(menu);
	if (index>=0)expMenu(menu.all.menusub[index]);//2005.5.27
}

