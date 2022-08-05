<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	margin: 0 auto;
	text-align: center;
	min-width:1280px; 
	background-image: url("resources/images/background.jpg");
    background-repeat : no-repeat;
    background-size: cover;
    overflow: hidden;
}
table tr td { text-align:left; padding-left: 10px }
p { margin: 20px auto; text-align:right; color: #3367d6 }
.valid, .invalid { font-size:14px; font-weight:bold; } 
.valid { color:green }
.invalid { color:red }
[name=address]{ width:calc(100% - 22px); margin-top:3px }
.ui-datepicker table tr, .ui-datepicker table tr td { height: inherit; }
#delete { position: relative; right: 30px; }
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
</head>
<body>

<h3>회원가입</h3>
<p class='w-px500'>* 항목은 필수입력입니다</p>
<form action='join' method='post'>
<table class='w-px500'>
	<tr><th class='w-px120'>* 성명</th>
		<td><input type='text' name='name'></td>
	</tr>
	<tr><th>* 아이디</th>
		<td>
			<input type='text' name='id' class='chk' >
			<a class='btn-fill-s' onclick='id_check()'>아이디중복확인</a>
			<div class='valid'>아이디를 입력하세요(영문소문자,숫자만 가능)</div>
		</td>
	</tr>
	<tr><th>* 비밀번호</th>
		<td>
			<input type='password' name='pw' class='chk'><br>
			<div class='valid'>비밀번호를 입력하세요(영문 대/소문자,숫자를 모두 포함)</div>
		</td>
	</tr>
	<tr><th>* 비밀번호 확인</th>
		<td>
			<input type='password' name='pw_ck' class='chk'><br>
			<div class='valid'>비밀번호를 다시 입력하세요</div>
		</td>
	</tr>
	<tr><th>전화번호</th>
		<td><input type='text' name='phone' maxlength="13"></td>
	</tr>
	<tr><th>주소</th>
		<td>
			<a class='btn-fill-s' onclick='post()'>우편번호찾기</a>
			<input class='w-px50' type='text' name='post' readonly>
			<input type='text' name='address' readonly>
			<input type='text' name='address'>
		</td>
	</tr>
</table>
</form>
<div class='btnSet'>
	<a class='btn-fill' onclick='join()'>회원가입</a>
	<a class='btn-empty' onclick='history.go(-1)'>취소</a>
</div>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src='js/member_check.js?<%=new java.util.Date()%>'></script>
<script>
//아이디 중복확인 요청
function id_check(){
	var $id = $('[name=id]');
	if( $id.hasClass('chked') ) return;  //이미 중복확인했다면 다시 할 필요없음
		
	var data = member.tag_status( $id );
	if( data.code=='invalid' ){
		alert( '아이디 중복확인 불필요!\n' + data.desc );
		$id.focus();
		return;
	}
	
	$.ajax({
		url: 'id_check',
		data: { id: $id.val() },
		success: function( response ){
			$id.addClass('chked');
			//false(사용가능아이디) : true(이미사용중인아이디)
			response = member.id_usable( !response );
			$id.siblings('div').text( response.desc )
					.removeClass().addClass( response.code );
			
		},error: function(req,text){
			alert(text+':'+req.status);
		}
	});
}

$('.chk').keyup(function(e){
	if( $(this).attr('name')=='id' && e.keyCode==13 ){
		id_check();
	}else{
		//아이디 태그에 뭔가 입력한다면 중복확인했음을 삭제 
		if( $(this).attr('name')=='id' ) $(this).removeClass('chked')
			
		var status = member.tag_status( $(this) );
		$(this).siblings('div').text( status.desc )
			.removeClass().addClass( status.code );
	}
});

// 우편번호찾기
function post(){
    new daum.Postcode({
        oncomplete: function(data) {
        	console.log( data )
        	$('[name=post]').val( data.zonecode ); //우편번호
        	//도로명:R, 지번:J
        	var address = data.userSelectedType=='R' 
        				? data.roadAddress : data.jibunAddress;
        	if( data.buildingName != '' ) 
        		address += ' ('+data.buildingName+')';
        	$('[name=address]').eq(0).val( address );
//         	$('[name=address]:eq(0)').val( address );
        }
    }).open();	
}

//form태그 submit처리
function join(){
	if( $('[name=name]').val()=='' ){
		alert('성명을 입력하세요');
		$('[name=name]').focus();
		return;
	}
	
	//아이디인 경우: 중복확인여부
	if( $('[name=id]').hasClass('chked') ){
		//중복확인했고 + invalid -> 이미 사용중인 아이디 
		if( $('[name=id]').siblings('div').hasClass('invalid') ){
			alert( '회원가입 불가\n' + member.id.unusable.desc );
			$('[name=id]').focus();
			return;
		}
	}else{
		//중복확인하지 않은 경우
		if( ! validate_check( $('[name=id]') ) ) return;
		else{
			alert( '회원가입 불가\n' + member.id.valid.desc );
			$('[name=id]').focus();
			return;
		}
	}
	
	//비번, 비번확인, 이메일
	if( ! validate_check( $('[name=pw]') ) ) return;
	if( ! validate_check( $('[name=pw_ck]') ) ) return;
	$('form').submit();
}

//각 태그의 상태를 확인
function validate_check(tag){
	var data = member.tag_status( tag );
	if( data.code=='valid' )	return true;
	else {
		alert('회원가입 불가\n' + data.desc);
		tag.focus();
		return false;
	}
}
</script>

</body>
</html>