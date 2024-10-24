package egovframework.com.user.service;

import java.util.HashMap;

public interface UserService {

	public int insertUser(HashMap<String, Object> paramMap);
	
	public HashMap<String, Object> selectUserInfo(HashMap<String, Object> paramMap);

	public HashMap<String, Object> selectLoginuserInfo(HashMap<String, Object> paramMap);
}
