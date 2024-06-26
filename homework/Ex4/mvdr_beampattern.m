% This script calculates the Minimum Variance Distortionless Response (MVDR) weights
% for a uniform linear array (ULA) and plots the power pattern according to them.
%
% Parameters:
% - N_sensors: Number of sensors in the array
% - lambda: Wavelength of the signal
% - d: Distance between adjacent sensors
% - thetas: Angles from 0 to 180 degrees
% - theta_steer: Steering angle
% - sigma_w: Standard deviation of the sensor's Gaussian noise
% - inr_db: Interference-to-Noise Ratio (INR) in dB
% - u_1: Interfering direction (cosine of the angle)
%

N_sensors = 10;
lambda = 0.03; % Wavelength of 10 GHz signal, lambda is 3 cm
d = lambda / 2;
thetas = 0:0.1:180; % Angles from 0 to 180 degrees
theta_steer = 90; % Steering angle
sigma_w = 1; % Assume the sensor's noise is Gaussian with mu = 0, sigma = 1;

%% Assume interference comes from u = 0.3
inr_db = 70;
sigma_interf = db2mag(inr_db);
n = -N_sensors/2:N_sensors/2; n = (n(n ~= 0))'; 
u_s = cosd(theta_steer); % Desired signal direction u = cos(theta_desired) = 0 -> broadside here
v_s = exp(1j .* n .* 2 * pi * d / lambda * u_s); % Manifold vector for desired signal

u_1 = 0.3; % Interfering direction -> u = cos(theta_interferer) = 0.3
v_1 = exp(1j .* n .* 2 * pi * d / lambda * u_1); % Manifold vector for interferer
S_n = sigma_w * eye(N_sensors) + sigma_interf * (v_1 * v_1'); % Sensor noise + interferer covariance matrix

w_mvdr_H = (v_s' / S_n) / (v_s' / S_n * v_s); % Calculate MVDR weights

B_theta_mag = calculate_array_response(N_sensors, d, lambda, thetas, theta_steer, w_mvdr_H);

% Plotting the power pattern
figure;
plot(thetas, B_theta_mag);
title('MVDR Beamforming Power Pattern');
xlabel('Angle (degrees)');
ylabel('Magnitude');
grid on;
legend('Interference direction: u = 0.3');

%% Assume interference comes from u = 0.004
u_1 = 0.004; % Interfering direction -> u = cos(theta_interferer) = 0.004
v_1 = exp(1j .* n .* 2 * pi * d / lambda * u_1); % Manifold vector for interferer
S_n = sigma_w * eye(N_sensors) + sigma_interf * (v_1 * v_1'); % Sensor noise + interferer covariance matrix

w_mvdr_H = (v_s' / S_n) / (v_s' / S_n * v_s); % Calculate MVDR weights

B_theta_mag = calculate_array_response(N_sensors, d, lambda, thetas, theta_steer, w_mvdr_H);

% Plotting the power pattern
figure;
plot(thetas, B_theta_mag);
title('MVDR Beamforming Power Pattern');
xlabel('Angle (degrees)');
ylabel('Magnitude');
grid on;
legend('Interference direction: u = 0.004');




