<%@ page language="java" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
		<style type="text/css">
			.topSearchBar{width:1200px;height:60px;padding:15px 0;margin:0 auto;}
			.topSearchBar .logo{float:left;width:330px;height:60px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p"/>/images/g_image.png) no-repeat 0 -80px;cursor:pointer}
			.topSearchBar .search{float:left;width:500px;height:60px;display:inline-block;padding-right:120px}
			.topSearchBar .searchText{float:left;height:14px;padding:9px 6px;border:2px solid #eb4a3f;width:388px;font:14px/14px '宋体';color:#333333;outline:0}
			.topSearchBar .searchSubmit{float:left;height:36px;border:0;width:96px;background-color:#eb4a3f;text-align:center;font:18px/36px 'microsoft yahei';color:#ffffff;outline:0}
			.topSearchBar .hotSearch{width:500px;padding-top:4px;height:20px;overflow:hidden;font:12px/20px '宋体';color:#999999}
			.topSearchBar .hotSearch a{color:#999999;text-decoration:none}
			.topSearchBar .hotSearch a:hover{color:#eb4a3f}		
			.topSearchBar .timeInterval{float:left;width:250px;height:60px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p"/>/images/g_image.png) no-repeat -330px -80px}
			
			.naviBarFrame{;overflow:hidden}
			.naviBar{background-color:#eb4a3f;width:1200px;margin:0 auto;font:600 14px/35px '宋体';overflow:hidden}
			.naviBar .classDiv{width:180px;padding-left:20px;height:35px;background:#E8362C;color:#FFFFFF;float:left;font:600 14px/35px '宋体'}
			.naviBar .naviMenu{list-style: none outside none;float:left;background-color:#EB4A3F;width:750px}
			.naviBar .naviMenu li{float:left;display:block}
			.naviBar .naviMenu a{padding:0 25px;font:600 14px/35px '宋体';color:#FFFFFF;text-decoration:none;cursor:pointer;display:block}
			.naviBar .naviMenu .target{background-color:#c40000}
			.naviBar .cart{float:left;width:250px;height:35px;color:#ffffff;font:600 20px/35px 'microsoft yahei';text-indent:195px;}
			.naviBar .g_position_cart{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p"/>/images/g_image.png) no-repeat 0 -141px}
			
			.g_allClass {z-index:100;display:none;background-color:#FFFFFF;position:absolute;padding:0 10px;border:1px solid #DDDDDD;border-top:0;overflow:hidden;margin:0 auto;width:950px;box-shadow:1px 1px 1px #e0e0e0;}
			.g_allClass .g_classFrame1{overflow:hidden}
			.g_allClass .g_classFrame{padding:0 10px;border-bottom:1px solid #DDDDDD;overflow:hidden;float: left;}
			.g_allClass .g_classFrame .g_class_1{float:left;display:block;height:33px;width:140px;text-decoration:none;font:600 14px/33px '宋体';color:#EB4A3F}
			.g_allClass .g_classFrame .g_class_2{float:left;display:block;height:16px;margin:8px 5px;padding:0 10px;border-left:1px solid #DDDDDD;text-decoration:none;font:14px/16px '宋体';color:#666666}
			.g_allClass .g_classFrame .g_class_2:hover{color:#EB4A3F;text-decoration:underline}
			
			.fixed_navigation_cart{z-index:100;visibility:hidden;background-color:#FFffff;height:35px;border-bottom:1px solid #DDDDDD;position:fixed;top:0;left:0;width:100%;box-shadow:0 1px 0 #e0e0e0}
			.fixed_navigation_cart_form{width:1200px;margin:0 auto}
			.fixed_navigation_cart_class{height:35px;float:left;padding-left:20px;width:180px;font:600 14px/35px '宋体';color:#666666}
			.fixed_navigation_cart_search{float:left;width:750px}
			.fixed_navigation_cart .searchText{width:328px;border:1px solid #CCCCCC;float:left;height:12px;margin:5px 0;padding:5px 4px;font:12px/12px '宋体'}
			.fixed_navigation_cart .searchSubmit{cursor:pointer;width:100px;border:0;float:left;height:24px;font:600 12px/27px 'microsoft yahei';color:#FFFFFF;margin:5px 0;background-color:#cccccc;text-align:center}
			.fixed_navigation_cart .searchSubmit:hover{color:#EB4A3F}
			.fixed_navigation_cart_cart{color:#ffffff;font:600 20px/35px 'microsoft yahei';text-indent:195px;width:250px;float:left;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p"/>/images/g_image.png) no-repeat 0 -141px;height:35px}
		</style>
		<script type="text/javascript">
			function search(d){
				if($(d).find(".searchText").val()==""){
					return false;
				}else{
					return true;
				}
			};
			//Navigation hover
			$(function(){
				$(".naviMenu a").hover(function() {
					$(this).css({"background-color":"#c40000"});
				}, function() {
					$(this).css({"background-color":"#eb4a3f"});
				});
			});
			//All class
			$(function(){
				var timer;
				$(".g_allClass_flag").hover(function(){
					clearTimeout(timer);
					var position;
					if($(".fixed_navigation_cart").css("visibility")=="visible"){
						position = $(".fixed_navigation_cart_class").offset();
						$(".g_allClass").css({"display":"block","position":"fixed"}).offset({top:position.top+35,left:position.left});
					}else{
					    position = $(".classDiv").position();						
						$(".g_allClass").css({"display":"block","position":"absolute"}).offset({top:position.top+35,left:position.left});
					}
				},function(){
					timer=setTimeout(function(){
						$(".g_allClass").css({"display":"none"});
					},50);
				});
			});
			//Fixed cart
		    $(function () {
		        $(window).scroll(function () {
		            if (Math.max(document.body.scrollTop || document.documentElement.scrollTop)>= parseInt($("#g_naviBar").offset().top)) {
		                $(".fixed_navigation_cart").css({ 'visibility': 'visible'});
		                if($(".g_allClass").css("display")=="block"){
		                	var position = $(".fixed_navigation_cart_class").offset();
		                	$(".g_allClass").css({"position":"fixed"}).offset({top:position.top+35,left:position.left});
		                }
		                if($(".g_cart").css('display')=="block"){
		                	var position = $(".g_fixed_cart").offset();
		                	$(".g_cart").css({"position":"fixed"}).offset({top:position.top+35,left:position.left-101});
		                }
		            } else {
		            	$(".fixed_navigation_cart").css({ 'visibility':'hidden' });
		            	if($(".g_allClass").css("display")=="block"){
		            		var position =$(".classDiv").position();						
							$(".g_allClass").css({"position":"absolute"}).offset({top:position.top+35,left:position.left});
		            	}
		                if($(".g_cart").css('display')=="block"){
		                	var position = $(".g_position_cart").position();
		                	$(".g_cart").css({"position":"absolute"}).offset({top:position.top+35,left:position.left-101});
		                }
		            } 
		        });
		    });
		</script>
		<s:include value="/WEB-INF/jsp/frame/topStatus.jsp"></s:include>
		<div style="text-align:center;">
			<s:iterator value="#request.headerPromotionList">
				<s:a href="%{@com.haozhuoji.mall.util.Constant@http_p+'/promotion.html?promotionID='+promotionID}">
					<img src="<s:property value="@com.haozhuoji.mall.util.Constant@promotionImg_p+'/'+titleImg" />" alt="<s:property value="title" />" />
				</s:a>
			</s:iterator>
		</div>
		<div class="topSearchBar">
			<s:a href="%{@com.haozhuoji.mall.util.Constant@http_p}" cssClass="logo"></s:a>
			<div class="search">
				<div class="searchInput">
				<form action='<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/search.html' onsubmit="return search(this)">
					<s:textfield name="keyWord" cssClass="searchText" autocomplete="off"/>
					<input type="submit" class="searchSubmit" value="搜索" style="cursor:pointer" />
				</form>
				</div>
				<div class="hotSearch">
					<span>热门搜索：</span>
					<s:iterator value="#request.hotKeyWords.split('spe_spe')" var="_var">
						<s:a href="%{@com.haozhuoji.mall.util.Constant@http_p+'/search.html?keyWord='+#_var}"><s:property value="#_var"/></s:a>
					</s:iterator>
				</div>
			</div>
			<script type="text/javascript">
			var header_time=0;
			header_timeClock=function(){
				if(header_time>0){
					header_time = header_time-1;
					var d = header_time%60;
					$("#header_timeInterval div:eq(1)").text(parseInt(header_time/60)+"分"+(d<10?'0'+d:d)+"秒");
					setTimeout("header_timeClock()",1000);
				}else{
					header_getNextPeriod();
				}
			};
			header_getNextPeriod=function(){
				$.ajax({
					type:'post',
					url:'<s:property value="@com.haozhuoji.mall.util.Constant@http_p"/>/period_getNextPeriod.action',
					success:function(data){
						data =eval("("+data+")");
						$("#header_timeInterval div:eq(0)").text(data.period);
						header_time = Math.round((data.time-new Date().getTime())/1000);
						header_timeClock();
					},
					error:function(){
						$("#header_timeInterval div:eq(0)").text("载入失败");
					}
				});
			};
			$(function(){
				header_getNextPeriod();
			});
			</script>
			<div class="timeInterval" id="header_timeInterval">
				<div style="padding-top:11px;padding-left:145px;font:12px/12px '宋体'"></div>
				<div style="padding-top:1px;padding-left:165px;font:12px/12px '宋体'"></div>
			</div>
		</div>
		<div class="naviBarFrame">
			<div class="naviBar" id="g_naviBar">
				<div class="classDiv g_allClass_flag">
					所有商品分类
				</div>
				<ul class="naviMenu">
					<li><s:a href="%{@com.haozhuoji.mall.util.Constant@http_p}" >首页</s:a></li>
				</ul>
				<div class="cart g_cart_flag g_position_cart g_cart_total_count_flag">0</div>
			</div>
		</div>
		<div class="fixed_navigation_cart">
			<div class="fixed_navigation_cart_form">
				<div class="fixed_navigation_cart_class g_allClass_flag">所有商品分类</div>
				<div class="fixed_navigation_cart_search">
				<form action='<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/search.html' onsubmit="return search(this)">
					<s:textfield name="keyWord" cssClass="searchText" autocomplete="off"/>
					<input type="submit" value="搜  索" class="searchSubmit"/>
				</form>
				</div>
				<div class="fixed_navigation_cart_cart g_cart_flag g_fixed_cart g_cart_total_count_flag">0</div>
			</div>
		</div>
		<!-- 所有分类 -->
		<div class="g_allClass g_allClass_flag">
			<s:iterator value="#request.allGoodsTypeList">
				<div class="g_classFrame1">
					<div class="g_classFrame">
						<s:a href="%{@com.haozhuoji.mall.util.Constant@goodsType_p+typeID}.html" cssClass="g_class_1"><s:property value="typeName"/></s:a>
						<s:iterator value="subTypeList">
							<s:a href="%{@com.haozhuoji.mall.util.Constant@goodsType_p+typeID}.html" cssClass="g_class_2"><s:property value="typeName"/></s:a>
						</s:iterator>
					</div>
				</div>
			</s:iterator>
		</div>
		<s:include value="/WEB-INF/jsp/frame/cart.jsp"></s:include>