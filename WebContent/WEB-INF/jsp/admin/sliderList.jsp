<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>活动规则</title>
	<s:include value="/WEB-INF/jsp/admin/headMeta.jsp"></s:include>
	<script type="text/javascript" src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p+'/js/jquery.form.js'" />"></script>
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
			$(".addButton").click(function(){
				var tr = $(this).closest("tr");
				var data = getFileds(tr);
				data.sliderID=null;
				$.ajax({
					data:data,
					type:'post',
					url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/slider_add.html'" />",
					success:function(data){
						data = eval("("+data+")")
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
				curr.find("td:eq(2) input").val(old.find("td:eq(2)").text());
				curr.find("td:eq(3) input").val(old.find("td:eq(3)").text());
				curr.find("td:eq(4)").text("").append($("#updateCon").children().clone(true));
				curr.css({"display":"table-row"}).attr({sliderID:old.attr("sliderID")});
				old.css({"display":"none"});
				old.after(curr);
			});
			$(".cancelUpdate").click(function(){
				var old = $(this).closest("tr");
				var id = old.find("td:eq(0)").text();
				$("tr[sliderID='"+id+"']").css({"display":"table-row"});
				old.remove();
			});
			$(".deletePointToCouponList").click(function(){
				if(confirm("确认删除！")){
					$.ajax({
						data:{sliderID:$(this).closest("tr").find("td:eq(0)").text().trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/slider_delete.html'" />",
						success:function(data){
							data = eval("("+data+")")
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
					url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/slider_update.action'" />",
					success:function(data){
						data = eval("("+data+")")
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
					sliderID:tr.find("td:eq(0)").text().trim(),
					href:tr.find("td:eq(2)").find("input").val().trim(),
					sequence:tr.find("td:eq(3)").find("input").val().trim(),
				};
				return data;
			};
			
            $('.photoimg').change(function(){
            	var td = $(this).closest("td");
            	td.find(".preview").html('').html('<img src="<s:property value="@com.haozhuoji.mall.util.Constant@file_p" />/images/ajax/loader.gif" alt="Uploading...."/>');
            	td.find("input").hide();
            	td.find(".imageform").ajaxForm({
            		data:{sliderID:td.closest("tr").attr("sliderID")},
            		success:function(data){
            			data = eval("("+data+")");
            			if(data.status!="success"){
            				alert(data.status);
            				location.reload();
            			}else{
            				location.reload();
            			}
            		},
            		error:function(){
            			alert("上传失败");
            				location.reload();
            		}
            	}).submit();
			});
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
		.sliderImg{width:250px}
		input{text-align:center;width:60px}
		.tInput{width:140px}
	</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
		<div class="trueBody">
			<div class="title">首页幻灯片</div>
			<br />
			注意链接格式，一定要加http://
			<div id="updateCon" style="display:none">
				<a class='confimrUpdate'>确定</a><span> </span><a class="cancelUpdate">取消</a>
			</div>
			<br />
			<br/>
			<hr/>
			<br/>
			<table>
				<tr class="header">
					<td class="width1">ID</td>
					<td class="width2">图片</td>
					<td class="width4">链接</td>
					<td class="width5">排序</td>
					<td class="width5">操作</td>
				</tr>
				<tr id="addPointToCoupon">
					<td>增加幻灯片</td>
					<td>-</td>
					<td><input class="tInput" name="href" autocomplete="off" /></td>
					<td><input class="tInput" name="sequence" autocomplete="off" /></td>
					<td>
						<input type="submit" value="确定增加" class="addButton"  />
					</td>
				</tr>
				<s:iterator value="#request.sliderList">
					<tr sliderID="<s:property value="sliderID" />">
						<td><s:property value="sliderID" /></td>
						<td>
							
							<img class="sliderImg" src="<s:property value="@com.haozhuoji.mall.util.Constant@sliderImg_p+'/'+imgName" />">
							<form class="imageform" method="post" enctype="multipart/form-data" action='<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/slider_changeImg.action'" />'>
								<div class='preview'>
								</div>
									<input value="更换图片" type="file" name="upload" class="photoimg" />
							</form>
						</td>
						<td><s:property value="href" /></td>
						<td><s:property value="sequence" /></td>
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
