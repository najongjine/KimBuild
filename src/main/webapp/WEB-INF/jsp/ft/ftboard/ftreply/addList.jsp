<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/cmmn/incTagLib.jsp"/>
<script type="text/javaScript">
$(document).ready(function(){
});
var checkLoggedIn=function(){
	if(!'${loginFtSeq}'){
		alert("로그인을 해주세요")
		return false
	}
	fncPageBoard('write','insertForm.do');
	return false
}
var checkPrivateBoard=function(seq,isPrivate='N',rgstId=""){
	if(isPrivate == 'Y' && '${loginFtSeq}' != rgstId ){
		alert("비밀글입니다")
		return false
	}
	fncPageBoard('view','view.do',seq+"",'seq')
	return false
}
</script>
<div class="tbl_top">
	<div class="tbl_left"><i class="i_all"></i><span>전체 : <strong>${paginationInfo.totalRecordCount}</strong> 건(${searchVO.pageIndex}/${paginationInfo.totalPageCount} Page) </span></div>
	<div class="tbl_right"></div>
</div>
<div class="tbl_wrap">
	<table class="tbl_col_type01">
		<caption>목록</caption>
		<colgroup> 
			<col style="width:5%">
			<col>
			<col style="width:10%">
			<col style="width:10%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col" class="subject">제목</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) > 0}">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr onclick="checkPrivateBoard(${result.seq},'${result.isPrivate}',${result.rgstId})" class="cursor">
							<td >
								${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}
							</td>
							<td class="subject" >
								<a href="#"><c:out value="${util:cutText(result.title,30,'...') }"/>
								<c:if test="${result.isPrivate eq 'Y'}"><i class="fa fa-lock"></i></c:if></a>
							</td>
							<td >${result.name }</td>
							<td >${result.rgstDt }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr><td colspan="4" class="no_data">데이터가 없습니다.</td></tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
<%-- //tbl end --%>
<%-- paging start --%>
<div class="paging_wrap">
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="manage" jsFunction="fncPageBoard" />
	</div>
	<div class="btn_right">
		<a href="#" class="btn btn_middle btn_purple" onclick="checkLoggedIn()">등록</a>
	</div>
</div>
<%-- //paging end--%>