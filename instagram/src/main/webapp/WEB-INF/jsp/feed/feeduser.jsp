<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
    <title>Instagram</title>
    <!-- Favicon -->
 <link rel="apple-touch-icon" sizes="180x180" href="/images/egovframework/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/images/egovframework/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/images/egovframework/favicon/favicon-16x16.png">
 <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/522c2b7a73.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/egovframework/reset.css">
    <link rel="stylesheet" href="/css/egovframework/color.css">
    <link rel="stylesheet" href="/css/egovframework/main/style.css">
    
    <script type="text/javascript">
    $(document).ready(function(){
    /* 	
    	fn_selectfeed(1);
    	
    	$("#btn_search").on('click', function(){
    		fn_selectfeed(1);
    	});
    	
		$("#btn-blue").on('click', function(){
			fn_insertfeed();
		})    	 */
    	
    });
    
    /* 파일선택 태그ID : inputFile
		포스트 이미지 추가: postImg
			<input type="file" id="inputFile" style="display:none;"/>
			
				$(document).ready(funcion(){
				$("#postImg").on("click",founcion(){
					$("inputFile").click();
				});
		}); */
		
/*     function fn_insertfeed(){
			$("#flag").val("I");
			var frm = $("#frm");
			frm.attr("action", "/feed/registFeed.do");
			frm.submit();
		} */
    
    
		
/* 		// fn_selectList() 반복문 안에 더보기 메뉴 버튼 수정
		postsHtml += '<button class="option-btn" type="button" onclick="javascript:fn_moreOption(\''+data.list[i].feedIdx+'\');">';

		// 더보기 메뉴 함수 생성
		function fn_moreOption(feedIdx){
		      $(".more-option").addClass("active");
		      var moreHtml = '';
		      
		      moreHtml += '<ul>';
		      moreHtml += '<li class="red-txt">삭제</li>';
		      moreHtml += '<li onclick="javascript:fn_updateFeed(feedIdx);">수정</li>';
		      moreHtml += '<li>다른 사람에게 좋아요 수 숨기기</li>';
		      moreHtml += '<li>댓글 기능 해제</li>';
		      moreHtml += '<li>게시물로 이동</li>';
		      moreHtml += '<li>공유 대상...</li>';
		      moreHtml += '<li>링크 복사</li>';
		      moreHtml += '<li>퍼가기</li>';
		      moreHtml += '<li class="option-close-btn" onclick="popupClose();">취소</li>';
		      moreHtml += '</ul>';
		   
		      $("#moreOption").html(moreHtml);
		   }
		   
		   function popupClose(){
		      $(".more-option").removeClass("active");
		   } */
    
    </script>
</head>
<body>
<div class="wrapper">
  <header class="global-header">
    <div>
      <h1 class="logo">
        <a href="/feed/feeduser.do">
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
          <img src="/images/egovframework/assets/images/멍.jpeg" alt="post-img-01">
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
              <div class="userId">dog123</div>
              <p>멍멍</p>
            </div>
            <div class="commnet-heart">
              <i class="fa-regular fa-heart"></i>
            </div>
          </div>

          <div class="comment">
            <div class="comment-detail">
              <div class="userId">idididid</div>
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
            <img src="/images/egovframework/assets/images/멍1.jpeg" alt="프로필이미지">
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
          <img src="/images/egovframework/assets/images/멍1.jpeg" alt="post-img-01">
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
              <div class="userId">idididid</div>
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
          <div class="userId">yejin</div>
          <div class="userName">이예진</div>
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
              <div class="userId">zzz_zzz</div>
              <p>instagram 신규 가입</p>
            </div>
          </div>

          <div class="thumb-user">
            <div class="profile-img">
              <img src="/images/egovframework/assets/images/멍3.jpeg" alt="프로필사진">
            </div>

            <div>
              <div class="userId">lorem</div>
              <p>회원님을 위한 추천</p>
            </div>
          </div>

          <div class="thumb-user">
            <div class="profile-img">
              <img src="/images/egovframework/assets/images/user.jpeg" alt="프로필사진">
            </div>

            <div>
              <div class="userId">cldieid</div>
              <p>회원님을 위한 추천</p>
            </div>
          </div>

          <div class="thumb-user">
            <div class="profile-img">
              <img src="/images/egovframework/assets/images/user.jpeg" alt="프로필사진">
            </div>

            <div>
              <div class="userId">abcdefg</div>
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

        <button class="submit_btn btn-blue" type="submit">공유하기</button>
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
</div>


<script src="/js/script.js"></script>
</body>
</html>