package egovframework.com.user.web;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import egovframework.com.user.service.UserService;
import egovframework.com.util.SHA256;

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
	public ModelAndView saveFeed(@RequestParam HashMap<String, Object> paramMap, @RequestParam(name="FeedList") List<MultipartFile> multipartFile, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		int resultChk = 0;
		
		HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
		paramMap.put("userId", sessionInfo.get("id").toString());
		
		resultChk = userService.saveFeed(paramMap, multipartFile);
		mv.addObject("resultChk", resultChk);
		mv.setViewName("jsonView");
		
		return mv;
	}
	


	
}
