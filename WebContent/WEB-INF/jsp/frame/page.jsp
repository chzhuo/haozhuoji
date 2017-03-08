<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<style type="text/css">
	 .g_pageFrame{float:right;overflow:hidden}
	 .g_pageFrame .pageItem{cursor:pointer;float:left;width:34px;font:16px/34px 'microsoft yahei';margin:0 5px;color:#999999;background-color:#fafafa;border:1px solid #DDDDDD;text-align:center}
	 .g_pageFrame .pageItem:hover{color:#FFFFFF;background-color:#FF8C64;border:1px solid #FF8C64}
	 .g_pageFrame .nextPage{width:100px}
	 .g_pageFrame .prePage{width:100px}
	 .g_pageFrame .pageSpace{float:left;width:35px;font:16px/30px 'microsoft yahei';margin:0 5px;color:#999999;text-align:center}
	 .g_pageFrame .curPage{float:left;width:35px;font:16px/35px 'microsoft yahei';margin:0 5px;color:#FFFFFF;background-color:#FF8C64;text-align:center}
</style>
<div class="g_pageFrame">
	<s:if test="page.currentPage>1">
		<a class="pageItem prePage">上一页</a>
	</s:if>
	<s:iterator value="new byte[page.totalPage]" status="sta">
		<s:if test="page.currentPage==#sta.index+1">
			<span class="curPage"><s:property value="#sta.index+1" /></span>
		</s:if>
		<s:else>
			<a class="pageItem" href="javascript:void(0)"><s:property value="#sta.index+1" /></a>
		</s:else>
	</s:iterator>
	<s:if test="page.currentPage<page.totalPage">
		<a class="pageItem nextPage">下一页</a>
	</s:if>
</div>
