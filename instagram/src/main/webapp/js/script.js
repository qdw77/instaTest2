

function updateInputState(input, activeVar){
   // trim() 공백
  // 공백 제거한 value 값의 길이가 0보다 클 때 => 사용자가 input 창에 입력한 값이 하나라도 있냐
  if(input.value.trim().length > 0){
    input.parentElement.classList.add('active');
    activeVar=true;
  }

  else{
    // value 값의 길이가 없을 때 
   input.parentElement.classList.remove('active');
   activeVar = false;
  }
// return : 해당함수가 실행된 후 함수 호출한 위치로 전달되는 값
  return activeVar;
}


let userId = document.getElementById('id');
let userPw = document.getElementById('pwd');

let idActive = false;
let pwActive = false;

let submitBtn = document.getElementById('submit-btn');

function handleInput(e){
    // e.target => 이벤트가 일어나는 대상
  let input = e.target;

  let type = input.getAttribute("type");

  if(type == "text"){
    idActive = updateInputState(input, idActive); //return 값 =>true, false
  } else {
    // type이 text가 아닐경우 password
    pwActive = updateInputState(input, pwActive); //return 값 =>true, false
  }

    // idActive와 pwActive가 둘다 참일 때=> input,value,length > 0
  if(idActive && pwActive) {
    submitBtn.removeAttribute('disabled');
  } else {
    // idActive나 pwActive 중 둘중 하나 값이 false 일때
    submitBtn.setAttribute('disabled', true);
  }
}

userId.addEventListener('keyup', handleInput)
userPw.addEventListener('keyup', handleInput)

// e.target에 대한
// let txtapTxt = document.querySelector('.txtap-txt');
// console.log(txtapTxt)

// function btnClick(e) {
//   console.log(e.target)
// }

// txtapTxt.addEventListener('click',btnClick)


let pwVisible = document.getElementById('pw-visible');

function pwMode (){


  // userpw의 type이 password일 경우
  if(userPw.getAttribute('type') == 'password'){
    // 변경대상 stAttribute(어떤 속성을, 어떤걸로)
    // 비밀번호 표시 클릭> userpw(input) type >text 변경

    userPw.setAttribute('type', 'text');
  //  pwVisbie.innerHTML>숨기기로 변경
    pwVisible.innerHTML = '숨기기';
 
  }    else{
      // userpw의 type이 text일 경우
// 숨기기 >userpw type >password
  userPw.setAttribute('type', 'password');
  pwVisible.innerHTML = '비밀번호 표시';
//
  }
}

pwVisible.addEventListener('click', pwMode);



let modeBtn = document.getElementById('mode-toggle');

function modeToggle(e) {
  e.preventDefault();

  let body = document.querySelector('body');
  body.classList.toggle('dark');

  
  if(body.classList.contains('dark')){
    modeBtn.innerHTML ='Lightmode';
  } else {
    modeBtn.innerHTML = 'Darkmode';
    // classList.contans()
  }
  // 상향연산자
  // 조건 ? 참일 때 : 거짓일때
  // modeBtn.innerHTML = body.classList.contains('dark') ? 'Lightmode' : 'Darkmode';
}
modeBtn.addEventListener('click', modeToggle);


// e.target-의미/return-어디로/매개변수(parametr)-어떤값

