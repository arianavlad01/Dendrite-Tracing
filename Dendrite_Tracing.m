%% Trace Dendrites from 3D Spines Distributions

% Read a data file containing 3D position of each spine 

dendrites_data=readmatrix('position.csv');

%Store the coordinates of each spine 

x=dendrites_data(:, 1);
y=dendrites_data(:, 2);
z=dendrites_data(:, 3);
index=dendrites_data(:, 8);

%Visualize the spine distribution 

plot3(x, y, z, '.');

trace_x={};    % these cells stores the dendrite traces
trace_y={};
trace_z={};

i=1;
hold on
termination_p=[];
N=100; % maximum number of branches you want to trace

while i<N
    plot(x, y, '.')
    [x_t,y_t] = ginput(2);
        [dist, index_cl] = closest_distance(x, y, zeros(length(x), 1), x_t(1), y_t(1), 0, index);
        termination_p(end+1)=index_cl;  %starting point of the branch
        [dist, index_cl] = closest_distance(x, y, zeros(length(x), 1), x_t(2), y_t(2), 0, index);
        termination_p(end+1)=index_cl;  %ending point of the branch

    direction=[x(termination_p(end))-x(termination_p(end-1)) y(termination_p(end))-y(termination_p(end-1)) z(termination_p(end))-z(termination_p(end-1))];  %direction of the branch
    x0={[x(termination_p(end-1))]};
    y0={[y(termination_p(end-1))]};
    z0={[z(termination_p(end-1))]};
    last=termination_p(end);

    [x0, y0, z0] = trace_dendrite(x0, y0, z0, x, y, z, index, direction, termination_p, last);  %trace the dendrite with the given termination points and direction

    trace_x{end+1}=x0;
    trace_y{end+1}=y0;
    trace_z{end+1}=z0;

    plot3(trace_x{end}{:}, trace_y{end}{:}, trace_z{end}{:}, 'LineWidth', 5)  %plot dendrite

    i=i+1;
end

coupled=cell(1, length(trace_x), 1);    % determine which branches are connected
dists=zeros(length(termination_p), length(termination_p));
for i=1:length(termination_p)
    coupled{round(i/2)}(end+1)=[round(i/2)];
    for j=1:i-1
        if distance(x(termination_p(i)), y(termination_p(i)), z(termination_p(i)), x(termination_p(j)), y(termination_p(j)), z(termination_p(j)))<7 % to be chosen depending on the data set
            coupled{round(i/2)}(end+1)=round(j/2);
        end

    end
    coupled{round(i/2)}=unique(coupled{round(i/2)});
end 


for i=1:length(coupled)
        for j=i+1:length(coupled)
            if ismember(coupled{i}, coupled{j})==1
                coupled{i}=[];
            end
        end
end
        
dendrites=coupled(~cellfun('isempty',coupled));  % list of branches forming each dendrite


