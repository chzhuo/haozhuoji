<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>时段</title>
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
			$(".updateReply").click(function(){
				var r = $(this).closest("tr").find("td:eq(8)").text();
				var c = prompt('修改提示',r);
				if(c!=null&&r!=c){
					var data = {
						reply:c,
						commentID:$(this).closest("tr").attr("commentID")
					};
					comment_updata(data);
				}
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
		table{border-collapse:collapse}
		a{cursor:pointer}
		.trueBody td{border:1px solid #DDDDDD;text-align:center;height:30px}
		.width50{width:50px}
		.width100{width:100px}
		.width150{width:150px}
		.width200{width:200px}
		.width300{width:300px}
		input{text-align:center;width:60px}
	</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
		<div class="trueBody">
			<div class="title">商品评论</div>
			<br/>
			<s:form action="" method="get" onsubmit="return toServer('')" >
				<span>ID</span>：<s:textfield name="commentID" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>商品ID</span>：<s:textfield name="goodsID" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>用户ID</span>：<s:textfield name="userID" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>订单ID</span>：<s:textfield name="orderID" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>评分</span>：<s:textfield name="point" cssClass="g_page_flag" />&nbsp;&nbsp;
				<span>是否显示</span>：<s:select list="#{'':'全部','true':'是','false':'否'}" cssClass="g_page_flag" name="sell"/>&nbsp;&nbsp;
				<span>排序</span>：<s:select list="#{'':'不排序','commentID':'ID','goodsID':'商品ID','userID':'用户ID','orderID':'订单ID','point':'积分'}" cssClass="g_page_flag" name="page.orderBy"/>&nbsp;&nbsp;
				<span>升降序</span>：<s:select list="#{'true':'降序','false':'升序'}" cssClass="g_page_flag" name="page.desc"/>&nbsp;&nbsp;
				<input type="reset" value="重置" />
				<input value="查询" type="submit" />
			</s:form>
			<div style="border-top:2px solid #dddddd;width:500px"></div>
			<br/>
			<br/>
			<table>
				<tr class="header">
					<td class="width50">ID</td>
					<td class="width50">商品ID</td>
					<td class="width50">用户ID</td>
					<td class="width100">用户名</td>
					<td class="width50">订单ID</td>
					<td class="width50">评分</td>
					<td class="width200">评价时间</td>
					<td class="width300">评价内容</td>
					<td class="width300">回复</td>
					<td class="width50">是否显示</td>
					<td class="width200">操作</td>
				</tr>
				<s:iterator value="#request.commentList">
					<tr commentID="<s:property value="commentID" />">
						<td><s:property value="commentID" /></td>
						<td><s:property value="goodsID"/></td>
						<td><s:property value="userID" /></td>
						<td><s:property value="nickName" /></td>
						<td><s:property value="orderID" /></td>
						<td><s:property value="point" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format(createDateTime)" /></td>
						<td><s:property value="content" /></td>
						<td><s:property value="reply" /></td>
						<td><s:property value="showFlag?'是':'否'" /></td>
						<td>
						<a class="cancelShow" showFlag="<s:property value="showFlag?false:true"/>" ><s:property value="showFlag?'取消显示':'显示'"/></a>
						<a class="updateReply" >修改回复</a>
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
