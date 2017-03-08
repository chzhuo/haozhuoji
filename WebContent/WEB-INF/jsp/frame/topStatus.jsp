<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<style type="text/css">
	.topBar{border-bottom:solid 1px #DBDBDB;color:#666666;font:12px/30px '宋体';box-shadow:0 0 1px #e0e0e0}
	.topBar .topBar_content{width:1200px;height:30px;margin:0 auto}
	.topBar .content_left{float:left}
	.topBar .content_right{float:right;overflow:hidden}
	.topBar a{color:#666666;text-decoration:none;height:30px;cursor:pointer;}
	.topBar .content_left a{line-height:30px}
	.topBar a:hover{color:#eb4a3f;text-decoration:underline}
	.topBar .item{margin:9px 0;border-left:1px solid #dddddd;float:left;font:12px/12px '宋体';float:left;width:auto;padding:0 15px}
</style>
<html xmlns:wb="http://open.weibo.com/wb">
<div class="topBar">
	<div class="topBar_content">
		<div class="content_left">
			Hi
			<s:if test="#session.userBean==null">
			<a href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/login.html ">[登陆]</a>
			<a href="<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/register.html ">[注册]</a>
			</s:if>
			<s:else>
				<a href="<s:property value="@com.haozhuoji.mall.util.Constant@user_p" />/user_userInfo.html "><s:property value="#session.userBean.nickName"/></a>
				<a href="javascript:void(0)" onclick="location.href = '<s:property value="@com.haozhuoji.mall.util.Constant@http_p" />/logout.html?href='+location.href">[退出]</a>
			</s:else>
		</div>
		<div class="content_right">
			<div class="item"><s:a href="%{@com.haozhuoji.mall.util.Constant@http_p+'/user/order_orderPage.html'}">我的订单</s:a></div>
			<div class="item"><a>帮助中心</a></div>
			<div class="item" style="height:24px;margin:3px 15px 3px 0;border:0"><wb:follow-button uid="3909216450" type="gray_2" width="110px" height="24px" ></wb:follow-button></div>
			<script type="text/javascript">
				$(function(){
					$("#weixinFocus").hover(function(){
						$("#weixinFocusImg").css({display:'block',left:$(this).offset().left-150});
					},function(){
						$("#weixinFocusImg").css({display:'none'});
					});
				});
			</script>
			<div class="item" id="weixinFocus" style="width:93px;padding-right:0;height:18px;margin:6px 0;border:0;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat 0 -250px"></div>
		</div>
	</div>
</div>
<img id="weixinFocusImg" style="z-index:10;display:none;top:31px;position:absolute;width:258px;height:258px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/g_image.png) no-repeat 0 -280px" />
<s:include value="/WEB-INF/jsp/frame/message.jsp"/>