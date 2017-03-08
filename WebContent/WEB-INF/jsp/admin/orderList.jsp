<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>订单列表</title>
	<s:include value="/WEB-INF/jsp/admin/headMeta.jsp"></s:include>
	
	<script type="text/javascript">
		//auto color
		$(function(){
			$("tr:even").css("background-color","#f9f9f9");
			$("tr:odd").css("background-color","#fefefe");
			$("tr:gt(0)").hover(function(){
				$(this).css("background-color","#CEE3F7");
			},function(){					
				$("tr:even").css("background-color","#f9f9f9");
				$("tr:odd").css("background-color","#fefefe");
			});
		});
		$(function(){
			comment_updata=function(data){
				$.ajax({
					data:data,
					type:'post',
					url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/comment_update.action'" />",
					success:function(data){
						data = eval("("+data+")");
						if(data.status!="success"){
							alert(data.status);
						}else{
							alert("修改成功！");
							location.reload();
						}
					},
					error:function(){
						alert("修改异常，请刷新后重试");
					}
				});
			};
			$(".cancelShow").click(function(){
				var data = {
					showFlag:$(this).attr("showFlag"),
					commentID:$(this).closest("tr").attr("commentID")
				};
				comment_updata(data);
			});
		});
		$(function(){
			$(".g_pageFrame .pageItem").click(function(){
				toServer("page.currentPage="+$(this).text().trim()+"&");
			});
			$(".g_pageFrame .prePage").click(function(){
				toServer("page.currentPage="+(parseInt($(".g_pageFrame .curPage").text().trim())-1)+"&");
			});
			$(".g_pageFrame .nextPage").click(function(){
				toServer("page.currentPage="+(parseInt($(".g_pageFrame .curPage").text().trim())+1)+"&");
			});
			toServer = function(page){
				var href = location.href.split("?")[0]+"?";
				$(".g_page_flag").each(function(){
					if($(this).val()!=""){
						href+=$(this).attr("name")+"="+$(this).val().trim()+"&";
					}
				});
				href+=page;
				location.href = href;
				return false;
			};
			toPrint=function(){
				var href ="<s:property value="@com.haozhuoji.mall.util.Constant@admin_p"/>/order_printOrder.html?orderIDs=";
				var orderIDs = "-";
				$("tr[orderID]").each(function(){
					orderIDs+=$(this).attr("orderID")+"-";
				});
				window.open(href+orderIDs);
			};
			$(".updateReply").click(function(){
				var href ="<s:property value="@com.haozhuoji.mall.util.Constant@admin_p"/>/order_printOrder.html?orderIDs=-";
				href+=$(this).closest("tr").attr("orderID");
				href+="-";
				window.open(href);
			});
			$(".cancelOrder").click(function(){
				if(confirm("确认删除？（删除后该订单将无效，无法配送）")){
					$.ajax({
						data:{orderID:$(this).closest("tr").attr("orderID").trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/order_cancelOrder.action'" />",
						success:function(data){
							data = eval("("+data+")");
							if(data.status!="success"){
								alert(data.status);
							}else{
								alert("取消成功！");
								location.reload();
							}
						},
						error:function(){
							alert("操作异常，请刷新后重试");
						}
					});
				}
			});
		});
	</script>
	<style type="text/css">
		table{border-collapse:collapse}
		a{cursor:pointer}
		.trueBody td{border:1px solid #DDDDDD;text-align:center;height:30px}
		.width50{width:50px}
		.width100{width:100px}
		.width150{width:150px}
		.width200{width:200px}
		.width300{width:300px}
	</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
		<div class="trueBody">
			<div class="title">商品评论</div>
			<br/>
			<s:form action="/" method="get" onsubmit="return toServer('')" >
				<span>订单ID</span>：<s:textfield name="orderID" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>订单编号</span>：<s:textfield name="orderNumber" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>用户ID</span>：<s:textfield name="userID" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>配送时段</span>：<s:textfield name="timePeriod" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>配送时间</span>：<s:textfield name="distributionTime" value="%{distributionTime==null?'':@com.haozhuoji.mall.util.DateUtil@format(distributionTime)}" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>创建时间</span>：<s:textfield name="createDateTime" value="%{createDateTime==null?'':@com.haozhuoji.mall.util.DateUtil@format(createDateTime)}" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>打印时间</span>：<s:textfield name="printDateTime" value="%{printDateTime==null?'':@com.haozhuoji.mall.util.DateUtil@format(printDateTime)}" cssClass="g_page_flag" />&nbsp;&nbsp;<br/>
				<span>收货地址</span>：<s:textfield name="address" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>订单积分</span>：<s:textfield name="points" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>优惠信息</span>：<s:textfield name="orderCouponInfo" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>用户留言</span>：<s:textfield name="leaveMessage" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>是否打印</span>：<s:select list="#{'':'全部','true':'是','false':'否'}" cssClass="g_page_flag" name="print"/>&nbsp;&nbsp;
				<span>是否取消</span>：<s:select list="#{'':'全部','true':'是','false':'否'}" cssClass="g_page_flag" name="cancel"/>&nbsp;&nbsp;
				<span>是否删除</span>：<s:select list="#{'':'全部','true':'是','false':'否'}" cssClass="g_page_flag" name="del"/>&nbsp;&nbsp;<br/>
				<span>是否评论</span>：<s:select list="#{'':'全部','true':'是','false':'否'}" cssClass="g_page_flag" name="comment"/>&nbsp;&nbsp;
				<span>是否成功</span>：<s:select list="#{'':'全部','true':'是','false':'否'}" cssClass="g_page_flag" name="addPoint"/>&nbsp;&nbsp;
				<span>排序</span>：<s:select list="#{'':'不排序','orderID':'ID','orderNumber':'订单编号','userID':'用户ID','order_price':'订单价格',
				'goods_price':'商品价格','activity_price':'活动价格','coupon_price':'优惠价格','timePeriod':'时段','distrubutionTime':'配送时间','createDateTime':'创建时间',
				'printDateTime':'打印时间','cancel':'取消','del':'删除','comment':'评论','print':'是否打印','addPoint':'是否成功','points':'积分'}" cssClass="g_page_flag" name="page.orderBy"/>&nbsp;&nbsp;
				<span>升降序</span>：<s:select list="#{'true':'降序','false':'升序'}" cssClass="g_page_flag" name="page.desc"/>&nbsp;&nbsp;
				<input type="reset" value="重置" />
				<input value="查询" type="submit" />
				<a target="_blank" onclick="toPrint()" >答应本页订单</a>
			</s:form>
			<div style="border-top:2px solid #dddddd;width:500px"></div>
			<br/>
			<br/>
			<table>
				<tr class="header">
					<td class="width50">orderID</td>
					<td class="width50">订单编号</td>
					<td class="width50">用户ID</td>
					<td class="width50">订单价格</td>
					<td class="width50">商品价格</td>
					<td class="width50">活动价格</td>
					<td class="width50">优惠价格</td>
					<td class="width50">配送价格</td>
					<td class="width100">配送时段</td>
					<td class="width500">配送时间</td>
					<td class="width50">创建时间</td>
					<td class="width50">打印时间</td>
					<td class="width100">收货地址</td>
					<td class="width50">积分</td>
					<td class="width200">订单优惠信息</td>
					<td class="width200">订单信息</td>
					<td class="width200">用户留言</td>
					<td class="width50">打印</td>
					<td class="width50">取消</td>
					<td class="width50">评论</td>
					<td class="width50">成功</td>
					<td class="width50">删除</td>
					<td class="width100">操作</td>
				</tr>
				<s:iterator value="#request.orderList">
					<tr orderID="<s:property value="orderID" />">
						<td><s:property value="orderID" /></td>
						<td><s:property value="orderNumber"/></td>
						<td><s:property value="userID" /></td>
						<td><s:property value="order_price" /></td>
						<td><s:property value="goods_price" /></td>
						<td><s:property value="activity_price" /></td>
						<td><s:property value="coupon_price" /></td>
						<td><s:property value="send_price" /></td>
						<td><s:property value="timePeriod" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format(distributionTime)" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format(createDateTime)" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format(printDateTime)" /></td>
						<td><s:property value="address.split('spe_spe')" /></td>
						<td><s:property value="points" /></td>
						<td><s:property value="orderCouponInfo" /></td>
						<td><s:property value="orderInfo" /></td>
						<td><s:property value="leaveMessage" /></td>
						<td><s:property value="print?'是':'否'" /></td>
						<td><s:property value="cancel?'是':'否'" /></td>
						<td><s:property value="comment?'是':'否'" /></td>
						<td><s:property value="addPoint?'是':'否'" /></td>
						<td><s:property value="del?'是':'否'" /></td>
						<td>
						<a class="updateReply" >打印</a>
						<s:if test="!cancel">
							<a class="cancelOrder" >取消</a>
						</s:if>
						</td>
					</tr>
				</s:iterator>
			</table>
			<div style="padding:30px;overflow:hidden">
				<s:include value="/WEB-INF/jsp/frame/page.jsp"></s:include>
			</div>
		</div>
	</body>
</html>
