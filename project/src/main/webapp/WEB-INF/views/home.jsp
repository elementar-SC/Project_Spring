<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<meta charset="utf-8">
<title>SCLASS</title>
<style type="text/css">

html { 
	background: url("resources/images/background.jpg") no-repeat center center fixed; 
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
body {
	device-height:100%;
	device-width:100%;
	margin: 0 auto;
	text-align: center;
	/* background-image: url("resources/images/background.jpg");
    background-repeat : no-repeat;
    background-size: cover;
    */
}
ul { 
	list-style-type:none; 
	padding:0;  
	align-items: center; 
}
.center{
	position:absolute;
	left:50%; top:50%;
	transform:translate(-50%, -50%);  
}
.login ul li { margin:10px 0; }
.login input { width:400px; height: 38px; box-sizing: border-box; border-radius: 13px; padding: 0 15px; border: 0px solid #ffffff; opacity: 0.7; } 
.login input:focus { outline:none;} 
.login input[type=button] {
	background-color: #3367d6; border: none; color:#fff;
	cursor: pointer;
	opacity: 0.8;
} 

.btn-social-login {
  transition: all .2s;
  outline: 0;
  border: 1px solid transparent;
  padding: .5rem !important;
  border-radius: 50%;
  color: #fff;
  margin: 0 10px;
}
.btn-social-login:focus {
  box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
}
.text-dark { color: #343a40!important; }
.find li{float: left; margin-right: 5px;}
a:link, a:visited {text-decoration:none; }
a{margin: 5px 0; font-size: 18px; background: #D2C3BC; opacity: 80%}
li {color:white;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
</head>
<body>
<div class='center'>
	<img src='img/logo.png'>
	<div class='login'>
	<ul>
		<li><input type='text' id='id' class='chk' placeholder="아이디"></li>
		<li><input type='password' id='pw' class='chk' placeholder="비밀번호"></li>
		<li><input type='button' value='로그인' onclick="login()"></li>
		<li><a href='member'><input type='button' value='회원가입' style="background-color: gray;"></a></li>
		<li><a href='findPw'>비밀번호찾기</a></li>
		<li><hr></li>
		<li><button onclick='location="naver_login"' class='btn-social-login' style='background:#1FC700'><i class="xi-3x xi-naver"></i></button>
		<button onclick='location="kakao_login"' class='btn-social-login' style='background:#FFEB00'><i class="xi-3x xi-kakaotalk text-dark"></i></button></li>
	</ul>
	</div>
</div>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src='resources/js/member_check.js?'></script>
<script type="text/javascript">
$('#pw').keyup(function(e){
	if( e.keyCode==13 ) login();
});

function login(){
	if( emptyCheck() ){
		
		$.ajax({
			url: 'home',
			data: { id:$('#id').val(), pw:$('#pw').val() },
			success: function( response ){
				if( response )
					location = '<c:url value="/"/>';
				else{
					alert('아이디나 비밀번호가 일치하지 않습니다!')
					$('#id').focus();
				}
			},error: function(req, text){
				alert( text+':'+req.status);
			}			
		});
	}	
}
</script>

</body>
</html>