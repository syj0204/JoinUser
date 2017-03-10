<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/jquery-latest.js"></script>
<!-- <script src='https://www.google.com/recaptcha/api.js'></script> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<script type="text/javascript">

function getReturnValue(roadFullAddr,addrDetail,jibunAddr,zipNo) {
	document.getElementById("road_name_address").value = roadFullAddr;
	document.getElementById("detail_address").value = addrDetail; 
	document.getElementById("lot_number").value = jibunAddr; 
	document.getElementById("post_code").value = zipNo;
	$("#address_error").text("");
}

function verify_captcha(all_data) {
	
	$.ajax({
		url : "/verify_captcha",
		type: "POST",
		data : allData,
		success:function(data) {
		    
		    alert(data);
		},
		error: function(jqXHR, textStatus, errorThrown) {
		    alert("FAIL!!");
		}
		
	});
}

function check_inputerror() {
	//alert("check_mustfield!!");
	var id_error = $("#id_error").text();
	var name_error = $("#name_error").text();
	var phone_error = $("#phone_error").text();
	var email_error = $("#email_error").text();
	var password1_error = $("#password1_error").text();
	var password2_error = $("#password2_error").text();
	var result = 0;
	
	if(id_error.length==0 && name_error.length==0 && phone_error.length==0 && email_error.length==0 && $("#email_auth_verify_success").is(":visible") == true && password1_error.length==0 && password2_error.length==0) {
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


$(function(){
	
	var email_auth_code = "";
	
	$("#id").change(function() {
		var id = $("#id").val();
		if(id.length==0) {
			$("#id_error").text("필수입력 필드입니다.");
			
		} else {
			$("#id_error").text("");
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
	
	/*$("#road_name_address").change(function() {
		var road_name_address = $("#road_name_address").val();
		alert(road_name_address.length);

		if(road_name_address.length==0) {
			$("#address_error").text("필수입력 필드입니다.");
			
		} else {
			$("#address_error").text("");
		}
	});*/
	
	$("#password1").change(function() {
		var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		var password1 = $("#password1").val();
		var password2 = $("#password2").val();

		if(!check.test(password1)) {
			$("#password1_error").text("비밀번호는 영문,숫자,특수문자를 혼용하여 8~16 이내로 해야 합니다.");
			
		} else {
			$("#password1_error").text("");
		}
		
		if(password1 != password2) {
			$("#password2_error").text("패스워드가 다릅니다.");
		} else {
			$("#password2_error").text("");
		}
	});
	
	$("#password2").change(function() {
		var password1 = $("#password1").val();
		var password2 = $("#password2").val();
		if(password1 != password2) {
			$("#password2_error").text("패스워드가 다릅니다.");
		} else {
			$("#password2_error").text("");
		}
	});
	
	$("#find_address").click(function() {
		var address_popup = window.open("/popup/address_popup.jsp", "popupWindow", "width=570,height=420, scrollbars=yes");
		address_popup.focus();
	});
	
	$("#phone").change(function() {
		var check = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = $("#phone").val();
		if(!check.test(phone)) {
			$("#phone_error").text("유효하지 않은 핸드폰번호 입니다.");
			
		} else {
			$("#phone_error").text("");
		}
	});
	
	$("#email").change(function() {
		//var check = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
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
	
	$("#email_auth").click(function() {
		//alert("abc");
		var receiver = $("#email").val();
		//$("#email_auth_input").children().attr("disabled", "disabled");
		//$("#email_auth_input").hide();
		$("#email_auth").hide();
		$("#email_auth_verify").show();
		
		$.ajax({
			url : "/email_auth",
			type: "POST",
			data : {"receiver":receiver},
			success:function(data) {
			    //$("#result").html(data);
			    alert(data);
			    email_auth_code = data;
			},
			error: function(jqXHR, textStatus, errorThrown) {
			    alert("FAIL!!");
			}
		});
	});
	
	$("#email_auth_code_verify").click(function() {
		//var email_auth_code_input =  $("#email_auth_code").val();
		if(email_auth_code!="" && email_auth_code == $("#email_auth_code").val()) {
			alert("success!");
			//$("#email_auth_verify").children().attr("disabled", "disabled");
			$("#email_auth_verify").hide();
			$("#email_auth_input").show();
			$("#email_error").text("");
			$("#email_auth_verify_success").show();
			alert($("#email_auth_verify_success").is(":visible") );
			
		}
		else {
			alert("fail!");
			$("#email_auth_input").show();
			$("#email_auth").show();
			$("#email_auth_verify").hide();
			$("#email_error").text("이메일 인증에 실패하였습니다.");
			//alert($("#email_auth_verify_success").is(":visible") );
		}
	});
	
	$("#submit_button").click(function(e) {
		var id = $("#id").val().trim();
		var password = $("#password").val().trim();
		if(id=="" || password=="") {
			alert("ID와 Password를 올바르게 입력하세요!!");
		} else {
			$("#login_form").submit();
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

 <h2> 로그인 </h2>
 <!-- <form action="${pageContext.request.contextPath}/join" method="post"> -->
  <form id="login_form" name="login_form" method="post" action="${pageContext.request.contextPath}/login" accept-charset="UTF-8">
   <table class="table table-bordered">
    <tr>
     <td>ID</td>
     <td>
     	<input id="id" type="text" name="id"/>
     </td>
    </tr>
    <tr>
     <td>Password</td>
     <td><input id="password" type="password" name="password"/></td>
    </tr>
   </table>
   <br />
   <br />
   <!-- 
   <div id="recaptcha"></div>
   <input id="recaptchaCheck" type="button" value="Check">
   <input type="submit" value="Submit" /><input type="reset" value="reset" />-->
   <input id="submit_button" type="button" value="Login" class="btn btn-primary"/>
  </form>
  
</body>
</html>
