<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/foodarticle.css" type="text/css">

<script type="text/javascript">
	function deleteFoodMenu(f_num) {
		<c:if test="${sessionScope.loginMem.loginId== 'admin'}">
		    if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		    	 var url = "<%=cp%>/foodmenu/delete.do?f_num = " + num + "&page = ${page}";
		    	 location.href=url;
		    }	
		</c:if>
	}
	
	function updateFoodMenu(f_num) {
		<c:if test="${sessionScope.loginMem.loginId== 'admin'}">
		    var url="<%=cp%>/foodmenu/update.do?f_num = " + f_num + "&page = ${page}";
		    location.href=url;
		</c:if>
		}
</script>
</head>
<body>
	<div class="header">
	    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>
	<div class="container">
		<div class="body-container">
			<div class="body_title">
				<h2>| Main</h2>
			</div>
			
			<div class="menu">
				<table class="menu_list">
					<tr class="title">
						<td class="name">메&nbsp;&nbsp;&nbsp;뉴</td>
						<td class="write">${dto.f_name}</td>
					</tr>
					<tr class="title">
						<td class="name">가&nbsp;&nbsp;&nbsp;격</td>
						<td class="write">${dto.f_price}</td>
					</tr>
					<tr class="title">
						<td class="name">설&nbsp;&nbsp;&nbsp;명</td>
						<td class="write">
							${dto.f_intro}
						</td>
					</tr>
					<tr class="title">
						<td class="name">이미지</td>
						<td class="write">
							<img src="<%=cp%>/food/foodmenu/${dto.f_image}">
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<c:if test="${sessionScope.loginMem.loginId== 'admin'}">				    
			          		<button type="button" onclick="updateFoodMenu('${dto.f_num}');">수정</button>
			       		</c:if>
			      		<c:if test="${sessionScope.loginMem.loginId== 'admin'}">				    
			          		<button type="button" onclick="deleteFoodMenu('${dto.f_num}');">삭제</button>
			       		</c:if>
			
				    	<td>
			        		<button type="button" onclick="javascript:location.href='<%=cp%>/foodmenu/list.do?page=${page}';">리스트</button>
			    		</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="footer">
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>
</body>
</html>