<%@page import="com.fastfood.DbConnect"%>
<%@page import="java.sql.*"%>
<%
	String username = session.getAttribute("username").toString();
	String oldpassword = request.getParameter("oldpassword");
	String newpassword = request.getParameter("newpassword");
	String confirmpassword = request.getParameter("confirmpassword");

	if (!confirmpassword.equals(newpassword))
		response.sendRedirect("changePassword.jsp?msg=notMatch");
	else {
		int check = 0;
		try {
			Connection con = DbConnect.Connect();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(
					"select * from users where username='" + username + "' and password='" + oldpassword + "'");
			while (rs.next()) {
				check = 1;
				st.executeUpdate("update users set password='" + newpassword + "' where username='" + username + "'");
				response.sendRedirect("changePassword.jsp?msg=done");
			}
			if (check == 0)
				response.sendRedirect("changePassword.jsp?msg=wrong");
		} catch (Exception e) {
			System.out.println(e);
		}
	}
%>