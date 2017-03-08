package com.haozhuoji.mall.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.haozhuoji.mall.dao.BaseDao;
import com.haozhuoji.mall.domain.GoodsType;
import com.haozhuoji.mall.service.BaseService;

@Service("baseService")
public class BaseServiceImpl<T> implements BaseService<T>{
	
	@Resource(name="baseDao")
	public BaseDao<T> dao;
	@Override
	public void insert(String sqlMapId, T t){
		dao.insert(sqlMapId, t);
	}

	@Override
	public void update(String sqlMapId,T t){
		dao.update(sqlMapId, t);
		
	}

	@Override
	public void delete(String sqlMapId,T t){
		dao.delete(sqlMapId,t);
	}
	
	@Override
	public T getObject(String sqlMapId,T t) {
		return dao.getObject(sqlMapId, t);
	}

	@Override
	public List<T> getListHashMap(String sqlMapID,HashMap<String, Object> hashMap){
		return dao.getListHashMap(sqlMapID,hashMap);
	}

	@Override
	public List<T> getList(String sqlMapID,T t){
		return dao.getList(sqlMapID,t);
	}

	@Override
	public Integer getInt(String sqlMapId,T t){
		return dao.getInt(sqlMapId, t);
	}

	@Override
	public Integer getIntHashMap(String sqlMapId,HashMap<String, Object> hashMap){
		return dao.getIntHashMap(sqlMapId, hashMap);
	}
}
