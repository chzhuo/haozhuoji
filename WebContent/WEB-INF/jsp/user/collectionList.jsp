<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/user/headMeta.jsp"></s:include>
		<title>我的收藏-好捉急校园便利店</title>
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
			<style type="text/css">
				.goodsList{overflow:hidden}
				.goodsList .goodsName{width:445px;heigth:60px;overflow:hidden}
				.goodsList .specification{width:100px;heigth:60px;text-align:center}
				.goodsList .price{width:50px;heigth:60px;text-align:center}
				.goodsList .count{width:150px;heigth:60px;text-align:center}
				.goodsList .subtotal{width:100px;heigth:60px;color:#999999;text-align:center;}
				.goodsList .titleNav{height:30px;line-height:30px;background-color:#eeeeee}
				.goodsList .titleNav div{float:left;text-align:center}
				.goodsList .titleNav .goodsName{text-align:left}
				.goodsList .titleNav .subtotal{color:#333333;font-weight:400}
				.goodsList .goodsItem{border-bottom:1px solid #eeeeee;overflow:hidden}
				.goodsList .goodsItem>div{float:left}
				.goodsList .goodsItem{line-height:60px}
				.goodsList .goodsItem .coupon{width:445px;overflow:hidden}
				.goodsList .goodsItem .coupon>div{float:left}
				.goodsList .goodsItem .goodsName{padding:4px 0;height:52px}
				.goodsList .goodsItem .goodsName a{font:12px/20px '宋体';color:#333333;text-decoration:none}
				.goodsList .goodsItem .goodsName span{color:#eb4a3f}
				.goodsList .goodsItem .goodsName a:hover{color:#eb4a3f;text-decoration:underline;}
				.goodsList .goodsItem img{float:left;heigth:50px;width:50px;border:1px solid #eeeeee;margin-right:5px;height:50px;width:50px}
				.goodsList .goodsItem .count span{color:#eb4a3f}
			</style>
			<div class="goodsList">
				<div class="titleNav">
					<div class="goodsName">商品名称</div>
					<div class="price">单价</div>
					<div class="count">收藏时间</div>
					<div class="subtotal">操作</div>
				</div>
				<s:iterator value="#request.collectionList">
					<div class="goodsItem">
						<div class="coupon">
							<div class="goodsName">
								<s:a href="%{@com.haozhuoji.mall.util.Constant@goods_p+goods.goodsID}.html">
								<img src="<s:property value="@com.haozhuoji.mall.util.Constant@goodsImage_p+'/'+goods.goodsID+'/main/main_50x50.jpg'" />" />
								<s:property value="goods.brand+' '+goods.goodsName+' '+goods.specification" /><span><s:property value="goods.promotion_sentence" /></span></s:a>
							</div>
						</div>
						<div class="price">¥<s:property value="@com.haozhuoji.mall.util.Arith@format(goods.product_price)" /></div>
						<div class="count">
							<s:property value="@com.haozhuoji.mall.util.DateUtil@format(createDateTime)" />
						</div>
						<div class="subtotal">
							<s:if test="!goods.sell">
								已下架
							</s:if>
							<s:elseif test="goods.amount>0">
								<s:a href="javascript:void(0)" onclick="addGoods(%{goods.goodsID},1)">加入购物车</s:a>
							</s:elseif>							
							<s:else>
								暂时缺货
							</s:else>
							<s:a cssClass="c_delete_c" goodsID="%{goods.goodsID}" href="javascript:void(0)">删除</s:a>
						</div>
					</div>
				</s:iterator>
			</div>	        	
			<script type="text/javascript">
				$(".c_delete_c").click(function(){
					$(this).closest(".goodsItem").remove();
					$.ajax({
						type:'post',
						data:{goodsID:$(this).attr("goodsID")},
						url:'<s:property value="@com.haozhuoji.mall.util.Constant@user_p" />/goods_deleteCollection.html',
						success:function(data){
							data = eval("("+data+")");
							if(data.status!="success"){
								g_mess.alert(data.status);
							}
						},
						error:function(){
							g_mess.alert("删除失败，请刷新后再试");
						}
					});
				});
			</script>
			<div style="float:right">
				<s:if test="page.currentPage>1">
					<a class="nextPre" href="<s:property value="@com.haozhuoji.mall.util.Constant@user_p+'/goods_collectionList.html?page.currentPage='+(page.currentPage-1)" />" id="c_nextPre" style="float:left;margin:10px;padding:5px;width:50px;border:1px solid #dddddd;background-color:#eeeeee;text-align:center;color:#666666;cursor:pointer">上一页</a>
				</s:if>
				<s:if test="page.currentPage<page.totalPage">
					<a class="nextPre" href="<s:property value="@com.haozhuoji.mall.util.Constant@user_p+'/goods_collectionList.html?page.currentPage='" /><s:property value="page.currentPage+1"/>" id="c_nextPre" style="float:left;margin:10px;padding:5px;width:50px;border:1px solid #dddddd;background-color:#eeeeee;text-align:center;color:#666666;cursor:pointer">下一页</a>
				</s:if>
			</div>
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"/>
	</body>
</html>