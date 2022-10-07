/* Scripts de Libro.jsp*/ 
function cambiarLink(src) {

    if(src.value == "desc") {
        document.querySelector('#th-isbn').setAttribute('href','libros.jsp?ordenar_por=ISBN&orden=' + src.value)
        document.querySelector('#th-titulo').setAttribute('href','libros.jsp?ordenar_por=titulo&orden='+ src.value)
        document.querySelector('#th-autor').setAttribute('href','libros.jsp?ordenar_por=autor&orden='+ src.value)
        document.querySelector('#th-editorial').setAttribute('href','libros.jsp?ordenar_por=editorial&orden='+ src.value)
    }
    else {
        document.querySelector('#th-isbn').setAttribute('href','libros.jsp?ordenar_por=ISBN&orden=' + src.value)
        document.querySelector('#th-titulo').setAttribute('href','libros.jsp?ordenar_por=titulo&orden='+ src.value)
        document.querySelector('#th-autor').setAttribute('href','libros.jsp?ordenar_por=autor&orden='+ src.value)
        document.querySelector('#th-editorial').setAttribute('href','libros.jsp?ordenar_por=editorial&orden='+ src.value)
    }
}

function busqueda(src) {
    document.querySelector('#form-buscar').setAttribute('action', 'libros.jsp?buscar_isbn=' + src.value )
}

function actualizar(isbn) {
    document.getElementById('isbn').value = isbn
    document.getElementById('titulo').focus()
    document.getElementById('Actualizar').checked = true
    document.getElementById('Crear').checked = false
    document.getElementById('Eliminar').checked = false
}