package com.haozhuoji.mall.service;

import java.io.IOException;

import com.haozhuoji.mall.domain.Activity;
import com.haozhuoji.mall.domain.Slider;

public interface SliderService extends BaseService<Slider> {
	public void changeImg(Slider s)  throws Exception ;

	public void delete(Slider s) throws Exception ;
}
