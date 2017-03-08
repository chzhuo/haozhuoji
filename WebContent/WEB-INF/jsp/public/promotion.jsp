<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/frame/headMeta.jsp" />
		<title>好捉急校园便利店-河南工业大学</title>
		<style type="text/css">
			.i_title{height:40px;width:1200px;border-bottom:2px solid #dddddd;margin:30px auto 10px}
			.i_title .floor{padding-left:2px;font:600 20px/30px 'microsoft yahei';color:#ffffff;float:left;height:40px;width:30px;background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p"/>/images/g_image.png) no-repeat -50px -180px}
			.i_title .titleName{text-indent:30px;float:left;font:600 20px/40px 'microsoft yahei';color:#999999}
			.i_goodsFrame{width:1200px;margin:0 auto;overflow:hidden}
			.i_goodsFrame .goodsItem{display:block;width:200px;padding:15px;margin:4px;border:1px solid #FFFFFF;float:left}
			.i_goodsFrame .goodsItem:hover{border:1px solid #DBDBDB;box-shadow:0 0 6px #e0e0e0}
			.i_goodsFrame .goodsItem .goodsHref{display:block;cursor:pointer;font:12px/18px '宋体';color:#333333;text-decoration:none}
			.i_goodsFrame .goodsItem .goodsHref:hover{color:#EB4A3F}
			.i_goodsFrame .goodsItem .goodsHref .goodsImg{width:200px;height:200px;text-align:center}
			.i_goodsFrame .goodsItem .goodsName{height:54px;padding-top:15px}
			.i_goodsFrame .goodsItem .goodsName span{color:#eb4a3f}
			.i_goodsFrame .goodsItem .goodsPrice{font:18px/18px 'microsoft yahei';color:#EB4A3F;padding:15px 0}
			.i_goodsFrame .goodsItem .goodsPrice span{font:12px/18px '宋体';color:#999999;text-decoration:line-through}
			.i_goodsFrame .goodsItem .goodsConfirm{cursor: pointer;width:200px;height:30px;background-color:#eb4a3f;display: block;color:#FFFFFF;text-decoration:none;font:18px/30px 'microsoft yahei';text-align:center;border-radius:2px}
			.i_goodsFrame .goodsItem .goodsConfirm:hover{background-color:#f55e55}
			#countTime{overflow:hidden;width:1200px;margin:0 auto}
			#countTime .item{color:#eb4a3f;width:60px;height:40px;padding:10px;margin:10px;float:left;text-align:center;font:30px/40px 'microsoft yahei';background-color:#eeeeee}
			#countTime .blank{color:#333333;float:left;font:20px/40px 'microsoft yahei';height:40px}
			<s:property value="style" />
		</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp"></s:include>
		<div id="countTime" begin="<s:property value="beginDateTime.getTime()" />" end="<s:property value="endDateTime.getTime()" />">
			<div class="blank"></div>
			<div class="item day"></div><div class="blank">天</div>
			<div class="item hour"></div><div class="blank">时</div>
			<div class="item minute"></div><div class="blank">分</div>
			<div class="item second"></div><div class="blank">秒</div>
		</div>
		<script type="text/javascript">
			var countDownTime=null;
			$(function(){
				var curr = new Date().getTime();
				var begin = parseInt($("#countTime").attr("begin"));
				var end = parseInt($("#countTime").attr("end"));
				if(curr<begin){
					$("#countTime .blank:eq(0)").text("离活动开始还有：");
					$("#countTime .item").css({color:'#333333'});
					countDownTime=begin;
					countdown();
				}else if(end<curr){
					$("#countTime .blank:eq(0)").text("活动已结束");
					$("#countTime .item").text(0);
				}else{
					$("#countTime .blank:eq(0)").text("离活动结束还有：");
					countDownTime=end;
					countdown();
				}
			});
			countdown=function(t){
			    var cc = Math.abs(Math.round((new Date().getTime()-countDownTime)/1000));
			    var d = Math.floor(cc/(3600*24));
			    var h = Math.floor( (cc-d*3600*24)/3600 );
			    var m = Math.floor(((cc-d*3600*24-h*3600))/60);
			    var s = Math.floor(cc-d*3600*24-h*3600-m*60);
			    d=d<10?'0'+d:d;
			    $('#countTime .day').html(d);
			    h=h<10?'0'+h:h;
			    $('#countTime .hour').html(h);
			    m=m<10?'0'+m:m;
			    $('#countTime .minute').html(m);
			    s=s<10?'0'+s:s;
			    $('#countTime .second').html(s);
			    setTimeout("countdown()",1000);
			}
		</script>
		<s:iterator value="#request.goodsItemList" status="stu">
			<div class="i_title">
				<div class="floor"><s:property value="#stu.index+1" />F</div>
				<div class="titleName"><s:property value="itemTitle" /></div>
			</div>
			<div class="i_goodsFrame">
				<s:iterator value="goodsList">
					<div class="goodsItem">
						<s:a href="%{@com.haozhuoji.mall.util.Constant@goods_p+goodsID}.html" cssClass="goodsHref">
						<div class="goodsImg">
							<img src="<s:property value="@com.haozhuoji.mall.util.Constant@goodsImage_p+'/'+goodsID+'/main/main_200x200.jpg'" />" />
						</div> 
						<div class="goodsName">
							<s:property value="brand+' '+goodsName+' '+specification" />&nbsp;&nbsp;<span><s:property value="promotion_sentence" /></span>
						</div></s:a>
						<s:if test="beginDateTime.getTime()>@java.lang.System@currentTimeMillis()" >
							<div class="goodsPrice">
								<span style="color:#eb4a3f;text-decoration:none">活动价:</span>¥ <s:property value="@com.haozhuoji.mall.util.Arith@format(promotion_price)" />
								<span>原价：¥<s:property value="@com.haozhuoji.mall.util.Arith@format(product_price)" /></span>
							</div>
							<div href="javascript:void(0)" class="goodsConfirm" style="color:#666666;background-color:#eeeeee">暂未开始</div>
						</s:if>
						<s:else>
							<div class="goodsPrice">
								<span style="color:#eb4a3f;text-decoration:none">活动价:</span>¥ <s:property value="@com.haozhuoji.mall.util.Arith@format(product_price)" />
								<span>原价：¥<s:property value="@com.haozhuoji.mall.util.Arith@format(reference_price)" /></span>
							</div>
							<s:if test="amount>0">
								<s:a href="javascript:void(0)" cssClass="goodsConfirm" onclick="addGoods(%{goodsID},1)" > 加入购物车 </s:a>
							</s:if>
							<s:else>
								<div href="javascript:void(0)" class="goodsConfirm" style="color:#666666;background-color:#eeeeee">暂时缺货</div>
							</s:else>
						</s:else>
					</div>
				</s:iterator>
			</div>
		</s:iterator>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"></s:include>
	</body>
</html>