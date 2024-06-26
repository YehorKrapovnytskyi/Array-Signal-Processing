% This script simulates a Delay and Sum Beamformer (DSB) and calculates the
% Output-Input Ratio (OIR) for various directions of arrival (DOAs).

% Parameters:
% fs          : Sampling frequency in Hz
% ts          : Sampling time in seconds
% N_sensors   : Number of sensors in the array
% n           : Sensor positions, excluding the zero position
% d           : Distance between sensors in meters
% f_carrier   : Carrier frequency of the input signal in Hz
% c           : Speed of sound in m/s
% DOEs        : Vector of directions of arrival (DOAs) in degrees
% N_signal    : Number of samples in the input signal
% input_signal: Generated narrowband input signal
% delayed_signals: Matrix to store delayed signals for each sensor
% weights     : Weights applied to each sensor signal (ones for DSB)
% output_signals: Matrix to store the beamformed output signals
% OIR         : Vector to store the Output-Input Ratio for each DOA
% t           : Time vector for plotting
%

fs = 1e5;  % Sample frequency
ts = 1/fs; % Sample time 
N_sensors = 10;   % Number of sensors
d = 0.05; % Distance between sensors in meters
f_carrier = 2.33 * 10^3; % 2.33 kHz carrier signal
c = 342; % Speed of sound in m/s
DOEs = 0:1:90; % Different directions of arrival (DOAs)
N_signal = 5000; % Number of samples in the signal

%% Generate input signal and initialize other vectors
input_signal = NB_signal(fs, f_carrier, N_signal);
weights = ones(N_sensors, 1); % Weights are 1 here, broadside orrientation is assumed
output_signals = zeros(length(DOEs), N_signal);
OIR = zeros(length(DOEs), 1); 

% Calculate wavelength and input power
lambda = c / f_carrier;
input_power = mean(input_signal.^2);

for idx = 1:length(DOEs)
    % Delay a signal for every sensor based on direction of arrival
    DOE = DOEs(idx);
    
    output_signals(idx, :) = delay_sum_beamformer(input_signal, fs, DOE, N_sensors, d, c, weights);
    
    % Calculate the OIR
    OIR(idx) = mean(output_signals(idx, :).^2) / input_power;
end

% Enhanced Plotting
t = (0:N_signal-1) * ts;

% First Figure: Input signal and output signals for DOA 0, 45, and 90 degrees
figure;
subplot(4, 1, 1);
plot(t, input_signal, 'k');
title('Input Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-0.2 0.2]);

subplot(4, 1, 2);
plot(t, output_signals(DOEs == 0, :), 'b');
title('Output Signal for DOA = 0°');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-0.2 0.2]);

subplot(4, 1, 3);
plot(t, output_signals(DOEs == 45, :), 'r');
title('Output Signal for DOA = 45°');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-0.2 0.2]);

subplot(4, 1, 4);
plot(t, output_signals(DOEs == 90, :), 'g');
title('Output Signal for DOA = 90°');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-0.2 0.2]);

% Compute the array response (power pattern)
theta_steer = 0; % Steering angle, typically where the main beam is directed
thetas = 0:1:180; % Angles over which to calculate the array response
B_theta_mag = calculate_array_response(N_sensors, d, lambda, thetas, 90, weights' ./ N_sensors);

% Second Figure: OIR vs. DOA and Array Response
figure;
subplot(2, 1, 1);
plot(DOEs, mag2db(OIR), '-o');
title('OIR vs. DOA');
xlabel('DOA (degrees)');
ylabel('OIR (dB)');
grid on;

subplot(2, 1, 2);
plot(thetas, mag2db(B_theta_mag.^2));
title('Array Response (Power Pattern)');
xlabel('Angle (degrees)');
ylabel('Magnitude (dB)');
grid on;
