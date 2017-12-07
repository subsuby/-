<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<ul id="component_maker_list">
	<c:forEach var="maker" items="${makerList}" varStatus="status">
		<li><input type="radio" name="makerCd" data-value="${maker.key}" data-label="${maker.value}" onclick="render_combo(this, 'MODEL')"><label>${maker.value}</label></li>
	</c:forEach>
</ul>
<ul id="component_model_list">
	<c:forEach var="model" items="${modelList}" varStatus="status">
		<li><input type="radio" name="modelCd" data-value="${model.key}" data-label="${model.value}" onclick="render_combo(this, 'MODEL_DETAIL')"><label>${model.value}</label></li>
	</c:forEach>
</ul>
<ul id="component_model_detail_list">
	<c:forEach var="modelDtl" items="${modelDtlList}" varStatus="status">
		<li><input type="radio" name="detailModelCd" data-value="${modelDtl.key}" data-label="${modelDtl.value}" onclick="render_combo(this, 'GRADE')"><label>${modelDtl.value}</label></li>
	</c:forEach>
</ul>
<ul id="component_grade_list">
	<c:forEach var="grade" items="${gradeList}" varStatus="status">
		<li><input type="radio" name="gradeCd" data-value="${grade.key}" data-label="${grade.value}" onclick="render_combo(this)"><label>${grade.value}</label></li>
	</c:forEach>
</ul>