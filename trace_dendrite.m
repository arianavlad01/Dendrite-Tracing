function [x0, y0, z0] = trace_dendrite(x0, y0, z0, x, y, z, index, direction, termination_p, last)
    termination=0;
    nr=1;
    count_br=1;
    nr_branches=0;
    while termination==0
        [x0, y0, z0, direction, count, angles] = step(x0, y0, z0, x, y, z, index, direction, count_br, nr, 10, last);
        if count==0
            [x0, y0, z0, direction, count, angles] = step(x0, y0, z0, x, y, z, index, direction, count_br, nr, 20, last);
        end 

        if isnan(x0{end}(end))==1
            termination=1;
        end

        if count==0
            termination=1;
        end
        
        dist=distance(x(last), y(last), z(last), x0{end}(end), y0{end}(end), z0{end}(end));
        if dist<1
            termination=1;  % we reached the termination point
        end

    end
end