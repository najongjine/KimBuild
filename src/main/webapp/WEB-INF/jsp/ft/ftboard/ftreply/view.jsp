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
	$("#btn_insert_reply").on("click",function(){
		fncPageBoard('write','insertReplyForm.do');
		return false
	})
	$("#btn_update_reply").on("click",function(){
		fncPageBoard('update','updateReplyForm.do');
		return false
	})
	$("#btn_delete_reply").on("click",function(){
		fncPageBoard('del','deleteReplyProc.do');
		return false
	})
});
var nextprevItem=function(seq,isPrivate='N',rgstId=""){
	if(isPrivate == 'Y' && '${loginFtSeq}' != rgstId ){
		alert("비밀글입니다")
		return false
	}
	fncPageBoard('view','view.do',seq+"",'seq')
	return false
}
</script>
<div class="content_box">
	<form:form commandName="searchVO" name="defaultFrm" id="defaultFrm" method="post">
		<form:hidden path="seq" id="seq"/>
		<form:hidden path="subSeq" id="subSeq"/>
		<form:hidden path="breplySeq" id="breplySeq"/>
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
						<th scope="row"><strong>비밀글 여부</strong></th>
						<td>
							<c:choose>
								<c:when test="${boardVO.isPrivate eq 'Y'}">비밀글</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
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
		
	<div class="tbl_btns">
		<c:if test="${boardVO.rgstId eq loginFtSeq}">
			<a href="#" id="btn_update" class="btn btn_middle btn_purple" >수정</a> 
			<a href="#" id="btn_del" class="btn btn_middle btn_red" >삭제</a>
		</c:if>
		<c:if test="${empty replyVO}">
			<a href="#" id="btn_list" class="btn btn_middle btn_gray" >목록</a>
		</c:if>
	</div>	
	</form:form>
	
	<c:if test="${not empty replyVO}">
	<br>
	<h2>답변</h2>
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
						${replyVO.name }
					</td>
                    <th scope="row"><strong>등록일</strong></th>
					<td>${replyVO.rgstDt }</td>
				</tr> 
				<tr>
					<th scope="row"><strong>연락처</strong></th>
					<td><c:out value="${replyVO.hp}"/></td>
					<th scope="row"><strong>이메일</strong></th>
					<td><c:out value="${replyVO.email}"/></td>
				</tr>
				<tr>
					<th scope="row"><strong>내용</strong></th>
					<td colspan="3">
						<div class="text_area">
							<pre><c:out value="${util:unEscape(replyVO.cont)}" escapeXml="false"/></pre>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><strong>첨부파일</strong></th>
					<td colspan="3">
						<iframe name="atchFileId2Frame" id="atchFileId2Frame" src="/atch/fileUpload.do?atchFileId=${boardVO.atchFileId }&fileCnt=5&atchFileIdNm=atchFileId2&updateType=view" style="width: 100%;" height="50" frameborder="0" title="파일 업로드 폼"></iframe>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="tbl_btns">
		<a href="#" id="btn_list" class="btn btn_middle btn_gray" >목록</a>
	</div>	
	</c:if>
	
	<!-- prev & next -->
	<table class="tbl_prevNext" >
	    <caption></caption>
	    <colgroup>
	        <col style="width:15%"/>
	        <col />
	    </colgroup>
	    <tbody>
	    	<c:if test="${not empty prevItem }">
		        <tr onclick="nextprevItem(${prevItem.seq},'${prevItem.isPrivate}',${prevItem.rgstId})">
		            <th scope="row">이전글</th>
		            <td>
		            	<a href="#"><c:out value="${util:cutText(prevItem.title,30,'...') }"/>
		            	 <c:if test="${prevItem.isPrivate eq 'Y'}"><i class="fa fa-lock"></i></c:if></a>
		            </td>
		        </tr>
	        </c:if>
	        <c:if test="${not empty nextItem }">
		        <tr onclick="nextprevItem(${nextItem.seq},'${nextItem.isPrivate}',${nextItem.rgstId})">
		            <th scope="row">이전글</th>
		            <td>
		            	<a href="#"><c:out value="${util:cutText(nextItem.title,30,'...') }"/>
		            	<c:if test="${nextItem.isPrivate eq 'Y'}"><i class="fa fa-lock"></i></c:if></a>
		            </td>
		        </tr>
	        </c:if>
	    </tbody>
	</table>
	<!--// prev & next -->
</div>
