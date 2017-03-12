<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/jquery-latest.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/search.min.js"></script>
<script src='${pageContext.request.contextPath}/resources/js/api.js'></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jQuery.Multiple.min.js"></script>

<script type="text/javascript">

function getReturnValue(roadFullAddr,addrDetail,jibunAddr,zipNo) {
	document.getElementById("road_name_address").value = roadFullAddr;
	document.getElementById("detail_address").value = addrDetail; 
	document.getElementById("lot_number").value = jibunAddr; 
	document.getElementById("post_code").value = zipNo;
	$("#address_error").text("");
}

function check_inputerror() {
	var id_error = $("#id_error").text();
	var name_error = $("#name_error").text();
	var phone_error = $("#phone_error").text();
	var email_error = $("#email_error").text();
	var password1_error = $("#password1_error").text();
	var password2_error = $("#password2_error").text();
	var result = 0;
	var id_check = 0;
	var email_auth = 0;
	
	if($("#id_check_success").is(":visible") != true) {
		alert("ID 중복체크 해주세요!!");
	} else id_check = 1;
	
	if($("#email_auth_verify_success").is(":visible") != true) {
		alert("Email 인증 해주세요!!");
	} else email_auth = 1;
	
	if(id_check==1 && email_auth==1 && id_error.length==0 && name_error.length==0 && phone_error.length==0 && email_error.length==0 && password1_error.length==0 && password2_error.length==0) {
		result = 1;		
	}
	return result;
}

function check_captchaauth() {
	var captcha_response = document.getElementById("g-recaptcha-response").value;
	var result = 0;
	
	if(captcha_response!="") {
		result = 1;		
	}
	return result;
}

function compare_password() {
	var password1 = $("#password1").val();
	var password2 = $("#password2").val();
	
	if(password1 != password2) {
		$("#password2_error").text("패스워드가 다릅니다.");
	} else {
		if(password2.length==0) {
			$("#password2_error").text("필수입력 필드입니다.");
		} else {
			$("#password2_error").text("");
		}
	}
}

function remove(li) {
	var index = li.parentElement.index();
	alert(index);
}

$(function(){
	
	var email_auth_code = "";
	var file_values = [];
	
	$("#id").change(function() {
		var id = $("#id").val();
		if(id.length==0) {
			$("#id_error").text("필수입력 필드입니다.");
			$("#check_id").attr("disabled", true);
			
		} else {
			$("#id_error").text("");
			$("#check_id").attr("disabled", false);
		}
	});
	
	
	$("#name").change(function() {
		var name = $("#name").val();

		if(name.length==0) {
			$("#name_error").text("필수입력 필드입니다.");
			
		} else {
			$("#name_error").text("");
		}
	});
	
	$("#password1").change(function() {
		var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		var password1 = $("#password1").val();
		var password2 = $("#password2").val();
		
		if(password1.length==0) {
			$("#password1_error").text("필수입력 필드입니다. 비밀번호는 영문,숫자,특수문자를 혼용하여 8~16 이내로 해야 합니다.");
		} else {
			if(!check.test(password1)) {
				$("#password1_error").text("비밀번호는 영문,숫자,특수문자를 혼용하여 8~16 이내로 해야 합니다.");
				
			} else {
				$("#password1_error").text("");
			}
		}

		compare_password();
	});
	
	$("#password2").change(function() {
		compare_password();
	});
	
	$("#find_address").click(function() {
		var address_popup = window.open("/address_popup", "popupWindow", "width=570,height=420, scrollbars=yes");
		address_popup.focus();
	});
	
	$("#phone").change(function() {
		var check = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = $("#phone").val();
		
		if(phone.length==0) {
			$("#phone_error").text("필수입력 필드입니다.");
		} else {
			if(!check.test(phone)) {
				$("#phone_error").text("유효하지 않은 핸드폰번호 입니다.");
				
			} else {
				$("#phone_error").text("");
			}
		}
	});
	
	$("#email").change(function() {
		var check = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var email = $("#email").val();
		
		if(email.length==0) {
			$("#email_error").text("필수입력 필드입니다.");
			$("#email_auth").attr("disabled", true);
		} else {
			if(!check.test(email)) {
				$("#email_error").text("유효하지 않은 이메일주소 입니다.");
				$("#email_auth").attr("disabled", true);
			} else {
				$("#email_error").text("");
				$("#email_auth").attr("disabled", false);
			}
		}
	});
	
	$("#check_id").click(function() {
		var id = $("#id").val();
		$.ajax({
			url : "/check_id",
			type: "POST",
			data : {"id":id},
			success:function(data) {
			    if(data=="1") {
			    	$("#id_error").text("사용 할 수 없는 아이디 입니다.");
			    } else {
			    	$("#id_error").text("");
			    	$("#check_id").hide();
			    	$("#id_check_success").show();
			    }
			},
			error: function(jqXHR, textStatus, errorThrown) {
			    alert("FAIL!!");
			}
		});
		
	});
	
	$("#email_auth").click(function() {
		var receiver = $("#email").val();
		$("#email_auth").hide();
		$("#email_auth_verify").show();
		
		$.ajax({
			url : "/email_auth",
			type: "POST",
			data : {"receiver":receiver},
			success:function(data) {
			    email_auth_code = data;
			},
			error: function(jqXHR, textStatus, errorThrown) {
			    alert("FAIL!!");
			}
		});
	});
	
	$("#email_auth_code_verify").click(function() {
		if(email_auth_code!="" && email_auth_code == $("#email_auth_code").val()) {
			alert("success!");
			$("#email_auth_verify").hide();
			$("#email_auth_input").show();
			$("#email_error").text("");
			$("#email_auth_verify_success").show();
		}
		else {
			alert("fail!");
			$("#email_auth_input").show();
			$("#email_auth").show();
			$("#email_auth_verify").hide();
			$("#email_error").text("이메일 인증에 실패하였습니다.");
		}
	});
	
	$("#submit_button").click(function(e) {
		var captchaauth_check_result = check_captchaauth();
		var inputerror_check_result = check_inputerror();
		
		if(captchaauth_check_result==0) {
			alert("캡차 인증을 해주세요!");
		}
		
		if(inputerror_check_result == 1) {
			var interests = [];
			$('#captcha_response').val(document.getElementById("g-recaptcha-response").value);
					
			$(".chkclass :checked").each(function() {
				interests.push($(this).val());
			});
			$("#join_form").submit();
		} else {
			alert("필수 입력항목을 모두 입력해 주세요!!");
		}
	});
	$("#files").change(function(e) {
		var files = $("#files")[0].files;

		for (var i = 0; i < files.length; i++)
		{
		 alert(files[i].name);
		}
	});
});
</script>

