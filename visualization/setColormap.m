function setColormap(usingEconomicalModel, Max_val, Min_val)
    h=linspace(0,1,64);
h(1) = 0;
if(usingEconomicalModel)
    r = h';
    g = [0, zeros(1,63)]';
    invH = (1.-h');
    invH(1) = 1;
    b = invH;
    h=[r,g,b];
else
    invH = (1.-h');
    invH(1) = 1;
    r = invH;
    g = h';
    b = invH;
    h=[r,g,b];
end
colormap(h);
colorbar;
caxis([0 1]);
end