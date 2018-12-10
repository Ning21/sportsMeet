<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="itheima" uri="http://itheima.com/common/" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() 
	                   + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>田径运动会管理系统</title>
	<!-- 引入css样式文件 -->
	<!-- Bootstrap Core CSS -->
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" />
	<!-- MetisMenu CSS -->
	<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet" />
	<!-- DataTables CSS -->
	<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet" />
	<!-- Custom CSS -->
	<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet" />
	<!-- Custom Fonts -->
	<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="wrapper">
  <!-- 导航栏部分 -->
  <nav class="navbar navbar-default navbar-static-top" role="navigation"
		 style="margin-bottom: 0">
	<div class="navbar-header">
		<a class="navbar-brand" href="<%=basePath%>/sportslist">田径运动会管理系统</a>
	</div>
	<!-- 导航栏右侧图标部分 -->
	<ul class="nav navbar-top-links navbar-right">
		<!-- 用户信息和系统设置 start -->
		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#"> 
				<i class="fa fa-user fa-fw"></i>
				<i class="fa fa-caret-down"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#"><i class="fa fa-user fa-fw"></i>
				               用户：${user.userName}
				    </a>
				</li>
				<li class="divider"></li>
				<li>
					<a href="${pageContext.request.contextPath }/logout">
					<i class="fa fa-sign-out fa-fw"></i>退出登录
					</a>
				</li>
			</ul> 
		</li>
		<!-- 用户信息和系统设置结束 -->
	</ul>
	  <!-- 左侧显示列表部分 start-->
	<div class="navbar-default sidebar" role="navigation">
		<div class="sidebar-nav navbar-collapse">
			<ul class="nav" id="side-menu">
				<li class="sidebar-search">
					<div class="input-group custom-search-form">
					</div>
				</li>
				<li>
					<a href="/jsp/tiansai.jsp">
						<i class="fa fa-dashboard fa-fw" ></i> 田赛
					</a>
				</li>
				<li>
					<a href="/jsp/jingsai.jsp">
						<i class="fa fa-dashboard fa-fw" ></i> 径赛
					</a>
				</li>
			</ul>
		</div>
	</div>
	<!-- 左侧显示列表部分 end--> 
  </nav>
    <!-- 比赛项目查询部分  start-->
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">比赛项目管理</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" method="post"
				      action="${pageContext.request.contextPath }/sportslist">
					<div class="form-group">
						<label for="spo_name">项目名称</label>
						<select	class="form-control" id="spo_name" name="spo_name">
							<option value="">--请选择--</option>
							<!--将所有项目名称查出来，放在session中-->
							<c:forEach items="${sessionScope.nameType}" var="item">
								<option value="${item}">
										${item }
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="spo_property">项目性质</label>
						<select	class="form-control" id="spo_property" name="spo_property">
							<option value="">--请选择--</option>
							<option value="计时">计时</option>
							<option value="高度">高度</option>
							<option value="远度">远度</option>
							<option value="数量">数量</option>
						</select>
					</div>
					<div class="form-group">
						<label for="spo_type">所属类别</label>
						<select	class="form-control" id="spo_type"  name="spo_type">
							<option value="">--请选择--</option>
							<option value="田赛">田赛</option>
							<option value="径赛">径赛</option>
							<option value="接力赛">接力赛</option>
						</select>
					</div>
					<div class="form-group">
						<label for="gender">项目性别</label>
						<select	class="form-control" id="gender" name="gender">
							<option value="">--请选择--</option>
							<option value="女">女</option>
							<option value="男">男</option>
							<option value="男女">男女</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary">查询</button>
				</form>
			</div>
		</div>
		<a href="#" class="btn btn-primary" data-toggle="modal" 
		           data-target="#newCustomerDialog" onclick="clearSports()">新建</a>
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">比赛项目信息列表</div>
					<!-- /.panel-heading -->
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>编号</th>
								<th>比赛名称</th>
								<th>项目性质</th>
								<th>项目性别</th>
								<th>所属类别</th>
								<th>成绩格式</th>
								<th>成绩排序</th>
								<th>比赛场地</th>
								<th>开始时间</th>
								<th>比赛次数</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.rows}" var="row">
								<tr>
									<td>${row.spo_id}</td>
									<td>${row.spo_name}</td>
									<td>${row.spo_property}</td>
									<td>${row.gender}</td>
									<td>${row.spo_type}</td>
									<td>${row.scoreUnit}</td>
								    <td>${row.sort}</td>
									<td>${row.place}</td>
									<td>${row.startTime}</td>
									<td>${row.takenum}</td>
									<td>
										<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#customerEditDialog" onclick= "editSports(${row.spo_id})">修改</a>
										<a href="#" class="btn btn-danger btn-xs" onclick="deleteSports(${row.spo_id})">删除</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-md-12 text-right">
						<itheima:page url="${pageContext.request.contextPath }/sportslist" />
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	</div>
	<!-- 比赛项目查询部分  end-->
