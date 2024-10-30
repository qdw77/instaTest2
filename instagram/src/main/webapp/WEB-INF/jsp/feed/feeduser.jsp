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
    /* 파일 업로드 관련 변수 */
    var fileCnt = 0;
    var totalCnt = 20;
    var fileNum = 0;
    var content_files = new Array(); /* 실제 업로드 파일 */
    var deleteFeedFiles = new Array(); /* 삭제 업로드 파일 */
    /* 파일 업로드 관련 변수 */
    
	    $(document).ready(function(){
	    	
	    	fn_selectList();
	    	
	    	var feedFlag = "${paramInfo.feedFlag}";
	    	if(feedFlag == 'U'){
	    		fn_detail("${paramInfo.feedIdx}");
	    	}
	    	
			$("#share-button").on("click", function() {
			fn_feedinsert();
		});
			
			
			
			$("#file-upload-btn").on("change", function(e){
				var files = e.target.files;
				// 파일 배열 담기
				var filesArr = Array.prototype.slice.call(files);
				//파일 개수 확인 및 제한
				if(fileCnt + filesArr.length > totalCnt){
					alert("파일은 최대 "+totCnt+"개까지 업로드 할 수 있습니다.");
					return;
				}else{
					fileCnt = fileCnt+ filesArr.length;
				}
				
				// 각각의 파일 배열 담기 및 기타
				filesArr.forEach(function (f){
					var reader = new FileReader();
					reader.onload = function (e){
						content_files.push(f);
						$("#text_field").append(
									'<div id="file'+fileNum+'" style="float:left; width:100%; padding-left:100px;">'
									+'<font style="font-size:12px">' + f.name + '</font>'
									+'<a href="javascript:fileDelete(\'file'+fileNum+'\')"> X </a>'
									+'</div>'
						);
						fileNum++;
					};
					reader.readAsDataURL(f);
				});
				//초기화한다.
				$("#file-upload-btn").val("");
			});
			
	 });
    
    
    
	    function fileDelete(fileNum){
			var no = fileNum.replace(/[^0-9]/g, "");
			content_files[no].is_delete = true;
			$("#"+fileNum).remove();
			fileCnt--;
		}    
	    function fn_extFileDelete(fileNum){
	    	deleteFeedFiles.push(fileNum);
			$("#extFile_"+fileNum).remove();
		}
		
    
		   function fn_feedinsert() {
			   var frm = new FormData($("#post_form")[0]);
			   
			   for(var x=0; x<content_files.length; x++){
					//삭제 안한 것만 담아준다.
					if(!content_files[x].is_delete){
						frm.append("fileList", content_files[x]); 
					}
				}
			   frm.append("deleteFeed", deleteFeedFiles);
			   $.ajax({
			        url: '/feed/saveFeed.do',
			        method: 'post', 
			        data: frm, 
			        enctype: "multipart/form-data", 
			        processData: false, 
			        contentType: false, 
			        dataType: 'json', 
			        success: function(data, status, xhr) {
			            if (data.resultChk > 0) { 
			                alert("저장되었습니다."); 
			                location.href = "/feed/feeduser.do";
			            } else {
			                alert("저장에 실패하였습니다.");
			            }
			        },
			        error: function(data, status, err) {
			            console.log(err);
			        }
			    });
			}
		   
		   /* 조회 */
		   function fn_selectList() {
		       var frm = $("#searchFrm").serialize();
		       $.ajax({
		           url: '/feed/selectAdminFeedList.do',
		           method: 'post',
		           data: frm,
		           dataType: 'json',
		           success: function(data, status, xhr) {
					// console.log(data.list);
		               var boardHtml = '';
		               if (data.list.length > 0) {
		                   for (var i = 0; i < data.list.length; i++) {
		                      
		                       boardHtml += '<li class="post-item">';
		                       boardHtml += '<div class="profile">';
		                       boardHtml += '<div class="profile-img">';
		                       boardHtml += '<img src="" alt="프로필이미지">';
		                       boardHtml += '</div>';
		                       boardHtml += '<div class="profile-txt">';
		                       boardHtml += '<div class="username">' + data.list[i].userId + '</div>';
		                       boardHtml += '<div class="location">Sejong, South Korea</div>';
		                       boardHtml += '</div>';
		                       boardHtml += '<button class="option-btn" type="button" onclick="javascript:fn_moreOption(\''+data.list[i].feedIdx+'\');">';
		                       boardHtml += '<i class="fa-solid fa-ellipsis" aria-hidden="true"></i>';
		                       boardHtml += '</button>';
		                       boardHtml += '</div>'; // profile

		                       boardHtml += '<div id="carouselExampleControlsNoTouching_'+i+'" class="carousel slide" data-bs-touch="false" data-bs-interval="false" style="height: 600px;">';
		                       boardHtml += '<div class="carousel-inner">';
		                       // Assuming images are stored in an array
		                       for (var j = 0; j < data.list[i].fileList.length; j++) {
		                          boardHtml += '<div class="carousel-item' + (j === 0 ? ' active' : '') + '">';
		                          boardHtml += '<img src="/feed/feedImgView.do?saveFileName=' + data.list[i].fileList[j].saveFileName + '" class="d-block w-100 feed-picture" alt="...">';
		                          boardHtml += '</div>'; 
		                       } 
		                       
		                       boardHtml += '</div>'; // carousel-inner

		                       boardHtml += '<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControlsNoTouching_'+i+'" data-bs-slide="prev">';
		                       boardHtml += '<span class="carousel-control-prev-icon" aria-hidden="true"></span>';
		                       boardHtml += '<span class="visually-hidden">Previous</span>';
		                       boardHtml += '</button>';
		                       boardHtml += '<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControlsNoTouching_'+i+'" data-bs-slide="next">';
		                       boardHtml += '<span class="carousel-control-next-icon" aria-hidden="true"></span>';
		                       boardHtml += '<span class="visually-hidden">Next</span>';
		                       boardHtml += '</button>';
		                       boardHtml += '</div>'; // carousel

		                       boardHtml += '<div class="post-icons">';
		                       boardHtml += '<div>';
		                       boardHtml += '<span class="post-heart"><i class="fa-regular fa-heart" aria-hidden="true"></i></span>';
		                       boardHtml += '<span><i class="fa-regular fa-comment" aria-hidden="true"></i></span>';
		                       boardHtml += '</div>';
		                       boardHtml += '<span><i class="fa-regular fa-bookmark" aria-hidden="true"></i></span>';
		                       boardHtml += '</div>'; // post-icons

		                       boardHtml += '<div class="post-likes">';
		                       boardHtml += '좋아요 <span id="like-count">' + data.list[i].likeCount + '</span> 개';
		                       boardHtml += '</div>'; // post-likes

		                       boardHtml += '<div class="post-content">';
		                       boardHtml += '<p style="font-size:13px;padding:10px;" id="feed-count">' + data.list[i].feedContent + '</p>';
		                       boardHtml += '</div>';

		                       boardHtml += '<div class="post_hashtag">';
		                       boardHtml += '<span style="font-size:12px; font-weight: lighter; color: dodgerblue; padding:10px;" id="feed_hashtag">' + data.list[i].feedHashtag + '</span>';
		                       boardHtml += '</div>';

		                       boardHtml += '<div class="comment-list">';

		                       boardHtml += '</div>'; // comment-list

		                       boardHtml += '<div class="timer">' + data.list[i].timeDiffer+' 전' + '</div>';

		                       boardHtml += '<div class="comment-input">';
		                       boardHtml += '<input type="text" placeholder="댓글달기..." id="commentContent_'+data.list[i].feedIdx+'">';  // ID 추가
		                       boardHtml += '<button class="upload_btn" type="button" onclick="javascript:fn_comment('+data.list[i].feedIdx+');">게시</button>'; // 고유 ID 사용 
//		                     boardHtml += '<button class="upload_btn" id="btn_upload" name="btn_upload" type="button">게시</button>';
		                       boardHtml += '</div>'; // comment-input

		                       boardHtml += '</li>'; // post-item
		                   }
		               } else {
		                   boardHtml += '<li class="post-item" style="text-align:center;">등록된 글이 없습니다.</li>';
		               }
		               $(".post-list").html(boardHtml);//id값일경우 #, class일경우 .)
		           },
		           error: function(data, status, err) {
		               console.log(err);
		           }
		       });
		   }
		   
		 
    
    
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
          <form id="searchFeedFrm" name="searchFeedFrm">
           <input type="text" id="searchKeyword" name="searchKeyword" class="search-input" placeholder="검색어를 입력하세요" />
          </form>
        </li>
      </ul>
    </div>
  </header>

  <main>
  <form id="searchFrm" name="searchFrm">
  <input type="hidden" id="" name="" value="1">
    <ul class="post-list" id="post-list">
     	
    </ul>
  </form>
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
      <form  id="post_form" class="post_form" action="" >
      <input type="hidden" id="feedFlag" name="feedFlag" value="I"/>
      <input type="hidden" id="feedIdx" name="feedIdx"/>
        <p>새 게시물 만들기</p>

        <div class="post-img-preview">
          <div class="plus_icon">
            <img src="/images/egovframework/assets/images/upload.png" alt="">
          </div>

          <p>포스트 이미지 추가</p>
          <canvas id="img-canvas"></canvas>
        </div>

        <div class="post-file">
          <input id="file-upload-btn" name="file-upload-btn" type="file"  required="required" multiple>
        </div>

        <p class="post-txt">
          <textarea name="feedContent" id="feedContent" cols="50" rows="5" placeholder="문구를 입력하세요..."></textarea>
        </p>

        <button class="btn-blue" id="share-button" name="share-button" type="button">공유하기</button>
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