<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.NewsComment" %>
<%@ page import="com.chengxusheji.po.News" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<NewsComment> newsCommentList = (List<NewsComment>)request.getAttribute("newsCommentList");
    //获取所有的newsObj信息
    List<News> newsList = (List<News>)request.getAttribute("newsList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    News newsObj = (News)request.getAttribute("newsObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>新闻评论查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#newsCommentListPanel" aria-controls="newsCommentListPanel" role="tab" data-toggle="tab">新闻评论列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>NewsComment/newsComment_frontAdd.jsp" style="display:none;">添加新闻评论</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="newsCommentListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>评论id</td><td>被评新闻</td><td>评论人</td><td>评论内容</td><td>评论时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<newsCommentList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		NewsComment newsComment = newsCommentList.get(i); //获取到新闻评论对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=newsComment.getCommentId() %></td>
 											<td><%=newsComment.getNewsObj().getNewsTitle() %></td>
 											<td><%=newsComment.getUserObj().getName() %></td>
 											<td><%=newsComment.getContent() %></td>
 											<td><%=newsComment.getCommentTime() %></td>
 											<td>
 												<a href="<%=basePath  %>NewsComment/<%=newsComment.getCommentId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="newsCommentEdit('<%=newsComment.getCommentId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="newsCommentDelete('<%=newsComment.getCommentId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>新闻评论查询</h1>
		</div>
		<form name="newsCommentQueryForm" id="newsCommentQueryForm" action="<%=basePath %>NewsComment/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="newsObj_newsId">被评新闻：</label>
                <select id="newsObj_newsId" name="newsObj.newsId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(News newsTemp:newsList) {
	 					String selected = "";
 					if(newsObj!=null && newsObj.getNewsId()!=null && newsObj.getNewsId().intValue()==newsTemp.getNewsId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=newsTemp.getNewsId() %>" <%=selected %>><%=newsTemp.getNewsTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">评论人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="newsCommentEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;新闻评论信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="newsCommentEditForm" id="newsCommentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="newsComment_commentId_edit" class="col-md-3 text-right">评论id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="newsComment_commentId_edit" name="newsComment.commentId" class="form-control" placeholder="请输入评论id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="newsComment_newsObj_newsId_edit" class="col-md-3 text-right">被评新闻:</label>
		  	 <div class="col-md-9">
			    <select id="newsComment_newsObj_newsId_edit" name="newsComment.newsObj.newsId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsComment_userObj_user_name_edit" class="col-md-3 text-right">评论人:</label>
		  	 <div class="col-md-9">
			    <select id="newsComment_userObj_user_name_edit" name="newsComment.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsComment_content_edit" class="col-md-3 text-right">评论内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="newsComment_content_edit" name="newsComment.content" class="form-control" placeholder="请输入评论内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="newsComment_commentTime_edit" class="col-md-3 text-right">评论时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="newsComment_commentTime_edit" name="newsComment.commentTime" class="form-control" placeholder="请输入评论时间">
			 </div>
		  </div>
		</form> 
	    <style>#newsCommentEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxNewsCommentModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.newsCommentQueryForm.currentPage.value = currentPage;
    document.newsCommentQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.newsCommentQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.newsCommentQueryForm.currentPage.value = pageValue;
    documentnewsCommentQueryForm.submit();
}

/*弹出修改新闻评论界面并初始化数据*/
function newsCommentEdit(commentId) {
	$.ajax({
		url :  basePath + "NewsComment/" + commentId + "/update",
		type : "get",
		dataType: "json",
		success : function (newsComment, response, status) {
			if (newsComment) {
				$("#newsComment_commentId_edit").val(newsComment.commentId);
				$.ajax({
					url: basePath + "News/listAll",
					type: "get",
					success: function(newss,response,status) { 
						$("#newsComment_newsObj_newsId_edit").empty();
						var html="";
		        		$(newss).each(function(i,news){
		        			html += "<option value='" + news.newsId + "'>" + news.newsTitle + "</option>";
		        		});
		        		$("#newsComment_newsObj_newsId_edit").html(html);
		        		$("#newsComment_newsObj_newsId_edit").val(newsComment.newsObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#newsComment_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#newsComment_userObj_user_name_edit").html(html);
		        		$("#newsComment_userObj_user_name_edit").val(newsComment.userObjPri);
					}
				});
				$("#newsComment_content_edit").val(newsComment.content);
				$("#newsComment_commentTime_edit").val(newsComment.commentTime);
				$('#newsCommentEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除新闻评论信息*/
function newsCommentDelete(commentId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "NewsComment/deletes",
			data : {
				commentIds : commentId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#newsCommentQueryForm").submit();
					//location.href= basePath + "NewsComment/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交新闻评论信息表单给服务器端修改*/
function ajaxNewsCommentModify() {
	$.ajax({
		url :  basePath + "NewsComment/" + $("#newsComment_commentId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#newsCommentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#newsCommentQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

})
</script>
</body>
</html>

