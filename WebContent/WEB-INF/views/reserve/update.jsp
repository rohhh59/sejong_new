﻿<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();

   Date now = new Date();
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   
   Calendar cal = Calendar.getInstance();
   
   int y = Integer.parseInt(sdf.format(now).substring(0, 4));
   int m = Integer.parseInt(sdf.format(now).substring(5, 7));
   int d = Integer.parseInt(sdf.format(now).substring(8));   
    
   cal.set(y, m, 1);
   cal.add(Calendar.DATE, -1);
   
   int lastDay = cal.get(Calendar.DATE);   
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/reserve.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("input").not($(":button")).not($(":reset")).keypress(function(evt){
		if(evt.keyCode==13) {
			var fields = $(this).parents("form, body").find("button, input, select");		// parents : 모든 아버지 
			var index = fields.index(this);  // 자신의 인덱스 
			
			if(index > -1 && (index+1) < fields.length) {  // index가 존재하고 마지막이 아니면 
				fields.eq(index+1).focus();
			}
			return false; // 이벤트 취소 
		}		
	});
});

$(function(){
	$("form[name=updateForm] input+br+span").hide();
	$("form[name=updateForm] input[type=text]").css("border", "1px solid #aaa");
	
	$("form[name=updateForm] input").focus(function(){
		$(this).css("border", "2px solid #B2FA5C");
		if($(this).attr("id")!="userIdState") {
			$(this).next("br").next("span").show();
		}
	});
	
	$("form[name=updateForm] input").blur(function(){
		$(this).css("border", "1px solid #EAEAEA");
		if($(this).attr("id")!="userIdState") {
			$(this).next("br").next("span").hide();
		}
	});
	
});

function calTime() {
	
/* 	alert("실험"); */
	
	var now = new Date();
	var y = now.getFullYear();
	var m = now.getMonth();
	var d = now.getDate();
	
	return m;	
}

function updateOk() {
    var f = document.updateForm;   

 	var str = f.r_name.value;
    if(!str) {
        alert("예약자 이름을 입력 해 주세요.");
        f.r_name.focus();
        return;
    }

	str = f.r_tel.value;
    if(!str) {
        alert("연락처를 입력 해 주세요.");
        f.r_tel.focus();
        return;
    } 
    
    str = f.r_email.value;
    if(!str) {
        alert("이메일을 입력 해 주세요.");
        f.r_email.focus();
        return;
    } 

	f.action="<%=cp%>/reserve/update_ok.do";

    f.submit();
    
    alert("예약이 변경 되었습니다.");
} 

</script>
</head>
<body>

<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="text-sub1">
	<p class="hold-menu">Reservation</p>
	<ul class="sub-menu">
		<li><a href="<%=cp%>/reserve/reserve.do"><span style="color: #B2FA5C;">Reserve</span></a></li>
		<li><a href="<%=cp%>/reserve/checked.do">Check</a></li>		
		<li><a href="<%=cp%>/reserve/list.do">List</a></li>
	</ul>
</div>
	
