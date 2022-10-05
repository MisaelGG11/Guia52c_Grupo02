<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,net.ucanaccess.jdbc.*,java.util.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

 <title>Actualizar, Eliminar, Crear registros.</title>
 </head>
 <body>

<H1>MANTENIMIENTO DE LIBROS</H1>

<form action="matto.jsp" method="post" name="Actualizar">
 <table>
 <tr>
 <td>ISBN<input type="text" name="isbn" value="" size="40"/>
</td>
  </tr>
 <tr>
 <td>Título<input type="text" name="titulo" value="" size="50"/></td>
 
 </tr>
 <tr><td> Action <input type="radio" name="Action" value="Actualizar" /> Actualizar
 <input type="radio" name="Action" value="Eliminar"  > Eliminar</input>
 <input type="radio" name="Action" value="Crear" checked /> Crear

  </td>
 <td><input type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
 </form>
 </tr>
 </table>
 </form>
<br><br>


<form action="libros.jsp">
  <h1>Ordenamiento de los libros por titulo</h1>
  <label for=""><input type="radio" name="ord" value="asc" onchange="cambiarLink(this)"> Ascendiente</label>
  <label for=""><input type="radio" name="ord" value="desc" onchange="cambiarLink(this)">Descendiente </label>
  

</form>

<br>
<%!
public Connection getConnection(String path) throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= path+"/datos.mdb";
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

Connection conn = null;
String rutaRelativa = path + "\\datos.mdb";
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
   if (!conexion.isClosed()){
out.write("OK");
    String ordenamiento = request.getParameter("ordenamiento");
      Statement st = conexion.createStatement();
   
    String peticion = "select * from libros" ;

    try{
      if (ordenamiento.equals("asc")){
      peticion += " ORDER BY titulo ASC;";
      }
      else if(ordenamiento.equals("desc")){
        peticion += " ORDER BY titulo DESC;";
      }
    }catch(NullPointerException e){
     
    }
   
    

  try{
    ResultSet rs = st.executeQuery(peticion);
  
    

      // Ponemos los resultados en un table de html
      out.println("<table class='tabla' border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Acción</td></tr>");
      int i=1;
      while (rs.next())
      {
      
        String isbn = rs.getString("isbn");
        String titulo = rs.getString("titulo");
         
         out.println("<tr>");
         out.println("<td>"+i +"</td>");
         out.println("<td>"+isbn+"</td>");
         out.println("<td>"+titulo+"</td>");
         out.println("<td>"+"Actualizar<br><a href='matto.jsp?isbn="+isbn+"&Action=Eliminar'>Eliminar </a >"+"</td>");
         out.println("</tr>");
         i++;
      }
      out.println("</table>");
      

      // cierre de la conexion
      conexion.close();
    }catch(SQLException e){
    out.println(e);
  }
}

%>

<%

%>

<script>


 let textoH1 = document.getElementsByTagName("h1")[0]
 let link = document.createElement("a")

 link.textContent = textoH1.innerHTML
 textoH1.innerHTML = ""

 let ordenamiento = document.forms[1]

 document.getElementsByTagName("h1")[0].appendChild(link)


 
 function cambiarLink(src){

  document.getElementsByTagName("h1")[0].childNodes[0].setAttribute("href","libros.jsp?ordenamiento="+ src.value)

 }

  
</script>

 </body>