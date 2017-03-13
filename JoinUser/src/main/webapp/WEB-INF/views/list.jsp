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

function tr_click(tr) {
	var index = tr.rowIndex;
	var td_list = document.getElementById("user_list_table").rows.item(index).cells;
	
	/*$('#id').text("ID: " + td_list[0].innerHTML);
	$('#name').text("NAME: " + td_list[1].innerHTML);
	$('#phone').text("PHONE: " + td_list[2].innerHTML);
	$('#email').text("EMAIL: " + td_list[3].innerHTML);
	$('#road_name_address').text("도로명주소: " + td_list[4].innerHTML);
	$('#detail_address').text("상세주소: " + td_list[5].innerHTML);
	$('#lot_number').text("지번주소: " + td_list[6].innerHTML);
	$('#post_code').text("우편번호: " + td_list[7].innerHTML);
	$('#passwd').text("비밀번호: " + td_list[8].innerHTML);
	$('#joinpath').text("가입경로: " + td_list[9].innerHTML);
	$('#interests').text("관심사: " + td_list[10].innerHTML);
	$('#files').text("FILES: " + td_list[11].innerHTML);
	
	$('#detail_user_info').modal();*/
	 $.ajax({
	    	url : "/get_userinfo",
			type: "POST",
			data : {"id":td_list[0].innerHTML},
			success:function(data) {
			    alert(data);
				var json_data = JSON.parse(data);
				$('#id').text("ID: " + json_data.id);
				$('#name').text("NAME: " + json_data.name);
				$('#phone').text("PHONE: " + json_data.phone);
				$('#email').text("EMAIL: " + json_data.email);
				$('#road_name_address').text("도로명주소: " + json_data.road_name_address);
				$('#detail_address').text("상세주소: " + json_data.detail_address);
				$('#lot_number').text("지번주소: " + json_data.lot_number);
				$('#post_code').text("우편번호: " + json_data.post_code);
				$('#passwd').text("비밀번호: " + json_data.passwd);
				$('#joinpath').text("가입경로: " + json_data.joinpath);
				$('#interests').text("관심사: " + json_data.interests);
				$('#files').text("FILES: " + json_data.files);
				
				$('#detail_user_info').modal();
			},
			error: function(jqXHR, textStatus, errorThrown) {
			    alert("FAIL!!"+errorThrown);
			}
	    });
}

function load_user_detail_info(id) {
    $.ajax({
    	url : "/get_userinfo",
		type: "POST",
		data : {"id":id},
		success:function(data) {
		    alert(data);
		},
		error: function(jqXHR, textStatus, errorThrown) {
		    alert("FAIL!!"+errorThrown);
		}
    });
}
function load_user_list_table() {
    $('#user_list_table tbody tr').remove();
    $.ajax({
    	url : "/get_userlist",
		type: "POST",
		success:function(data) {
		    var json_data = JSON.parse(data);
		    var json_data_sub;
		    $.each(json_data, function(index, value) {
		    	json_data_sub = json_data[index];
		    	$.newtr = $("<tr onclick='tr_click(this)'><td>"+
		    			json_data_sub.id+"</td><td>"+
		    			json_data_sub.name+"</td><td>"+
		    			json_data_sub.phone+"</td><td>"+
		    			json_data_sub.email+"</td><td>"+
		    			json_data_sub.road_name_address+"</td><td>"+
		    			json_data_sub.detail_address+"</td><td style='display:none'>"+
		    			json_data_sub.lot_number+"</td><td style='display:none'>"+
		    			json_data_sub.post_code+"</td><td style='display:none'>"+
		    			json_data_sub.passwd+"</td><td style='display:none'>"+
		    			json_data_sub.joinpath+"</td><td style='display:none'>"+
		    			json_data_sub.interests+"</td><td style='display:none'>"+
		    			json_data_sub.files+"</td></tr>");
		    	
                $('#user_list_table tbody').append($.newtr);
		    });
		},
		error: function(jqXHR, textStatus, errorThrown) {
		    alert("FAIL!!"+errorThrown);
		}
    });
}

