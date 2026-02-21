<%@ page import="java.sql.*" %>
<%
String name=request.getParameter("name");
String email=request.getParameter("email");

if(name==null || email==null || name.trim().equals("") || email.trim().equals("")){
    out.println("<script>alert('Name and Email are required');window.history.back();</script>");
} else {
    Connection conn=null;
    PreparedStatement pst=null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/lotuswave","root","12345678");

        String sql="INSERT INTO subscriptions(name,email) VALUES(?,?)";
        pst=conn.prepareStatement(sql);
        pst.setString(1,name);
        pst.setString(2,email);
        int i=pst.executeUpdate();
        if(i>0){
%>
<script>alert('Thank you for subscribing!');window.location='index.html';</script>
<%
        } else {
%>
<script>alert('Subscription failed');window.history.back();</script>
<%
        }
    }catch(Exception e){
        out.println("Error: "+e.getMessage());
    }finally{
        if(pst!=null)pst.close();
        if(conn!=null)conn.close();
    }
}
%>
