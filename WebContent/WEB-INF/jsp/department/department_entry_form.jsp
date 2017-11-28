<%@ page import="helpers.ValidationHelper" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% if (ValidationHelper.isNotNull(session.getAttribute("loggedIn"))
	   && ((Boolean)session.getAttribute("loggedIn")) == true) { %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%! String title = "Department Entry"; %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css"/>
<title><%= title %></title>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/header.jsp" />
	<div class="container">
	
	<h1>Department Entry</h1>
	
	<form action="department_entry" method="POST" name="departmentForm" id="depForm">
	Department Name: <input type="text" name="departmentName" value="${validDepartmentName}"/><br>
	<div class="errorMsg">${errorMessage}</div>	<br>
	Department Location/Floor: <input type="text" name="locationName" value="${validLocation}"/><br>
	<div class="errorMsg">${errorMessage2}</div><br>
	
	<%
		String message = (String)request.getAttribute("confirmMessage"); 
		if(message != null){
	%>
	<!-- Modal from https://www.w3schools.com/howto/howto_css_modals.asp -->
		<div id="dialogBox" class ="dialog">
			<div class="dialogContent">
				<div class="dialogHeader">
					<span class="close">&times;</span>
					<h3>New Department Added</h3>
				</div>
				<div class="dialogBody">
					<p>${confirmMessage}</p>
				</div>
			</div>
		</div>
	<%
		}
	%>
	
	<script>
		dialog = document.getElementById("dialogBox");
		var span = document.getElementsByClassName("close")[0];
		
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		    dialog.style.display = "none";
		}
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		    if (event.target == modal) {
		        dialog.style.display = "none";
		    }
		}
	</script>
	
	<input type="submit" value="Submit">
	<input type="reset"  value="Cancel">
	</form>
	
	</div>
</body>
</html>
<% } else { 
	   response.sendRedirect(request.getContextPath() + "/login");
   }
%>