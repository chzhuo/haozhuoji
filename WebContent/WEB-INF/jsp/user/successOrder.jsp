<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="../frame/headMeta.jsp" />
		<title>恭喜您成功订购商品-好捉急校园便利店</title>
	</head>
	<body>
		<div style="width:786px;margin:24px auto;margin-top:90px;height:24px;background:url(/images/submitOrderSuccess/title.png) no-repeat left center" ></div>
		<div style="width:786px;height:486px;margin:24px auto;border:2px solid #dddddd;">
			<div style="text-align:center;margin:50px 80px">
				<img src="/images/submitOrderSuccess/success.png" />
				<div style="text-align:center;width:100%;color:#eb4a3f;font:20px '微软雅黑';margin-top:50px">应付款<s:property value="#request.price" /> 元，请备好零钱</div>
				<div style="background-color:#eb4a3f;height:4px;width:100%"></div>
				<div style="text-align:center;width:100%;color:#eb4a3f;font:20px '微软雅黑';margin-top:5px">您的订单号为：<s:property value="#request.orderNumber"/>，将在<s:property value="#request.dateTime"/>送达，请备好零钱</div>
				<div>
					<s:a href="%{com.haozhuoji.mall.util.Constant@http_p}" cssStyle="text-decoration:none;float:left;margin-left:220px;display:block;height:65px;width:190px;background-color:#eb4a3f;color:#ffffff;font:28px '微软雅黑';line-height:65px;font-weight:700;cursor:pointer;margin-top:50px">继续购物</s:a>
					<s:a style="display:block;text-decoration:none;float:right;color:#eb4a3f;font:20px '微软雅黑';margin-top:5px;cursor:pointer;position:relative;top:85px;right:90px" href="%{@com.haozhuoji.mall.util.Constant@user_p}/order_orderPage.html">查看订单信息</s:a>
				</div>
			</div>
		</div>
	</body>
</html>