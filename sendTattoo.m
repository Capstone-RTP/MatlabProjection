function sendTattoo(cyPath)
    %Definitions
    yOffset = 0;
    dis2cen = 42.3;
    rOffset = 35;
    pulsesPerRev = 200;
    degreesPerRev = 360;
    pitch = 12; %mm/rev
    thetaN2 = 520;
    thetaN1 = 20;
    
    %Get data in pulses
    thetaPulses = cyPath(:,2)*thetaN2*pulsesPerRev/thetaN1/degreesPerRev;
    thetaPulses = round(thetaPulses);
    yPulses = (cyPath(:,3)+yOffset)*pulsesPerRev/pitch;
    yPulses = round(yPulses);
    rPulses  = dis2cen-cyPath(:,1)+rOffset;
    rPulses = rPulses*pulsesPerRev/pitch;
    rPulses = round(rPulses);
    
    pathPulses = [rPulses,thetaPulses,yPulses];
    
    %open serial connection
    %if theres an error delete s from workspace and rerun
    s = serialport("COM3",115200);
    %increase timout
    s.Timeout = 100000;
    
    n = size(pathPulses,1);
    %loading
    fig = uifigure;
    d = uiprogressdlg(fig,'Title','Tattooing',...
        'Message','In Progress','Cancelable','on');
    drawnow
    
    %send over serial
    for ii=1:n
        if ~mod(ii+1,20)
            d.Message = sprintf('Progress: %0.1f %% ',ii*100/n);
        end
        %Update progress and cancel from UI
        d.Value = ii/n;
        if d.CancelRequested
            break
        end
        %write points to UART
        write(s, pathPulses(ii,:), 'uint16');
        %wait for acknowledge
        ack = read(s,1,'uint8');
        %check ack
        if(ack ~= 'a')
            error('Invalid acknowledge from MCU')
        end
    end
    clear s
    close(d);
    close(fig);
end