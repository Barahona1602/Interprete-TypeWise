function keyup(event) {
  var numberOfLines = event.value.split("\n").length;
  event.parentElement.getElementsByClassName("line-numbers")[0].innerHTML =
    Array(numberOfLines).fill("<span></span>").join("");
  if (numberOfLines >= 32) {
    event.parentElement.getElementsByClassName("line-numbers")[0].style.height =
      (numberOfLines + 1) * 21 + "px";
  } else {
    event.parentElement.getElementsByClassName("line-numbers")[0].style.height =
      "";
  }
  event.style.height = numberOfLines * 21 + "px";
}

function keydown(event) {
  if (event.key === "Tab") {
    const start = event.target.selectionStart;
    const end = event.target.selectionEnd;

    event.target.value =
      event.target.value.substring(0, start) +
      "\t" +
      event.target.value.substring(end);

    event.preventDefault();
  }
}

// Método para abrir una pestaña con la ruta actual
function AbrirPestaña() {
  window.open(location.href, "_blank");
}

// Cierra la pestaña actual
function CerrarPestaña() {
  window.open('', '_self', '');
  window.close();
}



function Abrir() {
  var input = document.createElement("input");
  input.type = "file";
  input.click();
  input.onchange = (e) => {
    var file = e.target.files[0];
    var fr = new FileReader();
    fr.onload = function () {
      document.getElementById("entrada").value = fr.result.trim();
      keyup(document.getElementById("entrada"));
    };
    fr.readAsText(file);
  };
}

function GuardarComo() {
  Swal.fire({
    title: 'Nombre del archivo',
    input: 'text',
    inputValue: '',
    inputAttributes: {
      autocapitalize: 'off'
    },
    showCancelButton: true,
    confirmButtonText: 'Guardar',
    cancelButtonText: 'Cancelar',
    showLoaderOnConfirm: true,
    preConfirm: (filename) => {
      var element = document.createElement("a");
      element.setAttribute(
        "href",
        "data:text/plain;charset=utf-8," +
          encodeURIComponent(document.getElementById("entrada").value)
      );
      element.setAttribute("download", filename + ".tw");

      element.style.display = "none";
      document.body.appendChild(element);

      element.click();

      document.body.removeChild(element);
    },
    allowOutsideClick: () => !Swal.isLoading()
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire({
        title: 'Archivo guardado exitosamente!',
        icon: 'success'
      });
    }
  });
}


function Nuevo() {
  var entrada = document.getElementById("entrada");
  var consola = document.getElementById("consola");
  entrada.value = "";
  consola.value = "";
}

function Analizar() {
  document.getElementById("consola").value = "";

  d3.select("#canvas-arbol").selectAll("*").remove();
  var parser = new gramatica.Parser();
  parser.yy = { er_l: [], er_s: [], arbol: [] };

  try {
    parser.parse(document.getElementById("entrada").value);
  } catch {
    document.getElementById("consola").value = "Errores existentes";
    d3.select("#canvas-simbolos")
      .graphviz()
      .renderDot(graficar_errores(parser.yy.er_l, parser.yy.er_s));
    return;
  }

  if (parser.yy.er_l.length != 0) {
    document.getElementById("consola").value = "Errores existentes";
    d3.select("#canvas-simbolos")
      .graphviz()
      .renderDot(graficar_errores(parser.yy.er_l, parser.yy.er_s));
    return;
  }

  let resultado = new ast(parser.yy.arbol[0]);
  resultado.calcular_entorno(resultado.arbol);
  resultado.calcular_tabla(resultado.arbol);
  resultado.correr_programa();
  d3.select("#canvas-simbolos")
    .graphviz()
    .renderDot(resultado.graficar_tabla());
  d3.select("#canvas-arbol")
    .graphviz()
    .renderDot(resultado.arbol.graficar_ast());
    Swal.fire({
      icon: 'success',
      title: '¡Análisis completado!',
      text: 'Se ha analizado correctamente el archivo',
      confirmButtonColor: '#3085d6',
      confirmButtonText: 'Ok'
    })
}

function graficar_errores(lex, sin) {
  let dot =
    "digraph {N_1[shape=none label = <\n" +
    ' <TABLE border="1" cellspacing="0" cellpadding="10" bgcolor="#f7f7f7">\n' +
    "  <TR>\n" +
    '    <TD colspan="4" bgcolor="#ebebeb" align="center"><b><font color="#333333" face="Arial, Helvetica, sans-serif">Tabla de errores</font></b></TD>\n' +
    "  </TR>\n" +
    '  <TR bgcolor="#ebebeb">\n' +
    '    <TD><b><font color="#333333" face="Arial, Helvetica, sans-serif">Tipo de Error</font></b></TD>\n' +
    '    <TD><b><font color="#333333" face="Arial, Helvetica, sans-serif">Descripción</font></b></TD>\n' +
    '    <TD><b><font color="#333333" face="Arial, Helvetica, sans-serif">Línea</font></b></TD>\n' +
    '    <TD><b><font color="#333333" face="Arial, Helvetica, sans-serif">Columna</font></b></TD>\n' +
    "  </TR>\n";

  for (const s of lex) {
    dot +=
      "  <TR>\n" +
      "    <TD>" +
      s.tipo +
      "</TD>\n" +
      "    <TD>" +
      s.desc +
      "</TD>\n" +
      "    <TD>" +
      s.lin +
      "</TD>\n" +
      "    <TD>" +
      s.col +
      "</TD>\n" +
      "  </TR>\n";
  }

  for (const s of sin) {
    dot +=
      "  <TR>\n" +
      "    <TD>" +
      s.tipo +
      "</TD>\n" +
      "    <TD>" +
      s.desc +
      "</TD>\n" +
      "    <TD>" +
      s.lin +
      "</TD>\n" +
      "    <TD>" +
      s.col +
      "</TD>\n" +
      "  </TR>\n";
  }

  dot += "</TABLE>>];\n}";
  return dot;
}

