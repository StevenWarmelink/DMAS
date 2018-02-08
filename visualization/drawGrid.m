function drawGrid(Dims,Time,Data,Speed,economicalMode,TrackCoordinates, Max_val, Min_val, DataColumn)
pause(1.0/Speed);
t = Time;

plotGrid(t, Dims, Data, economicalMode, TrackCoordinates, true, DataColumn);

setColormap(economicalMode, Max_val, Min_val);

end