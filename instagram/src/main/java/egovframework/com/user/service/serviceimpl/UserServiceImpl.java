package egovframework.com.user.service.serviceimpl;

import java.util.HashMap;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("UserService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService{
	@Resource(name="UserDAO")
	private UserDAO userDAO;
	
	@Override
	public int insertUser(java.util.HashMap<String, Object> paramMap) {
		return userDAO.insertUser(paramMap);
	}

	@Override
	public HashMap<String, Object> selectUserInfo(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userDAO.selectUserInfo(paramMap);
	}

	@Override
	public HashMap<String, Object> selectLoginuserInfo(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userDAO.selectLoginuserInfo(paramMap);
	}
	
	

}
