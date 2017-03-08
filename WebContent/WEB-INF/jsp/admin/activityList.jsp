<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>活动规则</title>
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
			//add relevant goods
			$(".addButton").click(function(){
				var tr = $(this).closest("tr");
				var data = getFileds(tr);
				data.activityID=null;
				if(checkFileds(data)){
					$.ajax({
						data:data,
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/activity_add.html'" />",
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
			});
			$(".updatePointToCouponList").click(function(){
				var old = $(this).closest("tr");
				var curr = $("#addPointToCoupon").clone(true);
				
				curr.find("td:eq(1) input:eq(0)").val(old.find("td:eq(1) span:eq(0)").text());
				curr.find("td:eq(1) input:eq(1)").val(old.find("td:eq(1) span:eq(1)").text());
				curr.find("td:eq(0)").text(old.find("td:eq(0)").text());
				curr.find("td:eq(2) select").val(old.find("td:eq(2)").attr("typeID"));
				curr.find("td:eq(3) input").val(old.find("td:eq(3)").text());
				curr.find("td:eq(4) input").val(old.find("td:eq(4)").text());
				curr.find("td:eq(5)").text("").append($("#updateCon").children().clone(true));
				curr.css({"display":"table-row"});
				old.css({"display":"none"});
				old.after(curr);
			});
			$(".cancelUpdate").click(function(){
				var old = $(this).closest("tr").css({"display":"none"});
				var id = old.find("td:eq(0)").text();
				$("tr[activityID='"+id+"']").css({"display":"table-row"});
			});
			$(".deletePointToCouponList").click(function(){
				if(confirm("确认删除！")){
					$.ajax({
						data:{activityID:$(this).closest("tr").find("td:eq(0)").text().trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/activity_delete.html'" />",
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
			$(".confimrUpdate").click(function(){
				var tr = $(this).closest("tr");
				var data = getFileds(tr);
				if(checkFileds(data)){
					$.ajax({
						data:data,
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/activity_update.action'" />",
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
			getFileds=function(tr){
				var data = {
					activityID:tr.find("td:eq(0)").text().trim(),
					typeID:tr.find("td:eq(2)").find("select").val().trim(),
					beginDateTime:tr.find("td:eq(3)").find("input").val().trim(),
					endDateTime:tr.find("td:eq(4)").find("input").val().trim(),
					rech:tr.find("td:eq(1)").find("input:eq(0)").val().trim(),
					sub:tr.find("td:eq(1)").find("input:eq(1)").val().trim()
				};
				return data;
			};
			checkFileds=function(data){
				if(data.beginDateTime==""){
					alert("开始时间不能为空！");
				}else if(data.endDateTime==""){
					alert("结束时间不能为空！");
				}else if(!data.beginDateTime.match("^\\d{4}(-\\d{1,2}){2} (\\d{1,2}:){2}\\d{1,2}$")){
					alert("开始时间格式错误！");
				}else if(!data.endDateTime.match("^\\d{4}(-\\d{1,2}){2} (\\d{1,2}:){2}\\d{1,2}$")){
					alert("完成时间格式错误！");
				}else if(data.rech==""){
					alert("满多少不能为空！");
				}else if(!data.rech.match("^\\d+(\\.\\d{1,2})?$")){
					alert("满多少格式错误！");
				}else if(data.sub==""){
					alert("减多少不能为空！");
				}else if(!data.sub.match("^\\d+(\\.\\d{1,2})?$")){
					alert("减多少格式错误！");
				}else{
					return true;
				}
				return false;
			};
		});
	</script>
	<style type="text/css">
		table{border-collapse:collapse}
		a{cursor:pointer}
		.trueBody td{border:1px solid #DDDDDD;text-align:center;height:30px}
		.width1{width:100px}
		.width2{width:300px}
		.width3{width:200px}
		.width4{width:100px}
		.width5{width:150px}
		input{text-align:center;width:60px}
		.tInput{width:140px}
	</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
		<div class="trueBody">
			<div class="title">积分兑换规则</div>
			<br />
			时间格式：2014-02-22 15:22:02<br /><br/>如果满多少等于减多少即为代金券<br/>
			<div id="updateCon" style="display:none">
				<a class='confimrUpdate'>确定</a><span> </span><a class="cancelUpdate">取消</a>
			</div>
			<br />
			<table>
				<tr class="header">
					<td class="width1">ID</td>
					<td class="width2">兑换内容</td>
					<td class="width4">使用范围</td>
					<td class="width5">开始使用时间</td>
					<td class="width5">过期时间</td>
					<td class="width3">操作</td>
				</tr>
				<tr id="addPointToCoupon">
					<td>增加优惠券兑换</td>
					<td>满：<input name="rech"  autocomplete="off" /> 减：<input name="sub" autocomplete="off"/></td>
					<td><s:select list="#request.goodsTypeList" name="typeID" listKey="typeID" listValue="fullTypeName" /></td>
					<td><input class="tInput" name="beginDateTime" autocomplete="off" /></td>
					<td><input class="tInput" name="endDateTime" autocomplete="off" /></td>
					<td>
						<input type="submit" value="确定增加" class="addButton"  />
					</td>
				</tr>
				<s:iterator value="#request.activityList">
					<tr activityID="<s:property value="activityID" />">
						<td><s:property value="activityID" /></td>
						<td>
						<s:if test="rech!=sub">优惠券：</s:if>
						<s:else>代金券：</s:else>
							 满<span><s:property value="@com.haozhuoji.mall.util.Arith@format(rech)" /></span> ，减 <span><s:property value="@com.haozhuoji.mall.util.Arith@format(sub)"/></span>  
						</td>
						<td typeID="<s:property value="typeID" />" >
							<s:property value="fullTypeName" />
						</td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format_dateTime(beginDateTime)" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format_dateTime(endDateTime)" /></td>
						<td>
						<a class="updatePointToCouponList" >修改</a>
						<a class="deletePointToCouponList" >删除</a>
						</td>
					</tr>
				</s:iterator>
			</table>
		</div>
	</body>
</html>
