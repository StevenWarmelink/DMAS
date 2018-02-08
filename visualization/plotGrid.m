function plotGrid(t, Dims, Data, Model, TrackCoordinates, Tracking, DataColumn)

% Create meshgrid of N*N dimensions. If this is not the first plot, clear
% the figure. 
[X,Y]=meshgrid(1:Dims);
if t ~= 1
    clf;
end

figure(1); hold on;
plot(X,Y,'k');
pbaspect([1 1 1]);
xlabel(['T = ',num2str(t)]);
axis([1 (Dims+1) 1 (Dims+1)]);
I = ones(Dims+1)*-1;
for i = 1:Dims
    for j = 1:Dims
        % J and I are flipped because X and Y are flipped in Data
        % Accessing the (i-1)*10+jth element corresponds to the coordinates
        DataEntry = ((i-1)*10)+j;
        I(j,i) = Data(DataEntry,DataColumn); 
    end
end
surface(I);

end