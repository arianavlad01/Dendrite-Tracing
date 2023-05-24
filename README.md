# Dendrite-Tracing
Matlab Algorithm to Semi-Automatically Trace Dendrites from the Spines Distribution

distance.m is the function that computes the L2 distance between two points in 3D. 

closest_distance.m is the function that loops over all the spines in the dataset and finds the spine closest to a given point in the space. 

trace_dendrite.m is the function that creates the dendrite branch by passing through the corresponding spines, given a starting and termination point. 

Dendrite_tracing.m is the code that reads the data file and opens the window that allows the scientist to choose the starting and termination points for an arbitrary number of dendritic branches. Then, the code connects the dendritic branches to form a complete dendrite. 
