<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<script type="text/javascript">
	$(function(){
		g_mess={
			params:null,
			show:function(p){
				var defaultParams = {
						showCover:true,
						titleColor:'#333333',
						contentColor:'#eb4a3f',
						showAjax:false,
						content:'',
						title:'提示',
						confirmContent:'确定',
						cancelContent:'取消',
						showConfirm:true,
						confirm:null,
						showCancel:true,
						cancel:null,
						canDrag:true
				};
	            g_mess.params =p?g_mess.extend(defaultParams,p):defaultParams;
	            
	            //drag register event
	            if(g_mess.params.canDrag){
					 $("#g_mess_remain .g_mess_title").mousedown(function(e){  
			                var offset = $("#g_mess_remain").offset();
			                var x = e.pageX - offset.left;
			                var y = e.pageY - offset.top;
			                $(document).bind("mousemove",function(ev){  
			                    $("#g_mess_remain").stop();
			                    var _x = ev.pageX - x;
			                    var _y = ev.pageY - y;
			                    $("#g_mess_remain").animate({left:_x+"px",top:_y+"px"},0);  
			                });  
			         });
		            $(document).mouseup(function(){  
		                 $(this).unbind("mousemove");  
		            });
	            }
			 	//confirm click register event
          	   if(g_mess.params.confirm!=null){
		          $("#g_mess_remain .g_mess_confirm").click(function(){
		          			g_mess.params.confirm();
		            });
          	   }
			 	//cancel click register event
          	   if(g_mess.params.showCancel!=null){
	             $("#g_mess_remain .g_mess_cancel").click(function(){
	          			g_mess.params.cancel();
	             });
          	   }
	           	$("#g_mess_remain .g_mess_title").text(g_mess.params.title).css({color:g_mess.params.titleColor});
				 if(g_mess.params.showAjax){
					 $("#g_mess_remain .g_mess_consub").css({"display":"none"});
					$("#g_mess_remain span").css({display:'block'}).text(g_mess.params.content).css({color:g_mess.params.contentColor});
					$("#g_mess_remain .g_mess_message").css({background:"url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/ajax/ajax-b.gif) no-repeat center center"}).text("");
				 }else{
					 $("#g_mess_remain .g_mess_message").css({background:''});
		           	$("#g_mess_remain .g_mess_message").text(g_mess.params.content).css({color:g_mess.params.contentColor});
		           	$("#g_mess_remain .g_mess_confirm").text(g_mess.params.confirmContent).css({display:g_mess.params.showConfirm?'block':'none'});					 
		           	$("#g_mess_remain .g_mess_cancel").text(g_mess.params.cancelContent).css({display:g_mess.params.showCancel?'block':'none'});
		           	if(g_mess.params.showConfirm!=g_mess.params.showCancel){
		           		$("#g_mess_remain .g_mess_consub").css({"margin-left":"100px"});
		           	}else{
		           		$("#g_mess_remain .g_mess_consub").css({"margin-left":"33px"});		           		
		           	}
		           	$("#g_mess_remain span").css({display:'none'});
				 }
				 if(g_mess.params.showCover){
					 $("#g_cover").width($(window).width()).height($(window).height()).css({"display":"block"});
				 }
				$(window).resize(function(){
					$("#g_mess_remain").css({top:($(window).height()-100)/2,left:($(window).width()-300)/2});
					if(g_mess.params.showCover){
						$("#g_cover").width($(window).width()).height($(window).height());
					}
				});
				$("#g_mess_remain").css({top:($(window).height()-100)/2,left:($(window).width()-300)/2}).css({"display":"block"});
        	},
			close:function(){
           		$("#g_mess_remain").css({display:"none"});
           		$("#g_cover").css({display:"none"});
           		$(window).unbind("resize");
           	   if(g_mess.params.confirm!=null){
 		          $("#g_mess_remain .g_mess_confirm").unbind("click");
           	   }
           	   if(g_mess.params.showCancel!=null){
 	             $("#g_mess_remain .g_mess_cancel").unbind("click");
           	   }
           	},
           	alert:function(content,confirm){
           		g_mess.show({content:content,showCancel:false,confirm:function(){if(confirm)confirm();g_mess.close();}});
           	},
           	ajax:function(content){
           		g_mess.show({content:content,showAjax:true});
           	},
           	extend:function (t, s, b) {
                if (s) {
                    for (var k in s) {
                        if (!b || !t.hasOwnProperty(k)) {
                            t[k] = s[k];
                        }
                    }
                }
                return t;
            }
		};
	});
</script>
<style type="text/css">
	#g_cover{position:fixed;background-color:#dddddd;top:0;left:0;z-index:998;opacity:0.3;display:none}
	#g_mess_remain{background-color:#ffffff;width:300px;box-shadow:0 0 10px #eb4a3f;border:1px solid #F6ABA6;position:fixed;z-index:999;display:none}
	#g_mess_remain .g_mess_title{height:20px;border-bottom:1px solid #eeeeee;background-color:#fafafa;font:12px/20px 'microsoft yahei';text-indent:6px;cursor:move}
	#g_mess_remain .g_mess_message{padding:10px;height:40px;color:#eb4a3f;font:12px/20px '宋体';text-align:center}
	#g_mess_remain .g_mess_con{text-align:center;height:26px;margin-bottom:5px;overflow:hidden}
	#g_mess_remain .g_mess_consub{float:left;height:15px;padding:3px 0;width:100px;font:12px/15px 'microsoft yahei';text-align:center;cursor:pointer;background-color:#cccccc;color:#ffffff;border-radius:3px}
	#g_mess_remain .g_mess_consub:hover{background-color:#aaaaaa}
</style>
<div id="g_cover"></div>
<div id="g_mess_remain">
	<div class="g_mess_title">提示</div>
	<div class="g_mess_message"></div>
	<div class="g_mess_con">
		<span>打底衫顶顶顶顶1</span>
		<div class="g_mess_confirm g_mess_consub">确定</div>
		<div class="g_mess_cancel g_mess_consub">取消</div>
	</div>
</div>