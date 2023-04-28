%{
%}

%lex
%options case-insensitive

%%

[ \r\t\n]+ //blancos
\s+     //ignorar blancos
"//".* //comentarios una linea
"/*"([^*]|("*"[^/]))+"*/" //comentarios multilinea

"int" 			return 'reservada_int';
"double" 			return 'reservada_double';
"boolean" 			return 'reservada_boolean';
"char" 			return 'reservada_char';
"string" 			return 'reservada_string';
"true" 			return 'reservada_true';
"false" 			return 'reservada_false';
"print" 			return 'reservada_print';
"if" 			return 'reservada_if';
"else" 			return 'reservada_else';
"while" 			return 'reservada_while';
"for" 			return 'reservada_for';
"do" 			return 'reservada_do';
"switch" 			return 'reservada_switch';
"case" 			return 'reservada_case';
"new" 			return 'reservada_new';
"list" 			return 'reservada_list';
"add" 			return 'reservada_add';
"default" 			return 'reservada_default';
"break" 			return 'reservada_break';
"continue" 			return 'reservada_continue';
"return" 			return 'reservada_return';
"void" 			return 'reservada_void';
"tolower" 			return 'reservada_tolower';
"toupper" 			return 'reservada_toupper';
"length" 			return 'reservada_length';
"truncate" 			return 'reservada_truncate';
"round" 			return 'reservada_round';
"typeof" 			return 'reservada_typeof';
"tostring" 			return 'reservada_tostring';
"tochararray" 			return 'reservada_tochararray';
"main" 			return 'reservada_main';
"," 			return 'com';
"." 			return 'pto';
"+" 			return 'mas';
"-" 			return 'menos';
"*" 			return 'estrella';
"/" 			return 'division';
"^" 			return 'potencia';
"%" 			return 'mod';
"==" 			return 'igualacion';
"!=" 			return 'desigual';
"<=" 			return 'menor_igual';
"<" 			return 'menor';
">=" 			return 'mayor_igual';
">" 			return 'mayor';
":" 			return 'dp';
"?" 			return 'interrogacion';
"||" 			return 'or';
"&&" 			return 'and';
"!" 			return 'not';
";" 			return 'pc';
"{" 			return 'llave_a';
"}" 			return 'llave_c';
"(" 			return 'paren_a';
")" 			return 'paren_c';
"[" 			return 'corchete_a';
"]" 			return 'corchete_c';
"="  			return 'igual';

//variables
[0-9]+"."[0-9]+ 			return 'double';
[0-9]+ 			return 'int';
"'"(.|"\n"|"\\"|"\""|"\t"|"\'")"'" 			{yytext = yytext.substr(1,yyleng-2); return 'char';}
"\""([^"]|("\\\""))*"\"" 			{yytext = yytext.substr(1,yyleng-2); return 'string';}
[a-z_][a-z0-9_]* 			return 'id';
<<EOF>>               return 'fin_archivo';
.                     {yy.er_l.push({tipo: "Lexico", desc: "el caracter: \""+yytext+"\", no existe en el lenguaje",lin:yylloc.first_line,col:yylloc.first_column});};

/lex

%left 'or'
%left 'and'
%right 'not'
%left 'mayor'
%left 'mayor_igual'
%left 'menor'
%left 'menor_igual'
%left 'desigual'
%left 'igualacion'
%left 'menos'
%left 'mas'
%left 'estrella'
%left 'division' 'mod'
%left 'potencia'


%start PROGRAMA

%%

PROGRAMA: INSTRUCCIONES fin_archivo { 
	let arbol = new Nodo("Programa",@1.first_line ,@1.first_column);
	arbol.hijos.push($1);
	yy.arbol.push(arbol);

}
	| fin_archivo;

