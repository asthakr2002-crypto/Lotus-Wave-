<%@ page import="java.sql.*" %>
<%
Connection conn = null;
Statement st = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/lotuswave","root","12345678");
    st = conn.createStatement();
    rs = st.executeQuery("SELECT * FROM subscriptions ORDER BY subscribed_at DESC");
%>
<html>
<head>
<title>LotusWave Subscribers</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<style>
body {
    background: linear-gradient(135deg,#6a11cb,#2575fc);
    font-family: Arial, sans-serif;
    padding:40px;
}
.container {
    background:#fff;
    border-radius:15px;
    padding:30px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}
h2 {
    text-align:center;
    margin-bottom:20px;
    color:#333;
}
table {
    width:100%;
}
th {
    background:#6a11cb;
    color:#fff;
    padding:10px;
    text-align:center;
}
td {
    padding:10px;
    text-align:center;
    border-bottom:1px solid #ddd;
}
.action-btn {
    padding: 5px 10px;
    font-size: 14px;
}
</style>
</head>
<body>
<div class="container">
    <h2>LotusWave Subscribers</h2>
    <table class="table table-bordered">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Subscribed At</th>
            <th>Actions</th>
        </tr>
        <%
            boolean hasRows = false;
            while(rs.next()){
                hasRows = true;
                int id = rs.getInt("id");
        %>
        <tr>
            <td><%=id%></td>
            <td><%=rs.getString("name")%></td>
            <td><%=rs.getString("email")%></td>
            <td><%=rs.getTimestamp("subscribed_at")%></td>
            <td>
                <a href="edit_subscriber.jsp?id=<%=id%>" class="btn btn-warning btn-sm action-btn">Edit</a>
                <a href="delete_subscriber.jsp?id=<%=id%>" class="btn btn-danger btn-sm action-btn" 
                   onclick="return confirm('Are you sure you want to delete this subscriber?');">Delete</a>
            </td>
        </tr>
        <%
            }
            if(!hasRows){
        %>
        <tr>
            <td colspan="5">No subscribers yet.</td>
        </tr>
        <%
            }
        %>
    </table>
</div>
</body>
</html>
<%
} catch(Exception e){
    out.println("<p style='color:red'>Error: "+e.getMessage()+"</p>");
} finally {
    try { if(rs!=null) rs.close(); } catch(Exception e){}
    try { if(st!=null) st.close(); } catch(Exception e){}
    try { if(conn!=null) conn.close(); } catch(Exception e){}
}
%>
