function B_theta_mag = calculate_array_response(N_sensors, d, lambda, thetas, theta_steer, w_H)
% Computes the magnitude of the array response for a uniform linear array.
%
% Parameters:
%   N_sensors (integer) - Number of sensors in the array.
%   d (double) - Element spacing between the sensors.
%   lambda (double) - Wavelength of the signal.
%   thetas (vector) - Angles of interest (in degrees) over which the array response is calculated.
%   theta_steer (double) - Steering angle of the array (in degrees).
%   w_H (vector) - Weights applied to each sensor.
%
% Returns:
%   B_theta_mag (vector) - Magnitude of the array response for each angle in 'thetas'.
%

    % Calculate sensor positions 'N_sensors' for both even and odd N_sensors
    if mod(N_sensors, 2) == 0
        N_sensors = -N_sensors/2:N_sensors/2;
        N_sensors = (N_sensors(N_sensors ~= 0))'; % Exclude zero for even N_sensors
    else
        N_sensors = (-(N_sensors-1)/2:(N_sensors-1)/2)'; % For odd N_sensors
    end
    
    % Initialize array response 'B_theta'
    B_theta = zeros(1, length(thetas));
    
    % Compute the array response for each angle in 'thetas'
    for i = 1:length(thetas)
        B_theta(i) = w_H * exp(1j .* N_sensors .* 2 * pi * d / lambda * (cosd(thetas(i)) - cosd(theta_steer)));
    end
    
    % Return the magnitude of the array response
    B_theta_mag = abs(B_theta).^2;
end
