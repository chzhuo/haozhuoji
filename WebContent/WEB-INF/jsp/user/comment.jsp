<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/user/headMeta.jsp"/>
		<title>商品评价 <s:property value="#request.orderNumber"/> -好捉急校园便利店</title>
		<style type="text/css">
			.uc_title{height:20px;width:1000px;margin:0 auto;padding:10px 5px;font:20px/20px 'microsoft yahei';color:#333333}
			.uc_frame{width:1000px;margin:0 auto;overflow:hidden}
			.uc_right{width:780px;margin-left:18px;float:left;box-shadow:0 0 6px #eeeeee}
			
			.uc_right a{color:#3377ff;text-decoration:none}
			.uc_right a:hover{text-decoration:underline}
			.goodsList{overflow:hidden}
			.goodsList .goodsName{width:445px;heigth:60px;overflow:hidden}
			.goodsList .specification{width:100px;heigth:60px;text-align:center}
			.goodsList .count{width:200px;heigth:60px;text-align:center}
			.goodsList .subtotal{width:100px;heigth:60px;text-align:center;color:#999999}
			.goodsList .titleNav{height:30px;line-height:30px;background-color:#eeeeee}
			.goodsList .titleNav div{float:left;text-align:center}
			.goodsList .titleNav .goodsName{text-align:left}
			.goodsList .goodsItem{border-bottom:1px solid #eeeeee;overflow:hidden}
			.goodsList .goodsItem>div{float:left}
			.goodsList .goodsItem{line-height:60px}
			.goodsList .goodsItem .coupon{width:445px;overflow:hidden}
			.goodsList .goodsItem .coupon>div{float:left}
			.goodsList .goodsItem .goodsName{padding:4px 0;height:52px}
			.goodsList .goodsItem .goodsName a{font:12px/20px '宋体';color:#333333}
			.goodsList .goodsItem .goodsName a:hover{color:#eb4a3f;text-decoration:underline;}
			.goodsList .goodsItem img{float:left;heigth:50px;width:50px;border:1px solid #eeeeee;margin-right:5px;height:50px;width:50px}
			.goodsList .goodsItem .count span{color:#eb4a3f}
		</style>
		<script type="text/javascript">
			$(function(){
				$(".commentFrame .commentItme div").click(function(){
					$(this).siblings("input").prop("checked",true);
				});
				$(".goodsList .publishComment").click(function(){
					$(this).closest(".goodsItem").after($(".commentFrame").css({display:'block'}));
					$(".commentFrame").attr({"orderGoodsID":$(this).closest(".goodsItem").attr("orderGoodsID"),"goodsID":$(this).closest(".goodsItem").attr("goodsID")});
					$(".commentFrame input[type='radio']:eq(0)").prop("checked",true);
					$("#commentContent").val("");
				});
				$(".goodsList .publishComment:eq(0)").click();
				$("#submitComment").click(function(){
					var reP={
						orderGoodsID:$(".commentFrame").attr("orderGoodsID"),
						goodsID:$(".commentFrame").attr("goodsID"),
						comment:$("#commentContent").val()
					};
					if($(".commentFrame .commentItme input:checked").length==0){
						g_mess.alert("请选择评分");
						return;
					}else{
						reP.point=$(".commentFrame .commentItme input:checked").val();
					}
					if(reP.comment.length<10||reP.comment.length>100){
						g_mess.alert("评价内容10-100个字符");
						return;
					}
					if(reP.orderGoodsID==""||reP.goodsId==""){
						g_mess.alert("参数异常");
						return;
					}
					$.ajax({
						type:'post',
						url:"<s:property value="@com.haozhuoji.mall.util.Constant@user_p" />/order_comment.action",
						data:reP,
						success:function(data){
							data=eval("("+data+")");
							if(data.status=="success"){
								$(".commentFrame").prev().find(".subtotal").text("已评论");
								var c = $(".commentFrame");
								while(c.next().length>0){
									if(c.next().find(".publishComment").length>0){
										c.next().find(".publishComment").click();
										return;
									}else{
										c= c.next();
									}
								}
								$(".commentFrame").css({display:'none'});
							}else{
								g_mess.alert(data.status);								
							}
						},
						error:function(){
							g_mess.alert("评论出错，请刷新后再试！");
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp" />
		<s:include value="/WEB-INF/jsp/user/userCenter/headerStyle.jsp" />
		<div class="uc_title">
			个人中心
		</div>
		<div class="uc_frame">
			<s:include value="/WEB-INF/jsp/user/userCenter/menu.jsp" />
			<div class="uc_right">
				<strong>商品评价 - 订单编号：<s:property value="#request.order.orderNumber" /></strong>
		   		<br/><br/>
				<div class="goodsList">
					<div class="titleNav">
						<div class="goodsName">商品名称</div>
						<div class="count">购买时间</div>
						<div class="subtotal" style="color:#333333">评价</div>
					</div>
					<s:iterator value="#request.order.orderGoodsList">
						<s:iterator value="goodsIDs.split('-')" status="sta">
							<s:div cssClass="goodsItem" orderGoodsID="%{orderGoodsID}" goodsID="%{goodsIDs.split('-')[#sta.index]}">
								<div class="coupon">
									<div class="goodsName">
										<s:a href="%{@com.haozhuoji.mall.util.Constant@goods_p+goodsIDs.split('-')[#sta.index]}.html">
										<img src="<s:property value="@com.haozhuoji.mall.util.Constant@goodsImage_p+'/'+goodsIDs.split('-')[#sta.index]+'/main/main_50x50.jpg'" />" />
										<s:property value="goodsName.split('spe_spe')[#sta.index]" /></s:a>
									</div>
								</div>
								<div class="count">
									<s:property value="@com.haozhuoji.mall.util.DateUtil@format(#request.order.createDateTime)" />
								</div>
								<div class="subtotal">
									<s:if test='(goodsIDs.split("-")[#sta.index])=="1"'>
										该商品已删除
									</s:if>
									<s:elseif test="comment.contains(goodsIDs.split('-')[#sta.index])">
										已评论
									</s:elseif>
									<s:else>
										<a class="publishComment" href="javascript:void(0)">发表评价</a>
									</s:else>
								</div>
							</s:div>
						</s:iterator>
					</s:iterator>
				</div>		
				<style type="text/css">
					.commentFrame .title{float:left;height:80px;width:80px;text-align:center}
					.commentFrame .title span{color:#eb4a3f}
					.commentFrame .commentItme{width:130px;float:left;height:15px;overflow:hidden;padding:2px 0 3px}
					.commentFrame .commentItme input{float:left;width:15px;height:15px;margin-right:5px}
					#submitComment{height:25px;text-align:center;font:15px/25px 'microsoft yahei';color:#ffffff;margin-top:10px;box-shadow:0 0 5px #eeeeee;border-radius:2px;cursor:pointer}
				</style>
				<div class="commentFrame" style="display:none;position:relative;padding:20px 0;overflow:visibility;font:12px/20px microsoft yahei;background-color:#FFFDEE;border:1px solid #EDD28B">
					<div style="border:0;margin:0;font:25px/25px Arail;position:absolute;top:-23px;left:680px;z-index:6;width:25px;color:#EDD28B;background-color:#FFFDEE">∧</div>
					<div style="overflow:hidden">
						<div class="title">
							<span>*</span>评分：<br/><br/>
							<span>*</span>评价：
						</div>
						<s:div cssClass="commentItme"><input autocomplete="off" name="point" value="5" type="radio" /><s:div cssStyle="height:15px;width:75px;background:url(%{@com.haozhuoji.mall.util.Constant@file_p}/images/g_image.png) no-repeat 0 -231px;float:left"></s:div></s:div>
						<s:div cssClass="commentItme"><input autocomplete="off" name="point" value="4"  type="radio" /><s:div cssStyle="height:15px;width:75px;background:url(%{@com.haozhuoji.mall.util.Constant@file_p}/images/g_image.png) no-repeat -15px -231px;float:left"></s:div></s:div>
						<s:div cssClass="commentItme"><input autocomplete="off" name="point" value="3" type="radio" /><s:div cssStyle="height:15px;width:75px;background:url(%{@com.haozhuoji.mall.util.Constant@file_p}/images/g_image.png) no-repeat -30px -231px;float:left"></s:div></s:div>
						<s:div cssClass="commentItme"><input autocomplete="off" name="point" value="2" type="radio" /><s:div cssStyle="height:15px;width:75px;background:url(%{@com.haozhuoji.mall.util.Constant@file_p}/images/g_image.png) no-repeat -45px -231px;float:left"></s:div></s:div>
						<s:div cssClass="commentItme"><input autocomplete="off" name="point" value="1" type="radio" /><s:div cssStyle="height:15px;width:75px;background:url(%{@com.haozhuoji.mall.util.Constant@file_p}/images/g_image.png) no-repeat -60px -231px;float:left"></s:div></s:div>
						<textarea id="commentContent" autocomplete="off" style="width:500px;height:100px;margin-top:20px;float:left"></textarea>
						<div style="float:left;padding-top:102px;padding-left:20px;color:#666666">10-100字</div>
						<div id="submitComment" style="width:100px;float:left;margin-left:80px;background-color:#eb4a3f">提交并继续</div>
					</div>
				</div>	
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp" />
		<s:include value="/WEB-INF/jsp/frame/message.jsp" />
	</body>
</html>