<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<style type="text/css">
	.uc_left{width:200px;border:1px solid #eeeeee;float:left;overflow:hidden}
	.uc_left .title{height:25px;background-color:#eeeeee;font:16px/25px 'microsoft yahei';text-indent:10px;color:#333333}
	.uc_left .option{height:25px;background-color:#ffffff;line-height:25px;text-indent:30px;text-decoration:none;display:block}
	.uc_left .option:hover{color:#eb4a3f;text-decoration:underline;background-color:#fafafa}
	.uc_title{height:20px;width:1000px;margin:0 auto;padding:10px 5px;font:20px/20px 'microsoft yahei';color:#333333}
	.uc_frame{width:1000px;margin:0 auto;overflow:hidden}
	.uc_right{margin:3px 0;padding:15px;width:745px;margin-left:16px;float:left;box-shadow: 0 0 10px #e0e0e0;overflow:hidden;border:1px solid #eeeeee}
</style>
<div class="uc_left">
	<script type="text/javascript">
		$(function(){
			$(".uc_left .option").each(function(){
				if($(this).attr("href")==location.href.split('?')[0]){
					$(this).attr("href","javascript:void(0)").css({color:'#eb4a3f'});
					return;
				}
			});
		});
	</script>
	<div class="title">账户中心</div>
	<s:a href="%{@com.haozhuoji.mall.util.Constant@user_p+'/user_userInfo.html'}" cssClass="option">账户信息</s:a>
	<s:a href="%{@com.haozhuoji.mall.util.Constant@user_p+'/user_userAddress.html'}" cssClass="option">收货地址</s:a>
	<s:a href="%{@com.haozhuoji.mall.util.Constant@user_p+'/user_userPoints.html'}" cssClass="option">我的积分</s:a>
	<s:a href="%{@com.haozhuoji.mall.util.Constant@user_p+'/user_coupon.html'}" cssClass="option">优惠券/代金券</s:a>
	<div class="title">订单中心</div>
	<s:a href="%{@com.haozhuoji.mall.util.Constant@user_p+'/order_orderPage.html'}" cssClass="option">我的订单</s:a>
	<s:a href="%{@com.haozhuoji.mall.util.Constant@user_p+'/goods_collectionList.html'}" cssClass="option">我的收藏</s:a>
	<s:a href="%{@com.haozhuoji.mall.util.Constant@user_p+'/goods_BHList.html'}" cssClass="option">浏览记录</s:a>
</div>