<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function() {
	opener.location.href="javascript:KMCISAccOk('"+$("#rec_cert").val()+"','"+$("#certNum").val()+"');"; 
	self.close();
});
</script>