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
<!-- 
<link href="{% static 'libvirtapp/css/dashboard.css' %}" rel="stylesheet">
<script src="{% static 'libvirtapp/js/ie-emulation-modes-warning.js' %}"></script>
<script src="{% static 'libvirtapp/js/holder.js' %}"></script>
<script src="{% static 'libvirtapp/js/ie10-viewport-bug-workaround.js' %}"></script>
 -->
<script type="text/javascript">

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
        <div id="navbar" class="navbar-collapse collapse">
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
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
                    <li><input id="info_detail" type="button" value="정보조회" class="btn btn-default"/></li>
                  </ul>
              </div>
          <div class="table-responsive">
            <table id="user_list_table" class="table table-striped">
              <thead>
                <tr>
                  <!-- <th style='display:none'>#</th> -->
                  <th>ID</th>
                  <th>NAME</th>
                  <th>PHONE</th>
                  <th>EMAIL</th>
                  <th>ADDRESS</th>
                </tr>
              </thead>
              <tbody>

              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
 </body>
</html>
