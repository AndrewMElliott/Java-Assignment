<%@ page import="helpers.ValidationHelper"%>
<%@ page import="utilities.DatabaseAccess"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import ="java.util.Map" %>
<%@ page import ="java.util.LinkedHashMap" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="objects.Employee" %>

<% if (ValidationHelper.isNotNull(session.getAttribute("loggedIn"))
	   && ((Boolean)session.getAttribute("loggedIn")) == true) { %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%! String title = "Attendance Entry"; %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%= title %></title>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp" />
	<div id="group-div" class="centered container">
	<%
		Integer depID = 0;
		Map<String, String> departments = new LinkedHashMap<>();
		if(request.getAttribute("departments") != null){
			departments = (Map<String, String>)request.getAttribute("departments");
		}
		if(request.getAttribute("depID") != null){
			depID = (Integer)request.getAttribute("depID");
		}
	%>
	
	<h1 class="text-align-center">Attendance Entry</h1>
		<form action="attendance_entry" method="POST" name="departmentS" id="dSelect">
		<input type="hidden" name="formselect" value="selectDepartment">
		<select name="department">
			<option selected disabled hidden>Select Department</option>
				<%for(Map.Entry<String,String> entry : departments.entrySet()){%>
			<option value="<%=entry.getKey()%>"><%=entry.getValue() %></option>
			<%} %>
		</select>
		<br><div class="errorMsg">${errorMessage}</div><br>
		<input type="submit" value="Search">
		
		<hr>
		</form>
		
		<form action="attendance_entry" method="POST" name="attendance">
		<input type="hidden" name="formselect" value="enterAttendance">
		<input type="hidden" name="departmentID" value="<%=depID%>">
		<span>Date:</span><input type="date" name="reportDate" >
		<div class="overflow">
			<table>
			<tr>
			    <th>Lastname</th>
			    <th>Firstname</th>
			    <th>Employee #</th>
			    <th>Present</th>
			 </tr>
			 
			 	<%
					ArrayList<Employee> eList = (ArrayList<Employee>)request.getAttribute("employeeL");
					if(request.getAttribute("employeeL")!=null){
						for (Employee e : eList){
							%>
							<tr>
								<td><%=e.getlName() %></td>
								<td><%=e.getfName() %></td>
								<td><%=e.getEmployeeNum() %></td>
								<td><input type="checkbox" name="present" value="<%=e.geteId()%>"></td>
							</tr>
							<%
						}
						
					};
				%>
			</table>
			<br><br><input type="submit" value="Submit">
		</div>
		</form>
		
</div>
</body>
</html>
<% } else { 
	   response.sendRedirect(request.getContextPath() + "/login");
   }
%>