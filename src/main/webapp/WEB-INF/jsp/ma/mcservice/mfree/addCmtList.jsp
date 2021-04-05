<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/cmmn/incTagLib.jsp"/>
<script type="text/javaScript">
var bUpdateCmtFormShowed=false
$(document).ready(function(){
});
var showCmtUpdateForm=function(bcmtSeq){
	if(bUpdateCmtFormShowed){
		return false
	}
	if(!'${loginMgrSeq}'){
		alert("로그인을 해주세요")
		return false
	}
	let exCont=$("#cmtContTd_"+bcmtSeq).text().trim()
	bUpdateCmtFormShowed=true
	
	let updateCmtFormHtml=`
		<td colspan="3">
		<textarea name="updateCmtCont" id="updateCmtCont" class="txt_area w_100p" >\${exCont}</textarea>
		</td>
		<td>
			<a href="#" class="btn btn_mdl btn_rewrite" onclick="submitUpdateCmt(\${bcmtSeq})" >수정</a> 
			<a href="#" class="btn btn_mdl btn_list" onclick="getCmtList()">취소</a>
		</td>
	`
	$("#cmtTr_"+bcmtSeq).html(updateCmtFormHtml)
	return false
}
var submitUpdateCmt=function(bcmtSeq){
	if(!$("#updateCmtCont").val().trim()){
		alert("수정할 내용을 입력해주세요")
		return false
	}
	$("#bcmtSeq").val(bcmtSeq)
	if($("#bcmtSeq").val()!=bcmtSeq){
		alert("댓글 수정 에러 발생")
		return false
	}
	$.ajax({
		url:'updateCmtProc.json'
		,data:$("#defaultFrm").serialize()
		,method:"POST"
		,success:function(data){
			getCmtList()
		}
		,error:function(error){
			alert("통신 에러")
		}
	})
	return false
}
var submitDeleteCmt=function(bcmtSeq){
	if(!confirm("댓글을 삭제하시겠습니까?")){
		return false
	}
	$.ajax({
		url:'deleteCmtProc.json'
		,data:{"bcmtSeq":bcmtSeq}
		,method:"POST"
		,success:function(data){
			getCmtList()
		}
		,error:function(error){
			alert("통신 에러")
		}
	})
	return false
}
</script>
<div class="tbl_wrap">
	<table class="tbl_col_type01">
		<caption>목록</caption>
		<colgroup> 
			<col>
			<col style="width:10%">
			<col style="width:10%">
			<col style="width:10%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="subject">제목</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
				<th scope="col">기능</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) > 0}">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr id="cmtTr_${result.bcmtSeq}" class="cursor">
							<td id="cmtContTd_${result.bcmtSeq}" class="subject">
								<pre><c:out value="${result.cont}"/></pre>
							</td>
							<td>${result.name }</td>
							<td>${result.rgstDt }</td>
							<td>
								<c:if test="${loginMgrAuthCode eq 1}">
									<a href="#" class="btn btn_mdl btn_rewrite" onclick="showCmtUpdateForm(${result.bcmtSeq})" >수정</a> 
									<a href="#" class="btn btn_mdl btn_del" onclick="submitDeleteCmt(${result.bcmtSeq})">삭제</a>
								</c:if>
							</td>
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
