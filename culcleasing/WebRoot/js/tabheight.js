//div自动适应窗口高度功能 王晓东 080721

	function setDivHeight(name,Height){
			var mydiv=document.getElementById(name);
			var mydiv_resize=function(){
			    mydiv.style.height=document.body.clientHeight+Height+"px";
			}
			mydiv_resize();
			window.onresize=mydiv_resize;
	}
		function setDivHeight2(name,Height){
	var mydiv=document.getElementById(name);
	if (document.all.Changeicon.src.search("images/jt_a.gif") != -1)
	{
//		alert('展开');
			var mydiv_resize=function(){
			    mydiv.style.height=document.body.clientHeight-240+"px";
			}
			mydiv_resize();
			window.onresize=mydiv_resize;
	}else
		{
//			alert('取消展开');
				var mydiv_resize=function(){
			    mydiv.style.height=document.body.clientHeight-129+"px";
				}
				mydiv_resize();
				window.onresize=mydiv_resize;
		}

	}
