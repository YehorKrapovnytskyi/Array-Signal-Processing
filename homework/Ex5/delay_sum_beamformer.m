function output_signal = delay_sum_beamformer(input_signal, fs, DOE, N_sensors, d, c, weights)
    

    % Calculate sensor positions 'n' for both even and odd N
    if mod(N_sensors, 2) == 0
        n = -N_sensors/2:N_sensors/2;
        n = n(n ~= 0); % Exclude zero for even N
    else
        n = -(N_sensors-1)/2:(N_sensors-1)/2; % For odd N
    end

    N_signal = length(input_signal);
    delayed_signals = zeros(N_sensors, N_signal);
    
    taus = -1 * (cosd(DOE) .* n * d) / c;  % tau = -position/c, given ULA p_x, p_y = 0, p_z = n * d * cos(DOE)  
    for i = 1:N_sensors
        delayed_signal = delay_signal(input_signal, taus(i), fs);
        delayed_signals(i, :) = delayed_signal;
    end
    output_signal = sum(delayed_signals .* weights, 1) / N_sensors;
end

