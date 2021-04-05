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
</script>
<div class="tbl_top">
	<div class="tbl_left"><i class="i_all"></i><span>전체 : <strong>${paginationInfo.totalRecordCount}</strong> 건(${searchVO.pageIndex}/${paginationInfo.totalPageCount} Page) </span></div>
	<div class="tbl_right"></div>
</div>
<div class="content_box">
	<ul class="thum_list">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li  <c:if test="${status.count % 3 ==2 }">class="middle"</c:if> >
				<a href="#" onclick="fncPageBoard('view','view.do','${result.seq}','seq')">
					<img src="/atch/getImage.do?atchFileId=${result.atchFileId}&fileSn=${result.minFileSn}" onerror="this.src='/publish/ma/images/no_img.png'"
					 height="200" width="180">
					<h5 class="thum_tit"><c:out value="${util:cutText(result.title,30,'...')}"/></h5>
					<p>${result.rgstDt}</p>
				</a>
			</li>
		</c:forEach>
	</ul>
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