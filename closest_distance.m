function [dist, index_cl] = closest_distance(x, y, z, x0, y0, z0, index)

dist=[];

for i=1:length(index)
    dist(end+1)=distance(x(i), y(i),z(i), x0, y0, z0);
end

[dist, index_cl]=min(dist(dist>=0));

end

