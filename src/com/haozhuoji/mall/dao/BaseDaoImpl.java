package com.haozhuoji.mall.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class BaseDaoImpl<T> extends SqlSessionDaoSupport implements BaseDao<T>{
	
	@Override
	public void insert(String sqlMapId,T t){
		this.getSqlSession().insert(sqlMapId, t);
	}

	@Override
	public void update(String sqlMapId,T t){
		this.getSqlSession().update(sqlMapId, t);
		
	}

	@Override
	public void delete(String sqlMapId,T t){
		this.getSqlSession().delete(sqlMapId,t);
	}
	
	@Override
	public T getObject(String sqlMapId,T t) {
		return this.getSqlSession().selectOne(sqlMapId, t);
	}

	@Override
	public List<T> getListHashMap(String sqlMapID,HashMap<String, Object> hashMap){
		return this.getSqlSession().selectList(sqlMapID,hashMap);
	}

	@Override
	public List<T> getList(String sqlMapID,T t){
		return this.getSqlSession().selectList(sqlMapID,t);
	}

	@Override
	public Integer getInt(String sqlMapId,T t){
		return this.getSqlSession().selectOne(sqlMapId, t);
	}

	@Override
	public Integer getIntHashMap(String sqlMapId,HashMap<String, Object> hashMap){
		return this.getSqlSession().selectOne(sqlMapId, hashMap);
	}
}