</div>
<!-- 创建客户模态框 -->
<div class="modal fade" id="newCustomerDialog" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">新建比赛项目信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="new_sports_form">
					<div class="form-group">
						<label for="new_name" class="col-sm-2 control-label">
						    项目名称
						</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_name" placeholder="项目名称" name="cust_name" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_property" style="float:left;padding:7px 15px 0 27px;">项目性质</label>
						<div class="col-sm-10">
							<select	class="form-control" id="new_property" name="cust_property">
								<option value="">--请选择--</option>
								<option value="">计时</option>
								<option value="米">高度</option>
								<option value="分秒">远度</option>
								<option value="个">数量</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="new_gender" style="float:left;padding:7px 15px 0 27px;">项目性别</label>
						<div class="col-sm-10"> 
							<select	class="form-control" id="new_gender"  name="cust_gender">
								<option value="">--请选择--</option>
								<option value="女">女</option>
								<option value="男">男</option>
								<option value="男女">男女</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="new_type" style="float:left;padding:7px 15px 0 27px;">项目类别</label>
						<div class="col-sm-10">
							<select	class="form-control" id="new_type" name="cust_type">
								<option value="">--请选择--</option>
								<option value="田赛">田赛</option>
								<option value="径赛">径赛</option>
								<option value="接力赛">接力赛</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="new_scoreUnit" class="col-sm-2 control-label">成绩格式</label>
						<div class="col-sm-10">
							<select	class="form-control" id="new_scoreUnit" name="cust_scoreUnit">
								<option value="">--请选择--</option>
								<option value="米">米</option>
								<option value="分秒">分秒</option>
								<option value="个">个</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="new_sort" class="col-sm-2 control-label">成绩排序</label>
						<div class="col-sm-10">
							<select	class="form-control" id="new_sort" name="cust_sort">
								<option value="">--请选择--</option>
								<option value="升序">升序</option>
								<option value="降序">降序</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="new_place" class="col-sm-2 control-label">比赛地点</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_place" placeholder="比赛地点" name="cust_place" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_startTime" class="col-sm-2 control-label">开始时间</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_startTime" placeholder="开始时间" name="cust_startTime" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_endTime" class="col-sm-2 control-label">结束时间</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_endTime" placeholder="结束时间" name="cust_endTime" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_takenum" class="col-sm-2 control-label">比赛次数</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_takenum" placeholder="比赛次数" name="cust_takenum" />
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="createSports()">创建</button>
			</div>
		</div>
	</div>
