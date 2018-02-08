% Simple exploration of the data

%% --- Initialization
addpath(genpath('.'));


opts = struct();
%opts.file_name = fullfile('.','data','uniform-linear-1.csv');
%opts.file_name = fullfile('.','data','logistic_nocost.csv');
%opts.file_name = fullfile('.','data','almost_segregation.csv');
%opts.file_name = fullfile('.','data','almost_segregation_2.csv');
opts.file_name = fullfile('.','data','almost_balanced.csv');
%opts.file_name = fullfile('.','data','test.csv');

data = read_data(opts);
dims = [max(x_of(data)) max(y_of(data))];


%% --- Show the distribution of G
close all
% agent ids

e0 = filter_epoch(data, 0);
e1 = filter_epoch(data, max(epoch_of(data)));
ids0 = unique(id_of(e0));
ids1 = unique(id_of(e1));


% 0 means empty house so remove those
ids0 = ids0(ids0 > 0)';
ids1 = ids1(ids1 > 0)';

% allocate
g0 = zeros(size(ids0));
g1 = zeros(size(ids1));

for idx = 1:length(ids0)
    %extract their data
    agent = filter_id(data, ids0(idx));
    % g is fixed over time so get the first value
    g0(idx) = g_of(agent(1,:));
end

for idx = 1:length(ids1)
    %extract their data
    agent = filter_id(data, ids1(idx));
    % g is fixed over time so get the first value
    g1(idx) = g_of(agent(1,:));
end

figure(1)
subplot(1, 2, 1)
hist(g0, 20);
xlabel('Growth term: Ra')
title('Distribution of initial growth terms')
xlim([0, 1]);
ylim([0, 300])
subplot(1, 2, 2)
hist(g1, 20);
title('Distribution of final growth terms')
xlabel('Growth term: Ra')
xlim([0, 1]);
ylim([0, 300])


%% --- Avg S and V over time
close all
% Get data
times = unique(epoch_of(data))';
ids = unique(id_of(data));
ids = ids(ids > 0)';

% allocate
avg_houses = zeros(size(times));
sd_houses = zeros(size(times));
avg_agents = zeros(size(times));
sd_agents = zeros(size(times));
occupied = zeros(size(times));
tension = zeros(size(times));

% compute values
for idx = 1:length(times)   
    e0 = filter_epoch(data, times(idx));
    % Remove empty cells from the vector
    agnt = filter_id(e0, ids);
    
    avg_houses(idx) = mean(v_of(e0));
    sd_houses(idx) = var(v_of(e0));
    avg_agents(idx) = mean(s_of(agnt));
    sd_agents(idx) = var(s_of(agnt));
    occupied(idx) = length(agnt) / length(e0);
    tension(idx) = mean(nb_t_of(agnt));
end

% Plot
figure(2)
hold off
plot(times, avg_houses, 'b.');
hold on
plot(times, avg_agents, 'r.');
plot(times, occupied, 'g.');
plot(times, tension, 'k.');
ylim([0, 1]);
xlim([0, max(times)]);
legend('houses', 'agents', 'occupied', 'nb\_tension')
xlabel('Epoch')
ylabel('Value')


%% --- Compute agent lifetime

ids = unique(id_of(data));
ids = ids(ids > 0)';

lifetimes = zeros(size(ids));

for idx = 1:length(ids)
    agent = filter_id(data, ids(idx));
    es = epoch_of(agent);
    lifetimes(idx) = max(es) - min(es);
end

disp(['Max lifetime:  ', num2str(max(lifetimes))]);
disp(['Min lifetime:  ', num2str(min(lifetimes))]);
disp(['Mean lifetime: ', num2str(mean(lifetimes))]);
disp(['Std lifetime:  ', num2str(std(lifetimes))]);

%% --- Plot s over time for each agent
close all
% agent ids
ids = unique(id_of(data));
% 0 means empty house so remove those
ids = ids(ids > 0)';
% loop over the agents

for id = ids
    %extract their data
    agent = filter_id(data, id);
    % plot s over t
    figure(2)
    hold off
    plot(epoch_of(agent), s_of(agent), 'k.');
    hold on
    plot(epoch_of(agent), g_of(agent), 'r.');
    ylim([0, 2])
    xlim([0, max(epoch_of(data))])
    
    pause
end

