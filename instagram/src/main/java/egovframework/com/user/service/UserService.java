package egovframework.com.user.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface UserService {

	public int insertUser(HashMap<String, Object> paramMap);
	
	public HashMap<String, Object> selectUserInfo(HashMap<String, Object> paramMap);

	public HashMap<String, Object> selectLoginuserInfo(HashMap<String, Object> paramMap);

	public int selectUserCertification(HashMap<String, Object> paramMap);

	public int saveFeed(HashMap<String, Object> paramMap, List<MultipartFile> multipartFile);
}
