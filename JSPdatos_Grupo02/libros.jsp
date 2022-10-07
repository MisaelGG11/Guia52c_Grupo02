<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, net.ucanaccess.jdbc.*" %>
<%
	String query = "", orden_th = "";
	ServletContext context = request.getServletContext();
	String path = context.getRealPath("/data");
	Connection conexion = getConnection(path);
%>
<%!
	public Connection getConnection(String path) throws SQLException {

		String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
		String filePath= path + "\\datos.mdb";
		String userName="", password="";
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
<!DOCTYPE html>
<html>
	<head>
		<title>Actualizar, Eliminar, Crear registros.</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/libros.css"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta charset="UTF-8" lang="es"/>
		<script src="${pageContext.request.contextPath}/scripts/libros.js"></script>
	</head>
	<body>
		<div class="name-form">
			<h1>Mantenimiento de Libros</h1>
		</div>
		<div id="container-li" class="container-li">
			<form id="form-actualizar" action="matto.jsp" method="post" name="actualizar">
				<table class="styled-table-form">
					<tbody>
						<td>
							<h3>Actualizar Datos</h3>
						</td>
						<tr>
							<td><label>ISBN:</label><input type="text" id="input-isbn" name="input-isbn" value="" size="60"/></td>
						</tr>
						<tr>
							<td><label>Título:</label><input type="text" id="input-isbn" name="input-titulo" value="" size="60"/></td>
						</tr>
						<tr>
							<td>
								<label>Editorial:</label>
								<select name="editorial">
								   <%
								   		query = "select * from editorial ";

										if (!conexion.isClosed()){
									  		Statement st = conexion.createStatement();
									  		ResultSet rs = st.executeQuery(query);

									   		while(rs.next()){
										  		out.println("<option>"+ rs.getString("nombreEditorial")+"</option>");
											}
									  	}
								   %>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<h4>Opciones</h4>
								<input type="radio" name="Action" value="Actualizar"/><label>Actualizar</label>
								<input type="radio" name="Action" value="Eliminar"/><label>Eliminar</label>
								<input type="radio" name="Action" value="Crear" checked/><label>Crear</label>
								<input class="button" type="SUBMIT" value="Actualizar" />
							</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</form>
			<form id="form-buscar" action="libros.jsp" method="post" name="buscar">
				<table class="styled-table-form">
					<tbody>
						<td>
							<h3>Realizar Búsqueda</h3>
						</td>
						<tr>
							<td>
								<label>ISBN:</label><input id="buscar-isbn" type="text" name="buscar-isbn" value="" size="60" onchange="busqueda(this)"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>Titulo:</label><input id="buscar-titulo" type="text" name="busca-titulo" value="" size="60"/>
								<td>
									<input class="button" type="SUBMIT" value="Buscar"/>
								</td>
							</td>
						</tr>
						<td>
							<h3>Ordenar Datos</h3>
						</td>
						<tr>
							<td>
								<%
									if(request.getParameter("orden") != null && request.getParameter("orden").toString().equals("desc")) {
										out.println("<label for=\"\"><input id=\"radio-asc\" type=\"radio\" name=\"ord\" value=\"asc\" onchange=\"cambiarLink(this)\"/> Ascendente</label>");
										out.println("<label for=\"\"><input id=\"radio-desc\" type=\"radio\" name=\"ord\" value=\"desc\" onchange=\"cambiarLink(this)\" checked/> Descendente</label>");
									}
									else {
										out.println("<label for=\"\"><input id=\"radio-asc\" type=\"radio\" name=\"ord\" value=\"asc\" onchange=\"cambiarLink(this)\" checked/> Ascendente</label>");
										out.println("<label for=\"\"><input id=\"radio-desc\" type=\"radio\" name=\"ord\" value=\"desc\" onchange=\"cambiarLink(this)\"/> Descendente</label>");
									}
								%>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div class="container-tb">
			<!--SCRIPTS-->
			<%
				// Consulta inicial
				query = "select * from libros ";

				if (request.getParameter("ordenar_por") != null && request.getParameter("orden") != null) {

					query += "order by " + request.getParameter("ordenar_por") + " " + request.getParameter("orden");

					if(request.getParameter("orden").equals("desc")) {
						orden_th = "desc";
					}
					else {
						orden_th = "asc";
					}
				}

				if(request.getParameter("buscar_isbn") != null) {
					query = "select * from libros where isbn like'" + request.getParameter("buscar_isbn") + "%'";
				}

				if(request.getParameter("buscar_titulo") != null) {
					query = "select * from libros where titulo='" + request.getParameter("buscar_titulo") + "%'";
				}

				if (!conexion.isClosed()){
					out.write("Status: OK");
					Statement st = conexion.createStatement();
					ResultSet rs = st.executeQuery(query);

					// Tabla de Datos
					out.println("<table class=\"styled-table-book\"><tbody><thead><tr><th>Número</th>" +
						"<th><a id=\"th-isbn\" class=\"white\" href=\"libros.jsp?ordenar_por=ISBN&orden=" + orden_th + "\">ISBN<img class=\"order\" title=\"isbn\" src=\"resources/order_by.svg\"/></a></th>" +
						"<th><a id=\"th-titulo\" class=\"white\" href=\"libros.jsp?ordenar_por=titulo&orden=" + orden_th + "\">Título<img class=\"order\" title=\"titulo\" src=\"resources/order_by.svg\"/></a></th>" +
						"<th><a id=\"th-autor\" class=\"white\" href=\"libros.jsp?ordenar_por=autor&orden=" + orden_th + "\">Aútor<img class=\"order\" title=\"autor\" src=\"resources/order_by.svg\"/></a></th>" +
						"<th><a id=\"th-editorial\" class=\"white\" href=\"libros.jsp?ordenar_por=editorial&orden=" + orden_th + "\">Editorial<img class=\"order\" title=\"autor\" src=\"resources/order_by.svg\"/></a></th>" +
						"<th>Acción</th></tr></thead>");

					String isbn = "", titulo = "", editorial = "";
					int i = 1;

					while (rs.next()) {
						isbn = rs.getString("isbn");
						titulo = rs.getString("titulo");
						editorial = rs.getString("editorial");
						out.println("<tr>");
						out.println("<td>"+ i +"</td>");
						out.println("<td>" + isbn + "</td>");
						out.println("<td>" + titulo + "</td>");
						out.println("<td> Desconocido </td>");
						out.println("<td>" + editorial + "</td>");
						out.println("<td>Actualizar<br><a href=\"matto.jsp?isbn="+ isbn +"&action=eliminar\">Eliminar</a ></td>");

						out.println("</tr>");
						i++;
					}
					out.println("</tbody></table>");

					// cierre de la conexion
					conexion.close();
				}
			%>
		</div>
	</body>
</html>