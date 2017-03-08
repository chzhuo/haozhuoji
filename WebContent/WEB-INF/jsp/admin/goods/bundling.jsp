<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>捆绑销售商品</title>
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
		//register  listener
		$(function(){
			checkFileds=function(ttr){
				var goodsIDs = $(ttr).find("td:eq(1)").find("input").val().trim();
				var price = $(ttr).find("td:eq(2)").find("input").val().trim();
				var amount = $(ttr).find("td:eq(3)").find("input").val().trim();
				var points = $(ttr).find("td:eq(4)").find("input").val().trim();
				if(goodsIDs==""){
					alert("商品IDs不能为空！");
					return false;
				}else if(price==""){
					alert("价格不能为空！");
					return false;
				}else if(amount==""){
					alert("数量不能为空！");
					return false;
				}else if(!goodsIDs.match("^(\\d+-)+\\d+$")){
					alert("商品IDs格式错误！");
					return false;
				}else if(!price.match("^\\d+(\\.\\d{1,2})?$")){
					alert("价格格式错误！");
					return false;
				}else if(!amount.match("^\\d+$")){
					alert("数量格式错误！");
					return false;
				}else if(!points.match("^\\d+$")){
					alert("积分格式错误！");
					return false;
				}else{
					var s = goodsIDs.split('-');
					for(var i=0;i<s.length-1;i++){
						for(var j=i+1;j<s.length;j++){
							if(s[i]==s[j]){
								alert("ID为 "+s[i]+" 的商品重复");
								return false;
							}
						}
					}
				}
				return true;
			};
			//add relevant goods
			add=function(){
				var goodsIDs = $("#addBundling").find("td:eq(1)").find("input").val().trim();
				var price = $("#addBundling").find("td:eq(2)").find("input").val().trim();
				var amount = $("#addBundling").find("td:eq(3)").find("input").val().trim();
				var points = $("#addBundling").find("td:eq(4)").find("input").val().trim();
				if(checkFileds($("#addBundling"))){
					$.ajax({
						data:{goodsIDs:goodsIDs,price:price,amount:amount,points:points},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/bundling_add.html'" />",
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
			$(".updateRelevantGoods").click(function(){
				$("tr[update]").removeAttr("update").css({display:"table-row"});
				var tr = $(this).closest("tr").attr("update","update");
				var utr = $("#updateFrame");
				tr.after(utr);
				utr.find("td:eq(0)").text(tr.find("td:eq(0)").text());
				utr.find("td:eq(1)").find("input").val(tr.find("td:eq(1)").text());
				utr.find("td:eq(2)").find("input").val(tr.find("td:eq(2)").text());
				utr.find("td:eq(3)").find("input").val(tr.find("td:eq(3)").text());
				utr.find("td:eq(4)").find("input").val(tr.find("td:eq(4)").text());
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
						data:{bundlingID:$(this).closest("tr").find("td:eq(0)").text().trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/bundling_delete.html'" />",
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
				var bundlingID = tr.find("td:eq(0)").text().trim();
				var goodsIDs = tr.find("td:eq(1)").find("input").val().trim();
				var price = tr.find("td:eq(2)").find("input").val().trim();
				var amount = tr.find("td:eq(3)").find("input").val().trim();
				var points = tr.find("td:eq(4)").find("input").val().trim();
				if(checkFileds(tr)){
					$.ajax({
						data:{goodsIDs:goodsIDs,price:price,amount:amount,bundlingID:bundlingID,points:points},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/bundling_update.html'" />",
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
		});
	</script>
	<style type="text/css">
		table{border-collapse:collapse}
		a{cursor:pointer}
		.trueBody td{border:1px solid #DDDDDD;text-align:center;height:30px}
		.width1{width:100px}
		.width2{width:300px}
		.width3{width:200px}
		.width4{width:50px}
		input{text-align:center}
	</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
		<div class="trueBody">
			<div class="title">绑定商品</div>
			<table>
				<tr class="header">
					<td class="width1">ID</td>
					<td class="width2">商品IDs</td>
					<td class="width4">价格</td>
					<td class="width4">库存</td>
					<td class="width4">积分</td>
					<td class="width3">操作</td>
				</tr>
				<tr id="addBundling">
					<form  onsubmit="return add()" >
						<td>增加绑定商品</td>
						<td><input name="goodsIDs" style="width:200px" autocomplete="off" /> 如“5-6-21”</td>
						<td><input name="price" autocomplete="off" /></td>
						<td><input name="amount" autocomplete="off" /></td>
						<td><input name="points" autocomplete="off" /></td>
						<td>
							<input type="submit" value="确定增加"  />
						</td>
					</form>
				</tr>
				<s:iterator value="#request.bundlingList">
					<tr>
						<td><s:property value="bundlingID" /></td>
						<td><s:property value="goodsIDs" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.Arith@format(price)" /></td>
						<td><s:property value="amount" /></td>
						<td><s:property value="points" /></td>
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
					<td><input name="price" autocomplete="off" /></td>
					<td><input name="amount" autocomplete="off" /></td>
					<td><input name="points" autocomplete="off" /></td>
					<td>
						<a id="confirmUpdate" >确认</a>
						<a id="cancelUpdate"  href="javascript:void(0)">取消</a>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
