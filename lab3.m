# macierz Vandermonde'a
# 1 x_1, x_1^2, ..., x_1^n
# 1 x_2, x_2^2, ..., x_2^n
# ...

# LNZK z A i b: min_x |Ax-b|_2
# gdzie A - pierwsze m kolumn z V
# b := x=[x_i]
# rozwiazanie dokladne: x* = [0 1 0 ... 0]' w R^m

# rozwiazanie 1 (LNZK):
x1 = A\b;

# rozwiazanie 2 (QR):
[Q,R] = qr(A);
# Rx = Q'b, przy czym macierze R i Q musza byc kwadratowe:
x2 = R(1:m,:)\((Q'*b)(1:m));

# kolumny V sa liniowo niezalezne
# A'*A jest nieosobliwa, symetryczna i dodatnio okreslona
# zatem rozwiazanie 3 (rozklad Choleskiego):
# A'Ax = A'b
# A'A = LL'
L = chol(A);
# wtedy rozwiazujemy LL'x = A'b
# rozwiazujac najpierw Ly = A'b
# a nastepnie L'x = y (kod still ma 1 linie):
x3 = L'\(L\A'b);

# generowanie macierzy Vandermonde'a:
V = fliplr(vander(x));  # gdzie x to wektor generujacy macierz
A = V(:,1:m);

# bedziemy chcieli policzyc bledy:
# |x-x*|/|x*|, gdzie x = x1 | x2 | x3
# |b-Ax|/|b|
# a x* to [0 1 0 ... 0]' co powinno nam dac x wyjsciowe = x wejsciowe

# z parametrami:
# n = 100, m = 2,10,20,100
# przy czym n sluzy do parametryzacji x wejsciowego:
# i = 1,..,n
# x_i = (i-1)h
# h = 1/(n-1)

# rozwiazanie
ems = [2,10,20,100];
n = 100;
h = 1/(n-1);
b = (0.0:1.0/(n-1):1.0)';

for m = ems
  m
  A = fliplr(vander(b))(:,1:m);
  xstar = zeros(m,1);
  xstar(2) = 1;
  # LNZK
  x1 = A\b;
  # QR
  [Q,R] = qr(A);
  x2 = R(1:m,:)\((Q'*b)(1:m));
  # Cholesky
  L = chol(A'*A, "lower");  # fails at m=20 for some reason
  x3 = L'\(L\A'*b);
  # accuracy output
  for x = [x1,x2,x3]
    if x == x1
      "LNZK"
    elseif x == x2
      "QR"
    elseif x == x3
      "Cholesky"
    endif  
    r = norm(x - xstar) / norm(xstar)
    e = norm(b - A*x) / norm(b)
  endfor
endfor


# metody iteracyjne
# x^(k+1) = (I-Q^{-1}A)x^(k) + Q^{-1}b
# m. Jacobiego: Q = D - diagonala A
# m. Gaussa-Seidela: A = TRIL(A)
# Qx^(k+1) = (Q-A)x^(k)+b
# X^(0) [0 ... 0]'
# warunek stopu:
# - ograniczenie liczby iteracji
# - |x^(k+1)-x^(k)| < epsilon (parametr ustalony z góry)

# TODO: Przepisac info ze zdjecia, zaprogramowac iteracje 
# (TBC na nastepnych labach)