$(document).ready(function(){
    load_user_list_table();
});

$(function(){ // this will be called when the DOM is ready
	$('#search_text').keyup(function() {
		var category = $('#search_target').val();
		var value = $('#search_text').val();
		
		if(value=="") {
			$("#user_list_table tbody tr").each(function(){
				$(this).show();
			});
		} else {
			if(category=="-1") return false;
			else if(category=="1") {
				var id;
				$("#user_list_table tbody tr").each(function(){
					id = $(this).find('td').eq(0).text();
					if(id.indexOf(value)!=-1) $(this).show();
					else $(this).hide();
				});
			} else if(category=="2") {
				var address;
				$("#user_list_table tbody tr").each(function(){
					address = $(this).find('td').eq(4).text();
					if(address.indexOf(value)!=-1) $(this).show();
					else $(this).hide();
				});
			} else if(category=="3") {
				var phone;
				$("#user_list_table tbody tr").each(function(){
					phone = $(this).find('td').eq(2).text();
					if(phone.indexOf(value)!=-1) $(this).show();
					else $(this).hide();
				});
			}
		}
	});
});

</script>
</head>
 <body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">회원정보페이지</a>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">User Management<span class="sr-only">(current)</span></a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

          <h2 class="sub-header">User List</h2>
          <div id="navbar" class="navbar-collapse collapse">
                  <ul class="nav navbar-nav navbar-right">
                    <li>
                    	<select name="search_target" id="search_target" class="form-control">
                    	    <option value=-1>검색분류</option>
	                    	<option value=1>ID</option>
	                    	<option value=2>주소</option>
	                    	<option value=3>핸드폰</option>
						</select>
                    </li>
                    <li><input name="search_text" id="search_text" type="text" class="form-control" placeholder="Search..."></li>
                  </ul>
              </div>
          <div class="table-responsive">
            <table id="user_list_table" class="table table-striped">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>NAME</th>
                  <th>PHONE</th>
                  <th>EMAIL</th>
                  <th>ROAD_NAME_ADDRESS</th>
                  <th>DETAIL_ADDRESS</th>
                  <th style='display:none'>LOT_NUMBER</th>
                  <th style='display:none'>POST_CODE</th>
                  <th style='display:none'>PASSWORD</th>
                  <th style='display:none'>JOIN_PATH</th>
                  <th style='display:none'>INTERESTS</th>
                  <th style='display:none'>FILES</th>
                </tr>
              </thead>
              <tbody>

              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    		<!-- Modal -->
			<div class="modal fade" id="detail_user_info" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			        <h4 class="modal-title" id="myModalLabel">User Info Detail</h4>
			      </div>
			      <div class="modal-body">
					<div class="row">
					<div class="col-lg-12">
						<label id="name">name</label>
					</div>
					<div class="col-lg-12">
						<label id="id">id</label>
					</div>
					<div class="col-lg-12">
						<label id="passwd"></label>
					</div>
					<div class="col-lg-12">
						<label id="road_name_address"></label>
					</div>
					<div class="col-lg-12">
						<label id="lot_number"></label>
					</div>
					<div class="col-lg-12">
						<label id="detail_address"></label>
					</div>
					<div class="col-lg-12">
						<label id="post_code"></label>
					</div>
					<div class="col-lg-12">
						<label id="phone"></label>
					</div>
					<div class="col-lg-12">
						<label id="email"></label>
					</div>
					<div class="col-lg-12">
						<label id="joinpath"></label>
					</div>
					<div class="col-lg-12">
						<label id="interests"></label>
					</div>
					<div class="col-lg-12">
						<label id="files"></label>
					</div>
					</div>
			      </div>
			      <div class="modal-footer">
			        <button id="detail_user_info_close" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button id="detail_user_info_save" type="button" class="btn btn-primary">Save Changes</button>
			      </div>
			    </div>
			  </div>
			</div>	
 </body>
</html>
