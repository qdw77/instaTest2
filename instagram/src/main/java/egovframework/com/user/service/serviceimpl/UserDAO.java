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


	public HashMap<String, Object> selectLoginuserInfo(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return selectOne("selectLoginuserInfo", paramMap);
	}


	public int selectUserCertification(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return selectOne("selectUserCertification", paramMap);
	}

	public int getFileIdx(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return selectOne("getFileIdx", paramMap);
	}

	public int updateFeed(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return update("updateFeed", paramMap);
	}



	public int deleteFeedFileInfo(HashMap<String, Object> paramMap) {
		return update("deleteFeedFileInfo", paramMap);
		// TODO Auto-generated method stub
		
	}

	public int insertFileFeedAttr(HashMap<String, Object> paramMap) {
		return insert("insertFileFeedAttr",paramMap);
		// TODO Auto-generated method stub
		
	}

	public int getFileMaxIdx() {
		// TODO Auto-generated method stub
		return selectOne("getFileMaxIdx");
	}

	public int insertFeed(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return insert("insertFeed", paramMap);
	}


	public int insertUser(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return insert("insertUser", paramMap);
	}




	public int selectUserFeedListCnt(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return selectOne("selectUserFeedListCnt", paramMap);
	}


	public List<HashMap<String, Object>> selectFeedList(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return selectList("selectFeedList", paramMap);
	}


	public List<HashMap<String, Object>> selectUserFeedList(int feedIdx) {
		// TODO Auto-generated method stub
		return selectList("selectUserFeedList", feedIdx);
	}


	public List<HashMap<String, Object>> selectUserList(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return selectList("selectUserList", paramMap);
	}


	public List<HashMap<String, Object>> selectFileList(int feedIdx) {
		// TODO Auto-generated method stub
		return selectList("selectFileList",feedIdx);
	}


	public List<HashMap<String, Object>> selectFeedComment(int feedIdx) {
		// TODO Auto-generated method stub
		return selectList("selectFeedComment",feedIdx);
	}


	public HashMap<String, Object> selectFeedDetail(int feedIdx) {
		// TODO Auto-generated method stub
		return selectOne("selectFeedDetail", feedIdx);
	}
	

}
