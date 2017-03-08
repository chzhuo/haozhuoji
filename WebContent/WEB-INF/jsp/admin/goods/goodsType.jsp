<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>商品类型</title>
	<s:include value="/WEB-INF/jsp/admin/headMeta.jsp"></s:include>
	
	<script type="text/javascript">
		//auto color
		$(function(){
			$(".trueBody .itemFrame:even").css("background-color","#f9f9f9");
			$(".trueBody .itemFrame:odd").css("background-color","#fefefe");
			$(".trueBody .itemFrame").hover(function(){
				$(this).css("background-color","#CEE3F7");
			},function(){					
				$(".trueBody .itemFrame:even").css("background-color","#f9f9f9");
				$(".trueBody .itemFrame:odd").css("background-color","#fefefe");
			});
		});
		//register  listener
		$(function(){
			checkFileds=function(typeName){
				if(typeName==""){
					alert("类型名不能为空");
					return false;
				}
				return true;
			};
			$(".addGoodsType").click(function(){
				var typeName = $(this).closest(".itemFrame").find(".typeName input").val().trim();
				if(checkFileds(typeName)){
					$.ajax({
						data:{typeName:typeName,fatherID:$(this).closest(".itemFrame").attr("fatherID")},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/goodsType_add.html'" />",
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
			$(".updateType").click(function(){
				$(".itemFrame[update]").removeAttr("update").css({display:"block"});
				var tr = $(this).closest(".itemFrame").attr("update","update");
				var utr = $("#updateFrame");
				tr.after(utr);
				utr.attr({"typeID":tr.attr("typeID"),"style":tr.attr("style"),"fatherID":tr.attr("fatherID")});
				utr.find(".typeName input").val(tr.find(".typeName").text());
				tr.css({display:"none"});
				utr.css({display:"block"});
			});
			$("#cancelUpdate").click(function(){
				$("#updateFrame").css({display:"none"});
				$(".itemFrame[update]").removeAttr("update").css({display:"block"});
			});
			$(".deleteType").click(function(){
				if(confirm("确认删除！")){
					$.ajax({
						data:{typeID:$(this).closest(".itemFrame").attr("typeID").trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/goodsType_delete.html'" />",
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
				var tr = $(this).closest(".itemFrame");
				if(checkFileds(tr.find(".typeName input").val().trim())){
					$.ajax({
						data:{typeID:tr.attr("typeID"),typeName:tr.find(".typeName input").val().trim()},
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@admin_p+'/goodsType_update.html'" />",
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
			$(".addSubType").click(function(){
				var item = $(this).closest(".itemFrame");
				var n = $("#addSubType").css({display:'block'}).attr("fatherID",item.attr("typeID"));
				item.after(n);
			});
			$(".cancelAddSub").click(function(){
				$(this).closest(".itemFrame").css({display:'none'});
			});
		});
	</script>
	<style type="text/css">
		a{cursor:pointer}
		.trueBody .frame{padding:20px}
		.trueBody .itemFrame{height:20px;overflow:hidden;width:400px}
		.trueBody .itemFrame .typeName{float:left;line-height:20px;width:110px}
		.trueBody .itemFrame .operation{float:left;line-height:20px;width:200px}
	</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/admin/menu.jsp" />
		<div class="trueBody">
			<div class="title">商品类型</div>
			<div class="frame">
				<s:iterator value="#request.goodsTypeList">
					<s:div typeID="typeID" fatherID="%{fatherID}" cssClass="itemFrame" cssStyle="padding-left:%{fatherID!=0?'20px':0};border-top:%{fatherID==0?'2px solid #999999':0};margin-top:%{fatherID==0?'5px':0}">
						<div class="typeName"><s:property value="typeName"/></div>
						<div class="operation">
							<a href="javascript:void(0)" class="updateType">修改</a>
							<a href="javascript:void(0)" class="deleteType">删除</a>
							<s:if test="fatherID==0">
								<a href="javascript:void(0)" class="addSubType">增加子类</a>
							</s:if>
						</div>
					</s:div>
				</s:iterator>
				<div class="itemFrame" id="updateFrame" style="display:none">
					<div class="typeName"><input autocomplete="off" style="width:100px" /></div>
					<div class="operation">
						<a href="javascript:void(0)" id="confirmUpdate">确认</a>
						<a href="javascript:void(0)" id="cancelUpdate">取消</a>
					</div>
				</div>
				<div class="itemFrame" id="addSubType" style="display:none">
					<div class="typeName"><input autocomplete="off" style="width:100px" /></div>
					<div class="operation">
						<a href="javascript:void(0)" class="addGoodsType">确认增加子类</a>
						<a href="javascript:void(0)" class="cancelAddSub">取消</a>
					</div>
				</div>
				<div class="itemFrame" fatherID="0" style="border-top:2px solid #999999;margin-top:15px;padding-top:5px">
					<div class="typeName"><input autocomplete="off" style="width:100px" /></div>
					<div class="operation">
						<a href="javascript:void(0)" class="addGoodsType">确认增加父类</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
