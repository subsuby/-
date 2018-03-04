<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$( document ).ready(function() {
	CommonScript.loading();
	//초기화
	FriendScript.init();
	CommonScript.loadingHide();
});

FriendScript = {
	//템플릿
	friendClone : '',
	//초기화
	init : function(){
		//템플릿 복사
		FriendScript.friendClone = $('#friendClone').clone();
		$('#friendClone').remove();
		//친구목록 불러오기
		FriendScript.getFriendList();
	},
	search : function(){
		var schKey = $('input[name=schValue]').val();
		FriendScript.getFriendList(schKey);
	},
	getFriendList : function(schKey){
		//리스트 호출
		$.ajax({
			url : '/front/friend/list/api',
			type : 'POST',
			dataType : 'json',
			data : {searchKey : schKey},
			success:function(data){
				var user = data.user;
				console.log(user);
				$('.friendTabs').remove();
				//내정보 만들기
				$('.myInfo').append(FriendScript.friendClone.clone());
				var myinfo = $('#friendClone');
				myinfo.find('.tableFriendName').append('<strong>'+user.userName+'(<spring:message code="friend.me"/>)</strong>');
				myinfo.find('.tableFriendBirth').append('<img src="/resources/img/custom/birth-blue.png" class="friendTabImg"/>'+CommonScript.formatBirth(user.userBirth));
				myinfo.find('.tableFriendPhone').append('<img src="/resources/img/custom/phone-blue.png" class="friendTabImg"/>'+user.userPhone)
				$('#friendClone').attr('id','');
				//리스트가 없을시
				if(user.friend.length == 0){
					$('#friendList').append('<h1><spring:message code="friend.msg.no_such_friend"/></h1>');
				}
				//리스트가 있을시
				else{
					FriendScript.makeFriendList(user);
				}
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="friend.friend_list"/>','<spring:message code="friend.msg.error_friend_list"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	makeFriendList : function(user){
		//친구목록 만들기
		for(var i = 0; i < user.friend.length; i++){
			$('.friendList').append(FriendScript.friendClone.clone());
			var friendTab = $('#friendClone');
			friendTab.find('.tableFriendName').append('<strong>'+user.friend[i].friend.userName+'</strong>')
			friendTab.find('.tableFriendBirth').append('<img src="/resources/img/custom/birth-blue.png" class="friendTabImg"/>'+CommonScript.formatBirth(user.friend[i].friend.userBirth));
			friendTab.find('.tableFriendPhone').append('<img src="/resources/img/custom/phone-blue.png" class="friendTabImg"/>'+user.friend[i].friend.userPhone)
			$('#friendClone').attr('id','');
		}
		if(user.friend.length == 0){
			$('.friendList').append
		}
	},
	findFriend : function(){
		CommonScript.loading();
		var id = $('input[name=findId]').val();
		//리스트 호출
		$.ajax({
			url : '/front/friend/find/api',
			type : 'POST',
			dataType : 'json',
			data : {userId : id},
			success:function(data){
				console.log(data);
				if(data.user){
					//검색된 친구 있을때
					FriendScript.findFriendResult(data.user);
				}else{
					//검색된 친구 없을때
					
				}
				CommonScript.loadingHide();
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="friend.friend_list"/>','<spring:message code="friend.msg.error_friend_list"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
	findFriendResult : function(data){
		$('.modal-window').hide();
// 		$('#idResult').text('회원님의 아이디는 '+data+'입니다.')
		$('.findFriendResult').show();
		$('.findFriendResult').addClass('open');
		$('.findFriendResult').children().css('top','185.5px');
		$('.findFriendName').text('');
		$('.findFriendName').append('<spring:message code="friend.name"/> : '+data.userName);
		$('.findFriendPhone').text('');
		$('.findFriendPhone').append('<spring:message code="friend.phone"/> : '+data.userPhone);
		$('.findFriendBirth').text('');
		$('.findFriendBirth').append('<spring:message code="friend.birth"/> : '+CommonScript.formatBirth(data.userBirth));
		$('#addFriendBtn').attr('onclick','FriendScript.addFriend("'+data.userId+'")');
	},
	addFriend : function(id){
		console.log(id);
		$.ajax({
			url : '/front/friend/add/api',
			type : 'POST',
			dataType : 'json',
			data : {userFriendId : id},
			success:function(data){
				console.log(data);
				if(data.result == 'true'){
					FriendScript.getFriendList();
					$('.modal-window').hide();
//			 		$('#idResult').text('회원님의 아이디는 '+data+'입니다.')
					$('.addFriendResult').show();
					$('.addFriendResult').addClass('open');
					$('.addFriendResult').children().css('top','185.5px');
				}
				CommonScript.loadingHide();
			},
			error : function(data, status, er) {
				CommonScript.errorPop('<spring:message code="friend.friend_list"/>','<spring:message code="friend.msg.error_friend_list"/>')
				console.log("error: " + JSON.stringify(data) + " status: " + status + " er:" + er);
			}
		})
	},
}
</script>