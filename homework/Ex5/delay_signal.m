function y = delay_signal(x, delay, fs)
    % Delay a signal by an integer and fractional delay
    % x     : input signal
    % delay : delay in seconds
    % fs    : sampling frequency in Hz
    % y     : delayed signal
    
    % Convert delay to samples
    delay_samples = delay * fs;

    % Separate integer and fractional parts of the delay
    int_delay = floor(delay_samples);
    frac_delay = delay_samples - int_delay;

    % Apply integer delay
    x_int_delayed = apply_integer_delay(x, int_delay);

    % Apply fractional delay using interpolation
    y = apply_fractional_delay(x_int_delayed, frac_delay);
end

function y = apply_integer_delay(x, D)
    % Apply integer delay to the signal x
    % D: integer number of samples to delay
    if D > 0
        y = [zeros(1, D), x(1:end-D)];
    elseif D < 0
        y = [x(-D+1:end), zeros(1, -D)];
    else
        y = x;
    end
end

function y = apply_fractional_delay(x, frac_delay)
    % Apply fractional delay to the signal x using interpolation
    % frac_delay: fractional delay in samples (0 <= frac_delay < 1)
    n = length(x);
    t = 1:n;
    t_frac = t - frac_delay;
    
    % Linear interpolation (or use higher-order interpolation if needed)
    y = interp1(t, x, t_frac, 'linear', 'extrap');
end