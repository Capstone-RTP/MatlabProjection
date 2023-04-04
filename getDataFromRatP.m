function distVec = getDataFromRatP(scanPath,smoothing)
    dist2Cen = 42.3;
    %open serial connection
    %if theres an error delete s from workspace and rerun
    s = serialport("COM3",115200);
    %increase timout
    s.Timeout = 100000;
   
    n = size(scanPath,1);
    %loading
    fig = uifigure;
    d = uiprogressdlg(fig,'Title','Scanner',...
        'Message','Scanning in Progress','Cancelable','on');
    drawnow
    %store distance
    distVec = zeros([n,1]);
    for ii = 1:n
        if ~mod(ii+1,20)
            d.Message = sprintf('Distance Sample: %d  Progress: %0.1f %% ',scanDist,ii*100/n);
        end
        %Update progress and cancel from UI
        d.Value = ii/n;
        if d.CancelRequested
            break
        end
        %write points to UART
        write(s, scanPath(ii,:), 'uint16');
        %wait for armDist
        scanDist = read(s,1,'uint16');
        scanRad = dist2Cen - scanDist;
        distVec(ii) = scanRad;
    end
    distVec = lowpass(distVec-mean(distVec),smoothing) + mean(distVec);
    clear s
    close(d);
    close(fig);
end