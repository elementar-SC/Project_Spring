<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<meta charset="utf-8">
<title>Insert title here</title>
<style type="text/css">
body {
	margin: 0 auto;
	text-align: center;
	min-width:1280px; 
	background-image: url("resources/images/background.jpg");
    background-repeat : no-repeat;
    background-size: cover;
    overflow: hidden;
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
.login input { width:400px; height: 38px; box-sizing: border-box; border-radius: 25px; padding: 0 15px; } 
.login input[type=button] {
	background-color: #3367d6; border: none; color:#fff;
	cursor: pointer;
} 
.chk {
	
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
.find li::before{padding-left: 5px; content:"│"}
.find li:first-child::before{content:""}
a:link, a:visited {background:#D2C3BE; color:black; text-decoration:none; }
li {color:white;}
</style>
</head>
<body>
<div class='center'>
	<%-- <a href='<c:url value="/"/>'><img src='로고이미지'></a> --%>
	<div class='login'>
	<ul>
		<li><input type='text' id='id' class='chk' placeholder="아이디"></li>
		<li><input type='password' id='pw' class='chk' placeholder="비밀번호"></li>
		<li><input type='button' value='로그인' onclick="login()"></li>
		<li><a href="">회원가입</a>│<a href="">비밀번호찾기</a></li>
		<li><hr></li>
		<li><button class='btn-social-login' style='background:#1FC700'><i class="xi-3x xi-naver"></i></button>
		<button class='btn-social-login' style='background:#FFEB00'><i class="xi-3x xi-kakaotalk text-dark"></i></button></li>
	</ul>
	</div>
</div>

</body>
</html>