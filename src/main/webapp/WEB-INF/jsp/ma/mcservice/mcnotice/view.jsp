<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/cmmn/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<%
    pageContext.setAttribute("crcn", "\r\n"); 
    pageContext.setAttribute("br", "<br>");
%> 
<script type="text/javascript" src="/publish/ma/js/board.js"></script>
<script type="text/javaScript">
$(document).ready(function(){
});
var nextprevItem=function(seq){
	fncPageBoard('view','view.do',seq+"",'seq')
	return false
}
</script>
<div class="content_box">
	<form:form commandName="searchVO" name="defaultFrm" id="defaultFrm" method="post">
		<form:hidden path="seq" id="seq"/>
		<form:hidden path="pageIndex" id="pageIndex"/> 
		<form:hidden path="atchFileId" id="atchFileId"/>
		<jsp:directive.include file="/WEB-INF/jsp/cmmn/inc/incSearchForm.jsp"/>
		<!-- tbl -->
		<div class="tbl_wrap">
			<table class="tbl_row_type01">
				<caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
				<colgroup>
					<col style="width:15%;">
					<col style="width:35%;">
					<col style="width:15%;">
					<col style="width:35%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><strong>등록자</strong></th>
						<td>
							${boardVO.name }
						</td>
	                    <th scope="row"><strong>등록일</strong></th>
						<td>${boardVO.rgstDt }</td>
					</tr> 
					<tr>
						<th scope="row"><strong>공지여부</strong></th>
						<td>
							<c:choose>
								<c:when test="${boardVO.notiYn eq 'Y'}">공지</c:when>
								<c:otherwise>비공지</c:otherwise>
							</c:choose>
						</td>
						<th scope="row"><strong>기간</strong></th>
						<td>
							${boardVO.staDate}
							~
							${boardVO.endDate}
						</td>
					</tr>
					<tr>
						<th scope="row"><strong>연락처</strong></th>
						<td><c:out value="${boardVO.hp}"/></td>
						<th scope="row"><strong>이메일</strong></th>
						<td><c:out value="${boardVO.email}"/></td>
					</tr>
					<tr>
						<th scope="row"><strong>내용</strong></th>
						<td colspan="3">
							<div class="text_area">
								<pre><c:out value="${util:unEscape(boardVO.cont)}" escapeXml="false"/></pre>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><strong>첨부파일</strong></th>
						<td colspan="3">
							<iframe name="atchFileIdFrame" id="atchFileIdFrame" src="/atch/fileUpload.do?atchFileId=${boardVO.atchFileId }&fileCnt=5&atchFileIdNm=atchFileId&updateType=view" style="width: 100%;" height="50" frameborder="0" title="파일 업로드 폼"></iframe>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
	<div class="btn_area">
		<c:if test="${loginMgrAuthCode eq 1}">
			<a href="#" id="btn_update" class="btn btn_mdl btn_rewrite" >수정</a> 
			<a href="#" id="btn_del" class="btn btn_mdl btn_del" >삭제</a>
		</c:if>
		<a href="#" id="btn_list" class="btn btn_mdl btn_list" >목록</a>
	</div>	
	</form:form>
	
	<!-- prev & next -->
	<table class="tbl_prevNext" >
	    <caption></caption>
	    <colgroup>
	        <col style="width:15%"/>
	        <col />
	    </colgroup>
	    <tbody>
	    	<c:if test="${not empty prevItem }">
		        <tr onclick="nextprevItem(${prevItem.seq})">
		            <th scope="row">이전글</th>
		            <td><a href="#"><c:out value="${util:cutText(prevItem.title,30,'...') }"/></a></td>
		        </tr>
	        </c:if>
	        <c:if test="${not empty nextItem }">
		        <tr onclick="nextprevItem(${nextItem.seq})">
		            <th scope="row">이전글</th>
		            <td><a href="#"><c:out value="${util:cutText(nextItem.title,30,'...') }"/></a></td>
		        </tr>
	        </c:if>
	    </tbody>
	</table>
	<!--// prev & next -->
</div>
