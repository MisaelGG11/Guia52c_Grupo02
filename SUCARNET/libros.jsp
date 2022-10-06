<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Actualizar, Eliminar, Crear registros.</title>
 </head>
 <body>

<H1>MANTENIMIENTO DE LIBROS</H1>

<%-- Ejercicio 3 --%>
<form name="formbusca" action="libros.jsp" method="aeleccion">
   ISBN a buscar:   <input type="text" name="busca-isbn" value="">
   Titulo a buscar: <input type="text" name="busca-titulo" value="">
   <input type="submit" name="uscar" value="BUSCAR">
</form>
<%-- Aquí termina el form del ejercicio 3 --%>

<form action="matto.jsp" method="post" name="Actualizar">
 <table>
 <tr>
 <td>ISBN<input type="text" id="isbn" name="isbn" value="" size="40"/>
</td>
  </tr>
 <tr>
 <td>T�tulo<input type="text" id="titulo" name="titulo" value="" size="50"/></td>
 
 </tr>
 <tr>
   Editorial:
   <select name="editorial">
      <%
         ServletContext context1 = request.getServletContext();
         String path1 = context1.getRealPath("/data");
         Connection conexion1 = getConnection(path1);
         Statement st1 = conexion1.createStatement();
         ResultSet rs1 = st1.executeQuery("select * from editorial" );
          while(rs1.next()){
             out.println("<option>"+ rs1.getString("nombreEditorial")+"</option>");
         }
         
      %>

   </select>
<tr>
 <td>Anio Publicacion<input type="text" name="anio" value="" size="50"/></td>
 
 </tr>
 <tr><td> Action <input type="radio" name="Action" id="Actualizar" value="Actualizar" /> Actualizar
 <input type="radio" name="Action" id="Eliminar" value="Eliminar"  > Eliminar</input>
 <input type="radio" name="Action" id ="Crear" value="Crear" checked /> Crear
  </td>
 <td><input type="SUBMIT" value="ACEPTAR" />
</td>
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

//Del ejercicio 3
String ls_buscaIsbn = request.getParameter("busca-isbn");
String ls_buscaTitulo = request.getParameter("busca-titulo");
String query = "select * from libros";

   if (!conexion.isClosed()){

      //del ejercicio 3
      if(ls_buscaIsbn != "")
         query = "select * from libros where isbn='" + ls_buscaIsbn + "'";
      else if(ls_buscaTitulo != "")
         query = "select * from libros where titulo='" + ls_buscaTitulo + "'";


   out.write("OK");
 
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery(query);

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Editorial</td><td>Anio Publicacion</td><td>Acci�n</td></tr>");
      int i=1;
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         out.println("<td>"+rs.getString("isbn")+"</td>");
         out.println("<td>"+rs.getString("titulo")+"</td>");
         out.println("<td>"+rs.getString("editorial")+"</td>");
         out.println("<td>"+rs.getString("anio")+"</td>");
         out.println("<td>"+"Actualizar<br>Eliminar"+"</td>");
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
}

%>
<script>
 function actualizar(isbn){
  document.getElementById('isbn').value = isbn
  document.getElementById('titulo').focus()
  document.getElementById('Actualizar').checked = true
  document.getElementById('Crear').checked = false
  document.getElementById('Eliminar').checked = false
}

  
</script>
 </body>
