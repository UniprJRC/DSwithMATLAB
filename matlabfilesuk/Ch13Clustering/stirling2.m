function [Sn,S] = stirling2(n,k)
% n:  number of elements to be partitioned.
% k:  number of partitions.
% S:  Stirling triangle. It is a lower triangular matrix whose
% element (i,j) contains the Stirling number S(i,j), i.e., the number of
% j-partitions of a set of i elements. The only way to compute the
% element S(i,j) is to construct all elements with the preceding indices
% i and j. In this sense, there is an analogy with the construction of
% the Tartaglia/Pascal triangle.
% Sn: Stirling number of the k-th class, i.e., the element S(n,k).
S=zeros(n); S(:,1)=1;  
for i=2:n
    for j=2:i
        S(i,j)=S(i-1,j-1)+j*S(i-1,j); % recurrence relation
    end
end
Sn = S(end,k);
