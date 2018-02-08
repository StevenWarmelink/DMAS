function [ is_leaving ] = should_leave_city( opts )
%SHOULD_LEAVE_CITY Determine if an agent should leave the city

roll = rand(1,1);
is_leaving = roll < opts.p_leave;

end

