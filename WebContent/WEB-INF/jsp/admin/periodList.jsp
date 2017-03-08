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
		//register  listener
		$(function(){
			//add relevant goods
			$(".addButton").click(function(){
				var tr = $(this).closest("tr");
				var data = getFileds(tr);
				data.periodID = null
				$.ajax({
					data:data,
					type:'post',
					url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/period_add.html'" />",
					success:function(data){
						data = eval("("+data+")");
						if(data.status!="success"){
							alert(data.status);
						}else{
							alert("增加成功！");
							location.reload();
						}
					},
					error:function(){
						alert("增加异常，请刷新后重试");
					}
				});
				return false;
			});
			$(".updatePointToCouponList").click(function(){
				var old = $(this).closest("tr");
				var curr = $("#addPointToCoupon").clone(true);
				
				curr.find("td:eq(0)").text(old.find("td:eq(0)").text());
				curr.find("td:eq(1) input").val(old.find("td:eq(1)").text());
				curr.find("td:eq(2) input").val(old.find("td:eq(2)").text());
				curr.find("td:eq(3) input").val(old.find("td:eq(3)").text());
				curr.find("td:eq(4) input").val(old.find("td:eq(4)").text());
				curr.find("td:eq(5) select").val(old.find("td:eq(5)").attr("weekday"));
				curr.find("td:eq(6)").text("").append($("#updateCon").children().clone(true));
				curr.css({"display":"table-row"});
				old.css({"display":"none"});
				old.after(curr);
			});
			$(".cancelUpdate").click(function(){
				var old = $(this).closest("tr").css({"display":"none"});
				var id = old.find("td:eq(0)").text();
				$("tr[id='"+id+"']").css({"display":"table-row"});
			});
			$(".deletePointToCouponList").click(function(){
				if(confirm("确认删除！")){
					$.ajax({
						data:{periodID:$(this).closest("tr").find("td:eq(0)").text().trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/period_delete.action'" />",
						success:function(data){
							data = eval("("+data+")");
							if(data.status!="success"){
								alert(data.status);
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
				$.ajax({
					data:data,
					type:'post',
					url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/period_update.action'" />",
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
				return false;
			});
			getFileds=function(tr){
				var data = {
					periodID:tr.find("td:eq(0)").text().trim(),
					time:'1970-01-01 '+tr.find("td:eq(1) input").val().trim(),
					timePeriod:tr.find("td:eq(2) input").val().trim(),
					printTime:'1970-01-01 '+tr.find("td:eq(3) input").val().trim(),
					aheadOfDay:tr.find("td:eq(4) input").val().trim(),
					weekday:tr.find("td:eq(5) select").val().trim(),
				};
				return data;
			};
		});

	</script>
	<style type="text/css">
		table{border-collapse:collapse}
		a{cursor:pointer}
		.trueBody td{border:1px solid #DDDDDD;text-align:center;height:30px}
		.width1{width:100px}
		.width2{width:200px}
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
			<div class="title">配送时段</div>
			<br />
			时间格式：2014-02-22 15:22:02<br /><br/>如果满多少等于减多少即为代金券<br/>
			<div id="updateCon" style="display:none">
				<a class='confimrUpdate'>确定</a><span> </span><a class="cancelUpdate">取消</a>
			</div>
			<hr/>
			<br/>
			<table>
				<tr class="header">
					<td class="width1">ID</td>
					<td class="width2">截止时间</td>
					<td class="width4">时段</td>
					<td class="width5">打印时间</td>
					<td class="width5">打印提前天数</td>
					<td class="width5">对应星期</td>
					<td class="width3">操作</td>
				</tr>
				<tr id="addPointToCoupon">
					<td>增加</td>
					<td><input name="time" class="tInput"  autocomplete="off" /></td>
					<td><input class="tInput" name="timePeriod" autocomplete="off" /></td>
					<td><input class="tInput" name="printTime" autocomplete="off" /></td>
					<td><input name="aheadOfDay"  autocomplete="off" /></td>
					<td><s:select list="#{'1':'星期一','2':'星期二','3':'星期三','4':'星期四','5':'星期五','6':'星期六','0':'星期天'}" name="weekday"/></td>
					<td>
						<input type="submit" value="确定增加" class="addButton"  />
					</td>
				</tr>
				<s:iterator value="#request.periodList">
					<tr iD="<s:property value="periodID" />">
						<td><s:property value="periodID" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@formatTime(time)"/></td>
						<td><s:property value="timePeriod" /></td>
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@formatTime(printTime)" /></td>
						<td><s:property value="aheadOfDay" /></td>
						<td weekday="<s:property value="weekday" />">星期<s:property value="weekday==0?'天':weekday" /></td>
						<td>
						<a class="updatePointToCouponList" >修改</a>
						<a class="deletePointToCouponList" >删除</a>
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
