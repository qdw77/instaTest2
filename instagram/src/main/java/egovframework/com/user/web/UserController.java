package egovframework.com.user.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import egovframework.com.user.service.UserService;
import egovframework.com.util.SHA256;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class UserController {
	@Resource(name="UserService")
	private UserService userService;
	
	SHA256 sha256 = new SHA256();
	
	/*
	 * @RequestMapping("/User.do") public String main(HttpSession session, Model
	 * model){ HashMap<String, Object> }
	 */

	@RequestMapping("/feed/feeduser.do")
	public String feed(HttpSession session, Model model) {
		HashMap<String, Object> loginInfo = null;
		loginInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
		if(loginInfo != null) {
			model.addAttribute("loginInfo", loginInfo);
			return "feed/feeduser";
		}else {
			return "redirect:/login.do";
		}
	}
	
	@RequestMapping("/login.do")
	public String login() {
		return "login";
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("loginInfo", null);
		session.removeAttribute("loginInfo");
		return "redirect:/";
	}
	
	@RequestMapping("/join.do")
	public String join() {
		return "join";
	}
	
	@RequestMapping("/insta/insertUser.do")
	public ModelAndView insertUser(@RequestParam HashMap<String, Object> paramMap) throws Exception{
		ModelAndView mv = new ModelAndView();
		/*
		 * if (paramMap.get("userId") == null || paramMap.get("userPw") == null ||
		 * paramMap.get("email") == null || paramMap.get("userName") == null) {
		 * mv.addObject("resultChk", -1); // 실패 코드 mv.setViewName("jsonView"); return
		 * mv; }
		 */
		System.out.println(1);
		String pwd = paramMap.get("userPw").toString();
		paramMap.replace("userPw", sha256.encrypt(pwd));
		String userEmail = paramMap.get("email").toString();
		paramMap.put("userEmail", userEmail);
		
		int resultChk = 0;
		resultChk = userService.insertUser(paramMap);
		
		mv.addObject("resultChk", resultChk);
		mv.setViewName("jsonView");
		return mv;
		
	}
	
	@RequestMapping("/user/loginuserAction.do")
	public ModelAndView loginuserAction(HttpSession session, @RequestParam HashMap<String, Object> paramMap) {
	ModelAndView mv = new ModelAndView();
	String pwd = paramMap.get("pwd").toString();
	// 암호화된 패스워드
	String encryptPwd = null;
	try {
		encryptPwd = sha256.encrypt(pwd).toString();
		paramMap.replace("pwd", encryptPwd);
	} catch (NoSuchAlgorithmException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	HashMap<String, Object> loginInfo = null;
	loginInfo = userService.selectLoginuserInfo(paramMap);
	if(loginInfo != null) {
		session.setAttribute("loginInfo", loginInfo);
		mv.addObject("resultChk", true);
	}else {
		mv.addObject("resultChk", false);
	}
	
	mv.setViewName("jsonView");
	
	return mv;
	}
	
	@RequestMapping("/Usercertification.do")
	public ModelAndView Usercertification(@RequestParam HashMap<String, Object> paramMap) {
		ModelAndView mv = new ModelAndView();
		
		int userIdx = 0;
		
		userIdx = userService.selectUserCertification(paramMap);
		System.out.println(userIdx);
		
		mv.addObject("userIdx", userIdx);
		mv.setViewName("jsonView");
		return mv;
	}
	

	
	@RequestMapping("/feed/saveFeed.do")
	public ModelAndView saveFeed(@RequestParam HashMap<String, Object> paramMap, @RequestParam(name="fileList") List<MultipartFile> multipartFile, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		int resultChk = 0;
		
		HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
		paramMap.put("userId", sessionInfo.get("id").toString());
		
		resultChk = userService.saveFeed(paramMap, multipartFile);
		mv.addObject("resultChk", resultChk);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	// 게시물 리스트
	@RequestMapping("/feed/selectAdminFeedList.do")
	public ModelAndView selectAdminFeedList(@RequestParam HashMap<String, Object> paramMap, HttpSession session) {
	      ModelAndView mv = new ModelAndView();
	      
	      HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
      paramMap.put("userId", sessionInfo.get("id").toString());

		List<HashMap<String, Object>> list = userService.selectUserList(paramMap);
		
		
		mv.addObject("list", list);
		
		mv.setViewName("jsonView");
		return mv;
	}
	

	// 피드 수정(상세)
		@RequestMapping("/main/getFeedDetail.do")
		public ModelAndView getFeedDetail(@RequestParam(name = "feedIdx") int feedIdx) {
			ModelAndView mv = new ModelAndView();
			HashMap<String, Object> feedInfo = userService.selectFeedDetail(feedIdx);
			List<HashMap<String, Object>> fileList = userService.selectFileList(feedIdx);
			mv.addObject("fileList", fileList);
			mv.addObject("feedInfo", feedInfo);
			mv.setViewName("jsonView");
			return mv;
		}
		
		
		@RequestMapping("/feed/deleteFeed.do")
		public ModelAndView deleteFeed(@RequestParam HashMap<String, Object> paramMap, HttpSession session) {
		    ModelAndView mv = new ModelAndView();
		    int resultChk = 0;

		    // 세션에서 로그인 정보 가져오기
		    HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
		    if (sessionInfo != null) {
		        // sessionInfo에서 userId 가져와 paramMap에 추가
		        paramMap.put("userId", sessionInfo.get("id").toString());

		        // 서비스에서 피드 삭제 수행
		        resultChk = userService.deleteFeed(paramMap);
		    }

		    // 결과를 JSON 형태로 반환
		    mv.addObject("resultChk", resultChk);
		    mv.setViewName("jsonView");
		    return mv;
		}
		
		@RequestMapping("/main/feedImgView.do")
		public void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String path = "/instagram/insta/";
			String saveFileName = request.getParameter("saveFileName").toString();

			File imageFile = new File(path, saveFileName);

			if (imageFile.exists()) {
				response.setContentType("image/jpeg");
				FileInputStream in = new FileInputStream(imageFile);
				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = in.read(buffer)) != -1) {
					response.getOutputStream().write(buffer, 0, bytesRead);
				}
				in.close();
			} else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		}
		
		
	


	
}
