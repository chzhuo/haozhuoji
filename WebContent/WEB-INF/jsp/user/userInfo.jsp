<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<s:include value="../frame/headMeta.jsp" />
		<title></title>
	</head>
	<body>
		<s:include value="../frame/navigation.jsp"></s:include>
	  	<s:if test="%{#session.userBean!=null||#request.userBean!=null}">
		  	<s:include value="../frame/cart.jsp"></s:include>
	  	</s:if>
	  	
	  	<center>
    <div id="midDiv" style="width:95%; height:1300px; position:relative; left:-5%; background-color:#F6F6E8;" >
    	<div style="height:110px;"></div>
        <div id="main" style="width:595px; margin-left:10%;">
            <img src="/images/user/mainMid.jpg" />
        </div>
        <div id="tabDiv" style="width:595px; height:500px; margin-left:10%; background-color:#FFFFFF;">
        	<table id="tab" style="width:280px;">
                <tr height="30px" valign="top">
                    <td align="center" colspan="2" style="font-size:16px; font-weight:600; color:#AEAEAE;">积分<s:property value="model.points" /></td>
                </tr>
                <tr>    
                    <td colspan="2" align="center">
                    <div style="width:160px; height:40px; line-height:40px; background-color:#E75280; color:#FFFFFF;">
                    </div>
                    </td>
                </tr>
                <tr height="20px"><td></td></tr>
                <tr><td colspan="2" align="center"><div style="width:350px; height:10px; border-top:1px solid #AEAEAE;"></div></td></tr>
                <tr height="35px">    
                    <td align="left" width="365px;" style="font-size:14px; font-weight:600; color:#AEAEAE;">收货地址:<s:property value="%{addr.getAddress()}"/></td>
                    <td align="left"><input class="inp" type="text" /></td>
                </tr>
                <tr height="35px">    
                    <td align="left" style="font-size:14px; font-weight:600; color:#AEAEAE;">联系电话:<s:property value="addr.cellphone"/></td>
                    <td align="left"><input class="inp" type="text" /></td>
                </tr>
                <tr height="35px">
                    <td align="left" style="font-size:14px; font-weight:600; color:#AEAEAE;">收件人:<s:property value="addr.name"/></td>
                    <td align="left"><input class="inp" type="text" /></td>
                </tr>
            </table>
        </div>
    </div>
    </center>
	  	
	</body>
</html>