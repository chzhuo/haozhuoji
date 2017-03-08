package com.haozhuoji.mall.service;

import com.haozhuoji.mall.domain.Activity;

public interface ActivityService extends BaseService<Activity> {

	public boolean checkTypeID(Activity model);
}
