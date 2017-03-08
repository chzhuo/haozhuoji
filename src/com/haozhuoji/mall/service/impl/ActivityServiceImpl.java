package com.haozhuoji.mall.service.impl;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.domain.Activity;
import com.haozhuoji.mall.service.ActivityService;

@Service("activityService")
public class ActivityServiceImpl extends BaseServiceImpl<Activity> implements ActivityService{

	@Override
	public boolean checkTypeID(Activity model) {
		if(this.getInt("Activity.checkTypeID", model)>0){
			return false;
		}
		return true;
	}
}
