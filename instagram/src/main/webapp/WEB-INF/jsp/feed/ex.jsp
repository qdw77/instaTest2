<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Instagram.Main</title>
<!-- 부트스트랩 CSS -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
   crossorigin="anonymous">
   
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
   crossorigin="anonymous"></script>   
<!-- Option 2: Separate Popper and Bootstrap JS -->   
   
<script src="https://code.jquery.com/jquery-3.7.1.js"
   integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
   crossorigin="anonymous"></script>
<!-- Option 1: Bootstrap Bundle with Popper -->

   
<!--    구글 머터리얼 아이콘   -->
<link
   href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
   rel="stylesheet">
<link rel="stylesheet"
   href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<script src="https://kit.fontawesome.com/522c2b7a73.js"
   crossorigin="anonymous"></script>

<link rel="stylesheet" href="/css/egovframework/reset.css">
<link rel="stylesheet" href="/css/egovframework/color.css">
<link rel="stylesheet" href="/css/egovframework/mainstyle.css">

<script src="/js/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
   /* 파일 업로드 관련 변수 */
   var fileCnt = 0;
   var totalCnt = 20;
   var fileNum = 0;
   var content_files = new Array();
   var deleteFiles = new Array();
   /* 파일 업로드 관련 변수 */

   //   $(document).ready(function() {
   //      $("#img-canvas").on("click", function(){
   //         $("#file-upload-btn").click();
   //      });      
   //   });
