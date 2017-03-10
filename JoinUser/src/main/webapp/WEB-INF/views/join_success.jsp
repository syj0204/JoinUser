<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Join Success!  
</h1>
<P>  image is ${image}. </P>
<img src="<c:out value="/images/${image}" />" width="100" height="100" />
<P>  id is ${id}. </P>
<P>  name is ${name}. </P>
<P>  road_name_address is ${road_name_address}. </P>
<P>  detail_address is ${detail_address}. </P>
<P>  lot_number is ${lot_number}. </P>
<P>  post_code is ${post_code}. </P>
<P>  phone is ${phone}. </P>
<P>  email is ${email}. </P>
<P>  password1 is ${password1}. </P>
<P>  password2 is ${password2}. </P>
<P>  joinpath is ${joinpath}. </P>
<P>  interests is ${interests}. </P>
</body>
</html>