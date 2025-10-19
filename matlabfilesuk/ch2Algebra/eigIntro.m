%% Characteristic polynomial and its roots
% Eigenvalue computation
A=[2 2; 1 3];
disp('Coefficients of the characteristic polynomial')
characteristic_polynomial=poly(A);
disp('The characteristic polynomial is:')

% If the coefficient of the first-degree term is positive it is necessary
% to insert in disp the string '+'
if characteristic_polynomial(2)>0
    coeffx=['+' num2str(characteristic_polynomial(2))];
else
    coeffx=num2str(characteristic_polynomial(2));
end
% If the constant term is positive it is necessary
% to insert in disp the string '+'
if characteristic_polynomial(3)>0
    constant_term=['+' num2str(characteristic_polynomial(3))];
else
    constant_term=num2str(characteristic_polynomial(3));
end

disp([' x^2 ' coeffx 'x ' constant_term])

disp('The roots of the characteristic polynomial (eigenvalues) are:')
disp(roots(characteristic_polynomial))

%% Eigenvalues and eigenvectors using the eig function
% If eig is called with a single output argument, then the eigenvalues are
% returned in a column vector
eigenvalues=eig(A);

%% Eigenvalue and eigenvector computation
% If eig is called with two output arguments,
% the first output argument is the eigenvector matrix and the second
% the diagonal matrix of eigenvalues
[V,Lambda]=eig(A);

disp('Eigenvalue matrix (ordered from smallest to largest)')
disp(Lambda)
disp('Associated eigenvector matrix')
disp(V)

% Ordering of eigenvalues
d=diag(Lambda);
[~,permutation]=sort(d,"descend");

% Lambda(1,1) largest eigenvalue
% Lambda(2,2) second largest eigenvalue
Lambda=diag(d(permutation));
% First column of V = eigenvector associated with the largest eigenvalue
% Second column of V = eigenvector associated with the second largest eigenvalue
V=V(:,permutation);
disp('Eigenvalue matrix (ordered from largest to smallest)')
disp(Lambda)
disp('Associated eigenvector matrix')
disp(V)


%% Eigenvalues and eigenvectors using symbolic computation
% In symbolic computation, the starting matrix A is initially defined
% as symbolic. All other instructions are the same. Calculations, however,
% are performed symbolically.
A=sym([2 2; 1 3]);

[V,Lambda]=eig(A);

% Order eigenvalues from largest to smallest and match the eigenvector matrix
% (first column of V eigenvector associated with the largest eigenvalue,
% second column of V eigenvector associated with the second largest eigenvalue).
% Verify that the eigenvector matrix (since A is symmetric) is orthogonal (V'V=I)
d=diag(Lambda);
[~,permutation]=sort(d,"descend");

% Lambda(1,1) largest eigenvalue
% Lambda(2,2) second largest eigenvalue
Lambda=diag(d(permutation));
% First column of V = eigenvector associated with the largest eigenvalue
% Second column of V = eigenvector associated with the second largest eigenvalue
V=V(:,permutation);
% Note: eigenvectors obtained with symbolic computation are not normalized to 1,
% therefore it is necessary to divide each column by the square root
% of the sum of the squares of each column.
V1=V./sqrt(sum(V.^2,1));
disp("Eigenvalue matrix ordered (non-increasing order)")
disp(Lambda)
disp("Normalized eigenvector matrix (corresponding to the ordered eigenvalues)")
disp(V1)


%% Another example of spectral decomposition
% Compute eigenvalues and eigenvectors symbolically
% of matrix A defined as follows
% [          1/3, (2*5^(1/2))/3]
% [(2*5^(1/2))/3,           2/3]
% Order eigenvalues from largest to smallest and match the eigenvector matrix
% (first column of V eigenvector associated with the largest eigenvalue,
% second column of V eigenvector associated with the second largest eigenvalue).
% Verify that the eigenvector matrix (since A is symmetric) is orthogonal (V'V=I)

A=sym([1/3 sqrt(20)/3; sqrt(20)/3 2/3]);

[V,Lambda]=eig(A);
d=diag(Lambda);
[~,permutation]=sort(d,"descend");

% Lambda(1,1) largest eigenvalue
% Lambda(2,2) second largest eigenvalue
Lambda1=diag(d(permutation));
% First column of V = eigenvector associated with the largest eigenvalue
% Second column of V = eigenvector associated with the second largest eigenvalue
V=V(:,permutation);
V1=V./sqrt(sum(V.^2,1));

disp("Eigenvalue matrix ordered (non-increasing order)")
disp(Lambda1)
disp("Eigenvector matrix (corresponding to the ordered eigenvalues)")
disp(V1)


% The matrix V1 in this case is orthogonal since the starting matrix is
% symmetric
disp('Verifying the orthogonality of matrix V1')
disp(V1'*V1)

disp('Verifying the reconstruction of the original matrix')
disp(V1*Lambda1*V1')






