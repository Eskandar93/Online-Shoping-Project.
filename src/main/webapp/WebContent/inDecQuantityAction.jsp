<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
String email = session.getAttribute("email").toString();
String id = request.getParameter("id");
String incdec = request.getParameter("quantity");
int quantity=0, price =0 ,total=0, final_total=0;
try{
	Connection con = ConnectionProvider.getCon();
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select *from cart where email='"+email+"' and product_id = '"+id+"' and address is NULL ");
	while(rs.next()){
		quantity = rs.getInt(3);
		price = rs.getInt(4);
		total = rs.getInt(5);
	}
	System.out.println(quantity+" "+price+" "+total);
	if(quantity==1 && incdec.equals("dec"))
		response.sendRedirect("myCart.jsp?msg=notPossible");
	else if (quantity!=1 && incdec.equals("dec")){
		quantity -=1;
		total -= price;
		st.executeUpdate("update cart set quantity='"+quantity+"', total ='"+total+"' where email='"+email+"' and product_id='"+id+"' and address is NULL ");
		response.sendRedirect("myCart.jsp?msg=decrement");
	}
	else {
		quantity +=1;
		total +=price;
		st.executeUpdate("update cart set quantity='"+quantity+"', total='"+total+"' where email='"+email+"' and product_id='"+id+"' and address is NULL ");
		response.sendRedirect("myCart.jsp?msg=increment");
	}
}catch(Exception e){
	System.out.println(e);
}
%>