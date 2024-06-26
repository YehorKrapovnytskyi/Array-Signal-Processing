function plot_array_responses(theta, B_theta_mag, title_suffix, d, lambda)
% Plots the array response in multiple domains and generates a polar plot.
%
% Parameters:
%   theta (vector) - Angles of interest (in degrees) over which the array response is calculated.
%   B_theta_mag (vector) - Magnitude of the array response for each angle in 'theta'.
%   title_suffix (string) - Suffix for the titles of the plots, indicating context (e.g., '10 Sensors').
%   d (double) - Element spacing between the sensors.
%   lambda (double) - Wavelength of the signal.
%

    % Calculate spatial frequency, wave number component, and spatial phase term
    u = cosd(theta);
    kz = -2 * pi / lambda .* u;
    ksi = -kz .* d;

    % Create figure with four subplots
    figure;
    
    subplot(4, 1, 1);
    plot(theta, B_theta_mag, 'LineWidth', 1.5);
    xlabel('\theta (degrees)');
    ylabel('Array Response');
    title(['Array Response in \theta Domain (' title_suffix ')']);
    grid on;

    subplot(4, 1, 2);
    plot(u, B_theta_mag, 'LineWidth', 1.5);
    xlabel('u');
    ylabel('Array Response');
    title(['Array Response in u Domain (' title_suffix ')']);
    grid on;

    subplot(4, 1, 3);
    plot(kz, B_theta_mag, 'LineWidth', 1.5);
    xlabel('k_z');
    ylabel('Array Response');
    title(['Array Response in k_z Domain (' title_suffix ')']);
    grid on;

    subplot(4, 1, 4);
    plot(ksi, B_theta_mag, 'LineWidth', 1.5);
    xlabel('\xi');
    ylabel('Array Response');
    title(['Array Response in \xi Domain (' title_suffix ')']);
    grid on;

    % Adjust the power in dB for polar plot visualization
    B_power_db = mag2db(B_theta_mag);
    B_power_db(B_power_db < -40) = -40;
    B_power_db = B_power_db + 40;
    theta_rad = deg2rad(theta);

    % Create polar plot of array response
    figure;
    polarplot(theta_rad, B_power_db, 'LineWidth', 1.5);
    title(['Polar Plot of Array Response (' title_suffix ')']);
end