<div class="container">
    <div class="body-container">   
   
   <jsp:include page="/WEB-INF/views/layout/sns.jsp"></jsp:include>
   
   <div class="reserve">   
   
		<h3>| 세종 스테이크 예약 </h3>			
		<div class="title">		
			<p> 예약 수정 </p>		
		</div>
		<div class="notice">
			<p> 고객님의 예약 정보를 수정합니다. <br>
				예약 변경은 기존 예약일 3일 전 까지만 가능합니다. <br>
				변경 시  참고 부탁드립니다. 감사합니다.</p>
		</div>
		
	<form name="updateForm" method="post">
		<div class=blank>
			<div class="title1">
				<p>예약 일시 선택 </p>
			</div>
			<div class="reserve-info1">
				<p>날짜 |&nbsp; 					
					<select name="r_year" class="selectField" onchange="calTime()">
						<option value="<%=y%>"><%=y%>년</option>											
					</select>
					<select name="r_month" class="selectField" onchange="calTime()">
				<%for(int i=m; i<=12; i++) { %>
						<option value="<%=i%>"><%=i%>월</option>
				<% } %>					
					</select>
						<select name="r_day" class="selectField" onchange="calTime()">						
				<%for(int i=d; i<=lastDay; i++) { %>
						<option value="<%=i%>"><%=i%>일</option>
				<% } %>						
					</select></p>						
				<p>시간 |&nbsp;					
					<select name="r_time" class="selectField" style="width:100px;">
						<option value="11:00" ${dto.r_time=="11:00" ? "selected='selected'" : ""}>11:00</option>
						<option value="11:30" ${dto.r_time=="11:30" ? "selected='selected'" : ""}>11:30</option>
						<option value="12:00" ${dto.r_time=="12:00" ? "selected='selected'" : ""}>12:00</option>
						<option value="12:30" ${dto.r_time=="12:30" ? "selected='selected'" : ""}>12:30</option>
						<option value="13:00" ${dto.r_time=="13:00" ? "selected='selected'" : ""}>13:00</option>
						<option value="13:30" ${dto.r_time=="13:30" ? "selected='selected'" : ""}>13:30</option>
						<option value="14:00" ${dto.r_time=="14:00" ? "selected='selected'" : ""}>14:00</option>
						<option value="14:30" ${dto.r_time=="14:30" ? "selected='selected'" : ""}>14:30</option>
						<option value="15:00" ${dto.r_time=="15:00" ? "selected='selected'" : ""}>15:00</option>
						<option value="15:30" ${dto.r_time=="15:30" ? "selected='selected'" : ""}>15:30</option>
						<option value="16:00" ${dto.r_time=="16:00" ? "selected='selected'" : ""}>16:00</option>
						<option value="16:30" ${dto.r_time=="16:30" ? "selected='selected'" : ""}>16:30</option>
						<option value="17:00" ${dto.r_time=="17:00" ? "selected='selected'" : ""}>17:00</option>
						<option value="17:30" ${dto.r_time=="17:30" ? "selected='selected'" : ""}>17:30</option>
						<option value="18:00" ${dto.r_time=="18:00" ? "selected='selected'" : ""}>18:00</option>
						<option value="18:30" ${dto.r_time=="18:30" ? "selected='selected'" : ""}>18:30</option>
						<option value="19:00" ${dto.r_time=="19:00" ? "selected='selected'" : ""}>19:00</option>
						<option value="19:30" ${dto.r_time=="19:30" ? "selected='selected'" : ""}>19:30</option>
						<option value="20:00" ${dto.r_time=="20:00" ? "selected='selected'" : ""}>20:00</option>													
					</select>						
				</p>
				<p>인원 |&nbsp;
					 <select name="r_count" class="selectField">
						<option value="1인" ${dto.r_count=="1인" ? "selected='selected'" : ""}>1명</option>
						<option value="2인" ${dto.r_count=="2인" ? "selected='selected'" : ""}>2명</option>
						<option value="3인" ${dto.r_count=="3인" ? "selected='selected'" : ""}>3명</option>	
						<option value="4인" ${dto.r_count=="4인" ? "selected='selected'" : ""}>4명</option>	
						<option value="5인 이상" ${dto.r_count=="5인 이상" ? "selected='selected'" : ""}>5명 이상</option>					
					</select>						
				</p>					
									
			</div>
		</div>
			
		<div class=blank style="margin-left:35px;">
			<div class="title2" style="margin-left: 0;">
				<p> 예약자 정보 </p>
			</div>
			<div class="reserve-info2" style="margin-left: 0;">
			
				<p>이&nbsp;&nbsp;&nbsp;&nbsp;름&nbsp; |&nbsp;  
					<input type="text" name="r_name" maxlength="20" class="selectField2" value="${dto.r_name}">
				</p> 
				<p>연 락 처&nbsp; |&nbsp;  
					<input type="text" name="r_tel" maxlength="20" class="selectField2" value="${dto.r_tel}">
				</p>
				<p>이 메 일&nbsp; |&nbsp;  
					<input type="text" name="r_email" maxlength="20" class="selectField2" value="${dto.r_email}">
				</p>
				<p>요청사항 |&nbsp;  
					<input type="text" name="r_request" maxlength="20" class="selectField2" style="width: 220px;" value="${dto.r_request}">
				</p>					
				    <input type="hidden" name="r_num" value="${dto.r_num}"> 					
			</div>			
		</div>		
	</form>	
			
		<div class="button">
			<button type="button" class="btn" onclick="updateOk();">예약 변경</button>
		</div>					
	</div>        

    </div>
</div>

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>