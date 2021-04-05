<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/cmmn/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<script type="text/javascript" src="/publish/ma/js/board.js"></script>
<script type="text/javascript" src="/resource/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var bCheckedId=false
var oldInputId=""
$(document).ready(function(){	
	if('${message}'){
		alert('${message}')
		return false
	}
	$("#btn_submit").bind("click", function(){
		
		if($("#id").val() == "" || $("#id").val() == null) {
			alert("아이디를 입력해주세요");
			$("#id").focus();
			return false;
		}
			
		if(!$("#pwd").val().trim()) {
			alert("비밀번호를 입력해주세요");
			return false;
		}
		if($("#pwd").val()!=$("#repwd").val()) {
			alert("비밀번호와 비밀번호 확인이 다릅니다");
			return false;
		}
		if(!bCheckedId || oldInputId!=$("#id").val()){
			alert("아이디를 확인해주세요")
			return false
		}
		
		fncPageBoard('write','registerProc.do');
		return false;
	});
	
	$("#btnCheckId").on("click",function(){
		if(!$("#id").val().trim()){
			alert("아이디를 입력해주세요")
			return false
		}
		$.ajax({
			url:'checkId.json'
			,data:{"id":$("#id").val()}
			,method:"POST"
			,success:function(data){
				if(data.success==true){
					alert("사용 가능한 아이디 입니다")
					bCheckedId=true
					oldInputId=$("#id").val()
				}
				else{
					alert("이미 사용중인 아이디 입니다")
					bCheckedId=false
				}
			}
		})
		return false
	})
});
</script>
<div class="content_box">
	<form:form commandName="loginVO" name="defaultFrm" id="defaultFrm" method="post">
		<form:hidden path="seq" id="seq"/>
		<form:hidden path="pageIndex" id="pageIndex"/> 
		<form:hidden path="atchFileId" id="atchFileId"/>
		<jsp:directive.include file="/WEB-INF/jsp/cmmn/inc/incSearchForm.jsp"/>
		<div class="tbl_wrap">
			<table class="tbl_row_type01"> 
				<caption>내용(제목, 작성자, 작성일 등으로 구성)</caption>
				<colgroup>
					<col style="width:20%;">
					<col style="width:30%;">
					<col style="width:20%;">
					<col style="width:30%;">
				</colgroup> 
				<tbody>
					<tr>
						<th scope="row"><strong class="th_tit">아이디</strong></th>
						<td colspan="3">
							<input type="text" name="id" id="id" class="text w100p"  required="required"  maxlength="16" />
						</td>
						<td>
							<a href="#" class="btn btn_middle btn_purple" id="btnCheckId">아이디 확인</a>
						</td>
					</tr>
					<tr>
						<th scope="row"><strong class="th_tit">비밀번호</strong></th>
						<td colspan="4">
							<input type="password" name="pwd" id="pwd" class="text w40p"  required="required"  maxlength="20" />
						</td>
					</tr>
					<tr>
						<th scope="row"><strong class="th_tit">비밀번호 확인</strong></th>
						<td colspan="4">
							<input type="password" id="repwd" class="text w40p"  required="required"  maxlength="20" />
						</td>
					</tr>
					<tr>
						<th scope="row"><strong class="">이름</strong></th>
						<td colspan="4">
							<input type="text" name="name" id="name" class="text w100p"  required="required"  maxlength="16" />
						</td>
					</tr>
					<tr>
						<th scope="row"><strong>연락처</strong></th>
						<td colspan="4">
							<input type="number" name="hp" id="hp" class="text w100p" maxlength="16" value="${loginVO.hp}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><strong>이메일</strong></th>
						<td colspan="4">
							<input type="email" name="email" id="email" class="text w30p" maxlength="16" value="${loginVO.email}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><strong class="">주소</strong></th>
						<td colspan="4">
							<input type="text" name="addr" id="addr" class="text w50p"  required="required"  maxlength="16" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="tbl_btns c">
			<a href="#" class="btn btn_middle btn_purple" id="btn_submit">회원가입</a>
		</div>
	</form:form>
</div>