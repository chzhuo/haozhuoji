<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/user/headMeta.jsp"></s:include>
		<title>全部订单-好捉急校园便利店</title>
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
        		<style type="text/css">
        			table tr td{text-align:center;vertical-align: center;border:1px #dddddd solid}
        			.trTitle{height:30px;text-align:left;text-indent:15px}
        			.trContent td{height:60px}
        			.order_price{color:#eb4a3f}
        		</style>
	        	<table style="width:100%;border-collapse: collapse;" cellpadding="0" cellspacing="0" >
        			<tr>
        				<td width="300px">订单信息</td>
        				<td width="100px">收货人</td>
        				<td width="120px">金额</td>
        				<td width="100px">时间</td>
        				<td width="120px">状态</td>
        				<td width="120px">操作</td>
        			</tr>
				<s:iterator value="#request.orderList">
					<tr>
						<td class="trTitle" colspan="6">订单编号：
							<s:a target="_blank" href="%{@com.haozhuoji.mall.util.Constant@user_p}/order_orderDetail.html?orderID=%{orderID}">
								<s:property value="orderNumber" />
							</s:a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property	value="orderInfo" />
						</td>
					</tr>
					<tr class="trContent">
						<td style="text-align:left;text-indent:30px">
							<s:iterator	value="orderGoodsList">
								<s:iterator value="goodsIDs.split('-')" status="sta">
									<s:a target="_blank" href="%{@com.haozhuoji.mall.util.Constant@goods_p+goodsIDs.split('-')[#sta.index]}.html" title="%{goodsName.split('-')[#sta.index]}">
										<img style="border:0" src="<s:property value="@com.haozhuoji.mall.util.Constant@goodsImage_p+'/'+goodsIDs.split('-')[#sta.index]+'/main/main_50x50.jpg'" />" />
									</s:a>
								</s:iterator>
							</s:iterator>
						</td>
						<td><s:property value="address.split('spe_spe')[0]" /></td>
						<td class="order_price">￥<s:property value="@com.haozhuoji.mall.util.Arith@format(order_price)" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format(createDateTime)" /></td>
						<td>
							<s:if test="cancel">
								已取消
							</s:if>
							<s:elseif test="addPoint">
								已完成
							</s:elseif>
							<s:else>
								配送中
							</s:else>
						</td>
						<td>
							<s:a target="_blank" action="order_orderDetail?orderID=%{orderID}">查看</s:a>
							<s:if test="addPoint&&!cancel&&!comment">
								<s:a target="_blank" action="order_toComment?orderID=%{orderID}">评价</s:a>
							</s:if>
							<s:if test="comment">
								已评价
							</s:if>
						</td>
					</tr>
				</s:iterator>
			</table>
			<div style="float:right">
				<s:if test="page.currentPage>1">
					<a class="nextPre" href="<s:property value="@com.haozhuoji.mall.util.Constant@user_p+'/order_orderPage.html?page.currentPage='+(page.currentPage-1)" />" id="c_nextPre" style="float:left;margin:10px;padding:5px;width:50px;border:1px solid #dddddd;background-color:#eeeeee;text-align:center;color:#666666;cursor:pointer">上一页</a>
				</s:if>
				<s:if test="page.currentPage<page.totalPage">
					<a class="nextPre" href="<s:property value="@com.haozhuoji.mall.util.Constant@user_p+'/order_orderPage.html?page.currentPage='" /><s:property value="page.currentPage+1"/>" id="c_nextPre" style="float:left;margin:10px;padding:5px;width:50px;border:1px solid #dddddd;background-color:#eeeeee;text-align:center;color:#666666;cursor:pointer">下一页</a>
				</s:if>
			</div>
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"/>
	</body>
</html>