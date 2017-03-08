package com.haozhuoji.mall.util;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.Random;

import javax.imageio.ImageIO;

import org.apache.struts2.ServletActionContext;
import org.junit.Test;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImageUtils {   
  
    /**  
     * 压缩图片文件<br>  
     * 先保存原文件，再压缩、上传  
     *   
     * @param file  
     *            要进行压缩的文件全路径  
     * @param width  
     *            宽度  
     * @param height  
     *            高度  
     * @param quality  
     *            质量  
     * @param fileName  
     *            压缩后图片存储路径  和名称
     * @return 返回压缩后的文件的全路径  
     */  
	private void zipImageFile(File file, int width, int height,   
            float quality, String fileName) {   
        if (file == null) {   
            return;   
        }   
        try {   
            /** 对服务器上的临时文件进行处理 */
            Image srcFile = ImageIO.read(file);
            if(srcFile.getHeight(null)>srcFile.getWidth(null)){
            	width =(int) Math.round(width*1.0*srcFile.getWidth(null)/srcFile.getHeight(null));
            }else if(srcFile.getHeight(null)<srcFile.getWidth(null)){
            	height =(int) Math.round(height*1.0*srcFile.getHeight(null)/srcFile.getWidth(null));            	
            }
            
            /** 宽,高设定 */  
            BufferedImage tag = new BufferedImage(width, height,   
                    BufferedImage.TYPE_INT_RGB);   
            tag.getGraphics().drawImage(srcFile, 0, 0, width, height, null); 
            /** 压缩之后临时存放位置 */  
            OutputStream out = new FileOutputStream(fileName);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);   
            JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tag);
            
            /** 压缩质量 */  
            jep.setQuality(quality, true);   
            encoder.encode(tag, jep);   
            out.close();   
  
        } catch (FileNotFoundException e) {   
            e.printStackTrace();   
        } catch (IOException e) {   
            e.printStackTrace();   
        }   
    } 
	/**
	 * 得到随机文件名
	 * @return
	 */
	private String getRandomFileName(){
		Random random = new Random();
		DecimalFormat format = new DecimalFormat("00000000");
		return format.format(random.nextInt(99999999));
	}
	/**
	 * 保存商品主图，并压缩成几种规格
	 * @param file 
	 * @param savePath 保存路径
	 * @return
	 */
	public String zipGoodsMain(File file,String savePath){
		File direct =new File(savePath);
		if(!direct.exists()){
			direct.mkdirs();
		}
		this.zipImageFile(file, 450, 450, 1, savePath+"/main_450x450.jpg");
		this.zipImageFile(file, 200, 200, 1, savePath+"/main_200x200.jpg");
		this.zipImageFile(file, 100, 100, 1, savePath+"/main_100x100.jpg");
		this.zipImageFile(file, 60, 60, 1, savePath+"/main_60x60.jpg");
		this.zipImageFile(file, 50, 50, 1, savePath+"/main_50x50.jpg");
		return  "main_450x450.jpg";
	}
	
	/**
	 * 压缩商品图片幻灯片
	 * @param file
	 * @param savePath 保存路径
	 * @return
	 */
	public String zipGoodsSliderImg(File file,String savePath,String fileName){
		File direct =new File(savePath);
		if(!direct.exists()){
			direct.mkdirs();
		}
		if(fileName!=null&&fileName.matches("\\d+")){
			fileName = String.format("%08d", Integer.parseInt(fileName));
		}else{
			fileName = this.getRandomFileName();						
		}
		this.zipImageFile(file, 450, 450, 1, savePath+"/"+fileName+"_450x450.jpg");
		this.zipImageFile(file, 60, 60, 1, savePath+"/"+fileName+"_60x60.jpg");
		return fileName+"_450x450.jpg";
	}
	
	/**
	 * 保存图片
	 * @param file 图片文件
	 * @param savePath 图片保存路径
	 * @param suffix 图片后缀
	 * @return 图片名
	 * @throws IOException
	 */
	public String saveImg(File file,String savePath,String suffix) throws IOException{
		File direct =new File(savePath);
		if(!direct.exists()){
			direct.mkdirs();
		}
		String fileName = this.getRandomFileName()+"."+suffix;
		File upload = new File(savePath+"/"+fileName);
		OutputStream os = new FileOutputStream(upload);
		InputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024];
		
		int length = 0;
		
		while((length=in.read(buffer))>0){
			os.write(buffer, 0, length);
		}
		os.close();
		in.close();
		return  fileName;
	}
}