$(document).ready(function() {
      fn_selectList(1);

   $("#btn_search").on('click', function() {
      fn_selectList(1);
   });
   /* 등록 버튼 */
   $("#btn_insert").on('click', function() {
      $("#statusFlag").val("I");
      fn_save();
   });
   /* 수정 버튼 */
   $("#btn_update").on('click', function(){
      $("#statusFlag").val("U");
      fn_save();
   });

   $("#postImg").on("click", function() {
      $("#uploadFile").click();
   });
   
   $(".post-upload-btn").on("click", function(){
      $(".upload-wrapper").addClass("active");
      fn_init();
   });

   /* 피드 등록 
      var flag = "${flag}";
      if (flag === "U") {
         fn_detail("${feedIdx}");
      }
   */
      /* 파일 업로드 */
      $("#uploadFile").on("change", function(e) {
         var files = e.target.files;
         // 파일 배열 담기
         var filesArr = Array.prototype.slice.call(files);
         //파일 개수 확인 및 제한
            if (fileCnt + filesArr.length > totalCnt) {alert("파일은 최대 " + totCnt + "개까지 업로드 할 수 있습니다.");
            return;
            } else {
               fileCnt = fileCnt + filesArr.length;
            }
            // 각각의 파일 배열 담기 및 기타
               filesArr.forEach(function(f) {
               var reader = new FileReader();
               reader.onload = function(e) {
                  content_files.push(f);
               $("#boardFileList").append('<div id="file'+fileNum+'" style="float:left;">'
                                    + '<font style="font-size:12px">'
                                    + '<a href="javascript:fn_imgView(\''
                                    + fileNum + '\', \'I\');">'
                                    + f.name + '</a></font>' + 
                                    '<a href="javascript:fileDelete(\'file'+ fileNum + '\',\'\')">X</a>' 
                                    + '</div>'
                                 );
                                 fileNum++;
                  };
                  reader.readAsDataURL(f);
               });
               //초기화한다.
               //$("#uploadFile").val("");
            });
         });
         
   /* 조회 */
   function fn_selectList() {
      var frm = $("#searchFrm").serialize();
      $.ajax({
         url : '/feed/selectAdminFeedList.do',
         method : 'post',
         data : frm,
         dataType : 'json',
         success : function(data, status, xhr) {
            var boardHtml = '';
            if (data.list.length > 0) {
            for (var i = 0; i < data.list.length; i++) {
                  boardHtml += '<li class="post-item">';
                  boardHtml += '<div class="profile">';
                  boardHtml += '<div class="profile-img">';
                  boardHtml += '<img src="/images/egovframework/cmmn/AppleMint House .jfif" alt="프로필이미지">';
                  boardHtml += '</div>';
                  boardHtml += '<div class="profile-txt">';
                  boardHtml += '<div class="username">' + data.list[i].userId + '</div>';
                  boardHtml += '<div class="location">Sejong, South Korea</div>';
                  boardHtml += '</div>';
                  boardHtml += '<button class="option-btn" type="button" onclick="javascript:fn_moreOption(\'' + data.list[i].feedIdx + '\');">';
                  boardHtml += '<i class="fa-solid fa-ellipsis" aria-hidden="true"></i>';
                  boardHtml += '</button>';
                  boardHtml += '</div>'; // profile

                  boardHtml += '<div id="carouselExampleControlsNoTouching_'+i+'" class="carousel slide" data-bs-touch="false" data-bs-interval="false" style="height: 600px;">';
                  boardHtml += '<div class="carousel-inner">';
                        // Assuming images are stored in an array
                  for (var j = 0; j < data.list[i].fileList.length; j++) {
                     boardHtml += '<div class="carousel-item' + (j === 0 ? ' active' : '') + '">';
                     boardHtml += '<img src="/feed/feedImgView.do?saveFileName='   + data.list[i].fileList[j].saveFileName + '" class="d-block w-100 feed-picture" alt="...">';
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
                  //하트아이콘
                  if(data.list[i].likeYn == 'N') {
                     boardHtml += '<span class="post-heart" onclick="javascript:fn_feedLike(\''+data.list[i].feedIdx+'\',\'I\');">';
                     boardHtml += '<i class="fa-regular fa-heart" aria-hidden="true"></i>';
                           boardHtml += '</span>';
                  }else {
                      boardHtml += '<span class="post-heart active" style="color: tomato;" onclick="javascript:fn_feedLike(\''+data.list[i].feedIdx+'\',\'U\');">';
                            boardHtml += '<i class="fa-solid fa-heart" aria-hidden="true"></i>';
                            boardHtml += '</span>';
                  }
                  boardHtml += '<span><i class="fa-regular fa-comment" aria-hidden="true"></i></span>';
                  boardHtml += '</div>'
                  boardHtml += '<span><i class="fa-regular fa-bookmark" aria-hidden="true"></i></span>';
                  boardHtml += '</div>'; //post-icons
                  //좋아요 시작
                  boardHtml += '<div class="post-likes">';
                  boardHtml += '좋아요 <span id="like-count">' + data.list[i].likeCount + '</span> 개';
                  boardHtml += '</div>'; // post-likes
                  //좋아요 끝
                  boardHtml += '<div class="post-content">';
                  boardHtml += '<p style="font-size:13px;padding:10px;" id="feed-count">' + data.list[i].feedContent + '</p>';
                  boardHtml += '</div>'; //post-content
                  
                  boardHtml += '<div class="post_hashtag">';
                  boardHtml += '<span style="font-size:12px; font-weight: lighter; color: dodgerblue; padding:10px;" id="feed_hashtag">' + data.list[i].feedHashtag + '</span>';
                  boardHtml += '</div>'; //post-hashtag
                        
                  boardHtml += '<div class="comment-list">';
                     for (var k = 0; k < data.list[i].commentList.length; k++) {
                     boardHtml += '<div class="comment" id="comment_'+ data.list[i].commentList[k].commentIdx +'">';
                     boardHtml += '<div class="comment-detail">';
                     boardHtml += '<div class="comment-username">'+ data.list[i].commentList[k].userId + '</div>'; //username
                     boardHtml += '<p style="margin: 0px 5px;">'+ data.list[i].commentList[k].commentContent + '</p>';
                     boardHtml += '</div>'; //detail
                     boardHtml += '<div style="display: flex; align-items: center;">';   
                     if (data.list[i].commentList[k].userId == "${loginInfo.Id}") {
                        boardHtml += '<a href="javascript:fn_commentDelete(\''+ data.list[i].commentList[k].commentIdx + '\');" class="comment-delete">';
                        boardHtml += '삭제';
                        boardHtml += '</a>';
                        }
                    //  boardHtml += '</div>'; // style                          
                     boardHtml += '<div class="commnet-heart"><i class="fa-regular fa-heart"></i></div>'; //heart
                     boardHtml += '</div>'; //detail
                     boardHtml += '</div>';//comment
                  }
                  boardHtml += '</div>'; // comment-list

                  boardHtml += '<div class="timer">'+ data.list[i].timeDiffer + '</div>';

                  boardHtml += '<div class="comment-input">';
                  boardHtml += '<input type="text" placeholder="댓글달기..." id="commentContent_'+data.list[i].feedIdx+'">'; // ID 추가
                  boardHtml += '<button class="upload_btn" type="button" onclick="javascript:fn_savecomment('+ data.list[i].feedIdx + ');">게시</button>'; // 고유 ID 사용 
                  boardHtml += '</div>'; // comment-input
                     
                  boardHtml += '</li>'; // post-item
                  }
               } else {
                  boardHtml += '<li class="post-item" style="text-align:center;">등록된 글이 없습니다.</li>';
               }
               $(".post-list").html(boardHtml);//id값일경우 #, class일경우 .)
            },
            error : function(data, status, err) {
                  console.log(err);
            }
         });   
      }
      
    // 피드 상세보기
   function fn_updateFeed(feedIdx) {
      //var uploadPopup = document.querySelector('.upload-wrapper');
      //uploadPopup.classList.add('active');
      //popupClose(uploadPopup); // 팝업 닫기
      $("#statusFlag").val("U");
      $("#feedIdx").val(feedIdx);
      //var feedIdx3 = $("#feedIdx").val();
      var formData = new FormData($("#saveFrm")[0]);
      /*  if ($("#statusFlag").val() === "U") {
             $("#btn_insert").hide();
             $("#btn_update").show();
             $(".new_upload_tit").hide();
             $(".update_upload_tit").show();
         } else {
             $("#btn_insert").show();
             $("#btn_update").hide();
             $(".new_upload_tit").show();
             $(".update_upload_tit").hide();
         } */

      fn_popupClose();
      $(".upload-wrapper").addClass("active");
      $.ajax({
         url : '/feed/getFeedDetail.do',
         method : 'post',
         data : {
            "feedIdx" : feedIdx
         },
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
               img.src = "/feed/feedImgView.do?fileName="
                     + data.fileList[i].saveFileName;
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
            $("#boardFileList").html(innerHtml);
            console.log(feedIdx);
         },
         error : function(data, status, err) {
            console.log(err);
         }
      });
   }

   function fn_save() {
      /* 팝업 닫기 변수 */
      var uploadPopup = document.querySelector('.upload-wrapper');
      function popupOpen(item) {
         item.classList.add('active');
      }
      function popupClose(item) {
         item.classList.remove('active');
      }
      var formData = new FormData($("#saveFrm")[0]);

      for (var x = 0; x < content_files.length; x++) {
         //삭제 안한 것만 담아준다.
         if (!content_files[x].is_delete) {
            formData.append("fileList", content_files[x]);
         }
      }
      if (deleteFiles.length > 0) {
         formData.append("deleteFiles", deleteFiles);
      }
      $.ajax({
         url : '/feed/saveFeed.do',
         method : 'post',
         data : formData,
         enctype : "multipart/form-data",
         processData : false,
         contentType : false,
         dataType : 'json',
         success : function(data, status, xhr) {
            if (data.resultChk > 0) {
               alert("저장되었습니다.");
               popupClose(uploadPopup); // 팝업 닫기
               fn_init();
               fn_selectList(1); // 리스트 업데이트
               content_files = new Array();
               delete_files = new Array()
            } else {
               alert("저장에 실패하였습니다.");
            }
         },
         error : function(data, status, err) {
            console.log(err);
         }
      });
   }
   //파일 목록
   function fn_filelist(feedIdx) {
      $.ajax({
      url : '/feed/getFileList.do',
      method : 'post',
      data : {
         "feedIdx" : feedIdx
      },
      dataType : 'json',
      success : function(data, status, xhr) {
         console.log(data.fileList);
      if (data.fileList.length > 0) {
         for (var i = 0; i < data.fileList.length; i++) {
         $("#boardFileList").append(         
          '<div id="file'+i+'" style="float:left;">' +'<font style="font-size:12px">' 
          +'<a href="javascript:fn_imgView(\''+ data.fileList[i].saveFileName+'\', \'U\');">'
             + data.fileList[i].originalFileName +'</a></font>'
             +'<a href="javascript:fileDelete(\'file'+i+'\',\''+data.fileList[i].fileIdx+'\');">X</a>'+'</div>'
             );
         }
         fileNum = data.fileList.length;
         }
      },
      error : function(data, status, err) {
         console.log(err);
      }
   });
   }
   // 파일삭제
   function fileDelete(fileNum, fileIdx) { 
      var no = fileNum.replace(/[^0-9]/g, ""); //공백제거 숫자로 바꿔주는 정규식, 숫자만

      if (fileIdx != "") {
         deleteFiles.push(fileIdx);
      } else {
         content_files[no].is_delete = true; // 파일삭제여부확인 
      }
      $("#" + fileNum).remove(); // j쿼리로 선택한 파일을 삭제
      fileCnt--; // 파일개수 줄여주는 (삭제된만큼)
   }
   //댓글 저장
   function fn_savecomment(feedIdx) {
      var commentContent = $("#commentContent_" + feedIdx).val();
      console.log(commentContent);
      $.ajax({
         url : '/feed/saveFeedComment.do',
         method : 'post',
         data : {
            "feedIdx" : feedIdx, //어떤데이터를 댓글 보고있는가
            "commentContent" : commentContent // 댓글의 내용, 입력값
         },
         dataType : 'json',
         success : function(data, status, xhr) {
            if (data.resultChk > 0) {
               alert("등록되었습니다.");
               fn_getReply(feedIdx); // 게시물 목록보여주기
               $("#commentContent").val(""); // 댓글 입력 필드 초기화
               fn_selectList(1);
            } else {
               alert("등록에 실패하였습니다.");
            }
         },
         error : function(data, status, err) {
            console.log(status);
         }
      });
   }

   function fn_getReply(feedIdx) {
      $.ajax({
               url : '/feed/getFeedComments.do', // 서버에 댓글 데이터를 요청하는 엔드포인트
               method : 'post',
               data : {
                  "feedIdx" : feedIdx
               },
               dataType : 'json',
               success : function(data, status, xhr) {
                  var commentHtml = '';

                  if (data.commentList && data.commentList.length > 0) {
                     // 서버로부터 받은 댓글 목록을 순회하며 HTML 구성
                     data.replyList
                           .forEach(function(comment) {
                              commentHtml += '<div class="comment-list">';
                              commentHtml += '<div class="comment" id="comment_'+ data.list[i].commentList[k].commentIdx +'">';
                              commentHtml += '<div class="comment-username">'
                                    + data.list[i].commentList[k].userId
                                    + '</div>';
                              commentHtml += '<div class="comment-content">'
                                    + data.list[i].commentList[k].commentContent
                                    + '</div>';
                              commentHtml += '<div class="comment-date">'
                                    + data.list[i].commentList[k].createDate
                                    + '</div>';
                              commentHtml += '</div>'; // comment-item
                           });
                     // 특정 피드 아이템에 댓글 목록을 업데이트
                     $('#feed_' + feedIdx + ' .comment-list').html(
                           commentHtml);
                  } else {// 댓글이 없을 경우 메시지 표시
                     $('#feed_' + feedIdx + ' .comment-list').html(
                           '<p>댓글이 없습니다.</p>');
                  }
               },
               error : function(data, status, err) {
                  console.log(err);
               }
            });
   }

   //더보기 메뉴 함수 생성
   function fn_moreOption(feedIdx) {
      $(".more-option").addClass("active");
      var moreHtml = '';

      moreHtml += '<ul>';
      moreHtml += '<li class="red-txt" onclick="javascript:fn_delete(\'' + feedIdx + '\');">삭제</li>';
      moreHtml += '<li onclick="javascript:fn_updateFeed(\'' + feedIdx + '\');">수정</li>';
      moreHtml += '<li>다른 사람에게 좋아요 수 숨기기</li>';
      moreHtml += '<li>댓글 기능 해제</li>';
      moreHtml += '<li>게시물로 이동</li>';
      moreHtml += '<li>공유 대상...</li>';
      moreHtml += '<li>링크 복사</li>';
      moreHtml += '<li>퍼가기</li>';
      moreHtml += '<li class="option-close-btn" onclick="javascript:fn_popupClose();">취소</li>';
      moreHtml += '</ul>';

      $("#moreOption").html(moreHtml);
   }

   function fn_popupClose() {
      $(".more-option").removeClass("active");
   }
   // 게시판(피드) 삭제
   function fn_delete(feedIdx) {
      $.ajax({
         url : '/feed/deleteFeedInfo.do',
         method : 'post',
         data : {
            "feedIdx" : feedIdx,
         },
         dataType : 'json',
         success : function(data, status, xhr) {
            if (data.resultChk > 0) {
               alert("삭제되었습니다.");
               fn_popupClose();
               fn_selectList(1);
            } else {
               alert("삭제에 실패하였습니다.");
            }
         },
         error : function(data, status, err) {
            console.log("삭제 요청 실패:", err);
         }
      });
   }
   
   // 좋아요 기능
   function fn_feedLike(feedIdx, type) {
        $.ajax({
        url: '/feed/feedLike.do',
        method: 'post',
        data : { 
          "feedIdx" : feedIdx,
          "likeType" : type //파라미터 type
          },
        dataType : 'json',
        success: function (data, status, xhr) {
          if(data.resultChk > 0){
             if(type == 'I'){
               alert("좋아요 성공");    
             }else if(type == 'U'){
               alert("좋아요 취소");
             }
                fn_selectList(1);
            }else{
               alert("좋아요 실패");
             }
         },
           error: function (data, status, err) {
             console.log(status);
        }
      });
   }

   // 댓글삭제
   function fn_commentDelete(commentIdx) {

      if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
         $.ajax({
            url : '/feed/commentDelete.do',
            method : 'post',
            data : {
               "commentIdx" : commentIdx,
            },
            dataType : 'json',
            success : function(data, status, xhr) {
               if (data.resultChk > 0) {
                  console.log(data);
                  alert("삭제되었습니다.");
                  $("#comment_" + commentIdx).remove(); // 해당 댓글 요소 삭제
                  fn_selectList(1);
               } else {
                  alert("삭제에 실패하였습니다.");
               }
            },
            error : function(data, status, err) {
               console.log("삭제 요청 실패:", err);
            }
         });
      }
   }
   // 피드 초기화 (맨하단 추가)

   function fn_init() {
      // canvas
      var cnvs = document.getElementById('img-canvas');
      // context
      var ctx = cnvs.getContext('2d');
      // 픽셀 정리
      ctx.clearRect(0, 0, cnvs.width, cnvs.height);
      // 컨텍스트 리셋
      ctx.beginPath();
       
       $("#statusFlag").val("I");
       /* $("#btn_insert").show();
       $("#btn_update").hide();
       $(".new_upload_tit").show();
       $(".update_upload_tit").hide(); */
      
       $("#uploadFile").val("");
       $("#uploadFile").clear;
       $("#feedContent").val("");
       $("#feedHashtag").val("");
       $("#boardFileList").html("");
       content_files = new Array();
       delete_files = new Array();
       fileNum = 0;
       fileCnt = 0;
   }
   $(".upload-wrapper").remove("active");

   // fn_imgView(맨하단 추가)
   function fn_imgView(fileName, type) {
      if (type == 'I') {
         var reader = new FileReader();
         var e = content_files[fileName];
         var canvas = document.getElementById('img-canvas');
         let ctx = canvas.getContext('2d');
         reader.onload = function(e) {
            var img = new Image();

            img.onload = function() {
               canvas.width = 500;
               canvas.height = 300;
               ctx.drawImage(img, 0, 0, 500, 300);
            };
            img.src = e.target.result;
         };
         reader.readAsDataURL(e);
      } else {
         let canvas = document.getElementById('img-canvas');
         let ctx = canvas.getContext('2d');
         let img = new Image();

         img.onload = function() {
            canvas.width = 500;
            canvas.height = 400;
            ctx.drawImage(img, 0, 0, 500, 400);
         };
         img.src = "/feed/feedImgView.do?saveFileName=" + fileName;
      }
   }
   
   