%% --- Calculate and plot number of clusters
close all
times = unique(epoch_of(data))';
% discrep: range of values agents find acceptable. 0.1 = within 10%
discrep = 0.20;
% Mode: 0 = moore, 1 = Neumann
mode = 0;
% occupied 0: look at all surrounding cells, regardless of whether they are occupied;
% occupied 1: take only occupied houses into account
occupied = 1;
% show plots over time
show_plot = false;
mooreClusterList = [];
neumannClusterList = [];
for t = times(2:end)
    numMooreClusters = 0;
    numNeumannClusters = 0;
    mooreClusterVals = [];
    neumannClusterVals = [];
    e0 = filter_epoch(data, t);
    for x = 2:(max(x_of(data)) - 1)
       for y = 2:(max(y_of(data)) - 1)
           if occupied == 0
               [moore, mooreval] = is_moore_cluster(e0,x,y,discrep);
               [neumann, neuval] = is_neumann_cluster(e0,x,y,discrep);
           else 
               [moore, mooreval] = is_moore_cluster_occupied(e0,x,y,discrep);
               [neumann, neuval] = is_neumann_cluster_occupied(e0,x,y,discrep);               
           end
           if moore
               numMooreClusters = numMooreClusters + 1;
               mooreClusterVals = [mooreClusterVals, mooreval];
           end
           if neumann
               numNeumannClusters = numNeumannClusters + 1;
               neumannClusterVals = [neumannClusterVals, neuval];
           end           
       end
    end
    
    if show_plot
        figure(1)
        subplot(2,1,1)
        hist(mooreClusterVals, 25)
        xlim([0,1])
        title('Moore Cluster (9 cell cluster) Values')
        xlabel(['Cluster Value T = ',num2str(t),'; N\_clusters =',num2str(numMooreClusters)])
        ylabel('Count')

        subplot(2,1,2)
        hist(neumannClusterVals, 25)
        xlim([0,1])
        title('Neumann Cluster (5 cell cluster) Values')
        xlabel(['Cluster Value T = ',num2str(t),'; N\_clusters =',num2str(numNeumannClusters)])
        ylabel('Count')

        pause(0.02)
    end
    mooreClusterList = [mooreClusterList, numMooreClusters];
    neumannClusterList = [neumannClusterList, numNeumannClusters];
end

figure(2)
hold off
plot(1:100,mooreClusterList)
hold on
plot(1:100,neumannClusterList)
xlim([1,100])
ylim([0,400])
xlabel('Epoch')
ylabel('# Clusters')
legend('Moore', 'Von Neumann')


%% --- Show the state over time
close all
times = unique(epoch_of(data))';
ids = unique(id_of(data));
ids = ids(ids > 0)';
e0 = filter_epoch(data, 0);
state = convert_to_state(e0);

% Create the initial figures

figure(1)
subplot(2, 2, 1)
colormap gray
caxis([0,1])
v = surface(state.v, 'FaceColor', 'flat');
xlim([0, dims(1)]);
ylim([0, dims(2)]);
title('House values')
subplot(2, 2, 2)
colormap gray
caxis([0,1])
s = surface(state.s, 'FaceColor', 'flat');
xlim([0, dims(1)]);
ylim([0, dims(2)]);
title('Agent economic status')
subplot(2, 2, 3)
colormap gray
caxis([0,1])
g = surface(state.g, 'FaceColor', 'flat');
xlim([0, dims(1)]);
ylim([0, dims(2)]);
title('Agent growth term');
subplot(2,2,4)
colormap gray
caxis([0,1])
nb_t = surface(state.nb_t, 'FaceColor', 'flat');
xlim([0, dims(1)]);
ylim([0, dims(2)]);
title('Neighbourhood tension')

figure(2)
subplot(2, 2, 1)
hist(v_of(filter_id(e0, ids)), 20);
xlim([0,1])
title('House values')
subplot(2, 2, 2)
hist(s_of(filter_id(e0, ids)), 20);
xlim([0,1])
title('Agent economic status')
subplot(2, 2, 3)
hist(g_of(filter_id(e0, ids)), 20);
xlim([0,1])
title('Agent growth term')
subplot(2, 2, 4)
hist(nb_v_of(filter_id(e0, ids)), 20);
xlim([0,1])
title('Neighbourhood value')

for t = times(2:end)   
    e0 = filter_epoch(data, t);
    state = convert_to_state(e0);
    
    figure(1)
    subplot(2, 2, 1)
    delete(v)
    v = surface(state.v, 'FaceColor', 'flat');
    subplot(2, 2, 2)
    delete(s)
    s = surface(state.s, 'FaceColor', 'flat');
    subplot(2, 2, 3)
    delete(g)
    g = surface(state.g, 'FaceColor', 'flat');
    subplot(2,2,4)
    delete(nb_t)
    nb_t = surface(state.nb_t, 'FaceColor', 'flat'); 
    
        figure(2)
    subplot(2, 2, 1)
    hist(v_of(filter_id(e0, ids)), 20);
    xlim([0,1])
    title('House values')
    subplot(2, 2, 2)
    hist(s_of(filter_id(e0, ids)), 20);
    xlim([0,1])
    title('Agent economic status')
    subplot(2, 2, 3)
    hist(g_of(filter_id(e0, ids)), 20);
    xlim([0,1])
    title('Agent growth term')
    subplot(2, 2, 4)
    hist(nb_v_of(filter_id(e0, ids)), 20);
    xlim([0,1])
    title('Neighbourhood value')

    pause(0.1)
