<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>Instagram</title>
    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="/images/egovframework/assets/images/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/images/egovframework/assets/images/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/images/egovframework/assets/images/favicon-16x16.png">
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/522c2b7a73.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/egovframework/reset.css">
    <link rel="stylesheet" href="/css/egovframework/color.css">
    <link rel="stylesheet" href="/css/egovframework/style.css">
    
    <script type="text/javascript">
    $(document).ready(function(){
    	
    	fn_selectfeed(1);
    	
    	$("#btn_search").on('click', function(){
    		fn_selectfeed(1);
    	});
    	
		$("#btn-blue").on('click', function(){
			fn_insertfeed();
		})    	
    	
    });
    
    /* 파일선택 태그ID : inputFile
		포스트 이미지 추가: postImg
			<input type="file" id="inputFile" style="display:none;"/>
			
			$(document).redy(funcion(){
				$("#postImg").on("click",founcion(){
					$("inputFile").click();
				});
		}); */
    function fn_insertfeed(){
			$("#flag").val("I");
			var frm = $("#boardFrm");
			frm.attr("action", "/feed/registFeed.do");
			frm.submit();
		}
    
    
    
    </script>
</head>
<body>
<div class="wrapper">
<from id="feedFrm" name="feedFrm" method="post">
  <header class="global-header">
    <div>
      <h1 class="logo">
        <a href="index.html">
          <img src="/images/egovframework/assets/images/logo-light.png" alt="logo">
        </a>
      </h1>
      <ul class="gnb-icon-list">
        <li class="post-upload-btn">
          <i class="fa-regular fa-square-plus"></i>
        </li>
        <li>
          <i class="fa-regular fa-compass"></i>
        </li>
        <li>
          <i class="fa-regular fa-heart"></i>
        </li>
        <li>
          <i class="fa-solid fa-magnifying-glass"></i>
        </li>
      </ul>
    </div>
  </header>

  <main>
    <ul class="post-list">
      <li class="post-item">
        <div class="profile">
          <div class="profile-img">
            <img src="/images/egovframework/assets/images/potato.jpeg" alt="프로필이미지">
          </div>

          <div class="profile-txt">
            <div class="username">yejin</div>
            <div class="location">Sejong, South Korea</div>
          </div>

          <button class="option-btn" type="button">
            <i class="fa-solid fa-ellipsis"></i>
          </button>
        </div>

        <div class="post-img">
          <img src="/images/egovframework/assets/images/멍.jpeg"post-img-01">
        </div>

        <div class="post-icons">
          <div>
            <span class="post-heart">
              <i class="fa-regular fa-heart"></i>
            </span>
             <span>
              <i class="fa-regular fa-comment"></i>
            </span>
          </div>

          <span>
            <i class="fa-regular fa-bookmark"></i>
          </span>
        </div>

        <div class="post-likes">
            좋아요
            <span id="like-count">2,346</span>
            개
        </div>

        <div class="comment-list">
          <div class="comment">
            <div class="comment-detail">
              <div class="username">dog123</div>
              <p>멍멍</p>
            </div>
            <div class="commnet-heart">
              <i class="fa-regular fa-heart"></i>
            </div>
          </div>

          <div class="comment">
            <div class="comment-detail">
              <div class="username">idididid</div>
              <p>오랑롸올아로아ㅗ알</p>
            </div>
            <div class="commnet-heart">
              <i class="fa-regular fa-heart"></i>
            </div>
          </div>
        </div>

        <div class="timer">2시간 전</div>

        <div class="comment-input">
          <input type="text" placeholder="댓글달기...">
          <button class="upload_btn" type="button">게시</button>
        </div>
      </li>

      <li class="post-item">
        <div class="profile">
          <div class="profile-img">
            <img src="/images/egovframework/assets/멍1.jpeg" alt="프로필이미지">
          </div>

          <div class="profile-txt">
            <div class="username">lalala</div>
            <div class="location">Daejeon</div>
          </div>

          <button class="option-btn" type="button">
            <i class="fa-solid fa-ellipsis"></i>
          </button>
        </div>

        <div class="post-img">
          <img src="/images/egovframework/assets/멍1.jpeg" alt="post-img-01">
        </div>

        <div class="post-icons">
          <div>
            <span class="post-heart">
              <i class="fa-regular fa-heart"></i>
            </span>
             <span>
              <i class="fa-regular fa-comment"></i>
            </span>
          </div>

          <span>
            <i class="fa-regular fa-bookmark"></i>
          </span>
        </div>

        <div class="post-likes">
            좋아요
            <span id="like-count">16</span>
            개
        </div>

        <div class="comment-list">
          <div class="comment">
            <div class="comment-detail">
              <div class="username">idididid</div>
              <p>오랑롸올아로아ㅗ알</p>
            </div>
            <div class="commnet-heart">
              <i class="fa-regular fa-heart"></i>
            </div>
          </div>
        </div>

        <div class="timer">1시간 전</div>

        <div class="comment-input">
          <input type="text" placeholder="댓글달기...">
          <button class="upload_btn" type="button">게시</button>
        </div>
      </li>
    </ul>

    <div class="recommend lg-only">
      <div class="side-user">
        <div class="profile-img side">
          <a href="">
            <img src="/images/egovframework/assets/images/potato.jpeg" alt="프로필사진">
          </a>
        </div>

        <div>
          <div class="username">yejin</div>
          <div class="ko-name">이예진</div>
        </div>
      </div>

      <div class="recommend-list">
        <div class="reco-header">
          <p>회원님을 위한 추천</p>
          <button class="all-btn" type="button">모두 보기</button>
        </div>

        <div class="thumb-user-list">
          <div class="thumb-user">
            <div class="profile-img">
              <img src="/images/egovframework/assets/images/멍2.jpeg" alt="프로필사진">
            </div>
            <div>
              <div class="username">zzz_zzz</div>
              <p>instagram 신규 가입</p>
            </div>
          </div>

          <div class="thumb-user">
            <div class="profile-img">
              <img src="/images/egovframework/assets/images/멍3.jpeg" alt="프로필사진">
            </div>

            <div>
              <div class="username">lorem</div>
              <p>회원님을 위한 추천</p>
            </div>
          </div>

          <div class="thumb-user">
            <div class="profile-img">
              <img src="/images/egovframework/assets/images/user.jpeg" alt="프로필사진">
            </div>

            <div>
              <div class="username">cldieid</div>
              <p>회원님을 위한 추천</p>
            </div>
          </div>

          <div class="thumb-user">
            <div class="profile-img">
              <img src="/images/egovframework/assets/images/user.jpeg" alt="프로필사진">
            </div>

            <div>
              <div class="username">abcdefg</div>
              <p>회원님을 위한 추천</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>

  <div class="upload-wrapper">
    <button class="post-close-btn" type="button">
      <i class="fa-solid fa-xmark"></i>
    </button>

    <div class="post-upload">
      <form class="post_form" action="" >
        <p>새 게시물 만들기</p>

        <div class="post-img-preview">
          <div class="plus_icon">
            <img src="/images/egovframework/assets/images/upload.png" alt="">
          </div>

          <p>포스트 이미지 추가</p>
          <canvas id="img-canvas"></canvas>
        </div>

        <div class="post-file">
          <input id="file-upload-btn" type="file"  required="required">
        </div>

        <p class="post-txt">
          <textarea name="content" id="text_field" cols="50" rows="5" placeholder="문구를 입력하세요..."></textarea>
        </p>

        <button class="submit_btn btn-blue" type="button">공유하기</button>
      </form>
    </div>
  </div>

  <div class="more-option">
    <ul>
      <li class="red-txt">삭제</li>
      <li>수정</li>
      <li>다른 사람에게 좋아요 수 숨기기</li>
      <li>댓글 기능 해제</li>
      <li>게시물로 이동</li>
      <li>공유 대상...</li>
      <li>링크 복사</li>
      <li>퍼가기</li>
      <li class="option-close-btn">취소</li>
    </ul>
  </div>
  </from>
</div>

<script src="./script.js"></script>
</body>
</html>