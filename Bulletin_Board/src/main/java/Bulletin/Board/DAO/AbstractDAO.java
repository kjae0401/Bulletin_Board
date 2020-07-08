package Bulletin.Board.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class AbstractDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public Object update(String queryId, Object params) {
		return sqlSessionTemplate.update(queryId, params);
	}
	
	// params 존재하지 않을 때
	public Object selectOne(String queryId) {
		return sqlSessionTemplate.selectOne(queryId);
	}
	// params 존재
	public Object selectOne(String queryId, Object params) {
		return sqlSessionTemplate.selectOne(queryId, params);
	}
	
	// SQL Query의 결과 값이 1개 이상일 때
	@SuppressWarnings("rawtypes")
	public List selectList(String queryId, Object params) {
		return sqlSessionTemplate.selectList(queryId, params);
	}
}
