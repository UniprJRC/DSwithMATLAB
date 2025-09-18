% Draw a normal random variable with the following parameters and domain.

%% Parameters of the random variable
mu = 0; 
sigma = 1;

%% Domain of the random variable
x = -4:0.1:4; 

% Compute the Y values of the density function
Y = normpdf(x, mu, sigma); 

%% Plot
plot(x, Y, 'LineWidth', 2);