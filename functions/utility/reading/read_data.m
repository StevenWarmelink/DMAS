function [ data ] = read_data( opts )
%READ_DATA read the data-file
    data = csvread(opts.file_name, 1, 0);
end

