<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Actualizar, Eliminar, Crear registros.</title>
 </head>
 <body>

<H1>MANTENIMIENTO DE LIBROS</H1>

<form name="formbusca" action="libros.jsp" method="aeleccion">
    <script>        
        function mensajeChange() {
          console.log("change");
          const mensaje = document.getElementById("buscarTitulo");
          const mensaje2 = document.getElementById("buscarAutor");
          const boton = document.getElementById("buscar");
          console.log(boton)
          
        if (mensaje.value.trim() !== "") {
            console.log("Se muestra")
            boton.removeAttribute('disabled')
        }
        else if(mensaje2.value.trim() !== "") {
            console.log("Se muestra")
            boton.removeAttribute('disabled')
        } else {
            boton.setAttribute('disabled', "true");
          }
        }
    </script>
    <table>
        <tr>
            <td>ISBN a buscar:   <input type="text" name="busca-isbn" id="buscarIsbn" value=""></td>
        </tr>
        <tr>
            <td>Titulo a buscar: <input onkeyup="mensajeChange()" type="text" name="busca-titulo" id="buscarTitulo" placeholder="Ingrese el titulo a buscar"></td>
        </tr>            
            <td>Autor: <input onkeyup="mensajeChange()" type="text" name="busca-autor" id="buscarAutor" placeholder="Ingrese autor a buscar"></td>
        </tr>   
    </table>
    <!-- <input type="submit" name="buscar" id="btnBuscar" value="BUSCAR"> -->
    <input type="submit" name="buscar" id="buscar" value="BUSCAR" disabled>
</form>

<script>

</script>

<form action="matto.jsp" method="post" name="Actualizar">
<table>
<tr>
    <td>ISBN<input type="text" name="isbn" value="" size="40"/></td>
</tr>
<tr>
    <td>Título<input type="text" name="titulo" value="" size="50"/></td>
</tr>
</tr>            
    <td>Autor: <input type="text" name="autor" value=""></td>
</tr> 
<tr>
    <td>
        Action 
        <input type="radio" name="Action" value="Actualizar" /> Actualizar
        <input type="radio" name="Action" value="Eliminar" /> Eliminar
        <input type="radio" name="Action" value="Crear" checked /> Crear
    </td>
<td><input type="SUBMIT" value="ACEPTAR" /></td>
</tr>
</form>
</tr>
</table>
</form>
<br><br>
<%!
public Connection getConnection(String path) throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= path + "\\datos.mdb";
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}
%>
<%
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);

String ls_buscaIsbn = request.getParameter("busca-isbn");
String ls_buscaTitulo = request.getParameter("busca-titulo");
String ls_buscaAutor = request.getParameter("busca-autor");

String query = "select * from libros";

    if (!conexion.isClosed()){
        if(ls_buscaIsbn != "")
            query = "select * from libros where isbn='" + ls_buscaIsbn + "'";

        else if(ls_buscaTitulo != "")
            query = "select * from libros where titulo='" + ls_buscaTitulo + "'";

        else if(ls_buscaAutor != ""){
            query = "select * from libros where autor='" + ls_buscaAutor + "'";
    }


    out.write("OK");

    Statement st = conexion.createStatement();
    ResultSet rs = st.executeQuery(query);
    // ResultSet rs = st.executeQuery("select * from libros");

    // Ponemos los resultados en un table de html
    out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Autor</td><td>Acción</td></tr>");
    int i=1;
    while (rs.next()) 
        {
        out.println("<tr>");
        out.println("<td>"+ i +"</td>");
        out.println("<td>"+rs.getString("isbn")+"</td>");
        out.println("<td>"+rs.getString("titulo")+"</td>");
        out.println("<td>"+rs.getString("autor")+"</td>");
        out.println("<td>"+"Actualizar<br>Eliminar"+"</td>");
        out.println("</tr>");
        i++;
        }
    out.println("</table>");

    // cierre de la conexion
    conexion.close();
}

%>
 </body>