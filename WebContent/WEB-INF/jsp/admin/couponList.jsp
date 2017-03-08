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
				data.couponID=null;
				if(checkFileds(data)){
					data.createCount = $("#createCount").val().trim();
					$.ajax({
						data:data,
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/coupon_add.html'" />",
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
				curr.find("td:eq(8)").text("").append($("#updateCon").children().clone(true));
				curr.css({"display":"table-row"});
				old.css({"display":"none"});
				old.after(curr);
			});
			$(".cancelUpdate").click(function(){
				var old = $(this).closest("tr").css({"display":"none"});
				var id = old.find("td:eq(0)").text();
				$("tr[couponID='"+id+"']").css({"display":"table-row"});
			});
			$(".deletePointToCouponList").click(function(){
				if(confirm("确认删除！")){
					$.ajax({
						data:{couponID:$(this).closest("tr").find("td:eq(0)").text().trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/coupon_delete.html'" />",
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
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/coupon_update.action'" />",
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
					couponID:tr.find("td:eq(0)").text().trim(),
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
			<div class="title">积分兑换规则</div>
			<br />
			时间格式：2014-02-22 15:22:02<br /><br/>如果满多少等于减多少即为代金券<br/>
			<div id="updateCon" style="display:none">
				<a class='confimrUpdate'>确定</a><span> </span><a class="cancelUpdate">取消</a>
			</div>
			<br />
			<s:form action="" method="get" onsubmit="return toServer('')" >
					<span>ID</span>：<s:textfield name="couponID" cssClass="g_page_flag" />&nbsp;&nbsp;
					<span>绑定用户</span>：<s:textfield name="bindUserID" cssClass="g_page_flag" />&nbsp;&nbsp;
					<span>优惠券号</span>：<s:textfield name="couponNumber" cssClass="g_page_flag" />&nbsp;&nbsp;
					<span>类型</span>：<s:select list="#request.goodsTypeList"  listKey="typeID" listValue="fullTypeName" cssClass="g_page_flag" name="typeID"/>&nbsp;&nbsp;
					<span>是否使用</span>：<s:select list="#{'':'全部','true':'是','false':'否'}" cssClass="g_page_flag" name="used"/>&nbsp;&nbsp;
					<span>排序</span>：<s:select list="#{'couponID':'ID','couponNumber':'编号','bindUserID':'绑定用户','rech':'满价格','sub':'减价格','beginDateTime':'开始时间','endDateTime':'结束时间','createDateTime':'创建时间','typeID':'商品类型'}" cssClass="g_page_flag" name="page.orderBy"/>&nbsp;&nbsp;
					<span>升降序</span>：<s:select list="#{'true':'降序','false':'升序'}" cssClass="g_page_flag" name="page.desc"/>&nbsp;&nbsp;
					<input value="查询" type="submit" />
					<input type="reset" value="重置" />
			</s:form>
			<br/>
			<hr/>
			<br/>
			<table>
				<tr class="header">
					<td class="width1">ID</td>
					<td class="width2">兑换内容</td>
					<td class="width4">使用范围</td>
					<td class="width5">开始使用时间</td>
					<td class="width5">过期时间</td>
					<td class="width5">创建时间</td>
					<td class="width1">绑定用户ID</td>
					<td class="width1">编号</td>
					<td class="width3">操作</td>
				</tr>
				<tr id="addPointToCoupon">
					<td>增加优惠券兑换</td>
					<td>满：<input name="rech"  autocomplete="off" /> 减：<input name="sub" autocomplete="off"/></td>
					<td><s:select list="#request.goodsTypeList" name="typeID" listKey="typeID" listValue="fullTypeName" /></td>
					<td><input class="tInput" name="beginDateTime" autocomplete="off" /></td>
					<td><input class="tInput" name="endDateTime" autocomplete="off" /></td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>
						数量：<input name="createCount" id="createCount"  autocomplete="off" />
						<input type="submit" value="确定增加" class="addButton"  />
					</td>
				</tr>
				<s:iterator value="#request.couponList">
					<tr couponID="<s:property value="couponID" />">
						<td><s:property value="couponID" /></td>
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
						<td><s:property value="@com.haozhuoji.mall.util.DateUtil@format_dateTime(createDateTime)" /></td>
						<td><s:property value="bindUserID" /></td>
						<td><s:property value="couponNumber" /></td>
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
