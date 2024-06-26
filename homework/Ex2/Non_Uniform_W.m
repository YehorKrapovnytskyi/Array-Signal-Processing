% This script calculates and plots the array response for a uniform linear array
% with 11 sensors using both uniform and non-uniform weights. The responses are
% compared by plotting them on the same graph.
%
% Parameters:
%   N - Number of sensors in the array (11)
%   n - Sensor positions ranging from -(N-1)/2 to (N-1)/2
%   lambda - Wavelength of the signal (0.03 meters for a 10 GHz signal)
%   d - Element spacing, set to lambda / 2
%   thetas - Angles of interest ranging from 0 to 180 degrees in 1-degree increments
%   w1 - Uniform weights for the sensors
%   w2 - Non-uniform weights for the sensors
%

% Define Parameters
N = 11; % Number of sensors
n = -(N-1)/2:(N-1)/2; % Sensor positions
lambda = 0.03; % Wavelength of 10 GHz signal, lambda is 3 cm
d = lambda / 2; % Element spacing
thetas = 0:1:180; % Angles from 0 to 180 degrees

% Define Weights
w1 = ones(1, N) / N; % Uniform weights
w2 = sin(pi / (2 * N)) * cos(pi * n / N); % Non-uniform weights

% Calculate Array Responses for Different Weights
B_theta_mag_w1 = calculate_array_response(N, d, lambda, thetas, 90, w1);
B_theta_mag_w2 = calculate_array_response(N, d, lambda, thetas, 90, w2);

% Plotting the Array Responses
figure;
hold on;
plot(cosd(thetas), B_theta_mag_w1, 'LineWidth', 1.5, 'DisplayName', 'Uniform Weights');
plot(cosd(thetas), B_theta_mag_w2, 'LineWidth', 1.5, 'DisplayName', 'Non-Uniform Weights');
xlabel('u');
ylabel('Array Response (Magnitude)');
title('Array Response for Uniform and Non-Uniform Weights');
legend('show');
grid on;
hold off;
