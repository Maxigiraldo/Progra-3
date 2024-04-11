%Definicion de segmento
segmento(punto(X1, Y1), punto(X2, Y2)) :-
    punto(X1,Y1) \= punto(X2,Y2).

%verificar si es un segmento horizontal
horizontal(segmento(punto(X1,Y), punto(X2,Y))) :-
    X1 \= X2, !.

%verificar si es un segmento vertical
vertical(segmento(punto(X,Y1), punto(X,Y2))) :-
    Y1 \= Y2, !.

%verificar si el poligono es cerrado
poligono_cerrado(Segmentos) :-
    primer_punto(Segmentos, PuntoInicio),
    ultimo_punto(Segmentos, PuntoFinal),
    mismo_punto(PuntoInicio, PuntoFinal).

% Obtiene el primer punto del primer segmento
primer_punto([segmento(Punto, _) | _], Punto).

% Obtiene el último punto del último segmento
ultimo_punto([segmento(_, Punto) | []], Punto).
ultimo_punto([_ | RestoSegmentos], Punto) :-
    ultimo_punto(RestoSegmentos, Punto).

% Comprueba si dos puntos son iguales
mismo_punto(punto(X1, Y1), punto(X2, Y2)) :-
    X1 =:= X2,
    Y1 =:= Y2.

%Comprueba si el poligono es triangulo
triangulo(Segmentos) :-
    length(Segmentos, 3),
    poligono_cerrado(Segmentos).

%Comprueba si el poligono es cuadrado
cuadrado(Segmentos) :-
    length(Segmentos, 4),
    poligono_cerrado(Segmentos),
    member(segmento(punto(X,Y), punto(X1,Y)), Segmentos),
    member(segmento(punto(X1,Y), punto(X1,Y1)), Segmentos),
    member(segmento(punto(X1,Y1), punto(X,Y1)), Segmentos),
    member(segmento(punto(X,Y1), punto(X,Y)), Segmentos), !.

%Comprueba si el poligono es rectangulo
rectangulo(Segmentos) :-
    length(Segmentos, 4),
    poligono_cerrado(Segmentos),
    member(segmento(punto(X,Y), punto(X1,Y)), Segmentos),
    member(segmento(punto(X1,Y), punto(X1,Y1)), Segmentos),
    member(segmento(punto(X1,Y1), punto(X,Y1)), Segmentos),
    member(segmento(punto(X,Y1), punto(X,Y)), Segmentos),
    ((horizontal(segmento(punto(X,Y), punto(X1,Y))),
    vertical(segmento(punto(X1,Y), punto(X1, Y1))));
    (horizontal(segmento(punto(X1,Y), punto(X,Y1))),
    vertical(segmento(punto(X,Y1), punto(X, Y))))), !.
