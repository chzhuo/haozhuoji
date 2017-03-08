<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>订单打印页面</title>
	<s:include value="/WEB-INF/jsp/frame/headMeta.jsp" />
	<style type="text/css">
		td{font-size:0.3cm}
		table{border-collapse:collapse;}
		td{text-align:center;vertical-align:center;border:1px solid #000000;}
		.order{font-size:0.3cm;text-align:left}
		.title{font-size:0.4cm}
		.noborder{border:0}
		.index{width:1cm}
		.amount{width:1cm}
		.price{width:1cm}
		.hrDiv{height:1px;background-color:#333333;padding:0;maring:0}
		#redDiv{width:9.5cm;height:3cm;background-color:red;color:#ffffff}
	</style>
	<script type="text/javascript">
		$(function(){
			$("#changePrint").click(function(){
				var orderIDs = "-";
				$("table[orderID]").each(function(){
					orderIDs+=$(this).attr("orderID")+"-";
				});
				$.ajax({
					data:{orderIDs:orderIDs},
					type:'post',
					url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/order_changePrint.action'" />",
					success:function(data){
						data = eval("("+data+")");
						if(data.status!="success"){
							alert(data.status);
						}else{
							$("#redDiv").remove();
						}
					},
					error:function(){
						alert("操作异常，请刷新后重试");
					}
				});
			});
			$("#noChangePrint").click(function(){
				$("#redDiv").remove();
			});
		});
	</script>
  </head>
<body>
	<div id="redDiv">
		本色块消失后方可打印
		<div id="changePrint" style="cursor:pointer;float:left;width:7cm;height:2cm;background-color:#999999;font:0.7cm/2cm 'microsoft yahei';text-align:center">修改数据库打印</div>		
		<div id="noChangePrint" style="cursor:pointer;float:left;width:2.5cm;height:2cm;background-color:#dddddd;font:0.7cm/2cm 'microsoft yahei';text-align:center">打印</div>
	</div>
	<s:iterator value="#request.orderList">
		<table cellpadding="0" cellspacing="0" style="width:9.5cm" orderID="<s:property value="orderID" />">
			<tr><td colspan="5" class="order noborder" align="left">订单:<s:property value="orderNumber" />
			<div style="float:right">送达时段:<s:property value="@com.haozhuoji.mall.util.DateUtil@formatDate(distributionTime)+' '+timePeriod"/></div></td></tr>
			<tr><td colspan="5" class="title noborder">好捉急校园便利店出货单</td></tr>
			<tr>
				<td class="index"><s:property value="sta.index"/>编号</td>
				<td class="goodsName">商品名称</td>
				<td class="amount">数量</td>
				<td class="price">单价</td>
			</tr>
			<s:iterator value="orderGoodsList" status="sta">
				<tr>
					<td><s:property value="#sta.index+1"/></td>
					<td>
						<s:iterator value="goodsName.split('spe_spe')" var="_var" status="sta">
							<s:property value="#_var"/>
							<s:if test="#sta.index<goodsName.split('spe_spe').length-1">
								<div class="hrDiv"></div>
							</s:if>
						</s:iterator>
					</td>
					<td><s:property value="amount"/></td>
					<td><s:property value="@com.haozhuoji.mall.util.Arith@format(product_price)"/></td>
				</tr>
			</s:iterator>
			<s:if test="orderInfo!=null">
				<tr>
					<td colspan="4" class="noborder" style="text-align:left"><s:property value="orderInfo"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</s:if>
				<tr><td colspan="4" class="footer noborder" align="right" style="font-size:0.3cm;text-align:right">
				<s:if test="send_price!=0">
					配送费:+ ¥<s:property value="@com.haozhuoji.mall.util.Arith@format(send_price)"/>
				</s:if>
				<s:if test="activity_price!=0">
					活动:- ¥<s:property value="@com.haozhuoji.mall.util.Arith@format(activity_price)"/>
				</s:if>
				<s:if test="coupon_price!=0">
					优惠券:- ¥<s:property value="@com.haozhuoji.mall.util.Arith@format(coupon_price)"/>
				</s:if>
				</td></tr>
			<tr><td colspan="4" class="footer noborder" align="right" style="font-size:0.4cm;font-weight:600;text-align:right">总价：¥<s:property value="@com.haozhuoji.mall.util.Arith@format(order_price)"/></td></tr>
			<s:if test="leaveMessage!=null&&!leaveMessage.trim().equals('')">
				<tr><td colspan="4" class="noborder" align="left" style="text-align:left">
				留言：<s:property value="leaveMessage"/>
				</td></tr>
			</s:if>
			<tr><td colspan="4" class="noborder" align="right" style="text-align:right">
			收货人:<s:property value="address.split('spe_spe')[0]"/>
			电话:<s:property value="address.split('spe_spe')[1]"/>
			地址:<s:property value="address.split('spe_spe')[2]"/></td></tr>
			<tr><td colspan="4" class="footer noborder" align="left" style="text-align:left"><span style="font-weight:600">haozhuoji.com<br/>只为简单的生活</span>
				好捉急校园便利店，期待您的再次光临</td>
			</tr>
		</table>
		<div style="width:9.5cm;height:3cm"></div>
	</s:iterator>
	<s:if test="params.split(',')[1].equals('1')">
		<div style="width:9.5cm;height:4cm"></div>
	</s:if>
</body>
</html>
