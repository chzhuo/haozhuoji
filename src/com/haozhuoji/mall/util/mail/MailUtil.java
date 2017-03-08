package com.haozhuoji.mall.util.mail;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.haozhuoji.mall.util.Constant;

public class MailUtil {
	private static void sendMail(String toAddress,String subject,String content){   
        //这个类主要是设置邮件   
     MailSenderInfo mailInfo = new MailSenderInfo();    
     mailInfo.setMailServerHost(Constant.emailHostServer);    
     mailInfo.setMailServerPort("25");    
     mailInfo.setValidate(true);    
     mailInfo.setUserName(Constant.emailUserName);    
     mailInfo.setPassword(Constant.emailPassword);//您的邮箱密码    
     mailInfo.setFromAddress(Constant.emailUserName);
     
     
     mailInfo.setToAddress(toAddress);    
     mailInfo.setSubject(subject);    
     mailInfo.setContent(content);    
        //这个类主要来发送邮件   
     SimpleMailSender sms = new SimpleMailSender();   
         //sms.sendTextMail(mailInfo);//发送文体格式    
         sms.sendHtmlMail(mailInfo);//发送html格式   
   }
	
	/*
	 * 发送找回Email的邮件！
	 */
	public static void sendGetPasswordMail(String toAddress,String link,String userName) throws UnsupportedEncodingException{
		link = URLEncoder.encode(link,"utf-8");
		StringBuffer sb = new StringBuffer();
		sb.append("<div style=\"background-color:#EEEEEE;width:480px;margin:0 auto;font:14px/18px '宋体';color:#333333\">");
		sb.append("<a href=\"http://www.haozhuoji.com\" style=\"display:block;background:url(http://file.haozhuoji.com/images/loginRegister/getPassword.png) no-repeat left center;height:100px;border-bottom:2px solid #eb3a3f\"></a>");
		sb.append("<div style=\"margin:30px\">");
		sb.append("亲爱的好捉急用户 <strong>"+userName+"：</strong>");
		sb.append("</div>");
		sb.append("<div style=\"margin:30px\">");
		sb.append("请点击以下链接完成重置密码（如无法打开请把此链接复制粘贴到浏览器打开）");
		sb.append("</div>");
		sb.append("<div style=\"margin:30px;word-break:break-all;word-wrap:break-word\">");
		sb.append("<a href=\"http://www.haozhuoji.com/getPassword.html?source="+link+"\" style=\"color:#3377ff\" target=\"_blank\">http://www.haozhuoji.com/getPassword.html?source="+link+"</a>");
		sb.append("</div>");
		sb.append("<div style=\"margin:30px\">");
		sb.append("好捉急邮件中心<br />");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		sb.append(format.format(new Date()));
		sb.append("</div>");
		sb.append("<div style=\"padding:30px;border-top:2px solid #DDDDDD;font:12px/18px '宋体';color:#666666\">");
		sb.append("① 此邮件为haozhuoji.com系统发出，请勿回复邮件<br/>");
		sb.append("② 好捉急校园便利店（<a href=\"http://www.haozhuoji.com\">www.haozhuoji.com</a>）是河南工业大学校园服务平台！<br/>");
		sb.append("③ 如果您有任何问题，可以随时与好捉急对话。TEL：15664059837 <br/>");
		sb.append("</div>");
		sb.append("</div>");
		sendMail(toAddress, "找回密码-好捉急校园便利店", sb.toString());
	}
}
