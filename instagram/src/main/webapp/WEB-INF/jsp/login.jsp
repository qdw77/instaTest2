<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
     <link rel="apple-touch-icon" sizes="180x180" href="/images/egovframework/favicon/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="/images/egovframework/favicon/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="/images/egovframework/favicon/favicon-16x16.png">
  <meta name="msapplication-TileColor" content="#da532c">
  <meta name="theme-color" content="#ffffff">
    
    <title>Instagram</title>
      <link rel="stylesheet" href="/css/egovframework/reset.css">
  <link rel="stylesheet" href="/css/egovframework/color.css">
  <link rel="stylesheet" href="/css/egovframework/common.css">
  <link rel="stylesheet" href="/css/egovframework/style.css"/>  
    <script type="text/javascript">
	$(document).ready(function(){
		$("#submit").on('click', function(){
			fn_login();
		});
	});

	function fn_createAccount(){
		var frm = $("#frm");
		frm.attr("method", "POST");
		frm.attr("action", "/join.do");
		frm.submit();
	}
	
	function fn_login(){
		var frm = $("#frm").serialize();
		$.ajax({
		    url: '/user/loginuserAction.do',
		    method: 'post',
		    data : frm,
		    dataType : 'json',
		    success: function (data, status, xhr) {
		        if(data.resultChk){
		        	location.href="/feed/feeduser.do";
		        	console.log(frm);
		        }else{
		        	alert("로그인에 실패하였습니다.");
		        	return "redirect:/login.do";
		        }
		    },
		    error: function (data, status, err) {
		    	console.log(err);
		    }
		});
	}
	
	
	
</script>
  </head>
  <body>
	<form name="frm" id="frm">
		    <div class="wrapper">
		      <div class="form-container">
		        <div class="box login-box">
		          <h1 class="logo">
		            <img class="logo-light" src="/images/egovframework/assets/images/logo-light.png" alt="instagram light-logo" />
		             <img class="logo-dark" src="/images/egovframework/assets/images/logo-dark.png" alt="instagram dark-logo" />
		          </h1>
		       		
		            <div class="animate-input">
		              <input id="id"  name="id" type="text" >
		              <span>전화번호 사용자 이름 또는 이메일</span>
		            </div>
		
		            <div class="animate-input userpw">
		              <input id="pwd" name="pwd" type="password">
		              <span>비밀번호</span>
		              <button id="pw-visible" type="button">비밀번호 표시</button>
		            </div>
		
		            <button id="submit" class="btn-blue" type="button">로그인</button>
		
		
		          <div class="or-box">
		            <div></div>
		            <div>또는</div>
		            <div></div>
		          </div>
		
		          <div class="fb-btn">
		            
		              <img
		                src="/images/egovframework/assets/images/facebook-icon.png" alt="facebook-icon">
		              <span>facebook으로 로그인</span>
		           
		          </div>
		
		          <a class="forgot-pw" href="javascript:fn_findPwView();">비밀번호를 잊으셨나요?</a>
		        </div>
		
		        <div class="box join-box">
		          <p>
		            계정이 없으신가요?
		            <span><a href="javascript:fn_createAccount();">가입하기</a></span>
		          </p>
		        </div>
			<div class="app-download">
		        <p class="txtap-txt">앱을 다운로드하세요</p>
		
		        <div class="store-link">
		          <a href="">
		            <img src="/images/egovframework/assets/images/app-store.png" alt="app-store-img" />
		          </a>
		          <a href="">
		            <img src="/images/egovframework/assets/images/gg-play.png" alt="gg-play-img">
		          </a>
		        </div>
		      </div>
		      </div>
		
		
		      <footer>
		        <ul class="links">
		          <li><a href="">Meta</a></li>
		          <li><a href="">소개</a></li>
		          <li><a href="">블로그</a></li>
		          <li><a href="">채용 정보</a></li>
		          <li><a href="">도움말</a></li>
		          <li><a href="">API</a></li>
		          <li><a href="">개인정보처리방침</a></li>
		          <li><a href="">약관</a></li>
		          <li><a href="">인기 계정</a></li>
		          <li><a id="mode-toggle" href="">Darkmode</a></li>
		        </ul>
		
		
		
		        <p class="copyright">© 2024 Instagram from Meta</p>
		      </footer>
		    </div>
		</form>
    <script src="/js/scriptLogin.js"></script>
  </body>
</html>
