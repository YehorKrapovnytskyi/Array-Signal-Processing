% This script calculates and plots the array response and power patterns 
% for uniform linear arrays with 10 and 11 sensors. It also compares the 
% power pattern in the ψ-domain with and without sensor failure in a single figure.
%
% Parameters:
%   lambda - Wavelength of the signal (0.03 meters for a 10 GHz signal)
%   d - Element spacing, set to lambda / 2
%   thetas - Angles of interest ranging from 0 to 180 degrees in 1-degree increments
%   thetas_steer - Array of steering angles (in degrees)
%   d_over_lambda - Logarithmic scale for element spacing over wavelength 
%                   ranging from 0.001 to 1
%   B_theta_dlambda - Array response matrix initialized to zeros
%   N - Number of sensors in the array (10 or 11)
%   w - Uniform weights for the sensors (equal weights)
%

% Define Parameters
lambda = 0.03; % Wavelength of 10 GHz signal, lambda is 3 cm
d = lambda / 2; % Element spacing
thetas = 0:1:180; % Angles from 0 to 180 degrees
thetas_steer = [0, 30, 60, 90]; % Steering angles

% Logarithmic scale for element spacing over wavelength
d_over_lambda = logspace(log10(0.001), log10(1), 100); 
B_theta_dlambda = zeros(length(d_over_lambda), length(thetas)); % Initialize response matrix

%% 10 Sensors
N = 10; % Number of sensors
w_10 = ones(1, N) / N; % Uniform weights

for theta_steer = thetas_steer
    B_theta_mag_10 = calculate_array_response(N, d, lambda, thetas, theta_steer, w_10);
    plot_array_responses(thetas, B_theta_mag_10, '10 Sensors', d, lambda);

    for i = 1:length(d_over_lambda)
        B_theta_dlambda(i, :) = calculate_array_response(N, d_over_lambda(i), 1, thetas, theta_steer, w_10);
    end

    % Plot power pattern
    plot_power_pattern(thetas, d_over_lambda, B_theta_dlambda);
end

%% 11 Sensors
N = 11; % Number of sensors
w_11 = ones(1, N) / N; % Uniform weights

for theta_steer = thetas_steer
    B_theta_mag_11 = calculate_array_response(N, d, lambda, thetas, theta_steer, w_11);
    plot_array_responses(thetas, B_theta_mag_11, '11 Sensors', d, lambda);

    for i = 1:length(d_over_lambda)
        B_theta_dlambda(i, :) = calculate_array_response(N, d_over_lambda(i), 1, thetas, theta_steer, w_11);
    end

    % Plot power pattern
    plot_power_pattern(thetas, d_over_lambda, B_theta_dlambda);
end

%% Sensor Failure Analysis for 11 Sensors
w_failure = w_11;
w_failure(3) = 0; w_failure(5) = 0; w_failure(6) = 0; % Simulate sensor failures

% Calculate array response with sensor failure
B_theta_mag_11_failure = calculate_array_response(N, d, lambda, thetas, theta_steer, w_failure);

%% Plot Power Pattern Comparison in the ψ-Domain
plot_power_pattern_comparison(thetas, B_theta_mag_11, B_theta_mag_11_failure, d, lambda);
