package com.haozhuoji.mall.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Slider;
import com.haozhuoji.mall.service.SliderService;
import com.haozhuoji.mall.util.Constant;

@Service("sliderService")
public class SliderServiceImpl extends BaseServiceImpl<Slider> implements SliderService{
	
	@Override
	public void changeImg(Slider slider) throws Exception {
		
		//保存图片
		String fileName =System.currentTimeMillis()+"."+ slider.getUploadFileName().split("\\.")[slider.getUploadFileName().split("\\.").length-1];
		slider.setImgName(fileName);
		File f =new File(Constant.localSlider_p+"/"+fileName);
		if(f.exists()){
			f.delete();
		}
		OutputStream os = new FileOutputStream(f);
		InputStream is = new FileInputStream(slider.getUpload());
		int len = 0;
		byte[] bf = new byte[1024];
		while((len=is.read(bf))>0){
			os.write(bf, 0, len);
		}
		is.close();
		os.close();
		
		Slider s = this.getObject("Slider.getObject", slider);
		
		//保存图片名
		this.insert("Slider.update",slider);
		//删除原有图片
		if(s.getImgName()!=null&&!s.getImgName().trim().equals("")){
			File file = new File(Constant.localSlider_p+"/"+s.getImgName());
			if(file.isFile()&&file.exists()){
				file.delete();
			}
		}
		
	}

	@Override
	public void delete(Slider slider) throws Exception {
		Slider s = this.getObject("Slider.getObject", slider);
		
		//删除幻灯片
		this.insert("Slider.delete",slider);
		
		//删除原有图片
		if(s.getImgName()!=null&&!s.getImgName().trim().equals("")){
			File file = new File(Constant.localSlider_p+"/"+s.getImgName());
			if(file.isFile()&&file.exists()){
				file.delete();
			}
		}
		
	}
}
