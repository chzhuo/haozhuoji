<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/frame/headMeta.jsp" />
		<title>好捉急校园便利店-河南工业大学</title>
		<style type="text/css">
			.classSlider{width:1200px;margin:0 auto;overflow:hidden}
			.classSlider .classDetail{float:left;width:178px;border:1px solid #DDDDDD;padding:0 10px;border-top:0;box-shadow:1px 1px 1px #e0e0e0;}
			.classSlider .classDetail a{padding:0 10px;color:#666666;display:block;width:157px;height:33px;border-bottom:1px solid #DDDDDD;text-decoration:none;font:600 14px/33px '宋体'}
			.classSlider .slider{width:750px;height:240px;float:left}
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
		</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp"></s:include>
		<!-- 主页商品 -->
		<div class="classSlider">
			<div class="classDetail g_allClass_flag">
				<s:iterator value="#request.allGoodsTypeList">
					<s:a href="%{@com.haozhuoji.mall.util.Constant@goodsType_p+typeID}.html"><s:property value="typeName"/></s:a>
				</s:iterator>
			</div>
			<div class="slider">
				<s:include value="/WEB-INF/jsp/frame/slider.jsp"/>
			</div>
		</div>
		<div style="text-align:center;">
			<s:iterator value="#request.indexPromotionList">
				<s:a href="%{@com.haozhuoji.mall.util.Constant@http_p+'/promotion.html?promotionID='+promotionID}">
					<img src="<s:property value="@com.haozhuoji.mall.util.Constant@promotionImg_p+'/'+titleImg" />" alt="<s:property value="title" />" />
				</s:a>
			</s:iterator>
		</div>
		<s:iterator value="#request.constantList" status="stu">
			<div class="i_title">
				<div class="floor"><s:property value="#stu.index+1" />F</div>
				<div class="titleName"><s:property value="value1" /></div>
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
						<div class="goodsPrice">
							¥ <s:property value="@com.haozhuoji.mall.util.Arith@format(product_price)" />
							<span>¥<s:property value="@com.haozhuoji.mall.util.Arith@format(reference_price)" /></span>
						</div>
						<s:if test="amount>0">
							<s:a href="javascript:void(0)" cssClass="goodsConfirm" onclick="addGoods(%{goodsID},1)" > 加入购物车 </s:a>
						</s:if>
						<s:else>
							<div href="javascript:void(0)" class="goodsConfirm" style="color:#666666;background-color:#eeeeee">暂时缺货</div>
						</s:else>
					</div>
				</s:iterator>
			</div>
		</s:iterator>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"></s:include>
	</body>
</html>