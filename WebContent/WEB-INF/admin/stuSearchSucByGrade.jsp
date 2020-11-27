<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>成绩分析管理系统</title>
    <link href="css/ui-lightness/jquery-ui-1.10.4.custom.css"
	rel="stylesheet">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui-1.10.4.custom.js"></script>
<script type="text/javascript">
	function searchBtn(){
		var $searchBtn = $("input[name=searchBtn]");
		$searchBtn.bind("click", function(){
		$.ajax(
			{
				type:"get",
				url:"stuSearchGradeTest.action",
				data:{
					gradeID:$("select[name=gradeID]").val()
				},
				dataType:"json",
				success :  login_Result,
				error : function() {
					alert("系统异常，请稍后重试！");
				}
			}
			 
			);
			function login_Result(data){
			  var d = eval("("+data+")");
			    if(d.flag == 0)
			    {
			    	alert("该班级目前还没有任何学生！");
			    	window.location.href="stuSearchByGrade.action";
			    	return;
			    }
			    else{
			    	$("#myForm").submit();
			    }
			};
		});
	}

	$(function(){
		$("#accordion").accordion();
		searchBtn();
		
	});
</script>
<style type="text/css">
body {
	font: 72.5% "Trebuchet MS", sans-serif;
	margin: 50px;
	background-color:#7ecef4;
}
.datalist{
	border:1px solid #0058a3;	/* 表格边框 */
	font-family:Arial;
	border-collapse:collapse;	/* 边框重叠 */
	background-color:#eaf5ff;	/* 表格背景色 */
	font-size:14px;
}
.datalist caption{
	padding-bottom:5px;
	font:bold 1.4em;
	text-align:left;
}
.datalist th{
	border:1px solid #0058a3;	/* 行名称边框 */
	background-color:#4bacff;	/* 行名称背景色 */
	color:#FFFFFF;				/* 行名称颜色 */
	font-weight:bold;
	padding-top:4px; padding-bottom:4px;
	padding-left:12px; padding-right:12px;
	text-align:center;
}
.datalist td{
	border:1px solid #0058a3;	/* 单元格边框 */
	text-align:center;
	padding-top:4px; padding-bottom:4px;
	padding-left:10px; padding-right:10px;
}
.datalist tr.altrow{
	background-color:#c7e5ff;	/* 隔行变色 */
}
a:link{
	text-decoration:none;
}
</style>
  </head>
  
  <body>
  <div>
  	<jsp:include page="stuServiceNavigation.jsp"></jsp:include>
  </div>
  	<div	id="accordion">
  		<h3>学生管理&nbsp;&gt;&nbsp;班级信息查询</h3>
  		<div align="center">
  			<form action="stuSearchSucByGrade.action" method="get" id="myForm">
  				<strong>请选择<span style="color:red">班级</span>：</strong>
  				<select name="gradeID">
  					<s:iterator value="grades">
  						<option value='<s:property value="bianHao" />' <s:if test="bianHao == gradeID">selected="selected"</s:if>  > <s:property value="year" />届（<s:property value="classID" />）班 </option>
  					</s:iterator>
  				</select>
  				&nbsp;&nbsp;&nbsp;<input type="button" name="searchBtn" value="查询"  />
  			</form>
  			<hr>
  			<table cellspacing="0" cellpadding="8" class="datalist" >  
    <tr>  
       <th>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</th>  
       <th>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</th>
       <th>班&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;级</th> 
       <th>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>  
       <th>身份证号</th>
       <th>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族</th>
       <th>政治面貌</th>
       <th>入学时间</th>
             
       <th>操作</th>
    </tr>  
    <s:iterator value="simpleStudents" status="st">  
       <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';" <s:if test="#st.odd">class="altrow"</s:if> >  
          <td><s:property value="xuehao"/></td>  
          <td><s:property value="name"/></td>  
          <td><s:property value="className"/></td>
          <td><s:property value="sex"/></td>  
          <td><s:property value="idCard"/></td>        
          <td><s:property value="nation"/></td>  
          <td><s:property value="polStat"/></td>  
          <td><s:property value="schoolTime"/></td> 
          <td><a href="stuModify.action?xuehao=<s:property value="xuehao"/>"><input type="button" value="修改" /></a>&nbsp;&nbsp;<a href="stuSeeing.action?xuehao=<s:property value="xuehao"/>"><input type="button" value="查看" /></a>&nbsp;&nbsp;<a href='stuDelete.action?xuehao=<s:property value="xuehao"/>' onclick="return confirm('确定删除吗，将会删除该学生所有的成绩记录？');"><input type="button" value="删除" /></a></td>
       </tr>
    </s:iterator> 
    </table>
  		</div>
  	</div>
  </body>
</html>
