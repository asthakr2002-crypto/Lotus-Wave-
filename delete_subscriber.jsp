<%@ page import="java.sql.*" %>
<%
int id = Integer.parseInt(request.getParameter("id"));

Connection conn=null;
PreparedStatement ps=null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lotuswave","root","12345678");
    ps = conn.prepareStatement("DELETE FROM subscriptions WHERE id=?");
    ps.setInt(1,id);
    int i=ps.executeUpdate();
    if(i>0){
        response.sendRedirect("view_subscriptions.jsp");
    } else {
        out.println("Delete failed.");
    }
} catch(Exception e){
    out.println("Error: "+e.getMessage());
} finally {
    if(ps!=null) ps.close();
    if(conn!=null) conn.close();
}
%>
