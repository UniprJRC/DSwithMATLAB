% r is any positive number
r=2;
% Sequence of k values required by the exercise
kk=[0.25 0.5 1 2 4 10];
% The x coordinates range from -r to r
x=(-r:0.001:r)';

for j=1:length(kk)
    subplot(2,3,j)
    k=kk(j);
    % Find the y coordinate of the equation |x|^k + |y|^k = r^k
    y=(r^k-abs(x).^k).^(1/k);
    %plot(x,y)

    plot([x;x],[y;-y])
    % Add Cartesian axes
    xline(0)
    yline(0)
    % Fix min and max limits for the x-axis
    xlim([-r*1.1 r*1.1])
    % Insert the current k value in the title
    title(['k=' num2str(k)])
    % Same scale for both axes
    axis equal
end
% print -depsc figs\minkcontour.eps;

%% NOT IN THE BOOK
figure
% Add to each panel the circle with radius r
% Arbitrary value for r
r=2;
% Sequence of k values required by the exercise
kk=[0.25 0.5 1 2 4 10];
% The x coordinates range from -r to r
x=(-r:0.001:r)';

for j=1:length(kk)
    subplot(2,3,j)
    k=kk(j);
    % Find the y coordinate of the equation |x|^k + |y|^k = r^k
    y=(r^k-abs(x).^k).^(1/k);
    % plot(x,y)

    plot([x;x],[y;-y])
    % Add Cartesian axes
    xline(0)
    yline(0)
    % Fix min and max limits for the x-axis
    xlim([-r*1.1 r*1.1])
    % Insert the current k value in the title
    title(['k=' num2str(k)])
    % Same scale for both axes
    axis equal
    % Add the circle of radius r
    hold on
    k=2;
    y=(r^k-abs(x).^k).^(1/k);
    plot([x;x],[y;-y])
end

%% Euclidean distance based on elementary vectors

X = [1.2 2.1; 3.4 5.1; 1.9 2.2; 4.1 2.3; 4.2 2.9];
n=size(X,1);
k=2;

D=squareform(pdist(X,'minkowski',k));
nomirighe=string(('A':'E')');
% The array D is converted into a table
Dtable=array2table(D,"RowNames",nomirighe,"VariableNames",nomirighe);
disp(Dtable)

ei=zeros(5,1);
ei(1)=1;
ej=zeros(5,1);
ej(2)=1;

dist12=((ei-ej)'*(X*X')^(k/2)*(ei-ej))^(1/k);
% dist12 corresponds to the element (1,2) of the Dtable
disp(dist12)