<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>订单监控页面</title>
    <title>好着急后台管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<s:include value="/WEB-INF/jsp/admin/headMeta.jsp"></s:include>
	<script type="text/javascript" src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/js/jquery.cookie.js"></script>
	<script type="text/javascript">
		try{
		$(function(){
			var returnCookie='byPrintDateTime';
			initMonitor = function(){
				if($.cookie(returnCookie)=='null'){
					$(".monitoring").text("正在"+$(".monitor .item:eq(1)").text()+"...");
					$(".monitor .item").css({color:'#333333'});
					$(".monitor .item:eq(1)").css({color:'red'})
				}else{
					$(".monitoring").text("正在"+$(".monitor .item:eq(0)").text()+"...");			
					$(".monitor .item").css({color:'#333333'});
					$(".monitor .item:eq(0)").css({color:'red'})
				}
			}
			getOrder=function(){
				$.ajax({
					url:'<s:property value="@com.haozhuoji.mall.util.Constant@admin_p" />/order_getOrder.action',
					type:'post',
					data:{byPrintDateTime:$.cookie(returnCookie)},
					success:function(data){
						data=eval("("+data+")");
						$(".colorDiv").css({display:'none'});
						$(".noOrder").find("span").text(getCurrentTime());
						if(data.print=="true"){
							$(".haveOrder").css({display:'block'});
							$("#embodyFrame").html($('<embed id="reminder" src="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/reminder.mp3" autoplay="true" loop="true"/>'));
						}else{
							$(".noOrder").css({display:'block'});
							$("#reminder").remove();
						}
					},
					error:function(){
						$(".colorDiv").css({display:'none'});
						$(".serverError").css({display:'block'});
					}
				});
				setTimeout("getOrder()",30000);
				selectPeriod();
			};
			selectPeriod=function(){
				var d = new Date();
				var d1 = new Date();
				var t = null;
				$(".period").each(function(){
					var hms = $(this).find("span").text().split(":");
					d1.setHours(hms[0]);
					d1.setMinutes(hms[1]);
					d1.setSeconds(hms[2]);
					if(d>d1){
						t=this;
					}else{
						return;
					}
				});
				$(".period").css({color:'#333333'});
				if(t!=null){
					$(t).css({color:'red'});
				}
			}
			getCurrentTime=function(){
				var d = new Date();
				var r = '';
				r+=d.getHours()<10?'0'+d.getHours():d.getHours();
				r+=":";
				r+=d.getMinutes()<10?'0'+d.getMinutes():d.getMinutes();
				r+=":";
				r+=d.getSeconds()<10?'0'+d.getSeconds():d.getSeconds();
				return r;
			}
			$(".monitor .item").click(function(){
				var dd = $(this).attr("byPrintDateTime");
				if(dd==null){					
					$.cookie(returnCookie,null);
				}else{
					$.cookie(returnCookie,'true',{expires:365});
				}
				initMonitor();
			});
			printOrder=function(){
				$("#reminder").remove();
				$(".colorDiv").css({display:'none'});
				$(".noOrder").css({display:'block'});
				if($.cookie(returnCookie)=="null"){
					window.open('<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}"/>/order_printOrder.html');
				}else{
					window.open('<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}"/>/order_printOrder.html?byPrintDateTime=true');					
				}
				return false;
			};
			//初始化监控器
			initMonitor();
			//开始监控
			getOrder();
		});
		}catch(e){
			location.reload();
		}
	</script>
  </head>
  <body>
	<s:include value="/WEB-INF/jsp/admin/menu.jsp"></s:include>
	<style type="text/css">
		.colorDiv{height:100px;color:#ffffff;font:40px/100px 'microsoft yahei';display:none}
		.colorDiv span{color:#ffffff;font:40px/100px 'microsoft yahei'}
		.colorDiv a{color:#46E046;font:40px/100px 'microsoft yahei'}
		.noOrder{background-color:green}
		.haveOrder{background-color:red}
		.serverError{background-color:blue}
		.periodFrame{overflow:hidden;padding:30px 10px;width:800px}
		.period{font:16px/20px 'microsoft yahei';float:left;border:1px solid #dddddd;padding:5px;margin:7px}
		.monitor{overflow:hidden;margin-bottom:30px}
		.monitor .item{width:200px;height:40px;font:20px/40px 'microsoft yahei';text-align:center;background-color:#dddddd;float:left;margin-right:30px;cursor:pointer}
		.monitor .monitoring{height:40px;font:20px/40px 'microsoft yahei';text-align:center;float:left;margin-right:30px;cursor:pointer}
	</style>
	<div class="trueBody">
		<div class="title">
			订单监控
		</div>
		<div class="periodFrame">
			<s:iterator value="#request.periodList">
				<div class="period"><s:property value="timePeriod" /><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><s:property value="@com.haozhuoji.mall.util.DateUtil@formatTime(printTime)" /></span></div>
			</s:iterator>
		</div>
		<div class="monitor">
			<div class="item" byPrintDateTime="true">按打印时间监控</div>
			<div class="item">监控所有未打印订单</div>
			<div class="monitoring"></div>
		</div>
		<div class="colorDiv noOrder">暂无订单，更新时间：<span></span></div>
		<div class="colorDiv haveOrder">有未打印订单，<a href="javascript:void(0)" onclick="printOrder();">请打印</a></div>
		<div class="colorDiv serverError">服务器异常</div>
		<div id="embodyFrame" style="width:1px;height:1px;overflow:hidden"></div>
	</div>
  </body>
</html>
