function plot_power_pattern_comparison(theta, B_theta_mag_uniform, B_theta_mag_failure, d, lambda)
% Compares and plots the power patterns in the ψ-domain with and without sensor failure.
%
% Parameters:
%   theta (vector) - Angles of interest (in degrees) over which the array response is calculated.
%   B_theta_mag_uniform (vector) - Magnitude of the array response with uniform weights.
%   B_theta_mag_failure (vector) - Magnitude of the array response with sensor failure.
%   d (double) - Element spacing between the sensors.
%   lambda (double) - Wavelength of the signal.
%

    % Calculate spatial frequency and ψ values
    u = cosd(theta);
    psi = -2 * pi / lambda .* u * d;

    % Convert magnitudes to dB scale
    B_power_db_uniform = mag2db(B_theta_mag_uniform);
    B_power_db_failure = mag2db(B_theta_mag_failure);
    
    % Plot power pattern comparison
    figure;
    plot(psi, B_power_db_uniform, 'LineWidth', 1.5, 'DisplayName', 'Uniform Weights');
    hold on;
    plot(psi, B_power_db_failure, 'LineWidth', 1.5, 'DisplayName', 'With Sensor Failure');
    xlabel('\psi');
    ylabel('Power (dB)');
    title('Power Pattern in \psi-Domain with and without Sensor Failure');
    legend show;
    grid on;
end
