<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<tiles:insertAttribute name="meta"></tiles:insertAttribute>
<title>template</title>
</head>
<tiles:insertAttribute name="scripts"></tiles:insertAttribute>
<tiles:insertAttribute name="common"></tiles:insertAttribute>
<body>
	<tiles:insertAttribute name="header"></tiles:insertAttribute>
	<div id="container" style="margin-top:66px;">
		<tiles:insertAttribute name="body"></tiles:insertAttribute>
	</div>
	<tiles:insertAttribute name="footer"></tiles:insertAttribute>
</body>
<script>
Ventcamp.init();
</script>
</html>