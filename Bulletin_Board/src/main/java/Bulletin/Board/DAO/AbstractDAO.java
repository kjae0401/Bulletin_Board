package Bulletin.Board.DAO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class AbstractDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public Object selectOne(String queryId, Object params) {
		return sqlSessionTemplate.selectOne(queryId, params);
	}
}
