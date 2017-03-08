package com.haozhuoji.mall.domain;

import java.io.File;

public class Slider {
	private Long sliderID;
	private String imgName;
	private String href;
	private Integer sequence;
	
	//
	private File upload;
	private String uploadFileName;
	
	public Integer getSequence() {
		return sequence;
	}
	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}
	public Long getSliderID() {
		return sliderID;
	}
	public void setSliderID(Long sliderID) {
		this.sliderID = sliderID;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public File getUpload() {
		return upload;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
}
