<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
	*{padding:0;margin:0;font:12px/12px '宋体';color:#333333}
	a{font:12px/12px '宋体';text-decoration:none;color:#666666}
	a:hover{text-decoration:underline}
	.g_top{height:60px;background-color:#EEEEEE;border-bottom:2px solid #999999;position:fixed;width:100%;z-index:3}
	.g_left{width:120px;background-color:#fefefe;border-right:2px solid #999999;height:100%;position:fixed;padding-top:62px}
	.g_left .title{text-indent:3px;height:25px;background:#DDDDDD;border-bottom:1px solid #CCCCCC;line-height:25px;font-size:12px}
	.g_left .option{height:25px;background:#EEEEEE;display:block;text-align:center;line-height:25px;border-bottom:1px solid #DDDDDD}
	.g_left .option:hover{background-color:#DDDDDD}
	.trueBody{padding-top:62px;padding-left:122px}
	.trueBody .title{font:600 14px/20px '宋体';border-bottom:2px solid #DDDDDD;width:300px;text-indent:15px;padding:5px 0}
</style>
<div class="g_top">	
</div>
<div class="g_left">
	<div class="title">商品管理</div>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/goods_listGoods.html">商品查询</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/goods_toAdd.html">增加商品</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/relevantGoods_relevantGoods.html">关联商品</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/bundling_bundling.html">绑定商品</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/goodsType_goodsType.html">商品类型</a>		
	<div class="title">网站配置</div>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/period_periodList.html">配送时段</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/pointToCoupon_pointToCoupon.html">积分兑换规则</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/slider_sliderList.html">幻灯片</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/activity_activityList.html">活动设置</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/coupon_couponList.html">优惠券</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/comment_commentList.html">商品评价</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/promotion_promotionList.html">促销活动</a>
	<div class="title">订单管理</div>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/order_orderList.html">订单列表</a>
	<a class="option" href="<s:property value="%{@com.haozhuoji.mall.util.Constant@admin_p}" />/order_orderMonitor.html">订单监控</a>
</div>
