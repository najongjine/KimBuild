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
						<th scope="row"><strong class="th_tit">제목</strong></th>
						<td colspan="3"><c:out value="${boardVO.title}"/></td>
					</tr>
					<tr>
						<th scope="row"><strong>등록자</strong></th>
						<td>
							${boardVO.name }
						</td>
	                    <th scope="row"><strong>등록일</strong></th>
						<td>${boardVO.rgstDt }</td>
					</tr> 
					<tr>
						<th scope="row"><strong>연락처</strong></th>
						<td><c:out value="${boardVO.hp}"/></td>
						<th scope="row"><strong>이메일</strong></th>
						<td><c:out value="${boardVO.email}"/></td>
					</tr>
					<tr>
						<td colspan="4" class="tbl_text">
							<div class="thum_slide">
								<div class="pikachoose">
									<ul id="pikame" class="jcarousel-skin-pika">
										<c:forEach var="result" items="${boardVO.imgList}">
											<li>
												<img src="/atch/getImage.do?atchFileId=${result.atchFileId}&fileSn=${result.fileSn}" onerror="this.src='/publish/ma/images/no_img.png'"
					 							 >
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
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