<style type="text/css">
body {
    padding: 50px;
}
table {
    border-collapse: collapse;
    width: 40%;
}

table, th, td {
   border: 1px solid black;
}
td {
    padding: 10px;
    text-align: left;
}
fieldset { border:none; }
</style> 
</head>
<body>

 <h2> 회원가입 </h2>
 <!-- <form action="${pageContext.request.contextPath}/join" method="post"> -->
  <form id="join_form" name="join_form" method="post" action="${pageContext.request.contextPath}/join" enctype="multipart/form-data" accept-charset="UTF-8">
   <table class="table table-bordered">
   <tr>
     <td style="text-align:center; vertical-align:middle;">사진</td>
     <td>
     	<input id="files" name="files" type="file" multiple="multiple" />
	    <!--<input id="files" type="file" class="multifile" multiple="multiple" />
	      <div id="file_list" style="border:2px solid #c9c9c9;min-height:50px; width:60%;"></div>-->
     </td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">ID</td>
     <td>
     	<input id="id" type="text" name="id"/>   <button id="check_id" type="button" name="check_id" class="btn btn-primary" disabled>중복확인</button><br />
     	<i style="color: red;" id="id_error">필수입력 필드입니다.</i>
     	<strong id="id_check_success" style="color: red; display:none;">중복확인완료</strong> 
     </td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">이름</td>
     <td>
     	<input id="name" type="text" name="name"/>   <i style="color: red;" id="name_error">필수입력 필드입니다.</i>
     </td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">주소</td>
     <td id="find_address">
      <i style="color: red;" id="address_error">필수입력 필드입니다.</i> <br />
	     도로명주소: <input id="road_name_address" type="text" name="road_name_address" readonly/> <button type="button" class="btn btn-primary">주소찾기</button> <br />
	     상세주소: <input id="detail_address" type="text" name="detail_address" readonly/><br />
	     지번: <input id="lot_number" type="text" name="lot_number" readonly/> <br />
	     우편번호: <input id="post_code" type="text" name="post_code" readonly/> <br />
     </td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">핸드폰번호</td>
     <td><input id="phone" type="text" name="phone"/>   <i style="color: red;" id="phone_error">필수입력 필드입니다.</i></td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">Email</td>
     <td>
     	<fieldset id="email_auth_input">
	     	<input id="email" type="text" name="email"/> <button id="email_auth" type="button" name="email_auth" class="btn btn-primary" disabled>이메일인증</button> <br />
	     	<i style="color: red;" id="email_error">필수입력 필드입니다.</i> <br />
	     	<strong id="email_auth_verify_success" style="color: red; display:none;">인증완료</strong>
     	</fieldset>
     	<fieldset id="email_auth_verify" style="display:none;">
     		<input id="email_auth_code" type="text" name="email_auth_code"/>   <button id="email_auth_code_verify" type="button" name="email_auth_code_verify" class="btn btn-primary" >확인</button>
        </fieldset>
     </td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">Password</td>
     <td><input id="password1" type="password" name="password1"/>   <i style="color: red;" id="password1_error">필수입력 필드입니다. 비밀번호는 영문,숫자,특수문자를 혼용하여 8~16 이내로 해야 합니다.</i></td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">Password 확인</td>
     <td><input id="password2" type="password" name="password2"/>   <i style="color: red;" id="password2_error">필수입력 필드입니다.</i></td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">가입경로</td>
     <td>
     <div class="rdclass">
     	<input type="radio" name="joinpath" value="검색" />검색
		<input type="radio" name="joinpath" value="지인권유" />지인권유
		<input type="radio" name="joinpath" value="기타" />기타
	</div>
	</td>
    </tr>
    <tr>
     <td style="text-align:center; vertical-align:middle;">개인관심사항</td>
     <td>
     <div class="chkclass">
     	<input type="checkbox" name="interests" value="인터넷" />인터넷
		<input type="checkbox" name="interests" value="게임" />게임
		<input type="checkbox" name="interests" value="영화" />영화
		<input type="checkbox" name="interests" value="운동" />운동
		<input type="checkbox" name="interests" value="기타" />기타
	</div>
	</td>
    </tr>
   </table>
   <div class="g-recaptcha" data-sitekey="6Lf2ghcUAAAAALe-lbeJMektLXIo5CqLOPr9-1Xb"></div>
   <div id="recaptcha_result"></div>
   <input type="hidden" id="captcha_response" name="captcha_response" />
   <br />
   <br />
   <!-- 
   <div id="recaptcha"></div>
   <input id="recaptchaCheck" type="button" value="Check">
   <input type="submit" value="Submit" /><input type="reset" value="reset" />-->
   <input id="submit_button" type="button" value="Submit" class="btn btn-primary"/>        <input type="reset" value="reset" class="btn btn-info"/>
  </form>
  
</body>
</html>
