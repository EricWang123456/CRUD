<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- 新增按钮弹窗 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增员工信息</h4>
	      </div>
	      <div class="modal-body">
	      	<form class="form-horizontal">
				  <div class="form-group">
				    <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
				    <div class="col-sm-8">
				    	<input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="Steve Jobs">
				    	<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
				    <div class="col-sm-8">
				    	<input type="text" name="email" class="form-control" id="email_add_input" placeholder="example@icloud.com">
				    	<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">性别</label>
				    <div class="col-sm-10">
					<label class="radio-inline">
						<input type="radio" name="gender" id="gender_add_male" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
						<input type="radio" name="gender" id="gender_add_female" value="F"> 女
					</label>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">部门</label>
				    <div class="col-sm-6">
				    	<!-- 部门提交部门id就行 -->
						<select class="form-control" name="dId" id="dept_add_select">
							
						</select>
				    </div>
				  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	      <!-- 编辑按钮 -->
	      <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" >编辑员工信息</h4>
			      </div>
			      <div class="modal-body">
			      	<form class="form-horizontal">
						  <div class="form-group">
						    <label for="empName_update_input" class="col-sm-2 control-label">员工姓名</label>
						    <div class="col-sm-8">
						    	<input type="text" name="empName" class="form-control" id="empName_update_input" >
						    	<span class="help-block"></span>
						    	<!--  <p class="form-control-static" id="empName_update_static"></p>-->
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="email_update_input" class="col-sm-2 control-label">邮箱</label>
						    <div class="col-sm-8">
						    	<input type="text" name="email" class="form-control" id="email_update_input" placeholder="example@icloud.com">
						    	<span class="help-block"></span>
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="col-sm-2 control-label">性别</label>
						    <div class="col-sm-10">
							<label class="radio-inline">
								<input type="radio" name="gender" id="gender_update_male" value="M" checked="checked"> 男
							</label>
							<label class="radio-inline">
								<input type="radio" name="gender" id="gender_update_female" value="F"> 女
							</label>
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="col-sm-2 control-label">部门</label>
						    <div class="col-sm-6">
						    	<!-- 部门提交部门id就行--> 
								<select class="form-control" name="dId" id="dept_update_select">
									
								</select>
						    </div>
						  </div>
					</form>
	      	</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container">
		<!-- 标题 -->
		<div class="row"></div>
			<div class="col-md-12">
				<h1>欢迎使用员工信息管理系统</h1>
			</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					新增
				</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					删除
				</button>
			</div>
		</div>
		<!-- 信息 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>员工编号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//1.页面加载完成以后,直接发送ajax请求,要到分页数据
		$(function(){
			var TotalRecord,currentPage;//总记录数,当前页码
			//首页
			to_page(1);
		});
		
		function to_page(pn){
			$("#check_all").prop("checked",false);//解决在上一页全选之后,切换页面,全选框打钩而单选框不打钩的情况,干脆一律设置为不选中
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析并显示员工数据
					buind_emps_table(result);
					//2.解析并显示分页信息
					buind_page_info(result);
					//3.解析显示分页条信息
					buind_page_nav(result);
				}
			});
		}
		function buind_emps_table(result){
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn").append($("<span></span>")
								.addClass("glyphicon glyphicon-pencil").append("编辑"));
				editBtn.attr("edit_id",item.empId);
				var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>")
						.addClass("glyphicon glyphicon-trash").append("删除"));
				deleteBtn.attr("del_id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
						.append(empIdTd) 
						.append(empNameTd)
						.append(genderTd)
						.append(emailTd)
						.append(deptNameTd)
						.append(btnTd)
						.appendTo("#emps_table tbody");
			});
		}
		function buind_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录");
			TotalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//解析显示分页条,点击跳转
		function buind_page_nav(result){
			$("#page_nav_area").empty();
			
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false)
			{
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false)
			{
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item)
				{
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo(page_nav_area);
		}
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success")
			$(ele).find(".help-block").text("");
		}
		
		//新增按钮点击事件
		$("#emp_add_modal_btn").click(function(){
			//弹出框表单重置,否则不会刷新ajax请求,则可插入重复数据
			reset_form("#empAddModal form");
			//应在模态框弹出之前先查好部门信息,显示在下拉列表中
			getDepts("#dept_add_select");
			//弹出模态框
			$("#empAddModal").modal({
				//点击不关闭模态框
				backdrop:"static"
			});
		});
		//部门下拉框
		function getDepts(ele){
			//清空下拉列表
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result)
					//$("#dept_add_select")
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_input").val(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		function validate_add_form(){
			//校验姓名
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("姓名格式为2-5位字符或3-16位数字和字母组合");
				show_validate_msg("#empName_add_input","error","姓名格式为2-5位字符或3-16位数字和字母组合");
				return false;
			}
			else{
				show_validate_msg("#empName_add_input","success","");
			}
			//校验email
			var email = $("#email_add_input").val();
			var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确!");
				//应该清空这个元素之前的样式
				show_validate_msg("#email_add_input","error","邮箱格式不正确!");
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确!");
				return false;
			}
			else{
				show_validate_msg("#email_add_input","success","");
				//$("#email_add_input").parent().addClass("has-success");
				//$("#email_add_input").next("span").text("");
			}
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			//在此之前清除当前元素的状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax_va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax_va","error");
					}
				}
			});
		});
		
		$("#emp_save_btn").click(function(){
			//将模态框中的数据提交到服务器进行保存
			//前端校验
			if(!validate_add_form()){
				return false;
			}
			
			if($(this).attr("ajax_va")=="error"){
				alert("员工已存在或不正确的邮箱地址,"+"请仔细核对员工信息!");
				return false;
			}
			
			//发送ajax请求保存员工信息
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),//jquery中的方法
				success:function(result){
					//alert(result.msg);
					//新增成功后应该关闭模态框
					if(result.code ==100){//后端校验
						$("#empAddModal").modal('hide');
						//页码跳转到最后一页
						to_page(TotalRecord); //总记录数always大于总页码数
					}else{
						//显示失败信息
						//console.log(result);
						if(undefined != result.extend.errorFields.email){
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						//alert(result.extend.errorFields.email);
						//alert(result.extend.errorFields.empName);
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
					}
				}
			});
		});
			
		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			getEmp($(this).attr("edit_id"));
			getDepts("#dept_update_select");
			//将员工id传递到更新按钮上
			$("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
			$("#empUpdateModal").modal({
				//点击其他地方不关闭模态框
				backdrop:"static"
			});
		});
		
		$("#emp_update_btn").click(function(){
			//校验员工姓名
			var empName = $("#empName_update_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("姓名格式为2-5位字符或3-16位数字和字母组合");
				show_validate_msg("#empName_update_input","error","姓名格式为2-5位字符或3-16位数字和字母组合");
				return false;
			}
			else{
				show_validate_msg("#empName_update_input","success","");
			}
			
			//校验email
			var email = $("#email_update_input").val();
			var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确!");
				//应该清空这个元素之前的样式
				show_validate_msg("#email_update_input","error","邮箱格式不正确!");
				return false;
			}
			else{
				show_validate_msg("#email_update_input","success","");
			}
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
				type:"PUT",
				//data:$("#empUpdateModal form").serialize()+"&_method=PUT",//序列化
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					$("#empUpdateModal").modal('hide');
					to_page(currentPage);
				}
			});
		});
		$(document).on("click",".delete_btn",function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			//alert("确定要删除"+$(this).parents("tr").find("td:eq(1)").text()+"吗?");
			var empId = $(this).attr("del_id");
			if(confirm("确定删除["+empName+"]这位员工的信息吗?")){
				//确定,发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
		//全选/不全选
		$("#check_all").click(function(){//全选的意思为只选中当前页面的全部员工信息
			//attr拿到的是undefined;
			//使用prop修改和读取dom原生属性的值
			//$(this).prop("checked");
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		//check_item
		$(document).on("click",".check_item",function(){
			//判断当前选中的元素是否等于5个
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
			//alert($(".check_item:checked").length);
		});
		
		$("#emp_delete_all_btn").click(function(){
			//$(".check_item:checked")
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除empNames字符串结尾多余的逗号
			empNames = empNames.substring(0,empNames.length-1);
			//去除员工id字符串结尾多余的横线
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除["+empNames+"]吗?")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>