end

%% --- Plot s^t - s^t+1 for an agent
close all
ids = unique(id_of(data));
ids = ids(ids > 0)';
% 
% lifetimes = zeros(size(ids));
% 
% for idx = 1:length(ids)
%     agent = filter_id(data, ids(idx));
%     es = epoch_of(agent);
%     lifetimes(idx) = max(es) - min(es);
% end
% 
% [~, idx] = max(lifetimes);

for idx = 1:length(ids)

    agent = filter_id(data, ids(idx));    
    values = s_of(agent);
    time = epoch_of(agent);
    
    if isempty(time)
        continue
    end
    
    x = values(1:(end - 1));
    y = values(2:end);
    
    figure(1)
    plot(x, y);
    xlabel('agent value at time=t')
    ylabel('agent value at time=t+1')
    xlim([0, 1]);
    ylim([0, 1]);

    figure(2)
    plot(time, values)
    ylim([0, 1])
    xlim([0, max(max(time), 1)])
    xlabel('Time')
    ylabel('Agent value')
    pause(0.1)
end

%% Plot state for house value and agent economic status at t=100 and t=end
% t=100 and t=0 are hardcoded here

close all
times = unique(epoch_of(data))';
ids = unique(id_of(data));
ids = ids(ids > 0)';
e0 = filter_epoch(data, 0);
e1 = filter_epoch(data, max(times));
state0 = convert_to_state(e0);
state1 = convert_to_state(e1);

figure(1)
subplot(2, 2, 1)
colormap gray
caxis([0, 1])
surface(state0.v, 'FaceColor', 'flat');
xlim([0, dims(1)]);
ylim([0, dims(2)]);
title('House Values at t=0')
subplot(2, 2, 2)
colormap gray
caxis([0,1])
surface(state0.s, 'FaceColor', 'flat');
xlim([0, dims(1)]);
ylim([0, dims(2)]);
title('Agent status at t=0')
subplot(2, 2, 3)
colormap gray
caxis([0, 1])
surface(state1.v, 'FaceColor', 'flat');
xlim([0, dims(1)]);
ylim([0, dims(2)]);
title('House Values at t=100')
subplot(2, 2, 4)
colormap gray
caxis([0,1])
surface(state1.s, 'FaceColor', 'flat');
xlim([0, dims(1)]);
ylim([0, dims(2)]);
title('Agent status at t=100')


%% Plot cluster value distributions

close all
times = unique(epoch_of(data))';
e0 = filter_epoch(data, 20);
e1 = filter_epoch(data, max(times)-20);

discrep = 0.20;
mooreVals0 = [];
mooreVals1 = [];
neumannVals0 = [];
neumannVals1 = [];

for x = 2:(dims(1) - 1)
    for y = 2:(dims(2) - 1)
        [moore0, mooreval0] = is_moore_cluster_occupied(e0,x,y,discrep);
        [neumann0, neuval0] = is_neumann_cluster_occupied(e0,x,y,discrep); 
        [moore1, mooreval1] = is_moore_cluster_occupied(e1,x,y,discrep);
        [neumann1, neuval1] = is_neumann_cluster_occupied(e1,x,y,discrep); 
        if moore0
            mooreVals0 = [mooreVals0, mooreval0];
        end
        if neumann0
            neumannVals0 = [neumannVals0, neuval0];
        end
        if moore1
            mooreVals1 = [mooreVals1, mooreval1];
        end
        if neumann1
            neumannVals1 = [neumannVals1, neuval1];
        end
    end
end


figure(1)
subplot(2,2,1)
hist(mooreVals0,25)
title('Moore cluster values')
xlabel('Cluster values at t=20')
xlim([0, 1])
ylim([0, 40])
subplot(2,2,2)
hist(mooreVals1,25)
title('Moore cluster values')
xlabel('Cluster values at t=80')
xlim([0, 1])
ylim([0, 40])
subplot(2,2,3)
hist(neumannVals0,25)
title('Von Neumann cluster values')
xlabel('Cluster values at t=20')
xlim([0, 1])
ylim([0, 90])
subplot(2,2,4)
hist(neumannVals0,25)
title('Von Neumann cluster values')
xlabel('Cluster values at t=80')
xlim([0, 1])
ylim([0, 90])
