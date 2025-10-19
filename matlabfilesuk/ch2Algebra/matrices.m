%% Matrix multiplication
A = [3 -3 9; 10 0 4; 0 2 -1];
B = [-1 5; 7 3; 0 6];
C = A * B;
disp(C)

%% Diagonal matrices
D = diag([2 5 7]);
disp(D)

%% Superdiagonal matrix
E = diag([2 5 7], 1);
disp(E)

%% Extract elements on the main diagonal
rng(10);
A = randi(15, 5);
a = diag(A);
disp(a)

%% Extract elements two diagonals below the main one
b = diag(A, -2);
disp(b)

%% Identity matrix
I = eye(3);
disp(I)

%% Rectangular matrix with 1s on the main diagonal
A = eye(4, 6);

%% Identity matrix created with a double for loop
p = 5;
ID = zeros(p, p);
for i = 1:p
    for j = 1:p
        if i == j
            % Notice that we could write ID(j,j)=1 or ID(i,j)=1
            % since in the line below i=j
            ID(i, i) = 1;
        end
    end
end
% ID and IDchk are equal
IDchk = eye(p);

assert(isequal(ID, IDchk), "Programming error in " + ...
    "creating the identity matrix using a double for loop")

%% Matrix of ones
disp(ones(2, 3))

%% Matrix of zeros
disp(zeros(3, 4))

%% Matrix with all elements equal to 5
disp(5 * ones(3, 4))

%% Magic matrix of dimension kxk
k = 3;
magic(k)
