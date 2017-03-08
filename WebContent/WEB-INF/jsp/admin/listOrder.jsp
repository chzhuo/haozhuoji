<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="../frame/headMeta.jsp" />
		<title></title>
	</head>
	<body>
	<h3>订单列表</h3>
		<table>
			<tr>
				<td width="200px">订单号</td>
				<td width="300px">地址</td>
				<td width="300px">配送时间</td>
			</tr>
			<s:iterator value="orderList">
				<tr>
					<td width="200px"><a target="_blank" href="/admin/order_printSingleOrder.htm?model.id=<s:property value="id" />"><s:property value="orderNumber" /></a></td>
					<td width="200px"><s:property value="address" /></td>
					<td width="200px"><s:property value="distributionTime" /></td>
				</tr>
			</s:iterator>
		</table>
	</body>
</html>
