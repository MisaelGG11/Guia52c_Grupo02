/* Scripts de Libro.jsp*/ 
function cambiarLink(src) {

    if(src.value == "desc") {
        document.querySelector('#th-isbn').setAttribute('href','libros.jsp?ordenar_por=ISBN&orden=' + src.value)
        document.querySelector('#th-titulo').setAttribute('href','libros.jsp?ordenar_por=titulo&orden='+ src.value)
        document.querySelector('#th-autor').setAttribute('href','libros.jsp?ordenar_por=autor&orden='+ src.value)
        document.querySelector('#th-editorial').setAttribute('href','libros.jsp?ordenar_por=editorial&orden='+ src.value)
        document.querySelector('#th-anio').setAttribute('href','libros.jsp?ordenar_por=anio&orden='+ src.value)
    }
    else {
        document.querySelector('#th-isbn').setAttribute('href','libros.jsp?ordenar_por=ISBN&orden=' + src.value)
        document.querySelector('#th-titulo').setAttribute('href','libros.jsp?ordenar_por=titulo&orden='+ src.value)
        document.querySelector('#th-autor').setAttribute('href','libros.jsp?ordenar_por=autor&orden='+ src.value)
        document.querySelector('#th-editorial').setAttribute('href','libros.jsp?ordenar_por=editorial&orden='+ src.value)
        document.querySelector('#th-anio').setAttribute('href','libros.jsp?ordenar_por=anio&orden='+ src.value)
    }
}

function busqueda(src) {
    document.querySelector('#form-buscar').setAttribute('action', 'libros.jsp?buscar_isbn=' + src.value)
}

function actualizar() {

    isbn = document.querySelector('#input-isbn').getAttribute('value')
    titulo = document.querySelector('#input-titulo').getAttribute('value')
    autor = document.querySelector('#input-autor').getAttribute('value')
    editorial = document.querySelector('#input-editorial').getAttribute('value')
    anio = document.querySelector('#input-anio').getAttribute('value')

    document.querySelector('#form-actualizar').setAttribute('action','libros.jsp?isbn=' + isbn + '&titulo=' + titulo + '&autor' + autor + '&editorial=' + editorial + '&anio=' + anio)

}