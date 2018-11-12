# podstawy
# srednik na koncu linii nie wypisuje wyniku na ekran,
# ale wciaz ustawia wartosc zmiennej ans

# stale
pi
e

# liczby zespolone
# znaki i, j oznaczaja i sa traktowane jak cyfry

# wektor poziomy
u1 = [1 2 3]
u2 = [1,2,3]

# wektor pionowy
v = [1;2;3]

# macierz
A = [1,2,3;4,5,6]

# podstawowe operacje
A * v
u1 * v
v * u1
u + v

# Octave nie zawsze sprawdza czy wymiary sa odpowiednie przy operacjach
# To moze prowadzic do bardzo dziwnych wyników

# budowanie macierzy z bloków:
B = [A;u]
C = [v,B]

# do indeksowania i slicingu uzywamy nawiasów okraglych
# kolejne wymiary indeksujemy po przecinkach jak w Pythonie
# kolejnosc: (wiersze, kolumny)
# INDEKSUJEMY OD 1 I NIE DA SIE TEGO ZMIENIC
A(2,2)

# W ten sposób mozna przypisywac wartosci elementom:
A(2,2) = 5

# Podobnie jak w Pythonie mamy dwukropki

# a:b oznacza wektor poziomy zaczynajacy sie od a 
# i konczoncy na liczbie <=b, liczby inkrementowane o 1
# mozna z tego korzystac jak z pythonowego range

# a:c:b oznacza j.w ale skok jest o c, nie o 1

# Apostrof (') oznacza transpozycje
v'
A'

# w polaczeniu z range'ami:
(2:4:14)'

# sam dwukropek w miejscu indeksu oznacza ze bierzemy wszystko
D = A(:,1:2:3)

# zamiast pythonowego -1 mozna uzyc keyworda end
D = A(:, 1:2:end)

# mozliwe jest tez indeksowanie dowolnymi wektorami
D(v)

# przydatne funkcje do generowania macierzy i wektorów

# pusta macierz, podajemy wymiar x i y lub tylko x
zeros (10,5)

# tak samo dla jedynek
ones (21,37)

# macierz identycznosciowa
eye (10, 20)
# I jest zarezerwowane dla liczb zespolonych, stad nazwa "eye"

# macierz losowa (rozklad jednostajny z przedzialu [0,1])
rand (2137)

# fliplr odwraca kolejnosc kolumn
# flipud odwraca kolejnosc wierszy

# help wyswietla informacje o funkcji

# kropka przed znakiem operacji arytmetycznych 
# oznacza wykonywanie operacji po wspólrzednych
# wtedy obiekty musza byc tych samych wymiarów i jest to sprawdzane

# rozwiazywanie ukladów równan - notacja (operator rozwiazywania)
B\v
# oznacza x = B\v <==> Bx = v
# (taki zapis zwraca nam wlasnie x)

# powazniesze uklady:
# BX = U <==> X = B\U <-- to zapamietac !!!
# XB = U <==> X = U/B <-- tego nie uzywac (wyglada jak nieistniejace dzielenie macierzy)

# obrazki i wykresy generujemy podajac wpólrzedne x, y do plot:
x = 0.0:0.1:2.0*pi;
plot (x, sin(x));
# warto zwrócic uwage na sredniki

# alternatywnie do generowania uzywamy linspace
x = linspace(0, 2*pi, 20);
plot (x, sin(x));
# to jest latwiejsze bo krok jest automatycznie wyliczany
# inaczej latwo jest zawalic sobie ram obliczeniami

# instrukcje sterowania
if (v(1) == 0)
  v
endif
# mozna uzywac else
# nie ma natomiast symbolu endif

while (v(1) == 1)
  # do something
endwhile

for k=M
  # do something with k that is a vector (column od matrix M)
endfor

for i=1:10
  i
endfor

# programy ze skryptów wykonujemy wpisujac po prostu ich nazwe
# nazwa = nazwa pliku bez rozszerzenia (filename.m -> filename)

# definiowanie funkcji
function [out1,...,outn] = fname(in1,...,ink)
  # function body here
  # returned values are declared above and need to be set to be returned
endfunction

# jezeli nazwa pliku jest równa nazwie funkcji to mozna go wywolac 
# i przypisac do czegos jego wartosc

# czysci pamiec ze zmiennych i funkcji, przydaje sie bardzo czesto
clear all

# jezeli skrypt na poczatku zaczyna sie od nic nie robiacej instrukcji
# to jest tak po to aby nie zostal zinterpretowany jako skrypt funkcyjny

# funkcje anonimowe (jak lambdy w pythonie)
@(x,y) sin(x)+cos(y)

# jezeli chcemy przekazac nieanonimowa funkcje przez nazwe, uzywamy @:
# przykladowo @sin zamiast samego sin