</div>
<!-- 修改比赛项目信息模态框 -->
<div class="modal fade" id="customerEditDialog" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">修改比赛项目信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="edit_sports_form">
					<input type="hidden" id="edit_id" name="cust_id"/>
					<div class="form-group">
						<label for="edit_name" class="col-sm-2 control-label">项目名称</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_name" placeholder="项目名称" name="cust_name" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_property" style="float:left;padding:7px 15px 0 27px;">项目性质</label>
						<div class="col-sm-10">
							<select	class="form-control" id="edit_property" name="cust_property">
								<option value="">--请选择--</option>
								<option value="计时">计时</option>
								<option value="高度">高度</option>
								<option value="远度">远度</option>
								<option value="数量">数量</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="edit_gender" style="float:left;padding:7px 15px 0 27px;">项目性别</label>
						<div class="col-sm-10"> 
							<select	class="form-control" id="edit_gender"  name="cust_gender">
								<option value="">--请选择--</option>
								<option value="女">女</option>
								<option value="男">男</option>
								<option value="男女">男女</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="edit_type" style="float:left;padding:7px 15px 0 27px;">项目类别</label>
						<div class="col-sm-10">
							<select	class="form-control" id="edit_type" name="cust_type">
								<option value="">--请选择--</option>
								<option value="田赛">田赛</option>
								<option value="径赛">径赛</option>
								<option value="接力赛">接力赛</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="edit_scoreUnit" class="col-sm-2 control-label">成绩格式</label>
						<div class="col-sm-10">
							<select	class="form-control" id="edit_scoreUnit" name="cust_scoreUnit">
								<option value="">--请选择--</option>
								<option value="米">米</option>
								<option value="分秒">分秒</option>
								<option value="个">个</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="edit_sort" class="col-sm-2 control-label">成绩排序</label>
						<div class="col-sm-10">
							<select	class="form-control" id="edit_sort" name="cust_sort">
								<option value="">--请选择--</option>
								<option value="升序">升序</option>
								<option value="降序">降序</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="edit_place" class="col-sm-2 control-label">比赛地点</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_place" placeholder="比赛地点" name="cust_place" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_startTime" class="col-sm-2 control-label">开始时间</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_startTime" placeholder="开始时间" name="cust_startTime" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_endTime" class="col-sm-2 control-label">结束时间</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_endTime" placeholder="结束时间" name="cust_endTime" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_takenum" class="col-sm-2 control-label">比赛次数</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_takenum" placeholder="比赛次数" name="cust_takenum" />
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="updateSports()">保存修改</button>
			</div>
		</div>
	</div>
</div>
<!-- 引入js文件 -->
<!-- jQuery -->
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="<%=basePath%>js/metisMenu.min.js"></script>
<!-- DataTables JavaScript -->
<script src="<%=basePath%>js/jquery.dataTables.min.js"></script>
<script src="<%=basePath%>js/dataTables.bootstrap.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="<%=basePath%>js/sb-admin-2.js"></script>
<!-- 编写js代码 -->
<script type="text/javascript">
    //清空新建客户窗口中的数据
    function clearSports() {
        $("#new_name").val("");
        $("#new_property").val("")
        $("#new_gender").val("")
        $("#new_type").val("")
        $("#new_scoreUnit").val("");
        $("#new_sort").val("");
        $("#new_place").val("");
        $("#new_startTime").val("");
        $("#new_endTime").val("");
        $("#new_takenum").val("");
    }
    // 创建客户

    function createSports() {
        $.post("<%=basePath%>/createSports",
            $("#new_sports_form").serialize(),function(data){
                if(data =="OK"){
                    alert("新的比赛项目创建成功！");
                    window.location.reload();
                }else{
                    alert("创建失败！");
                    window.location.reload();
                }
            });
    }
    // 通过id获取修改的比赛项目信息
    function editSports(id) {
        /*debugger
        alert(id);*/
        $.ajax({
            type:"get",
            url:"<%=basePath%>/getSportsById",
            data:{"id":id},
            success:function(data) {
                $("#edit_name").val(data.spo_name);
                $("#edit_property").val(data.spo_property)
                $("#edit_gender").val(data.gender)
                $("#edit_type").val(data.spo_type)
                $("#edit_scoreUnit").val(data.scoreUnit);
                $("#edit_sort").val(data.sort);
                $("#edit_place").val(data.place);
                $("#edit_startTime").val(data.startTime);
                $("#edit_endTime").val(data.endTime);
                $("#edit_takenum").val(data.takenum);
            }
        });
    }
    // 执行修改比赛项目信息操作
    function updateSports() {
        $.post("<%=basePath%>/updateSports",$("#edit_sports_form").serialize(),function(data){
            if(data =="OK"){
                alert("信息更新成功！");
                window.location.reload();
            }else{
                alert("信息更新失败！");
                window.location.reload();
            }
        });
    }
    // 删除某一比赛项目
    function deleteSports(id) {
        if(confirm('确实要删除该比赛项目吗?')) {
            $.post("<%=basePath%>/deleteSports",{"id":id},
                function(data){
                    if(data =="OK"){
                        alert("删除成功！");
                        window.location.reload();
                    }else{
                        alert("删除失败！");
                        window.location.reload();
                    }
                });
        }
    }
</script>
</body>
</html>