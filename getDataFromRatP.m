function distVec = getDataFromRatP(scanPath)
    dist2Cen = 100;
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
        %Update progress and cancel from UI
        d.Value = ii/n;
        if d.CancelRequest
            break
        end
        %write points to UART
%         write(s, scanPath(ii,:), 'uint16');
%         %wait for armDist
%         scanDist = read(s,1,'uint16');
%         scanRad = dist2Cen - scanDist;
%         distVec(ii) = scanRad;
        pause(0.5);
    end

end