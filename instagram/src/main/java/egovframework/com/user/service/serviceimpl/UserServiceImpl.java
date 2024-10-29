package egovframework.com.user.service.serviceimpl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

	@Override
	public int selectUserCertification(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userDAO.selectUserCertification(paramMap);
	}

	@Override
	public int saveFeed(HashMap<String, Object> paramMap, List<MultipartFile> multipartFile) {
		// TODO Auto-generated method stub
		int resultChk = 0;
		
		String flag = paramMap.get("feedFlag").toString();
		int feedIdx = 0;
		if("I".equals(flag)) {
			resultChk = userDAO.insertFeed(paramMap);
			feedIdx = userDAO.getFileMaxIdx();
		}else if("U".equals(flag)) {
			resultChk = userDAO.updateFeed(paramMap);
			feedIdx = userDAO.getFileIdx(paramMap);
		}
		paramMap.put("feedIdx", feedIdx);
		int chk = 0;
		String filePath = "/instagram/insta/";
		String deleteFeedFiles = (String)paramMap.get("deleteFiles");
		if(deleteFeedFiles.length() >0) { userDAO.deleteFeedFileInfo(paramMap);
		}
		if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
			int index = 0;
			for(MultipartFile file : multipartFile) {
				HashMap<String, Object> uploadFile = new HashMap<String, Object>();
				SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHms");
				Calendar cal = Calendar.getInstance();
				String today = date.format(cal.getTime());
				try {
					File fileFolder = new File(filePath);
					if(!fileFolder.exists()) {
						if(fileFolder.mkdirs()) {
							System.out.println("[file.mkdirs] : Success");
						}
					}
					String fileExt = FilenameUtils.getExtension(file.getOriginalFilename());
					double fileSize = file.getSize();
					File saveFile = new File(filePath, "file_"+today+"_"+index+"."+fileExt);
					uploadFile.put("feedIdx", feedIdx);
					uploadFile.put("originalFileName", file.getOriginalFilename());
					uploadFile.put("saveFileName", "file_"+today+"_"+index+"."+fileExt); 
					uploadFile.put("saveFilePath", filePath);
					uploadFile.put("fileSize", fileSize);
					uploadFile.put("fileExt", fileExt);
					uploadFile.put("userId", paramMap.get("userId"));
					userDAO.insertFileFeedAttr(uploadFile);
					
					file.transferTo(saveFile);
					index++;
				}catch(Exception e) {
					e.printStackTrace();
					return 0;
				}
			}
		}
		
		return resultChk;
	}
	
	

}
