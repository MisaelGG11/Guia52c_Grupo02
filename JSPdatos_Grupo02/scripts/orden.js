/* Script utilizado para ordenar los datos */ 
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