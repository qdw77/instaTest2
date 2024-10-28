

function updateInputState(input, activeVar){
  if(input.value.trim().length > 0){
    input.parentElement.classList.add('active');
    activeVar=true;
  }

  else{
   input.parentElement.classList.remove('active');
   activeVar = false;
  }
  return activeVar;
}


let id = document.getElementById('id');
let pwd = document.getElementById('pwd');

let idActive = false;
let pwActive = false;

let submitBtn = document.getElementById('submit-btn');

function handleInput(e){
  let input = e.target;

  let type = input.getAttribute("type");

  if(type == "text"){
    idActive = updateInputState(input, idActive);
  } else {
    pwActive = updateInputState(input, pwActive);
  }

  if(idActive && pwActive) {
    submitBtn.removeAttribute('disabled');
  } else {
    submitBtn.setAttribute('disabled', true);
  }
}

id.addEventListener('keyup', handleInput)
pwd.addEventListener('keyup', handleInput)


let pwVisible = document.getElementById('pw-visible');

function pwMode (){


  if(pwd.getAttribute('type') == 'password'){

    pwd.setAttribute('type', 'text');
    pwVisible.innerHTML = '숨기기';
 
  }    else{
  pwd.setAttribute('type', 'password');
  pwVisible.innerHTML = '비밀번호 표시';
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
  }
 
}
modeBtn.addEventListener('click', modeToggle);



