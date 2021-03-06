function outT = least_error(histo, startT)
    % Calculates a threshold value from a histogram using the least-error method.
    %
    % histo: A 1D array histogram.
    % The histogram bins must correspond to gray value 0, 1, 2,...
    % startT: start threshold
    % outT: the calculated threshold (integer)
    num = length(histo);
    t0 = floor(startT);
    t1 = t0+2;

    % Calculate the threshold
    %------------------------
    while abs(t0-t1) > 0.5
    t0 = t1;

    % Calculate mean for the lower part of the histogram
    %---------------------------------------------------
    lowersum1 = sum(histo(1:t0+1).*[0:t0]);
    lowersum2 = sum(histo(1:t0+1));
    if lowersum2 ~= 0
        mean0 = lowersum1/lowersum2;
    else
        error('Cannot calculate new threshold');
    end

    % Calculate mean for the upper part of the histogram
    %---------------------------------------------------
    uppersum1 = sum(histo(t0+2:num).*[t0+1:num-1]);
    uppersum2 = sum(histo(t0+2:num));
    if uppersum2 ~= 0
        mean1 = uppersum1/uppersum2;
    else
        error('Cannot calculate new threshold');
    end

    % Calculate total probability for the lower part of the histogram
    %---------------------------------------------------
    lowersum1 = sum(histo(1:t0+1));
    lowersum2 = sum(histo(1:num));
    if lowersum2 ~= 0
        p0 = lowersum1/lowersum2;
    else
        error('Cannot calculate total probability')
    end

    % Calculate total probability for the upper part of the histogram
    %---------------------------------------------------
    uppersum1 = sum(histo(t0+2:num));
    uppersum2 = sum(histo(1:num));
    if uppersum2 ~= 0
        p1 = uppersum1/uppersum2;
    else
        error('Cannot calculate total probability')
    end

    % Calculate variance for the lower part of the histogram
    %---------------------------------------------------
    lowersum1 = sum(histo(1:t0+1).*([0:t0]-mean0).^2);
    lowersum2 = sum(histo(1:t0+1));
    if lowersum2 ~= 0
        s0 = lowersum1/lowersum2;
    else
        error('Cannot calculate variance')
    end

    % Calculate variance for the upper part of the histogram
    %---------------------------------------------------
    uppersum1 = sum(histo(t0+2:num).*([t0+1:num-1]-mean1).^2);
    uppersum2 = sum(histo(t0+2:num));
    if uppersum2 ~= 0
        s1 = uppersum1/uppersum2;
    else
        error('Cannot calculate variance')
    end

    % Calculate new threshold
    %------------------------
    a = (s0*s1)/(s1-s0);
    b = 2*(-(mean0/s0)+(mean1/s1));
    c = -2*log(p0/p1)+log(s0/s1)+(mean0^2/s0)-(mean1^2/s1);
    t1 = floor((roots([1 a*b a*c])));
    
    if t1(1) > mean0 && t1(1) < mean1
        t1 = t1(1);
    else
        t1 = t1(2);
    end
end
outT = t1;