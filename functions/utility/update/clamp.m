function [ value ] = clamp( low, value, high )
%CLAMP Clamp value by min and max
    value = min(max(value, low), high);
end