</script>
</head>


<body>
   <div class="wrapper">
      <header class="global-header">
         <div>
            <h1 class="logo">
               <a href="index.html"> <img
                  src="/images/egovframework/cmmn/logo-light.png" alt="logo">
               </a>
            </h1>
            <form id="searchFrm" name="searchFrm">
               <input type="hidden" id="pageIndex" name="pageIndex" value="1" />
               <ul class="gnb-icon-list">
                  <li class="post-upload-btn"><i
                     class="fa-regular fa-square-plus"></i></li>
                  <li><i class="fa-regular fa-compass"></i></li>
                  <li><i class="fa-regular fa-heart"></i></li>
                  <li><i class="fa-solid fa-magnifying-glass"></i> 
                     <input type="button" id="`" name="btn_search" value="" class="btn_blue_l" /></li>
                  <li><input type="text" id="searchKeyword" name="searchKeyword" style="border:1px solid #333;" class="txt" />
                        
                        <option value = "feedHashtag"></option>
                  </li>
               </ul>
            </form>
         </div>
      </header>

      <main>
         <ul class="post-list">
            <li class="post-item" style="text-align: center;">등록된 글이 없습니다.</li>
         </ul>
         <div class="recommend lg-only">
            <div class="side-user">
               <div class="profile-img side">
                  <a href=""> <img src="/images/egovframework/cmmn/potato.jpeg"
                     alt="프로필사진">
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
                        <img src="/images/egovframework/cmmn/멍2.jpeg" alt="프로필사진">
                     </div>
                     <div>
                        <div class="username">zzz_zzz</div>
                        <p>instagram 신규 가입</p>
                     </div>
                  </div>
                  <div class="thumb-user">
                     <div class="profile-img">
                        <img src="/images/egovframework/cmmn/멍3.jpeg" alt="프로필사진">
                     </div>

                     <div>
                        <div class="username">lorem</div>
                        <p>회원님을 위한 추천</p>
                     </div>
                  </div>
                  <div class="thumb-user">
                     <div class="profile-img">
                        <img src="/images/egovframework/cmmn/user.jpeg" alt="프로필사진">
                     </div>
                     <div>
                        <div class="username">cldieid</div>
                        <p>회원님을 위한 추천</p>
                     </div>
                  </div>
                  <div class="thumb-user">
                     <div class="profile-img">
                        <img src="/images/egovframework/cmmn/user.jpeg" alt="프로필사진">
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
            <!-- 피드 등록 시작 -->
            <form id="saveFrm" name="saveFrm" class="post_form" action="">
               <input type="hidden" id="statusFlag" name="statusFlag" value="I" />
               <input type="hidden" id="feedIdx" name="feedIdx" value="${feedIdx}"/>
               <p>새 게시물 만들기</p>
               <p class="update_upload_tit" style="display:none;">게시물 수정하기</p>

               <div class="post-img-preview">
                  <div class="plus_icon">
                     <img src="/images/egovframework/cmmn/upload.png" alt="">
                  </div>
                  <p>포스트 이미지 추가</p>
                  <canvas id="img-canvas"></canvas>
               </div>
               <div class="post-file">
                  <input type="file" class="text" id="uploadFile" name="uploadFile" multiple />
                  <div id="boardFileList" name="boardFileList"></div>
               </div>

               <p class="post-txt">
                  <textarea rows="5" cols="50" id="feedContent" name="feedContent" class="text" placeholder="문구를 입력하세요..."></textarea>
               </p>
               <p class="post-txt">
                  <textarea rows="1" cols="50" id="feedHashtag" name="feedHashtag" class="text" placeholder="#해시태그"></textarea>
               </p>


               <button id="btn_insert" name="btn_insert" class="submit_btn btn-blue" type="button">공유하기</button>
               <button style="display:none;" id="btn_update" name="btn_update" class="submit_btn btn-blue" type="button">수정하기</button>
            </form>
            <!-- 피드 등록 끝 -->
         </div>
      </div>
      <div class="more-option" id="moreOption"></div>
   </div>
   <script src="/js/main_script.js"></script>

   <!-- Option 1: Bootstrap Bundle with Popper -->
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
      crossorigin="anonymous"></script>
</body>
</html> --%>