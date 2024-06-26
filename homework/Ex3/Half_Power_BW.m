% This script calculates and plots the half-power beamwidth (3-dB beamwidth) 
% for a uniform linear array as a function of the array parameter Nd/λ. 
%
% Parameters:
%   thetas_steer - Array of steering angles (in degrees)
%   Nd_over_lambda_min - Minimum value for Nd/λ (1)
%   Nd_over_lambda_max - Maximum value for Nd/λ (1000)
%   N_points - Number of points in the log-space range for Nd/λ
%   N_angles - Number of steering angles
%   Nd_over_lambda - Logarithmic scale array for Nd/λ ranging from Nd_over_lambda_min to Nd_over_lambda_max
%   theta_h - Matrix to store the half-power beamwidth values for different Nd/λ and steering angles
%

thetas_steer = [2.5, 5, 10, 20, 30 , 45, 90]; % Steering angles in degrees
Nd_over_lambda_min = 1;
Nd_over_lambda_max = 1000;
N_points = 300;
N_angles = length(thetas_steer);
Nd_over_lambda = logspace(log10(Nd_over_lambda_min), log10(Nd_over_lambda_max), N_points);

theta_h = zeros(N_points, N_angles);

for i = 1:N_angles
    % Compute the arguments for acosd and clip them to be within [-1, 1]
    arg1 = cosd(thetas_steer(i)) - 0.443 ./ Nd_over_lambda;
    arg2 = cosd(thetas_steer(i)) + 0.443 ./ Nd_over_lambda;
    
    % Clip the arguments to be within the range [-1, 1]
    arg1 = min(max(arg1, -1), 1);
    arg2 = min(max(arg2, -1), 1);
    
    % Calculate the 3-dB beamwidth
    theta_h(:, i) = acosd(arg1) - acosd(arg2);
end

% Plotting
figure;
hold on;

for i = 1:N_angles
    plot(Nd_over_lambda, theta_h(:, i), 'DisplayName', ['\theta_{steer} = ' num2str(thetas_steer(i)) '°'], 'LineWidth', 1.5);
end

set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
xlabel('Nd / \lambda');
ylabel('3-dB Beamwidth in degrees');
title('Log-Log Plot of 3-dB Beamwidth vs Nd / \lambda for Various \theta_{steer}');
legend show;
grid on;
hold off;
