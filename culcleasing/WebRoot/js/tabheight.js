//div�Զ���Ӧ���ڸ߶ȹ��� ������ 080721

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
//		alert('չ��');
			var mydiv_resize=function(){
			    mydiv.style.height=document.body.clientHeight-240+"px";
			}
			mydiv_resize();
			window.onresize=mydiv_resize;
	}else
		{
//			alert('ȡ��չ��');
				var mydiv_resize=function(){
			    mydiv.style.height=document.body.clientHeight-129+"px";
				}
				mydiv_resize();
				window.onresize=mydiv_resize;
		}

	}
