<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>关联商品</title>
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
		//add relevant goods
		add=function(){
			var goodsIDs = $("input[name='goodsIDs']").eq(0).val().trim();
			if(goodsIDs==""){
				alert("商品IDs不能为空！");
			}else if(!goodsIDs.match("^(\\d+-)+\\d+$")){
				alert("商品IDs格式错误！");
			}else if(!checkRe(goodsIDs)){
				
			}else{
				$.ajax({
					data:{goodsIDs:goodsIDs},
					type:'post',
					url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/relevantGoods_add.html'" />",
					success:function(data){
						if(data!="success"){
							alert(data);
						}else{
							alert("增加成功！");
							location.reload();
						}
					},
					error:function(){
						alert("增加异常，请刷新后重试");
					}
				});
			}
			return false;
		};
		//register  listener
		$(function(){
			$(".updateRelevantGoods").click(function(){
				$("tr[update]").removeAttr("update").css({display:"table-row"});
				var tr = $(this).closest("tr").attr("update","update");
				var utr = $("#updateFrame");
				tr.after(utr);
				utr.find("td:eq(0)").text(tr.find("td:eq(0)").text());
				utr.find("td:eq(1)").find("input").val(tr.find("td:eq(1)").text());
				tr.css({display:"none"});
				utr.css({display:"table-row"});
			});
			$("#cancelUpdate").click(function(){
				$("#updateFrame").css({display:"none"});
				$("tr[update]").removeAttr("update").css({display:"table-row"});
			});
			$(".deleteRelevantGoods").click(function(){
				if(confirm("确认删除！")){
					$.ajax({
						data:{relevantGoodsID:$(this).closest("tr").find("td:eq(0)").text().trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/relevantGoods_delete.html'" />",
						success:function(data){
							if(data!="success"){
								alert(data);
							}else{
								alert("删除成功！");
								location.reload();
							}
						},
						error:function(){
							alert("删除异常，请刷新后重试");
						}
					});
				}
			});
			$("#confirmUpdate").click(function(){
				var tr = $(this).closest("tr");
				var goodsIDs = tr.find("td:eq(1)").find("input").val().trim();
				if(goodsIDs==""){
					alert("商品IDs不能为空！");
				}else if(!goodsIDs.match("^(\\d+-)+\\d+$")){
					alert("商品IDs格式错误！");
				}else if(!checkRe(goodsIDs)){
					
				}else{
					$.ajax({
						data:{goodsIDs:goodsIDs,relevantGoodsID:tr.find("td:eq(0)").text().trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/relevantGoods_update.html'" />",
						success:function(data){
							if(data!="success"){
								alert(data);
							}else{
								alert("修改成功！");
								location.reload();
							}
						},
						error:function(){
							alert("修改异常，请刷新后重试");
						}
					});
				}
				return false;
			});
			
			checkRe=function(src){
				var s = src.split('-');
				for(var i=0;i<s.length-1;i++){
					for(var j=i+1;j<s.length;j++){
						if(s[i]==s[j]){
							alert("ID为 "+s[i]+" 的商品重复");
							return false;
						}
					}
				}
				return true;
			};
		});
	</script>
	<style type="text/css">
		table{border-collapse:collapse}
		a{cursor:pointer}
		.trueBody td{border:1px solid #DDDDDD;text-align:center;height:30px}
		.width1{width:100px}
		.width2{width:400px}
		.width3{width:200px}
	</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
		<div class="trueBody">
			<div class="title">关联商品</div>
			<table>
				<tr class="header">
					<td class="width1">ID</td>
					<td class="width2">商品IDs</td>
					<td class="width3">操作</td>
				</tr>
				<tr>
					<form  onsubmit="return add()" >
						<td>增加关联商品</td>
						<td><input name="goodsIDs" style="width:200px" autocomplete="off" /> 填写关联商品ID，如“5-6-21”</td>
						<td>
							<input type="submit" value="确定增加"  />
						</td>
					</form>
				</tr>
				<s:iterator value="#request.relevantGoodsList">
					<tr>
						<td><s:property value="relevantGoodsID" /></td>
						<td><s:property value="goodsIDs" /></td>
						<td>
						<a target="_blank" href="<s:property value="@com.haozhuoji.mall.util.Constant@goods_p+goodsIDs.split('-')[0]+'.html'" />">查看</a>
						<a class="updateRelevantGoods" >修改</a>
						<a class="deleteRelevantGoods" >删除</a>
						</td>
					</tr>
				</s:iterator>
				<tr id="updateFrame" style="display:none">
					<td></td>
					<td><input name="goodsIDs" autocomplete="off" style="width:200px" /></td>
					<td>
						<a id="confirmUpdate" >确认</a>
						<a id="cancelUpdate"  href="javascript:void(0)">取消</a>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
