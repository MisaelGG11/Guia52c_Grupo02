/* */
function actualizar(isbn) {
    document.getElementById('isbn').value = isbn
    document.getElementById('titulo').focus()
    document.getElementById('Actualizar').checked = true
    document.getElementById('Crear').checked = false
    document.getElementById('Eliminar').checked = false
  }