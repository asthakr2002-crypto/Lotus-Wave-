<%@ page import="java.sql.*" %>
<%
int id = Integer.parseInt(request.getParameter("id"));
Connection conn=null;
PreparedStatement ps=null;
ResultSet rs=null;
String name="", email="";
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lotuswave","root","12345678");
    ps = conn.prepareStatement("SELECT * FROM subscriptions WHERE id=?");
    ps.setInt(1,id);
    rs = ps.executeQuery();
    if(rs.next()){
        name = rs.getString("name");
        email = rs.getString("email");
    }
} catch(Exception e){
    out.println("<p style='color:red'>Error: "+e.getMessage()+"</p>");
} finally {
    try{if(rs!=null) rs.close();}catch(Exception e){}
    try{if(ps!=null) ps.close();}catch(Exception e){}
    try{if(conn!=null) conn.close();}catch(Exception e){}
}
%>
<html>
<head>
    <title>Edit Subscriber</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg,#6a11cb,#2575fc);
            font-family: 'Poppins', sans-serif;
            display:flex;
            justify-content:center;
            align-items:center;
            min-height:100vh;
            padding:20px;
        }
        .card {
            width:100%;
            max-width:500px;
            background:#fff;
            border-radius:15px;
            padding:30px;
            box-shadow:0 8px 20px rgba(0,0,0,0.2);
            animation: fadeIn 0.8s ease-out;
        }
        @keyframes fadeIn {
            from{opacity:0;transform:translateY(-20px);}
            to{opacity:1;transform:translateY(0);}
        }
        .card h2 {
            text-align:center;
            margin-bottom:20px;
            color:#333;
        }
        .form-control:focus {
            border-color:#6a11cb;
            box-shadow:0 0 0 0.2rem rgba(106,17,203,.25);
        }
        .btn-gradient {
            background: linear-gradient(to right, #4a6fc7, #6a11cb);
            color: #fff;
            font-weight:600;
            border:none;
        }
        .btn-gradient:hover {
            background: linear-gradient(to right, #3b5bb0, #580fc1);
        }
    </style>
</head>
<body>
<div class="card">
    <h2><i class="fas fa-user-edit"></i> Edit Subscriber</h2>
    <form action="update_subscriber.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-user"></i> Full Name</label>
            <input type="text" name="name" class="form-control" value="<%=name%>" required>
        </div>

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-envelope"></i> Email Address</label>
            <input type="email" name="email" class="form-control" value="<%=email%>" required>
        </div>

        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-gradient btn-lg">
                <i class="fas fa-save"></i> Update Subscriber
            </button>
            <a href="view_subscriptions.jsp" class="btn btn-secondary btn-lg">
                <i class="fas fa-arrow-left"></i> Back to List
            </a>
        </div>
    </form>
</div>
</body>
</html>
