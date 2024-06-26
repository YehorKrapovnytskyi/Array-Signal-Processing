function plot_power_pattern(theta, d_over_lambda, B_theta_dlambda)
% Displays the power pattern of the array response over a range of d/lambda.
%
% Parameters:
%   theta (vector) - Angles of interest (in degrees) over which the array response is calculated.
%   d_over_lambda (vector) - Logarithmic scale of element spacing normalized by the wavelength (d/lambda).
%   B_theta_dlambda (matrix) - Array response matrix where each row corresponds to a different d/lambda value.
%

    % Generate figure for the power pattern
    figure;
    
    % Create an image plot of the power pattern in dB
    imagesc(theta, log10(d_over_lambda), 10*log10(abs(B_theta_dlambda))); 
    colorbar; % Show color scale

    % Label the axes
    xlabel('\theta (degrees)');
    ylabel('log_{10}(d/\lambda)');
    
    % Set the title of the plot
    title('Power Pattern in \theta-Space (Log Scale)');
    
    % Enable grid
    grid on;
end
