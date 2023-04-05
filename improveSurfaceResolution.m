function hqSurface = improveSurfaceResolution(surface,res)
    %Organize values for each axis
    theta = surface(:,2);
    y = surface(:,3);
    radius = surface(:,1);
    
    %Create higher resultion mesh grid
    [meshT,meshY] = meshgrid(linspace(min(theta),max(theta),res),linspace(min(y),max(y),res));
    
    %Use griddata to interpolate for the mesh
    meshR = griddata(theta,y,radius,meshT,meshY);
%     %Plot
%     figure;
%     surf(meshT,meshY,meshR);
    %Plot
    hqSurface = cat(2,meshT(:),meshY(:));
    hqSurface = [meshR(:),hqSurface];
    
    %scatter3((hqSurface(:,1)).*(cos(hqSurface(:,2)-pi/2)),hqSurface(:,3),(hqSurface(:,1)).*(sin(hqSurface(:,2)-pi/2)));
end