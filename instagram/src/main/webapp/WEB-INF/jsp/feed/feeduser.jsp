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
    <link rel="stylesheet" href="/css/egovframework/main/mainstyle.css">
    <link rel="stylesheet" href="/css/egovframework/main/mainplofile.css">
    
    <!-- 부트스트랩 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!--    구글 머터리얼 아이콘   -->
<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
      rel="stylesheet">
<link rel="stylesheet"
      href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    
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
	    	fn_imgView();
	    	
	    	var feedFlag = "${paramInfo.feedFlag}";
	    	if(feedFlag == 'U'){
	    		fn_detail("${paramInfo.feedIdx}");
	    	}
	    	
			$("#share-button").on("click", function() {
			fn_feedinsert();

		});
			
			
			// 사용자 아이콘 클릭 시 이벤트
			$(".user-icon").on("click", function() {
			let profilePopup = document.getElementById('profilePopup');
			let overlay = document.getElementById('overlay');

			// 팝업과 오버레이 표시
			profilePopup.style.display = 'block';
			overlay.style.display = 'block';
			});

			 // 오버레이 클릭 시 팝업과 오버레이 닫기
			$("#overlay").on("click", function() {
			let profilePopup = document.getElementById('profilePopup');
			let overlay = document.getElementById('overlay');

			// 팝업과 오버레이 숨기기
			profilePopup.style.display = 'none';
			overlay.style.display = 'none';
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
			
			$("#btn_update").on('click', function(){
				$("#feedFlag").val("U");
				fn_feedinsert();
			});
			
	
	 });
    
    
    
	    function fileDelete(fileNum){
			var no = fileNum.replace(/[^0-9]/g, "");
			content_files[no].is_delete = true;
			$("#"+fileNum).remove();
			fileCnt--;
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
			                popupClose(uploadPopup); // 팝업 닫기
			                fn_init();
			                fn_selectList();
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
					 console.log(data.list);
		               var boardHtml = '';
		               if (data.list.length > 0) {
		                   for (var i = 0; i < data.list.length; i++) {
		                      
		                       boardHtml += '<li class="post-item">';
		                       boardHtml += '<div class="profile">';
		                       boardHtml += '<div class="profile-img">';
		                       boardHtml += '<img src="/images/egovframework/assets/images/potato.jpeg" alt="프로필이미지">';
		                       boardHtml += '</div>';
		                       boardHtml += '<div class="profile-txt">';
		                       boardHtml += '<div class="username">' + data.list[i].createId + '</div>';
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
		                          boardHtml += '<img src="/main/feedImgView.do?saveFileName=' + data.list[i].fileList[j].saveFileName + '" class="d-block w-100 feed-picture" alt="...">';
		                          /* boardHtml += '<button class="option-btn" type="button" onclick="javascript:fn_moreOption(\''+data.list[i].feedIdx+'\');">';  */
		                          boardHtml += '</div>'; 
		                       } 
		                       
		                       boardHtml += '</div>'; // carousel-inner

		                       if (data.list[i].fileList.length > 1) {
		                           boardHtml += '<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControlsNoTouching_'+i+'" data-bs-slide="prev">';
		                           boardHtml += '<span class="carousel-control-prev-icon" aria-hidden="true"></span>';
		                           boardHtml += '<span class="visually-hidden">Previous</span>';
		                           boardHtml += '</button>';
		                           boardHtml += '<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControlsNoTouching_'+i+'" data-bs-slide="next">';
		                           boardHtml += '<span class="carousel-control-next-icon" aria-hidden="true"></span>';
		                           boardHtml += '<span class="visually-hidden">Next</span>';
		                           boardHtml += '</button>';
		                        }    
		                           boardHtml += '</div>'; // carousel
		                           
		                       boardHtml += '<div class="post-icons">';
		                       boardHtml += '<div>';
		                       
		                       if(data.list[i].likeYn == 'N') {
		                           boardHtml += '<span class="post-heart" onclick="javascript:fn_feedLike(\''+data.list[i].feedIdx+'\',\'I\');">';
		                           boardHtml += '<i class="fa-regular fa-heart" aria-hidden="true"></i>';
		                           boardHtml += '</span>';
		                       } else {
		                           boardHtml += '<span class="post-heart active" style="color: tomato;" onclick="javascript:fn_feedLike(\''+data.list[i].feedIdx+'\',\'U\');">';
		                           boardHtml += '<i class="fa-solid fa-heart" aria-hidden="true"></i>';
		                           boardHtml += '</span>';
		                       }
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
		                       for (var k = 0; k < data.list[i].commentList.length; k++) {
		                           boardHtml += '<div class="comment" id="comment_'+ data.list[i].commentList[k].commentIdx +'">';
		                           boardHtml += '<div class="comment-detail">';
		                           boardHtml += '<div class="username">' + data.list[i].commentList[k].createId + '</div>';
		                           boardHtml += '<p style="margin-bottom: 0;">' + data.list[i].commentList[k].commentContent + '</p>';
		                           boardHtml += '</div>';
		                           boardHtml += '<div style="display: flex; align-items: center;">';
		                         if (data.list[i].commentList[k].createId == "${loginInfo.userId}") {
		                             boardHtml += '<a href="javascript:fn_commentDelete(\''+data.list[i].commentList[k].commentIdx+'\');" class="comment-delete">';
		                             boardHtml += '삭제';
		                             boardHtml += '</a>';
		                         }
		                           boardHtml += '<div class="commnet-heart"><i class="fa-regular fa-heart"></i></div>';
		                           boardHtml += '</div>';
		                           boardHtml += '</div>';
		                       }
		                       boardHtml += '</div>'; // comment-list

		                       boardHtml += '<div class="timer">' + data.list[i].timeDiffer+' 전' + '</div>';

		                       boardHtml += '<div class="comment-input">';
		                       boardHtml += '<input type="text" placeholder="댓글달기..." id="commentContent_'+data.list[i].feedIdx+'" name="commentContent_'+data.list[i].feedIdx+'">';  // ID 추가
		                       boardHtml += '<button class="upload_btn" type="button" onclick="javascript:fn_comment('+data.list[i].feedIdx+');">게시</button>'; // 고유 ID 사용 
							   /* boardHtml += '<button class="upload_btn" id="btn_upload" name="btn_upload" type="button">게시</button>'; */
		                       boardHtml += '</div>'; // comment-input

		                       boardHtml += '</li>'; // post-item
		                   }
		               } else {
		                   boardHtml += '<li class="post-item" style="text-align:center;">등록된 글이 없습니다.</li>';
		               }
		               $("#post-list").html(boardHtml);//id값일경우 #, class일경우 .)
		           },
		           error: function(data, status, err) {
		               console.log(err);
		           }
		       });
		   }
		   
		   function fn_delete(feedIdx) {
			    if (confirm("정말로 이 게시물을 삭제하시겠습니까?")) {
			        // 서버에 삭제 요청을 보냅니다.
			        $.ajax({
			            url: '/feed/deleteFeed.do', // 삭제 API URL
			            method: 'POST',
			            data: { feedIdx: feedIdx },
			            success: function(response) {
			                if (response.resultChk > 0) {
			                    alert("게시물이 삭제되었습니다.");
			                    fn_selectList(); // 게시물 목록 새로 고침

			                    // 더보기 팝업 창 닫기
			                    fn_popupClose();
			                   
			                } else {
			                    alert("게시물 삭제에 실패했습니다.");
			                }
			            },
			            error: function(xhr, status, error) {
			                alert("삭제 요청 처리 중 오류가 발생했습니다.");
			                console.log(error);
			            }
			        });
			    }
			}
		   
		   // 더보기
		   function fn_moreOption(feedIdx){
		 //console.log(feedIdx);
	      $(".more-option").addClass("active");
	      var moreHtml = '';
	      
	      moreHtml += '<ul>';
	      moreHtml += '<li onclick="javascript:fn_delete(\''+feedIdx+'\');" class="red-txt">삭제</li>';
	      moreHtml += '<li onclick="javascript:fn_detail(\''+feedIdx+'\');">수정1</li>';
	      moreHtml += '<li>다른 사람에게 좋아요 수 숨기기</li>';
	      moreHtml += '<li>댓글 기능 해제</li>';
	      moreHtml += '<li>게시물로 이동</li>';
	      moreHtml += '<li>공유 대상...</li>';
	      moreHtml += '<li>링크 복사</li>';
	      moreHtml += '<li>퍼가기</li>';
	      moreHtml += '<li class="option-close-btn" onclick="fn_popupClose();">취소</li>';
	      moreHtml += '</ul>';
	   
	      // 다른사람이 로그인 하면 메뉴가 다르게 보이게 처리
	      
	      $("#moreOption").html(moreHtml);
	   }
	   
	   function fn_popupClose(){
	      $(".more-option").removeClass("active");
	      $(".upload-wrapper").removeClass("active"); // 팝업 닫기
	      $("#text_field").empty(); // 파일 목록 초기화 (필요시)
	   }
	   
	// 피드 상세보기
		// 피드 상세보기
		function fn_detail(feedIdx){
			//  팝업 닫기 변수 

				 
		    $("#feedFlag").val("U");
		    $("#feedIdx").val(feedIdx);
		  //var feedIdx3 = $("#feedIdx").val();
			var frm = new FormData($("#post_form")[0]);
			
		
			if ($("#feedFlag").val() === "U") {
			    $("#share-button").hide();
			    $("#btn_update").show();
			    $(".new_upload_tit").hide();
			    $(".update_upload_tit").show();
			} else {
			    $("#share-button").show();
			    $("#btn_update").hide();
			    $(".new_upload_tit").show(); //classList / new_upload_tit 
			    $(".update_upload_tit").hide(); // update_upload_tit
			}
			 
			  console.log(1);
			fn_popupClose();
		      $(".upload-wrapper").addClass("active");
		      $.ajax({
		         url : '/main/getFeedDetail.do',
		         method : 'post',
		         data : { "feedIdx" : feedIdx },
		         dataType : 'json',
		         success : function(data, status, xhr) {
		            $("#feedContent").val(data.feedInfo.feedContent);
		            $("#feedHashtag").val(data.feedInfo.feedHashtag);
		            var innerHtml = '';
		            var imgHtml = '';
		            let canvas = document.getElementById('img-canvas');
		            let ctx = canvas.getContext('2d');
		            let img = new Image();

		            img.onload = function() {
		               canvas.width = 500;
		               canvas.height = 400;
		               ctx.drawImage(img, 0, 0, 500, 400);
		            };
		            for (var i = 0; i < data.fileList.length; i++) {
		               img.src = "/main/feedImgView.do?saveFileName=" + data.fileList[i].saveFileName;
		               // 파일 삭제 버튼 소스 추가
		               innerHtml += '<div id="file' + i + '" >'
		                     + '<font style="font-size:12px">'
		                     + '<a href="javascript:fn_imgView(\''
		                     + data.fileList[i].saveFileName + '\', \'U\');">'
		                     + data.fileList[i].originalFileName + '</a></font>'
		                     + '<a href="javascript:fileDelete(\'file' + i
		                     + '\', \'' + data.fileList[i].fileIdx
		                     + '\');">X</a>' + '</div>';
		            }
		            $("#text_field").html(innerHtml);
		            console.log(feedIdx);
		           
		         },
		         error : function(data, status, err) {
		            console.log(err);
		         }
		      });
		   }

		   // 피드 초기화
		   function fn_init(){
		      // canvas
		       var cnvs = document.getElementById('img-canvas');
		       // context
		       var ctx = cnvs.getContext('2d');

		       // 픽셀 정리
		       ctx.clearRect(0, 0, cnvs.width, cnvs.height);
		       // 컨텍스트 리셋
		       ctx.beginPath();
		       
		       $("#feedFlag").val("I");
		       $("#share-button").show();
		       $("#btn_update").hide();
		       $(".new_upload_tit").show();
		       $(".update_upload_tit").hide();
		      
		       $("#file-upload-btn").val("");
		       $("#file-upload-btn").clear;
		       $("#feedContent").val("");
		       $("#feedHashtag").val("");
		       $("#boardFileList").html("");
		       content_files = new Array();
		       delete_files = new Array();
		       fileNum = 0;
		       fileCnt = 0;
		   }
		   
		// fn_imgView(맨하단 추가)
		   function fn_imgView(saveFileName, type){
		   		console.log(saveFileName, type);
		   		if(type == 'I'){
		   			var reader = new FileReader();
		   			var e = content_files[saveFileName];
		   			var canvas = document.getElementById('img-canvas');
		   			let ctx = canvas.getContext('2d');
		   		    reader.onload = function(e) {
		   		    	var img = new Image();
		   		    	
		   			    img.onload = function(){
		   			      canvas.width = 500;
		   			      canvas.height = 300;
		   			      ctx.drawImage(img,0,0,500,300);
		   			    };
		   			    img.src = e.target.result;
		   		    };
		   		    reader.readAsDataURL(e);
		   		}else{
		   			let canvas = document.getElementById('img-canvas');
		   			let ctx = canvas.getContext('2d');
		   			let img = new Image();
		   			
		   		    img.onload = function(){
		   		      canvas.width = 500;
		   		      canvas.height = 400;
		   		      ctx.drawImage(img,0,0,500,400);
		   		    };
		   		    img.src = "/main/feedImgView.do?saveFileName=" + saveFileName;	
		   		}
		   		
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
      <li class="user-icon"> <i class="fa-solid fa-user"></i></li>
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
    <ul class="post-list" id="post-list"></ul>
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
    
    <form id="fileFrm" name="fileFrm" method="POST">
               <input type="hidden" id="fileName" name="fileName" value=""/>
               <input type="hidden" id="filePath" name="filePath" value=""/>
            </form>
    
      <form  id="post_form" class="post_form" action="" >
      <input type="hidden" id="feedFlag" name="feedFlag"/>
      <input type="hidden" id="feedIdx" name="feedIdx"/>
        <p class="new_upload_tit">새 게시물 만들기</p>
        <p class="update_upload_tit" style="display:none;">게시물 수정하기</p>

        <div class="post-img-preview">
          <div class="plus_icon">
            <img src="/images/egovframework/assets/images/upload.png" alt="">
          </div>

          <p>포스트 이미지 추가</p>
          <canvas id="img-canvas"></canvas>
        </div>

        <div class="post-file">
          <input id="file-upload-btn" name="file-upload-btn" type="file"  class="text" required="required" multiple>
          <div id="text_field" name="text_field"></div>
        </div>

        <p class="post-txt">
          <textarea name="feedContent" id="feedContent" cols="50" rows="5" placeholder="문구를 입력하세요..." value="${feedInfo.feedContent}"></textarea>
           <p class="post-txt">
                  <textarea rows="1" cols="50" id="feedHashtag" name="feedHashtag" class="text" placeholder="#해시태그" value="${feedInfo.feedHashtag}"></textarea>
               </p>
        </p>

        <button class="btn-blue" id="share-button" name="share-button" type="button">공유하기</button>
         <button style="display:none;" id="btn_update" name="btn_update" class="submit_btn btn-blue" type="button">수정하기</button>
      </form>
    </div>
  </div>

  <div class="more-option" id="moreOption">
    
  </div>
  
  <!-- 오버레이 -->
    <div id="overlay" class="overlay" style="display:none;"></div>

    <!-- 팝업 영역 -->
    <div id="profilePopup" class="profile-popup" style="display:none;">
        <div class="popup-content">
            <div class="img-area">
                <div class="inner-area">
                    <img src="/images/egovframework/assets/images/user.jpeg">
                </div>
            </div>
            
            <div class="name">
            	${loginInfo.name}
            </div>
            
            <div class="social-share">
                <div class="row">
                    <span>게시물</span>
                </div>
                <div class="row">
                    <span>팔로워</span>
                </div>
                <div class="row">
                    <span>팔로우</span>
                </div>
            </div>
            
            <div class="buttons">
                <button>.</button>
                <button>로그아웃</button>
                <button>회원탈퇴</button>
            </div>
            
        </div>
    </div>
  
</div>


<script src="/js/script.js"></script>
<!-- Option 1: Bootstrap Bundle with Popper -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
</body>
</html>