<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
String email = session.getAttribute("email").toString();
String securtiyQuestion = request.getParameter("securtiyQuestion");
String newAnswer = request.getParameter("newAnswer");
String password = request.getParameter("password");
int check=0;
try{
	Connection con = ConnectionProvider.getCon();
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select *from users where email='"+email+"' and password='"+password+"' ");
	while(rs.next()){
		check=1;
		st.executeUpdate("update users set securityQuestion='"+securtiyQuestion+"', answer='"+newAnswer+"', password='"+password+"' where email='"+email+"' ");
		response.sendRedirect("changeSecurityQuestion.jsp?msg=done");
	}
	if(check==0) response.sendRedirect("changeSecurityQuestion.jsp?msg=wrong");
}catch(Exception e){
		System.out.println(e);
}
%>