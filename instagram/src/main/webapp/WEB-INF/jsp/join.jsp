<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가입하기 • Instagram</title>
    <!-- Favicon -->
  <link rel="apple-touch-icon" sizes="180x180" href="/images/egovframework/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/images/egovframework/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/images/egovframework/favicon/favicon-16x16.png">
   <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/522c2b7a73.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/egovframework/reset.css">
    <link rel="stylesheet" href="/css/egovframework/join/style.css">
    <link rel="stylesheet" href="/css/egovframework/color.css">
    <link rel="stylesheet" href="/css/egovframework/common.css">
    <script type="text/javascript">
	 $(document).ready(function(){
            $("#join-btn").on('click', function(){
                fn_join();
            }); 
        });

        function fn_join() {
            // 유효성 검사
            var email = $("#email").val();
            var name = $("#userName").val();
            var userId = $("#userId").val();
            var pwd = $("#userPw").val();
            if (email == "") {
                alert("이메일을 입력하세요.");
                return;
            }else if (name == "") {
                alert("성명을 입력하세요.");
                return;
            }else if (userId == "") {
                alert("사용자 이름을 입력하세요.");
                return;
            }else if (pwd == "") {
                alert("비밀번호를 입력하세요.");
                return;
                
            }else{ // AJAX로 가입 요청
	            var frm = $("#frm").serialize();
            	console.log(frm);
	            $.ajax({
	                url: '/insta/insertUser.do', 
	                method: 'POST',
	                data: frm,
	                dataType: 'json',
	                success: function(data, status, xhr) {
	                	 console.log(data);
	                    if (data.resultChk > 0) {
	                        alert("가입이 완료되었습니다.");
	                        location.href="/login.do";
	                    } else {
	                        alert("가입에 실패했습니다: ");
	                        return;
	                    }
	                },
	                error: function(data, status, err) {
	                	console.error("AJAX 오류:", err);
	                	
	                    alert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
	                }
	            });
     	   }
  	   }
        
    </script>
</head>
<body>
<form name="frm" id="frm">
  <div class="wrapper">

        <div class="form-container">
            <div class="box input-box">
                <h1 class="logo">
                    <img src="/images/egovframework/assets/images/logo-light.png" alt="Instagram Logo" class="logo-light">
                </h1>
                <p class="join-para">친구들의 사진과 동영상을 보려면 가입하세요.</p>

                <button class="btn-blue fb-btn">
                    <i class="fa-brands fa-square-facebook"></i>
                    <span>Facebook으로 로그인</span>
                </button>

                <div class="or-box">
                    <div></div>
                    <div>또는</div>
                    <div></div>
                </div>
                <div class="animate-input">
                     <label for="email">이메일 주소</label>
                  	<input class="email" id="email" name="email" type="text" required>
                </div>

				<div class="animate-input">
					<label for="userName">성명</label>
					<input id="userName" name="userName" type="text" required>
				</div>

				<div class="animate-input">
                    <label for="userId">사용자 이름</label>
                    <input id="userId" name="userId" type="text" required>
                </div>
                
                <div class="animate-input">
                    <label for="userPw">비밀번호</label>
                    <input id="userPw" name="userPw" type="password" required>
                    <button id="pw-btn" type="button">비밀번호 표시</button>
                </div>

                    <p class="more-info">
                        저희 서비스를 이용하는 사람이 회원님의 연락처 정보를 Instagram에 업로드했을 수도 있습니다. 
                        <a href="">더 알아보기</a>
                    </p>
                    
             		<button id="join-btn" type="button" class="btn-blue">가입</button>
            </div>

            <div class="box join-box">
                <p>
                    계정이 있으신가요?
                    <a href="/login.do">로그인</a>
                </p>
            </div>

            <div class="app-download">
                <p>앱을 다운로드하세요.</p>
                <div class="store-link">
                    <a href="">
                        <img src="/images/egovframework/assets/images/app-store.png" alt="App Store">
                    </a>
                    <a href="">
                        <img src="/images/egovframework/assets/images/gg-play.png" alt="Google Play">
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
                <li><a href="">위치</a></li>
                <li><a href="">Instagram Lite</a></li>
                <li><a href="" id="mode-toggle">Darkmode</a></li>
            </ul>
            <p class="copyright">© 2024 Instagram from Meta</p>
        </footer>
    </div>
 </form>
    <script src="/js/scriptJoin.js"></script>

</body>
</html>