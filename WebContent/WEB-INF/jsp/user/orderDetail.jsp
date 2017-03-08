<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/user/headMeta.jsp"/>
		<title>订单详情页面 <s:property value="#request.orderNumber.orderNumber"/> -好捉急校园便利店</title>
		<style type="text/css">
			.uc_title{height:20px;width:1000px;margin:0 auto;padding:10px 5px;font:20px/20px 'microsoft yahei';color:#333333}
			.uc_frame{width:1000px;margin:0 auto;overflow:hidden}
			.uc_right{width:780px;margin-left:18px;float:left;box-shadow:0 0 6px #eeeeee}
			
			.goodsList{overflow:hidden}
			.goodsList .goodsName{width:445px;heigth:60px;overflow:hidden}
			.goodsList .specification{width:100px;heigth:60px;text-align:center}
			.goodsList .price{width:100px;heigth:60px;text-align:center}
			.goodsList .count{width:100px;heigth:60px;text-align:center}
			.goodsList .subtotal{width:100px;heigth:60px;color:#eb4a3f;text-align:center;font-weight:600}
			.goodsList .titleNav{height:30px;line-height:30px;background-color:#eeeeee}
			.goodsList .titleNav div{float:left;text-align:center}
			.goodsList .titleNav .goodsName{text-align:left}
			.goodsList .titleNav .subtotal{color:#333333;font-weight:400}
			.goodsList .goodsItem{border-bottom:1px solid #eeeeee;overflow:hidden}
			.goodsList .goodsItem>div{float:left}
			.goodsList .goodsItem{line-height:60px}
			.goodsList .goodsItem .coupon{width:445px;overflow:hidden}
			.goodsList .goodsItem .coupon>div{float:left}
			.goodsList .goodsItem .goodsName{padding:4px 0;height:52px}
			.goodsList .goodsItem .goodsName a{font:12px/20px '宋体';color:#333333;text-decoration:none}
			.goodsList .goodsItem .goodsName a:hover{color:#eb4a3f;text-decoration:underline;}
			.goodsList .goodsItem img{float:left;heigth:50px;width:50px;border:1px solid #eeeeee;margin-right:5px;height:50px;width:50px}
			.goodsList .goodsItem .count span{color:#eb4a3f}
		</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp" />
		<s:include value="/WEB-INF/jsp/user/userCenter/headerStyle.jsp" />
		<div class="uc_title">
			个人中心
		</div>
		<div class="uc_frame">
			<s:include value="/WEB-INF/jsp/user/userCenter/menu.jsp" />
			<div class="uc_right">
				<strong>订单编号：<s:property value="#request.order.orderNumber" /></strong>
				<br/><br/>
				<div class="order_">
	   				收货人：<s:property value="#request.order.address.split('spe_spe')[0]" /><br/>
	   				地址：<s:property value="#request.order.address.split('spe_spe')[2]" /><br/>
	   				电话号码：<s:property value="#request.order.address.split('spe_spe')[1]" /><br/>
		   		</div>
		   		<br/>
				<div class="goodsList">
					<div class="titleNav">
						<div class="goodsName">商品名称</div>
						<div class="price">单价</div>
						<div class="count">数量</div>
						<div class="subtotal">小计</div>
					</div>
					<s:iterator value="#request.order.orderGoodsList">
						<div class="goodsItem">
							<s:iterator value="goodsIDs.split('-')" status="sta">
								<div class="coupon">
									<div class="goodsName">
										<s:a href="%{@com.haozhuoji.mall.util.Constant@goods_p+goodsIDs.split('-')[#sta.index]}.html">
										<img src="<s:property value="@com.haozhuoji.mall.util.Constant@goodsImage_p+'/'+goodsIDs.split('-')[#sta.index]+'/main/main_50x50.jpg'" />" />
										<s:property value="goodsName.split('spe_spe')[#sta.index]" /></s:a>
									</div>
								</div>
							</s:iterator>
							<div class="price">¥<s:property value="@com.haozhuoji.mall.util.Arith@format(product_price)" /></div>
							<div class="count">
								<s:property value="amount" />
							</div>
							<div class="subtotal">¥<s:property value="@com.haozhuoji.mall.util.Arith@mulFormat(product_price,amount)" /></div>
						</div>
					</s:iterator>
				</div>
				
	   			<div style="text-align:right;width:700px;float:right;padding:20px 20px;overflow:hidden">
	   				<style type="text/css">
	   					.order_ov .option{width:650px;text-align:right;float:left}
	   					.order_ov .value{width:50px;text-align:right;float:left}
	   				</style>
	   				<div style="width:700px;overflow:hidden" class="order_ov">
	   					<div class="option">总商品金额：</div><div class="value">¥<s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.goods_price)" /></div>
	   					<div class="option">运费：</div><div class="value">+¥<s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.send_price)" /></div>
	   					<s:if test="#request.order.orderCouponInfo.length()>0">
	   						<s:iterator value="#request.order.orderCouponInfo.split('spe_spe')" var="sfd">
	   							<div class="option"><s:property value="#sfd.split('-')[0]" />：</div>
	   							<div class="value">-¥<s:property value="#sfd.split('-')[1]" /></div>
	   						</s:iterator>
	   					</s:if>
	   				</div>
					<div style="border-bottom:1px solid #eb4a3f;padding-top:20px;margin-left:500px"></div>
					<br/>
					<div style="width:200px;margin-left:500px">总额：<span style="color:#eb4a3f;font-size:25px;font-family:'microsoft yahei'">¥<s:property value="@com.haozhuoji.mall.util.Arith@format(#request.order.order_price)" /></span></div>
	   			</div>
			
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp" />
	</body>
</html>