EXPRESION: ARITMETICO { 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| CONDICIONAL{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| LOGICO{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| CASTEO{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| ACCESO_VECTOR{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| ACCESO_LISTA{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| LLAMADA{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_TOUPPER{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_TOLOWER{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_LENGTH{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_ROUND{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| TERNARIO{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_TYPEOF{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_TOSTRING{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_TOCHARARRAY{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_TRUNCATE{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| DATOS{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| id{ 
	$$ = new Nodo("Expression",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
}
	| paren_a EXPRESION paren_c{ 
	$$ = $2;
};

INSTRUCCIONES: INSTRUCCIONES INSTRUCCION{ 
	$$ = new Nodo("instrucciones",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push($2);
}
	| INSTRUCCION{ 
	$$ = new Nodo("instrucciones",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
};

INSTRUCCION: DECLARACION_VARIABLE{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| ASIGNACION_VARIABLE{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| DECLARACION_VECTOR{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| MODIFICACION_VECTOR{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| DECLARACION_LISTA{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| AGREGAR_LISTA{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| MODIFICACION_LISTA{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| SENTENCIA_IF{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| SENTENCIA_SWITCH{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| SENTENCIA_WHILE{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| SENTENCIA_FOR{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| SENTENCIA_DO_WHILE{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| DECLARACION_FUNCION{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| DECLARACION_METODO{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| FUNCION_PRINT{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| TRANSFERENCIA{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
}
	| ACTUALIZACION pc{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("pc",@2.first_line ,@2.first_column,$2))
}
	| LLAMADA pc{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("pc",@2.first_line ,@2.first_column,$2))
}
	| FUNCION_MAIN{ 
	$$ = new Nodo("instruccion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
};

ARITMETICO: menos EXPRESION{ 
	$$ = new Nodo("aritmetico",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("menos",@1.first_line ,@1.first_column,$1))
	$$.hijos.push($2);
}
	| EXPRESION potencia EXPRESION{ 
	$$ = new Nodo("aritmetico",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("potencia",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION division EXPRESION{ 
	$$ = new Nodo("aritmetico",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("division",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION estrella EXPRESION{ 
	$$ = new Nodo("aritmetico",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("estrella",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION mas EXPRESION{ 
	$$ = new Nodo("aritmetico",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("mas",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION menos EXPRESION{ 
	$$ = new Nodo("aritmetico",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("menos",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION mod EXPRESION{ 
	$$ = new Nodo("aritmetico",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("mod",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
};

CONDICIONAL: EXPRESION igualacion EXPRESION{ 
	$$ = new Nodo("Condicional",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("igualacion",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION desigual EXPRESION{ 
	$$ = new Nodo("Condicional",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("desigual",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION menor_igual EXPRESION{ 
	$$ = new Nodo("Condicional",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("menor_igual",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION menor EXPRESION{ 
	$$ = new Nodo("Condicional",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("menor",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION mayor_igual EXPRESION{ 
	$$ = new Nodo("Condicional",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("mayor_igual",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION mayor EXPRESION{ 
	$$ = new Nodo("Condicional",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("mayor",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
};

LOGICO: not EXPRESION{ 
	$$ = new Nodo("Logico",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("not",@1.first_line ,@1.first_column,$1))
	$$.hijos.push($2);
}
	| EXPRESION and EXPRESION{ 
	$$ = new Nodo("Logico",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("and",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
}
	| EXPRESION or EXPRESION{ 
	$$ = new Nodo("Logico",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("or",@2.first_line ,@2.first_column,$2))
	$$.hijos.push($3);
};

ACTUALIZACION: id mas mas{ 
	$$ = new Nodo("Actualizacion",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("mas",@2.first_line ,@2.first_column,$2))
	$$.hijos.push(new Nodo("mas",@3.first_line ,@3.first_column,$3));
}
	| id menos menos{ 
	$$ = new Nodo("Actualizacion",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("menos",@2.first_line ,@2.first_column,$2))
	$$.hijos.push(new Nodo("menos",@3.first_line ,@3.first_column,$3));
};

CASTEO: paren_a TIPO paren_c EXPRESION { 
	$$ = new Nodo("Casteo",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("paren_a",@1.first_line ,@1.first_column,$1))
	$$.hijos.push($2);
	$$.hijos.push(new Nodo("paren_c",@3.first_line ,@3.first_column,$3))
	$$.hijos.push($4);
};

TIPO: reservada_int { 
	$$ = new Nodo("Tipo",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_int",@1.first_line ,@1.first_column,$1));
}
	| reservada_double{ 
	$$ = new Nodo("Tipo",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_double",@1.first_line ,@1.first_column,$1));
}
	| reservada_boolean{ 
	$$ = new Nodo("Tipo",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_boolean",@1.first_line ,@1.first_column,$1));
}
	| reservada_char{ 
	$$ = new Nodo("Tipo",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_char",@1.first_line ,@1.first_column,$1));
}
	| reservada_string{ 
	$$ = new Nodo("Tipo",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_string",@1.first_line ,@1.first_column,$1));
};

DATOS: double{ 
	$$ = new Nodo("Datos",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("double",@1.first_line ,@1.first_column,$1));
}
	| char{ 
	$$ = new Nodo("Datos",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("char",@1.first_line ,@1.first_column,$1));
}
	| string{ 
	$$ = new Nodo("Datos",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("string",@1.first_line ,@1.first_column,$1));
}
	| reservada_true{ 
	$$ = new Nodo("Datos",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_true",@1.first_line ,@1.first_column,$1));
}
	| reservada_false{ 
	$$ = new Nodo("Datos",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_false",@1.first_line ,@1.first_column,$1));
}
	| int{ 
	$$ = new Nodo("Datos",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("int",@1.first_line ,@1.first_column,$1));
};

TRANSFERENCIA: reservada_break pc{ 
	$$ = new Nodo("Transferencia",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_break",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("pc",@2.first_line ,@2.first_column,$2));
}
	| reservada_continue pc{ 
	$$ = new Nodo("Transferencia",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_continue",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("pc",@2.first_line ,@2.first_column,$2));
}
	| reservada_return pc{ 
	$$ = new Nodo("Transferencia",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_return",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("pc",@2.first_line ,@2.first_column,$2));
}
	| reservada_return EXPRESION pc{ 
	$$ = new Nodo("Transferencia",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_return",@1.first_line ,@1.first_column,$1));
	$$.hijos.push($2);
	$$.hijos.push(new Nodo("pc",@3.first_line ,@3.first_column,$3));
};


TERNARIO: EXPRESION interrogacion EXPRESION dp EXPRESION { 
	$$ = new Nodo("Ternario",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("interrogacion",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("dp",@4.first_line ,@4.first_column,$4));
	$$.hijos.push($5);
};

DECLARACION_VARIABLE: TIPO id pc{ 
	$$ = new Nodo("Declaracion variable",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("id",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("pc",@3.first_line ,@3.first_column,$3));
}
	| TIPO id igual EXPRESION pc{ 
	$$ = new Nodo("Declaracion variable",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("id",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("igual",@3.first_line ,@3.first_column,$3));
	$$.hijos.push($4);
	$$.hijos.push(new Nodo("pc",@5.first_line ,@5.first_column,$5));
};

ASIGNACION_VARIABLE: id igual EXPRESION pc { 
	$$ = new Nodo("Asignacion variable",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("igual",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("pc",@4.first_line ,@4.first_column,$4));
};

DECLARACION_VECTOR: TIPO corchete_a corchete_c id igual reservada_new TIPO corchete_a EXPRESION corchete_c pc {
	$$ = new Nodo("Declaracion vector",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("corchete_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("corchete_c",@3.first_line ,@3.first_column,$3));
	$$.hijos.push(new Nodo("id",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("igual",@5.first_line ,@5.first_column,$5));
	$$.hijos.push(new Nodo("reservada_new",@6.first_line ,@6.first_column,$6));
	$$.hijos.push($7);
	$$.hijos.push(new Nodo("corchete_a",@8.first_line ,@8.first_column,$8));
	$$.hijos.push($9);
	$$.hijos.push(new Nodo("corchete_c",@10.first_line ,@10.first_column,$10));
	$$.hijos.push(new Nodo("pc",@11.first_line ,@11.first_column,$11));
}
	| TIPO corchete_a corchete_c id igual llave_a LISTA_VALORES llave_c pc{
	$$ = new Nodo("Declaracion vector",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("corchete_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("corchete_c",@3.first_line ,@3.first_column,$3));
	$$.hijos.push(new Nodo("id",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("igual",@5.first_line ,@5.first_column,$5));
	$$.hijos.push(new Nodo("llave_a",@6.first_line ,@6.first_column,$6));
	$$.hijos.push($7);
	$$.hijos.push(new Nodo("llave_c",@8.first_line ,@8.first_column,$8));
	$$.hijos.push(new Nodo("pc",@9.first_line ,@9.first_column,$9));
};

ACCESO_VECTOR: id corchete_a EXPRESION corchete_c {
	$$ = new Nodo("Acceso vector",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("corchete_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("corchete_c",@4.first_line ,@4.first_column,$4));
};

MODIFICACION_VECTOR: id corchete_a EXPRESION corchete_c igual EXPRESION pc{
	$$ = new Nodo("Modificacion vector",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("corchete_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("corchete_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("igual",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("pc",@7.first_line ,@7.first_column,$7));
};

LISTA_VALORES: LISTA_VALORES com DATOS{ 
	$$ = new Nodo("Lista valores",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("com",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
}
	| LISTA_VALORES com id{ 
	$$ = new Nodo("Lista valores",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("com",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("id",@3.first_line ,@3.first_column,$3));
}
	| id{ 
	$$ = new Nodo("Lista valores",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
}
	| DATOS{ 
	$$ = new Nodo("Lista valores",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
};

DECLARACION_LISTA: reservada_list menor TIPO mayor id igual reservada_new reservada_list menor TIPO mayor pc {
	$$ = new Nodo("Declaracion lista",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_list",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("menor",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("mayor",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("id",@5.first_line ,@5.first_column,$5));
	$$.hijos.push(new Nodo("igual",@6.first_line ,@6.first_column,$6));
	$$.hijos.push(new Nodo("reservada_new",@7.first_line ,@7.first_column,$7));
	$$.hijos.push(new Nodo("reservada_list",@8.first_line ,@8.first_column,$8));
	$$.hijos.push(new Nodo("menor",@9.first_line ,@9.first_column,$9));
	$$.hijos.push($10);
	$$.hijos.push(new Nodo("mayor",@11.first_line ,@11.first_column,$11));
	$$.hijos.push(new Nodo("pc",@12.first_line ,@12.first_column,$12));
};

AGREGAR_LISTA: id pto reservada_add paren_a EXPRESION paren_c pc{
	$$ = new Nodo("Agregar lista",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("pto",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("reservada_add",@3.first_line ,@3.first_column,$3));
	$$.hijos.push(new Nodo("paren_a",@4.first_line ,@4.first_column,$4));
	$$.hijos.push($5);
	$$.hijos.push(new Nodo("paren_c",@6.first_line ,@6.first_column,$6));
	$$.hijos.push(new Nodo("pc",@7.first_line ,@7.first_column,$7));
};

ACCESO_LISTA: id corchete_a corchete_a EXPRESION corchete_c corchete_c{
	$$ = new Nodo("Acceso lista",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("corchete_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("corchete_a",@3.first_line ,@3.first_column,$3));
	$$.hijos.push($4);
	$$.hijos.push(new Nodo("corchete_c",@5.first_line ,@5.first_column,$5));
	$$.hijos.push(new Nodo("corchete_c",@6.first_line ,@6.first_column,$6));
};

MODIFICACION_LISTA: id corchete_a corchete_a EXPRESION corchete_c corchete_c igual EXPRESION pc{
	$$ = new Nodo("Modificacion lista",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("corchete_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("corchete_a",@3.first_line ,@3.first_column,$3));
	$$.hijos.push($4);
	$$.hijos.push(new Nodo("corchete_c",@5.first_line ,@5.first_column,$5));
	$$.hijos.push(new Nodo("corchete_c",@6.first_line ,@6.first_column,$6));
	$$.hijos.push(new Nodo("igual",@7.first_line ,@7.first_column,$7));
	$$.hijos.push($8);
	$$.hijos.push(new Nodo("pc",@9.first_line ,@9.first_column,$9));
};

SENTENCIA_IF: reservada_if paren_a EXPRESION paren_c llave_a INSTRUCCIONES llave_c{
	$$ = new Nodo("Sentencia if",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_if",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("llave_c",@7.first_line ,@7.first_column,$7));
}
	| reservada_if paren_a EXPRESION paren_c llave_a INSTRUCCIONES llave_c reservada_else llave_a INSTRUCCIONES llave_c{
	$$ = new Nodo("Sentencia if",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_if",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("llave_c",@7.first_line ,@7.first_column,$7));
	$$.hijos.push(new Nodo("reservada_else",@8.first_line ,@8.first_column,$8));
	$$.hijos.push(new Nodo("llave_a",@9.first_line ,@9.first_column,$9));
	$$.hijos.push($10);
	$$.hijos.push(new Nodo("llave_c",@11.first_line ,@11.first_column,$11));
}
	| reservada_if paren_a EXPRESION paren_c llave_a INSTRUCCIONES llave_c reservada_else SENTENCIA_IF{
	$$ = new Nodo("Sentencia if",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_if",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("llave_c",@7.first_line ,@7.first_column,$7));
	$$.hijos.push(new Nodo("reservada_else",@8.first_line ,@8.first_column,$8));
	$$.hijos.push($9);
};


SENTENCIA_SWITCH: reservada_switch  paren_a EXPRESION paren_c llave_a LISTA_CASOS DEFECTO llave_c {
	$$ = new Nodo("Sentencia switch",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_switch",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push($7);
	$$.hijos.push(new Nodo("llave_c",@8.first_line ,@8.first_column,$8));
}
	| reservada_switch  paren_a EXPRESION paren_c llave_a LISTA_CASOS llave_c {
	$$ = new Nodo("Sentencia switch",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_switch",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("llave_c",@7.first_line ,@7.first_column,$7));
}
	| reservada_switch  paren_a EXPRESION paren_c llave_a DEFECTO llave_c{
	$$ = new Nodo("Sentencia switch",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_switch",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("llave_c",@7.first_line ,@7.first_column,$7));
};

LISTA_CASOS: LISTA_CASOS CASO{ 
	$$ = new Nodo("Lista casos",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push($2);
}
	| CASO{ 
	$$ = new Nodo("Lista casos",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
};

CASO: reservada_case EXPRESION dp INSTRUCCIONES{ 
	$$ = new Nodo("Caso",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_case",@1.first_line ,@1.first_column,$1));
	$$.hijos.push($2);
	$$.hijos.push(new Nodo("dp",@3.first_line ,@3.first_column,$3));
	$$.hijos.push($4);
};

DEFECTO: reservada_default dp INSTRUCCIONES { 
	$$ = new Nodo("Default",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_default",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("dp",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
};

SENTENCIA_WHILE: reservada_while paren_a EXPRESION paren_c llave_a INSTRUCCIONES llave_c {
	$$ = new Nodo("Sentencia while",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_while",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("llave_c",@7.first_line ,@7.first_column,$7));
};

SENTENCIA_FOR: reservada_for paren_a DECLARACION_VARIABLE CONDICIONAL pc ACTUALIZACION paren_c llave_a INSTRUCCIONES llave_c{
	$$ = new Nodo("Sentencia for",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_for",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push($4);
	$$.hijos.push(new Nodo("pc",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("paren_c",@7.first_line ,@7.first_column,$7));
	$$.hijos.push(new Nodo("llave_a",@8.first_line ,@8.first_column,$8));
	$$.hijos.push($9);
	$$.hijos.push(new Nodo("llave_c",@10.first_line ,@10.first_column,$10));
}
	| reservada_for paren_a ASIGNACION_VARIABLE CONDICIONAL pc ACTUALIZACION paren_c llave_a INSTRUCCIONES llave_c{
	$$ = new Nodo("Sentencia for",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_for",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push($4);
	$$.hijos.push(new Nodo("pc",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("paren_c",@7.first_line ,@7.first_column,$7));
	$$.hijos.push(new Nodo("llave_a",@8.first_line ,@8.first_column,$8));
	$$.hijos.push($9);
	$$.hijos.push(new Nodo("llave_c",@10.first_line ,@10.first_column,$10));
};

SENTENCIA_DO_WHILE: reservada_do llave_a INSTRUCCIONES llave_c reservada_while paren_a EXPRESION paren_c pc{
	$$ = new Nodo("Sentencia do while",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_do",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("llave_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("llave_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("reservada_while",@5.first_line ,@5.first_column,$5));
	$$.hijos.push(new Nodo("paren_a",@6.first_line ,@6.first_column,$6));
	$$.hijos.push($7);
	$$.hijos.push(new Nodo("paren_c",@8.first_line ,@8.first_column,$8));
	$$.hijos.push(new Nodo("pc",@9.first_line ,@9.first_column,$9));
};

DECLARACION_FUNCION: TIPO id paren_a PARAMETROS paren_c llave_a INSTRUCCIONES llave_c{
	$$ = new Nodo("Declaracion funcion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("id",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("paren_a",@3.first_line ,@3.first_column,$3));
	$$.hijos.push($4);
	$$.hijos.push(new Nodo("paren_c",@5.first_line ,@5.first_column,$5));
	$$.hijos.push(new Nodo("llave_a",@6.first_line ,@6.first_column,$6));
	$$.hijos.push($7);
	$$.hijos.push(new Nodo("llave_c",@8.first_line ,@8.first_column,$8));
}
	| TIPO id paren_a paren_c llave_a INSTRUCCIONES llave_c{
	$$ = new Nodo("Declaracion funcion",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("id",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("paren_a",@3.first_line ,@3.first_column,$3));
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("llave_c",@7.first_line ,@7.first_column,$7));
};

DECLARACION_METODO: reservada_void id paren_a PARAMETROS paren_c llave_a INSTRUCCIONES llave_c {
	$$ = new Nodo("Declaracion metodo",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_void",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("id",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("paren_a",@3.first_line ,@3.first_column,$3));
	$$.hijos.push($4);
	$$.hijos.push(new Nodo("paren_c",@5.first_line ,@5.first_column,$5));
	$$.hijos.push(new Nodo("llave_a",@6.first_line ,@6.first_column,$6));
	$$.hijos.push($7);
	$$.hijos.push(new Nodo("llave_c",@8.first_line ,@8.first_column,$8));
}
	| reservada_void id paren_a  paren_c llave_a INSTRUCCIONES llave_c {
	$$ = new Nodo("Declaracion metodo",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_void",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("id",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("paren_a",@3.first_line ,@3.first_column,$3));
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("llave_a",@5.first_line ,@5.first_column,$5));
	$$.hijos.push($6);
	$$.hijos.push(new Nodo("llave_c",@7.first_line ,@7.first_column,$7));
};

PARAMETROS: PARAMETROS com TIPO id{
	$$ = new Nodo("Parametros",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("com",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("id",@4.first_line ,@4.first_column,$4));
}
	| TIPO id{
	$$ = new Nodo("Parametros",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("id",@2.first_line ,@2.first_column,$2));
};

LLAMADA: id paren_a PARAMETROS_LLAMADA paren_c {
	$$ = new Nodo("Llamada",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
}
	| id paren_a paren_c { 
	$$ = new Nodo("Llamada",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("id",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push(new Nodo("paren_c",@3.first_line ,@3.first_column,$3));
};

PARAMETROS_LLAMADA: PARAMETROS_LLAMADA com EXPRESION { 
	$$ = new Nodo("Parametros llamada",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
	$$.hijos.push(new Nodo("com",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
}
	| EXPRESION { 
	$$ = new Nodo("Parametros llamada",@1.first_line ,@1.first_column);
	$$.hijos.push($1);
};

FUNCION_PRINT: reservada_print paren_a EXPRESION paren_c pc{ 
	$$ = new Nodo("Funcion print",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_print",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
	$$.hijos.push(new Nodo("pc",@5.first_line ,@5.first_column,$5));
};

FUNCION_TOLOWER: reservada_tolower paren_a EXPRESION paren_c{ 
	$$ = new Nodo("Funcion toLower",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_tolower",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
};

FUNCION_TOUPPER: reservada_toupper paren_a EXPRESION paren_c{ 
	$$ = new Nodo("Funcion toUpper",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_toupper",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
};

FUNCION_LENGTH: reservada_length paren_a EXPRESION paren_c{ 
	$$ = new Nodo("Funcion length",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_length",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
};

FUNCION_TRUNCATE: reservada_truncate paren_a EXPRESION paren_c{ 
	$$ = new Nodo("Funcion truncate",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_truncate",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
};

FUNCION_ROUND: reservada_round paren_a EXPRESION paren_c{ 
	$$ = new Nodo("Funcion round",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_round",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
};

FUNCION_TYPEOF: reservada_typeof paren_a EXPRESION paren_c { 
	$$ = new Nodo("Funcion typeOf",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_typeof",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
};

FUNCION_TOSTRING: reservada_tostring paren_a EXPRESION paren_c{ 
	$$ = new Nodo("Funcion toString",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_tostring",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
};

FUNCION_TOCHARARRAY: reservada_tochararray paren_a EXPRESION paren_c{ 
	$$ = new Nodo("Funcion toCharArray",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_tochararray",@1.first_line ,@1.first_column,$1));
	$$.hijos.push(new Nodo("paren_a",@2.first_line ,@2.first_column,$2));
	$$.hijos.push($3);
	$$.hijos.push(new Nodo("paren_c",@4.first_line ,@4.first_column,$4));
};

FUNCION_MAIN: reservada_main LLAMADA pc { 
	$$ = new Nodo("Funcion main",@1.first_line ,@1.first_column);
	$$.hijos.push(new Nodo("reservada_main",@1.first_line ,@1.first_column,$1))
	$$.hijos.push($2);
	$$.hijos.push(new Nodo("pc",@3.first_line ,@3.first_column,$3));
};

