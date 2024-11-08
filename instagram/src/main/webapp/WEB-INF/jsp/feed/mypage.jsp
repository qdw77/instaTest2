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
        
        // 마이페이지 피드 목록 조회
        fn_selectMyFeedList();
        
        // 피드 업로드 버튼 클릭 시
        $("#share-button").on("click", function() {
            fn_feedinsert();
        });
        
        // 사용자 아이콘 클릭 시 프로필 팝업 열기
        $(".user-icon").on("click", function() {
            let profilePopup = document.getElementById('profilePopup');
            let overlay = document.getElementById('overlay');
            profilePopup.style.display = 'block';
            overlay.style.display = 'block';
        });

        // 오버레이 클릭 시 팝업 닫기
        $("#overlay").on("click", function() {
            let profilePopup = document.getElementById('profilePopup');
            let overlay = document.getElementById('overlay');
            profilePopup.style.display = 'none';
            overlay.style.display = 'none';
        });

        // 파일 업로드 처리
        $("#file-upload-btn").on("change", function(e){
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);

            if (fileCnt + filesArr.length > totalCnt) {
                alert("파일은 최대 " + totalCnt + "개까지 업로드 할 수 있습니다.");
                return;
            } else {
                fileCnt = fileCnt + filesArr.length;
            }

            // 각각의 파일 배열 담기 및 기타 처리
            filesArr.forEach(function (f){
                var reader = new FileReader();
                reader.onload = function (e){
                    content_files.push(f);
                    $("#text_field").append(
                        '<div id="file' + fileNum + '" style="float:left; width:100%; padding-left:100px;">' +
                        '<font style="font-size:12px">' + f.name + '</font>' +
                        '<a href="javascript:fileDelete(\'file' + fileNum + '\')"> X </a>' +
                        '</div>'
                    );
                    fileNum++;
                };
                reader.readAsDataURL(f);
            });

            // 초기화
            $("#file-upload-btn").val("");
        });

        // 피드 수정 버튼 클릭 시
        $("#btn_update").on('click', function(){
            $("#feedFlag").val("U");
            fn_feedinsert();
        });
    });

    // 파일 삭제 처리
    function fileDelete(fileNum) {
        var no = fileNum.replace(/[^0-9]/g, "");
        content_files[no].is_delete = true;
        $("#" + fileNum).remove();
        fileCnt--;
    }

    // 피드 삽입 또는 수정 처리
    function fn_feedinsert() {
        var frm = new FormData($("#post_form")[0]);

        for (var x = 0; x < content_files.length; x++) {
            // 삭제되지 않은 파일만 담기
            if (!content_files[x].is_delete) {
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
                    fn_init();
                    fn_selectMyFeedList(); // 마이페이지 피드 목록 갱신
                } else {
                    alert("저장에 실패하였습니다.");
                }
            },
            error: function(data, status, err) {
                console.log(err);
            }
        });
    }

    // 마이페이지 피드 목록 조회
    function fn_selectMyFeedList() {
        var frm = $("#searchFrm").serialize();
        $.ajax({
            url: '/feed/selectMyFeedList.do', // 내 피드 목록 조회 API
            method: 'post',
            data: frm,
            dataType: 'json',
            success: function(data, status, xhr) {
                var boardHtml = '';
                if (data.list.length > 0) {
                    for (var i = 0; i < data.list.length; i++) {
                        // 각 게시물에 대해 프로필, 이미지, 좋아요, 댓글 등을 출력
                        boardHtml += '<li class="post-item">';
                        boardHtml += '<div class="profile">';
                        boardHtml += '<div class="profile-img">';
                        boardHtml += '<img src="/images/egovframework/assets/images/potato.jpeg" alt="프로필이미지">';
                        boardHtml += '</div>';
                        boardHtml += '<div class="profile-txt">';
                        boardHtml += '<div class="username">' + data.list[i].createId + '</div>';
                        boardHtml += '</div>';
                        boardHtml += '</div>'; // profile

                        // 게시물 내용과 이미지 표시
                        boardHtml += '<div id="carouselExampleControlsNoTouching_' + i + '" class="carousel slide" data-bs-touch="false" data-bs-interval="false" style="height: 600px;">';
                        boardHtml += '<div class="carousel-inner">';
                        for (var j = 0; j < data.list[i].fileList.length; j++) {
                            boardHtml += '<div class="carousel-item' + (j === 0 ? ' active' : '') + '">';
                            boardHtml += '<img src="/main/feedImgView.do?saveFileName=' + data.list[i].fileList[j].saveFileName + '" class="d-block w-100 feed-picture" alt="...">';
                            boardHtml += '</div>';
                        }
                        boardHtml += '</div>'; // carousel-inner

                        if (data.list[i].fileList.length > 1) {
                            boardHtml += '<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControlsNoTouching_' + i + '" data-bs-slide="prev">';
                            boardHtml += '<span class="carousel-control-prev-icon" aria-hidden="true"></span>';
                            boardHtml += '<span class="visually-hidden">Previous</span>';
                            boardHtml += '</button>';
                            boardHtml += '<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControlsNoTouching_' + i + '" data-bs-slide="next">';
                            boardHtml += '<span class="carousel-control-next-icon" aria-hidden="true"></span>';
                            boardHtml += '<span class="visually-hidden">Next</span>';
                            boardHtml += '</button>';
                        }
                        boardHtml += '</div>'; // carousel

                        // 게시물 내용, 해시태그, 좋아요, 댓글 등 추가
                        boardHtml += '<div class="post-content">';
                        boardHtml += '<p>' + data.list[i].feedContent + '</p>';
                        boardHtml += '<div class="post_hashtag">' + data.list[i].feedHashtag + '</div>';
                        boardHtml += '</div>';

                        // 게시물 삭제 버튼 추가 (사용자 본인만 삭제 가능)
                        boardHtml += '<div class="post-delete">';
                        boardHtml += '<button onclick="fn_delete(\'' + data.list[i].feedIdx + '\')">삭제</button>';
                        boardHtml += '</div>';
                        boardHtml += '</li>'; // post-item
                    }
                } else {
                    boardHtml += '<li class="post-item" style="text-align:center;">등록된 글이 없습니다.</li>';
                }

                // 게시물 목록 출력
                $("#feedList").html(boardHtml);
            },
            error: function(data, status, err) {
                console.log(err);
            }
        });
    }

    // 게시물 삭제
    function fn_delete(feedIdx) {
        if (confirm("정말로 삭제하시겠습니까?")) {
            $.ajax({
                url: '/feed/deleteFeed.do',
                type: 'post',
                data: { feedIdx: feedIdx },
                dataType: 'json',
                success: function(data, status, xhr) {
                    if (data.resultChk > 0) {
                        alert("게시물이 삭제되었습니다.");
                        fn_selectMyFeedList(); // 게시물 목록 갱신
                    } else {
                        alert("삭제에 실패하였습니다.");
                    }
                },
                error: function(data, status, err) {
                    console.log(err);
                }
            });
        }
    }

</script>
</head>
<body>
    <!-- 마이페이지 상단 -->
    <div class="mypage-header">
        <h1>${loginInfo.userName}의 마이페이지</h1>
        <form id="searchFrm">
            <input type="text" name="search" placeholder="게시물 검색">
            <button type="button" id="btn_search">검색</button>
        </form>
    </div>

    <!-- 게시물 목록 -->
    <ul class="feed-list" id="feedList" name="feedList"></ul>

    <!-- 모달 오버레이 -->
    <div id="modalOption" class="modal-overlay"></div>

</body>
</html>