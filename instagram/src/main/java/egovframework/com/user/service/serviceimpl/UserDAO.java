package egovframework.com.user.service.serviceimpl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("UserDAO")
public class UserDAO extends EgovAbstractMapper{

	public HashMap<String, Object> selectUserInfo(HashMap<String, Object> paramMap){
		return selectOne("selectUserInfo", paramMap);
	}

	public int insertUser(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return insert("insertUser", paramMap);
	}

	public HashMap<String, Object> selectLoginuserInfo(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return selectOne("selectLoginuserInfo", paramMap);
	}
	

}
