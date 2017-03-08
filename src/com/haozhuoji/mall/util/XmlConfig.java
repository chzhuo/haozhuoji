package com.haozhuoji.mall.util;

import java.io.FileOutputStream;
import java.io.OutputStream;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class XmlConfig {
	public static String get(String name) throws Exception {
		Document document = getDocument();
		Element root = document.getRootElement();
		Element element = (Element) root.selectSingleNode("//item[@name='"+name+"']");
		if(element!=null){
			return element.attribute("value").getValue();
		}else{
			return null;
		}
	}
	public static void set(String name,String value) throws Exception{
		Document document = getDocument();
		Element root = document.getRootElement();
		Element element = (Element) root.selectSingleNode("//item[@name='"+name+"']");
		if(element==null){
			element = root.addElement("item");
			element.addAttribute("name",name);
		}
		element.addAttribute("value",value);
		write(document);
	}
	private static Document getDocument() throws DocumentException{
		SAXReader saxReader = new SAXReader(); 
		return saxReader.read(Constant.xmlPath);
	}
	private static void write(Document document) throws Exception{
		OutputFormat format = OutputFormat.createPrettyPrint();
		OutputStream os = new FileOutputStream(Constant.xmlPath);
		XMLWriter xmlWriter = new XMLWriter(os,format);
		xmlWriter.write(document);
		xmlWriter.close();
	}
}
