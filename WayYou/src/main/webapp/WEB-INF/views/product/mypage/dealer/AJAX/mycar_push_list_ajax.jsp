<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
	<ul>
	<c:forEach items="${pushList}" var="list" varStatus="status">
		<li>
			${list.userName}<span>${list.phoneMobile}</span>
			<input type="hidden" class="userId" id="id${status.index}" value="${list.userId}"/>
		</li>
	</c:forEach>
	</ul>