<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>查看所有商品</title>
	<s:include value="/WEB-INF/jsp/admin/headMeta.jsp"></s:include>
	<script type="text/javascript">
		var goodsID = null;
		$(function(){
			$("tr:even").css("background-color","#f9f9f9");
			$("tr:odd").css("background-color","#fefefe");
			$("tr:gt(0)").hover(function(){
				$(this).css("background-color","#CEE3F7");
			},function(){					
				$("tr:even").css("background-color","#f9f9f9");
				$("tr:odd").css("background-color","#fefefe");
			});
			
			$(".updateGoods").click(function(){
				var item=$("#updateFrame").css({"display":"block","top":100,"left":($(window).width()-$("#updateFrame").width())/2}).attr("goodsID",$(this).attr("goodsID"));
				goodsID = $(this).attr("goodsID");
				if($(this).attr("sell")=='true'){
					item.find(".changeSell").text("下架").attr("href","<s:property value="@com.haozhuoji.mall.util.Constant@admin_p" />/goods_update.html?sell=false&goodsID="+goodsID);
				}else{
					item.find(".changeSell").text("上架").attr("href","<s:property value="@com.haozhuoji.mall.util.Constant@admin_p" />/goods_update.html?sell=true&goodsID="+goodsID);
				}
			});
			$("#updateFrame .close").click(function(){
				$("#updateFrame").css({"display":"none"});
			});
			$(".deleteGoods").click(function(){
				if(confirm("你没病吧，你确认删除？将删除数据库记录，包括图片等")){
					$.ajax({
						data:{goodsID:goodsID},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/goods_deleteGoods.action'" />",
						success:function(data){
							data = eval("("+data+")");
							if(data.status!="success"){
								alert(data.status);
							}else{
								alert("看来你真的有病！删除成功");
								location.reload();
							}
						},
						error:function(){
							alert("操作异常，请刷新后重试");
						}
					});
				}
			});
			$(".toDetailPage").click(function(){
				window.open("<s:property value="@com.haozhuoji.mall.util.Constant@goods_p" />"+goodsID+'.html');
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
		});
	</script>
	<style type="text/css">
		.trueBody .filter{overflow:hidden;padding:5px;}
		.trueBody .filter .item{padding:10px;float:left}
		.trueBody .header{background-color:#EEEEEE;font-weight:600}
		table{border-collapse:collapse;width:100%}
		.trueBody td{border:1px solid #DDDDDD;text-align:center;height:30px} 
		.width3{width:10%}
		.width2{width:5%}
		.width4{width:3%}
	</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
		<div class="trueBody">
			<div class="title">商品查询</div>
			<div class="filter">
				<s:form action="" method="get" onsubmit="return toServer('')" >
						<span>关键字</span>：<s:textfield name="keyWord"  cssClass="g_page_flag" />&nbsp;&nbsp;
						<span>ID</span>：<s:textfield name="goodsID" cssClass="g_page_flag" />&nbsp;&nbsp;
						<span>产品编号</span>：<s:textfield name="productNumber" cssClass="g_page_flag" />&nbsp;&nbsp;
						<span>是否销售</span>：<s:select list="#{'':'全部','true':'是','false':'否'}" cssClass="g_page_flag" name="sell"/>&nbsp;&nbsp;
						<span>类型</span>：<s:select list="#request.goodsTypeList"  listKey="typeID" listValue="fullTypeName" cssClass="g_page_flag" name="typeID"/>&nbsp;&nbsp;
						<span>排序</span>：<s:select list="#{'goodsID':'ID','productNumber':'编号','product_price':'商品价格','purchase_count':'购买数量','comment_count':'评论','browse_count':'浏览','collection_count':'收藏','createDateTime':'创建时间','updateDateTime':'修改时间','amount':'库存','typeID':'商品类型','brand':'商标','points':'积分'}" cssClass="g_page_flag" name="page.orderBy"/>&nbsp;&nbsp;
						<span>升降序</span>：<s:select list="#{'true':'降序','false':'升序'}" cssClass="g_page_flag" name="page.desc"/>&nbsp;&nbsp;
						<input value="查询" type="submit" />
				</s:form>
			</div>
			<table>
				<tr class="header">
					<td class="width1">ID</td>
					<td class="width2">商品条形码</td>
					<td class="width3">商品名</td>
					<td class="width4">商品价格</td>
					<td class="width4">参考价格</td>
					<td class="width4">促销价格</td>
					<td class="width4">成本价格</td>
					<td class="width1">销量</td>
					<td class="width1">收藏</td>
					<td class="width1">评论</td>
					<td class="width1">浏览</td>
					<td class="width2">规格</td>
					<td class="width2">促销语</td>
					<td class="width1">货架号</td>
					<td class="width1">库存</td>
					<td class="width2">类型</td>
					<td class="width1">品牌</td>
					<td class="width1">积分</td>
					<td class="width2">创建时间</td>
					<td class="width2">修改时间</td>
					<td class="width1">操作</td>
				</tr>
				<s:iterator value="#request.goodsList">
					<tr>
						<td><s:property value="goodsID" /></td>
						<td><s:property value="productNumber" /></td>
						<td><s:property value="goodsName" /></td>
						<td><s:property value="product_price" /></td>
						<td><s:property value="reference_price"/></td>
						<td><s:property value="promotion_price"/></td>
						<td><s:property value="cost_price" /></td>
						<td><s:property value="purchase_count" /></td>
						<td><s:property value="collection_count" /></td>
						<td><s:property value="comment_count" /></td>
						<td><s:property value="browse_count" /></td>
						<td><s:property value="specification" /></td>
						<td><s:property value="promotion_sentence" /></td>
						<td><s:property value="shelfNumber" /></td>
						<td><s:property value="amount" /></td>
						<td><s:property value="typeName"/></td>
						<td><s:property value="brand" /></td>
						<td><s:property value="points" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format_dateTime(createDateTime)" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format_dateTime(updateTimeStamp)" /></td>
						<td><s:a cssClass="updateGoods" sell="%{sell}" href="javascript:void(0)" goodsID="%{goodsID}" >修改</s:a></td>
					</tr>
				</s:iterator>
			</table>
			<div style="padding:30px;overflow:hidden">
				<s:include value="/WEB-INF/jsp/frame/page.jsp"></s:include>
			</div>
		<style type="text/css">
			#updateFrame{background-color:#ffffff;width:300px;height:100px;border:1px solid #dddddd;box-shadow:0 0 10px #dddddd;text-align:center;position:fixed;display:none}
			#updateFrame a{font:15px/40px Arail}
			#updateFrame .title{border-bottom:1px solid #eeeeee;background-color:#f9f9f9;overflow:hidden;height:12px}
		</style>
		<div id="updateFrame">
			<div class="title">
				<div style="float:left;font:600 12px/12px Arial">修改</div>
				<div class="close" style="float:right;cursor:pointer;font:600 12px/12px Arial">&nbsp;X&nbsp;</div>
			</div>
			<a href="javascript:void(0)" onclick="location.href='<s:property value="@com.haozhuoji.mall.util.Constant@admin_p" />/goods_toUpdate.html?jspPage=addUpdateInfo&goodsID='+goodsID" >基本信息</a>
			<a href="javascript:void(0)" onclick="location.href='<s:property value="@com.haozhuoji.mall.util.Constant@admin_p" />/goods_toUpdate.html?jspPage=updateProperties&goodsID='+goodsID">属性</a>
			<a href="javascript:void(0)" onclick="location.href='<s:property value="@com.haozhuoji.mall.util.Constant@admin_p" />/goods_toUpdate.html?jspPage=updatePage&goodsID='+goodsID">详情页面</a>
			<a href="javascript:void(0)" class="changeSell"></a>
			<a href="javascript:void(0)" class="deleteGoods">删除</a>
			<br/>
			<a href="javascript:void(0)" class="toDetailPage">查看单页</a>
		</div>
		</div>
	</body>
</html>
