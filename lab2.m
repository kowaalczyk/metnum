# Przypomnienie - rozwiazanie ukladu równan:
A=[1,1;1,0.98], b=[1,2]';
x = A\b

# Sprawdzamy czy odpowiedz jest dobra:
A*x == b  # tego nie bedzie widac przy wielkich macierzach
norm(b-A*x)  # to powinno byc równe zero

# liczenie innych norm (domyslnie jest 2)
norm(x, 1)
norm(x, inf)

# blad rezydualny bezwzgledny i wzgledny
norm(b-A*x)
norm(b-A*x) / norm(b)

# kolejny uklad:
A=[1,1;1,0.99], b=[1,2]';
x = A\b



# macierz Hilberta: h_{i,j} = 1 / (i+j-1), zawsze jest dodatnio okreslona
H = hilb(7);

# bedziemy chcieli rozwiazac uklad Hx=b
# 1. za pomoca operatora rozwiazywania ukladu równan
x1 = H\b;

# 2. za pomoca odwracania macierzy
x2 = inv(H)*b

# zrobimy to dla nastepujacych wymiarów macierzy:
sizes = [5,10,20]

# trzeba bedzie tez policzyc bledy otrzymanych rozwiazan
for s = sizes
  H = hilb(s);
  os = ones(s,1);
  b = H * os;
  
  x1 = H\b;
  x2 = inv(H)*b; # to powinno byc mniej dokladne
  
  s
  r1 = norm(b-H*x1) / norm(b)
  r2 = norm(b-H*x2) / norm(b)
  e1 = norm(x1-os) / norm(os)
  e2 = norm(x2-os) / norm(os)
endfor

# wnioski:
# odwracanie macierzy rzeczywiscie znaczaco pogarsza wynik
# liczenie bledu nie znajac poprawnej odpowiedzi ukrywa jego wielkosc
# (bledy r - rezydualne sa mniejsze niz bledy e)



# spróbujmy teraz policzyc analitycznie odwrotnosc macierzy Hilberta
# i zobaczyc jaki bedzie wynik
for s = sizes
  H = hilb(s);
  os = ones(s,1);
  b = H * os;
  
  x1 = H\b;
  x2 = inv(H)*b;
  x3 = invhilb(s)*b;  # powinno byc dokladniejsze niz x2
  
  s
  r1 = norm(b-H*x1) / norm(b)
  r2 = norm(b-H*x2) / norm(b)
  r3 = norm(b-H*x3) / norm(b)
  e1 = norm(x1-os) / norm(os)
  e2 = norm(x2-os) / norm(os)
  e3 = norm(x3-os) / norm(os)
endfor

# wnioski:
# kiedy liczby w macierzy sa wielkie to metoda annalityczna nie dziala



# teraz bedziemy chcieli zrobic podobny eksperyment, ale dla losowej macierzy
sizes2 = [10,100,1000]
for s = sizes2
  R = rand(s);
  os = ones(s,1);
  b = R * os;
  
  x1 = R\b;
  x2 = inv(R)*b;
  
  s
  r1 = norm(b-R*x1) / norm(b)
  r2 = norm(b-R*x2) / norm(b)
  e1 = norm(x1-os) / norm(os)
  e2 = norm(x2-os) / norm(os)
endfor

# uwaga:
# zauwazmy ze losujac macierze losowo, prawie zawsze da sie je odwrócic
# (octave nie krzyczal ze odwraca macierz osobliwa)
# to jest uzyteczne do generowania sobie testów itp.

# TODO: Rozwazyc przepisanie wszystkiego do funkcji i skryptów



# teraz bedziemy chcieli zobaczyc jak dokladnie dziala rozklad LU:
for s = sizes2
  A = rand(s);
  [L,U,P] = lu(A);
  
  s
  norm(P*A-L*U)
endfor 

# wniosek: te bledy wygladaja dosyc dobrze
# TODO: mozna sprawdzic czy rozklad LU zwieksza precyzje rozwiazan


# funkcje triu i tril zwracaja czesci trójkatne z macierzy
# maja tez parametr k który wskazuje diagonale wg. której dzielimy macierze
# domyslnie k=0 to diagonala


# na koniec zobaczmy jak wyglada dokladnosc rozkladu QR:
# uwaga: teraz macierz moze byc juz prostokatna
n = 1000
A = rand(n);
[Q,R] = qr(A);

s
norm(Q*R-A)

# kolejny rodzaj walidacji: sprawdzmy czy Q jest macierza ortogonalna
norm(Q'*Q-eye(n))
# blad jest minimalny, wyglada OK


# rozwiazanie zadania najmniejszych kwadratów
