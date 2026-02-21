<%@ page import="java.sql.*" %>
<%
int id = Integer.parseInt(request.getParameter("id"));
String name = request.getParameter("name");
String email = request.getParameter("email");

Connection conn=null;
PreparedStatement ps=null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lotuswave","root","12345678");
    ps = conn.prepareStatement("UPDATE subscriptions SET name=?, email=? WHERE id=?");
    ps.setString(1,name);
    ps.setString(2,email);
    ps.setInt(3,id);
    int i=ps.executeUpdate();
    if(i>0){
        response.sendRedirect("view_subscriptions.jsp");
    } else {
        out.println("Update failed.");
    }
} catch(Exception e){
    out.println("Error: "+e.getMessage());
} finally {
    if(ps!=null) ps.close();
    if(conn!=null) conn.close();
}
%>
