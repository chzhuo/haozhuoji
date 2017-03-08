<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="/WEB-INF/jsp/frame/headMeta.jsp" />
		<title>
			<s:if test="keyWord!=null">
				搜索：<s:property value="keyWord" />
			</s:if>
			<s:if test="fullTypeID!=null">
				-类：<s:property value="fullTypeName.split('-')[fullTypeID.split('-').length-1]" />
			</s:if>
		- 好捉急校园便利店</title>
		<style type="text/css">
			.goodsClassContent{width:1200px;overflow:hidden;margin:0 auto;margin-top:8px}
			.leftContent{width:198px;margin-right:8px;float:left;border:1px solid #eaeaea}
			.leftContent a{display:block;cursor:pointer;text-decoration:none}
			.leftContent a:hover{color:#EB4A3F}
			.leftContent .topAll{cursor:pointer;border-top:2px solid #AAAAAA;height:30px;color:#333333;font:15px/30px 'microsoft yahei';padding-left:10px;border-bottom:1px solid #DDDDDD;background-color:#F7F7F7}
			.leftContent .topT{height:30px;color:#666666;font:15px/30px 'microsoft yahei';padding-left:40px;border-bottom:1px solid #DDDDDD;background-color:#F7F7F7}
			.leftContent .option{height:30px;color:#666666;font:15px/30px '宋体';padding-left:40px;border-bottom:1px solid #DDDDDD;}
			.leftContent .targetOption{color:#eb4a3f}
			.goodsClassContent .rightContent{float:left;}
			
			.rightContent .pageTitle{padding-left:30px;width:100%;border-top:2px solid #FF855B;height:30px;border-bottom:1px solid #EFEFEF;box-shadow:0 1px 1px #e0e0e0;margin-bottom:30px}
			.rightContent .pageTitle a{text-decoration:none;}
			.rightContent .pageTitle a:hover{color:#eb4a3f}
			.rightContent .option{color:#666666;font:14px/30px '宋体';float:left;margin:0 10px}
			
			.goodsFrame{width:992px;overflow:hidden}
			.goodsFrame .goodsItem{display:block;width:200px;padding:23px;border:1px solid #FFFFFF;float:left}
			.goodsFrame .goodsItem:hover{border:1px solid #DBDBDB;box-shadow:0 0 6px #e0e0e0}
			.goodsFrame .goodsItem .goodsHref{display:block;cursor:pointer;font:12px/18px '宋体';color:#333333;text-decoration:none}
			.goodsFrame .goodsItem .goodsHref:hover{color:#EB4A3F}
			.goodsFrame .goodsItem .goodsHref .goodsImg{width:200px;height:200px;text-align:center}
			.goodsFrame .goodsItem .goodsName{height:54px;padding-top:15px}
			.goodsFrame .goodsItem .goodsName span{color:#eb4a3f}
			.goodsFrame .goodsItem .goodsPrice{font:18px/18px 'microsoft yahei';color:#EB4A3F;padding:15px 0}
			.goodsFrame .goodsItem .goodsPrice span{font:12px/18px '宋体';color:#999999;text-decoration:line-through}
			.goodsFrame .goodsItem .goodsConfirm{cursor: pointer;width:200px;height:30px;background-color:#EB4A3F;display: block;color:#FFFFFF;text-decoration:none;font:18px/30px 'microsoft yahei';text-align:center;border-radius:2px}
			.goodsFrame .goodsItem .goodsConfirm:hover{background-color:#E55F55}
		</style>
	</head>
	<body>
		<s:include value="/WEB-INF/jsp/frame/header.jsp"></s:include>
		<div class="goodsClassContent">
			<div class="leftContent">
				<div typeID="0" class="topAll noTarget">所有类目</div>
				<div class="classItem">
					<s:set value="typeID" var="g_typeID"/>
					<s:iterator value="#request.goodsTypeList">
						<s:a href="javascript:void(0)" typeID="typeID" cssClass="%{fullTypeID.split('-').length>2?'option':'topT'} %{typeID==#g_typeID?'targetOption':'noTarget'}"><s:property value="typeName" /></s:a>
					</s:iterator>
				</div>
			</div>
			<div class="rightContent">
				<div class="pageTitle">
					<s:iterator value="fullTypeID.split('-')" var="varID" status="sta">
						<s:a cssClass="option" href="%{@com.haozhuoji.mall.util.Constant@goodsType_p+#varID}.html"><s:property value="fullTypeName.split('-')[#sta.index]" /></s:a>
						<div class="option">&gt;</div>
					</s:iterator>
					<s:if test="keyWord!=null">
						<div class="option"><s:property value="keyWord" /></div>
					</s:if>
				</div>
				<%--顶部排序控制 --%>
				<style type="text/css">
					 .orderBar{width:990px;height:36px;border:1px solid #DDDDDD;box-shadow:0 1px 2px #e0e0e0;margin-bottom:10px}
					 .orderBar ul{list-style:none outside none;float:left}
					 .orderBar li{float:left;}
					 .orderBar a{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p"/>/images/g_image.png) no-repeat;float:left;font:14px/36px '宋体';color:#333333;border-right:1px solid #DDDDDD;padding:0 25px 0 15px;text-decoration:none}
					 .orderBar a:hover{color:#EB4A3F;}
					 .pageCon{float:right;height:36px;font:14px/36px 'Century Gothic';color:#AAAAAA}
					 .pageCon .pageNumber{float:left}
					 .pageCon .pageNumber span{color:#EB4A3F}
					 .pageCon .pre{float:left;width:36px;height:36px;cursor:pointer;margin:0 10px}
					 .pageCon .next{float:left;width:36px;height:36px;cursor:pointer}
					 .pageCon .preNext{background:url(<s:property value="@com.haozhuoji.mall.util.Constant@file_p"/>/images/g_image.png) no-repeat}
				</style>
				<s:div cssClass="orderBar" typeID="%{typeID==null?'':typeID}" desc="%{page.desc!=null&&page.desc?'true':''}" keyWord="%{keyWord}" orderBy="%{page.orderBy==null?'':page.orderBy}">
					<s:a orderBy=" " href="javascript:void(0);" cssStyle="%{page.orderBy==null?'background-position:-50px 13px;background-color:#FF9570;color:#ffffff':'background-position:50px 13px'}">默认</s:a>
					<s:a orderBy="purchase_count" desc="true" href="javascript:void(0);" cssStyle="%{page.orderBy!=null&&page.orderBy.equals('purchase_count')?'background-position:-50px 13px;background-color:#FF9570;color:#ffffff':'background-position:50px 13px'}">销量</s:a>
					<s:a orderBy="aveComment" desc="true" href="javascript:void(0);" cssStyle="%{page.orderBy!=null&&page.orderBy.equals('aveComment')?'background-position:-50px 13px;background-color:#FF9570;color:#ffffff':'background-position:50px 13px'}">好评</s:a>
					<s:if test="page.orderBy!=null&&page.orderBy.equals('product_price')">
						<s:a orderBy="product_price" href="javascript:void(0);" desc="%{page.desc!=null&&page.desc?'':'true'}" cssStyle="color:#ffffff;background-color:#ff9570;%{page.desc!=null&&page.desc?'background-position:-350px 13px;color:#ffffff':'background-position:-250px 13px'}">价格</s:a>
					</s:if>
					<s:else>
						<a orderBy="product_price" href="javascript:void(0)" style="background-position:-150px 10px">价格&nbsp;</a>
					</s:else>
					<div class="pageCon">
						<div class="pageNumber"><span><s:property value="page.currentPage" /></span>&nbsp;/<s:property value="page.totalPage" /></div>
						<s:div cssClass="pre preNext" cssStyle="background-position:%{page.currentPage>1?'-44px -44px':'6px -44px'}"></s:div>
						<s:div cssClass="next preNext" cssStyle="background-position:%{page.currentPage<page.totalPage?'-194px -44px':'-144px -44px'}"></s:div>
					</div>
				</s:div>
				<%--商品分页 --%>
				<div class="goodsFrame">
					<s:iterator value="#request.goodsList" >
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
				<%--底部页码 --%>
				<script type="text/javascript">
				$(function(){
					$(".leftContent .noTarget").click(function(){
						var href = location.href.split("?")[0]+"?";
						var ob = $(".orderBar");
						if(ob.attr("keyWord")!=""){
							href+="keyWord="+ob.attr("keyWord")+"&";
						}
						href+="typeID="+$(this).attr("typeID");
						location.href = href;
						return false;
					});
					$(".g_pageFrame .pageItem").click(function(){
						toServer("page.currentPage="+$(this).text().trim()+"&");
					});
					$(".g_pageFrame .prePage").click(function(){
						toServer("page.currentPage="+(parseInt($(".g_pageFrame .curPage").text().trim())-1)+"&");
					});
					$(".orderBar .next").click(function(){
						$(".g_pageFrame .nextPage").click();
					});
					$(".orderBar .pre").click(function(){
						$(".g_pageFrame .prePage").click();
					});
					$(".g_pageFrame .nextPage").click(function(){
						toServer("page.currentPage="+(parseInt($(".g_pageFrame .curPage").text().trim())+1)+"&");
					});
					$(".orderBar a").click(function(){
						if($(this).attr("orderBy")!=$(".orderBar").attr("orderBy")||$(this).attr("orderBy")=="product_price"){
							var href = location.href.split("?")[0]+"?";
							var ob = $(".orderBar");
							if($(this).attr("desc")!=""&&$(this).attr("desc")!=null){
								href+="page.desc="+$(this).attr("desc")+"&";
							}
							if(ob.attr("keyWord")!=""&&ob.attr("keyWord")!=null){
								href+="keyWord="+ob.attr("keyWord")+"&";
							}
							if($(this).attr("orderBy").trim()!=""&&$(this).attr("orderBy")!=null){
								href+="page.orderBy="+$(this).attr("orderBy")+"&";
							}
							if(ob.attr("typeID")!=""&&ob.attr("typeID")!=null){
								href+="typeID="+ob.attr("typeID")+"&";
							}
							location.href = href;
							return false;
						}
					});
					toServer = function(page){
						var href = location.href.split("?")[0]+"?";
						var ob = $(".orderBar");
						if(ob.attr("desc")!=""){
							href+="page.desc="+ob.attr("desc")+"&";
						}
						if(ob.attr("keyWord")!=""){
							href+="keyWord="+ob.attr("keyWord")+"&";
						}
						if(ob.attr("orderBy")!=""){
							href+="page.orderBy="+ob.attr("orderBy")+"&";
						}
						if(ob.attr("typeID")!=""){
							href+="typeID="+ob.attr("typeID")+"&";
						}
						href+=page;
						location.href = href;
						return false;
					};
				});
				</script>				
				<div class="pageFrame" style="padding-top:50px">
					<s:include value="/WEB-INF/jsp/frame/page.jsp"></s:include>
				</div>
			</div>
		</div>
		<s:include value="/WEB-INF/jsp/frame/footer.jsp"></s:include>
	</body>
</html>