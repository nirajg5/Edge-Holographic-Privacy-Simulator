function edge_holographic_privacy()
%% =========================================================================
%  EDGE-BASED PRIVACY PRESERVATION FOR REAL-TIME HOLOGRAPHIC COMMUNICATION
%  Computer Networks Project — Full Interactive Simulation v3.0
%  NEW: Edge Parameters | Anonymization Overhead | Flooding Prob | Records Tab
%% =========================================================================
clc; clearvars;

SCR = get(0,'ScreenSize');
FW  = min(1600, SCR(3)-10);
FH  = min(900,  SCR(4)-50);

fig = uifigure('Name','Edge Privacy — Holographic Communication Simulator v3.0',...
    'Position',[5 30 FW FH],...
    'Color',[0.07 0.07 0.11]);

%% ===== TITLE BAR =====
uilabel(fig,'Text',...
    'Edge-Based Privacy Preservation for Real-Time Holographic Communication',...
    'Position',[5 FH-32 FW-10 26],...
    'FontSize',13,'FontWeight','bold',...
    'FontColor',[0.2 0.85 1],...
    'HorizontalAlignment','center',...
    'BackgroundColor',[0.07 0.07 0.11]);

%% ===== TAB GROUP (MAIN AREA) =====
tg = uitabgroup(fig,'Position',[5 5 FW-10 FH-40]);

tabSim     = uitab(tg,'Title','  Simulation  ');
tabRecords = uitab(tg,'Title','  Records & Analysis  ');

tabSim.BackgroundColor     = [0.08 0.08 0.12];
tabRecords.BackgroundColor = [0.08 0.08 0.12];

%% ===========================================================
%%  ============  SIMULATION TAB  ============================
%% ===========================================================

TW = FW-20;   % tab inner width
TH = FH-60;   % tab inner height

%-- Layout constants --
nodeW = 290; nodeH = 225;
topY  = TH - 265;
ax1X=8; ax2X=ax1X+nodeW+32; ax3X=ax2X+nodeW+32;

panW = 265;
panX = TW - panW - 5;

botH = 195;
botY = 128;
metricsW = 390; holoW = 320;

%--- Node Axes ---
axSource = uiaxes(tabSim,'Position',[ax1X topY nodeW nodeH]);
styleAx(axSource,'SOURCE NODE',[0.2 0.9 0.4]);

axEdge = uiaxes(tabSim,'Position',[ax2X topY nodeW nodeH]);
styleAx(axEdge,'EDGE NODE (Privacy Engine)',[1 0.6 0.1]);

axDest = uiaxes(tabSim,'Position',[ax3X topY nodeW nodeH]);
styleAx(axDest,'DESTINATION NODE',[0.2 0.6 1]);

%--- Arrows ---
uilabel(tabSim,'Text','=>','Position',[ax1X+nodeW+3 topY+nodeH/2-10 27 20],...
    'FontSize',15,'FontColor',[0.3 1 0.3],'FontWeight','bold',...
    'BackgroundColor',[0.08 0.08 0.12]);
uilabel(tabSim,'Text','=>','Position',[ax2X+nodeW+3 topY+nodeH/2-10 27 20],...
    'FontSize',15,'FontColor',[0.3 0.7 1],'FontWeight','bold',...
    'BackgroundColor',[0.08 0.08 0.12]);

%--- Metrics Axes ---
axMetrics = uiaxes(tabSim,'Position',[8 botY metricsW botH]);
axMetrics.Color=[0.04 0.04 0.09];
axMetrics.Title.String='PSNR & SSIM'; axMetrics.Title.Color=[0.9 0.9 0.9];
axMetrics.Title.FontSize=9;
axMetrics.XColor=[0.6 0.6 0.7]; axMetrics.YColor=[0.6 0.6 0.7];
grid(axMetrics,'on');

%--- Hologram Axes ---
axHolo = uiaxes(tabSim,'Position',[metricsW+20 botY holoW botH]);
axHolo.Color=[0.02 0.02 0.05];
axHolo.Title.String='Holographic Depth Map'; axHolo.Title.Color=[0.2 0.8 1];
axHolo.Title.FontSize=9;

%--- Edge Metrics Axes ---
axEdgeMetrics = uiaxes(tabSim,'Position',[metricsW+holoW+35 botY 260 botH]);
axEdgeMetrics.Color=[0.04 0.04 0.09];
axEdgeMetrics.Title.String='Edge Node Metrics'; axEdgeMetrics.Title.Color=[1 0.7 0.2];
axEdgeMetrics.Title.FontSize=9;
axEdgeMetrics.XColor=[0.6 0.6 0.7]; axEdgeMetrics.YColor=[0.6 0.6 0.7];
grid(axEdgeMetrics,'on');

%% ===== PARAMETERS PANEL =====
panel = uipanel(tabSim,'Title','Parameters',...
    'Position',[panX 5 panW TH-10],...
    'BackgroundColor',[0.1 0.1 0.16],...
    'ForegroundColor',[0.2 0.8 1],...
    'FontSize',9,'FontWeight','bold');

    function mkL(txt,ypos)
        uilabel(panel,'Text',txt,'Position',[6 ypos 248 17],...
            'FontColor',[0.85 0.85 0.9],'FontSize',8,...
            'BackgroundColor',[0.1 0.1 0.16]);
    end
    function ef = mkF(ypos, val)
        ef = uieditfield(panel,'numeric','Position',[6 ypos-21 248 21],...
            'Value',val,'BackgroundColor',[0.14 0.14 0.21],...
            'FontColor',[1 1 1],'FontSize',9);
    end

yp = TH - 80;

%-- Section: Network --
uilabel(panel,'Text','— NETWORK —','Position',[6 yp 248 18],...
    'FontColor',[0.2 0.85 1],'FontWeight','bold','FontSize',8,...
    'BackgroundColor',[0.1 0.1 0.16]);
yp=yp-22;

mkL('Media Type:',yp);
mediaDrop = uidropdown(panel,'Items',{'Synthetic Hologram','Image','Video'},...
    'Position',[6 yp-21 248 21],...
    'BackgroundColor',[0.14 0.14 0.21],'FontColor',[1 1 1],'FontSize',8);
yp=yp-50;

mkL('Privacy Mode:',yp);
privacyDrop = uidropdown(panel,...
    'Items',{'None','Gaussian Blur','AES-like Encryption','Differential Privacy','Face Anonymization','Edge Masking'},...
    'Position',[6 yp-21 248 21],...
    'BackgroundColor',[0.14 0.14 0.21],'FontColor',[1 1 1],'FontSize',8);
yp=yp-50;

mkL('Delay per Step (sec):',yp);  delayField=mkF(yp,0.4);   yp=yp-46;
mkL('Packet Loss Prob (0-1):',yp); lossField=mkF(yp,0.05);  yp=yp-46;
mkL('Bandwidth (MB/sec):',yp);    bandField=mkF(yp,10);     yp=yp-46;
mkL('Encryption Key:',yp);        keyField=mkF(yp,173);     yp=yp-46;
mkL('Noise Level (0-50):',yp);    noiseField=mkF(yp,15);    yp=yp-46;
mkL('Video Frames:',yp);          frameCountField=mkF(yp,10); yp=yp-50;

%-- Section: Edge Node Parameters --
uilabel(panel,'Text','— EDGE NODE PARAMETERS —','Position',[6 yp 248 18],...
    'FontColor',[1 0.65 0.1],'FontWeight','bold','FontSize',8,...
    'BackgroundColor',[0.1 0.1 0.16]);
yp=yp-22;

mkL('Processing Delay (ms):',yp);   edgeProcDelayField=mkF(yp,12);   yp=yp-46;
mkL('Cache Hit Ratio (0-1):',yp);   cacheHitField=mkF(yp,0.65);      yp=yp-46;
mkL('CPU Cycles (MHz):',yp);        cpuCyclesField=mkF(yp,800);      yp=yp-50;

%-- Section: Anonymization & Attack --
uilabel(panel,'Text','— ANONYMIZATION & ATTACK —','Position',[6 yp 248 18],...
    'FontColor',[1 0.4 0.6],'FontWeight','bold','FontSize',8,...
    'BackgroundColor',[0.1 0.1 0.16]);
yp=yp-22;

mkL('Interference Attack Prob (0-1):',yp); attackProbField=mkF(yp,0.15); yp=yp-46;
mkL('Anonymization Overhead (%):',yp);     anonOverheadField=mkF(yp,18); yp=yp-50;

%-- Section: Unique Twist --
uilabel(panel,'Text','— UNIQUE TWIST —','Position',[6 yp 248 18],...
    'FontColor',[0.6 0.3 1],'FontWeight','bold','FontSize',8,...
    'BackgroundColor',[0.1 0.1 0.16]);
yp=yp-22;

mkL('Flooding Probability (0-1):',yp); floodProbField=mkF(yp,0.1); yp=yp-46;
mkL('Flood Multiplier (load x):',yp);  floodMultField=mkF(yp,3.0); yp=yp-46;

%% ===== BUTTONS =====
btnY = topY - 40;
uibutton(tabSim,'push','Text','Load / Generate',...
    'Position',[8 btnY 162 30],...
    'BackgroundColor',[0.1 0.5 0.2],'FontColor',[1 1 1],'FontWeight','bold','FontSize',9,...
    'ButtonPushedFcn',@(b,e) loadMedia());

uibutton(tabSim,'push','Text','► Start Transmission',...
    'Position',[178 btnY 190 30],...
    'BackgroundColor',[0.1 0.3 0.7],'FontColor',[1 1 1],'FontWeight','bold','FontSize',9,...
    'ButtonPushedFcn',@(b,e) startTransmission());

uibutton(tabSim,'push','Text','Export CSV',...
    'Position',[376 btnY 110 30],...
    'BackgroundColor',[0.4 0.1 0.5],'FontColor',[1 1 1],'FontWeight','bold','FontSize',9,...
    'ButtonPushedFcn',@(b,e) exportLog());

uibutton(tabSim,'push','Text','Reset',...
    'Position',[494 btnY 80 30],...
    'BackgroundColor',[0.5 0.1 0.1],'FontColor',[1 1 1],'FontWeight','bold','FontSize',9,...
    'ButtonPushedFcn',@(b,e) resetAll());

%% ===== STATUS =====
statusLabel = uilabel(tabSim,...
    'Text','Status: Ready — Load media then Start Transmission',...
    'Position',[8 btnY-22 panX-15 19],...
    'FontSize',8,'FontColor',[0.3 1 0.5],...
    'BackgroundColor',[0.08 0.08 0.12]);

%% ===== LOG TABLE (bottom of Simulation tab) =====
tableW = panX - 12;
tableH = 115;
tableY = 8;

uilabel(tabSim,'Text','Transmission Log',...
    'Position',[8 tableY+tableH 140 15],...
    'FontColor',[0.2 0.8 1],'FontWeight','bold','FontSize',8,...
    'BackgroundColor',[0.08 0.08 0.12]);

logTable = uitable(tabSim,...
    'Position',[8 tableY tableW tableH],...
    'Data',{},...
    'ColumnName',{'#','Mode','PSNR','SSIM','Lat(ms)',...
                  'BW(MB/s)','PktLoss','EdgeDly','Cache','CPU(MHz)',...
                  'AnonOvhd','Attack','Flood','Status'},...
    'ColumnWidth',{28,120,58,54,55,60,55,58,50,60,65,55,45,52},...
    'RowName',{});

%% ===== SUMMARY PANEL (bottom-right of Simulation tab) =====
sumPanel = uipanel(tabSim,'Title','Summary',...
    'Position',[panX tableY panW tableH+18],...
    'BackgroundColor',[0.07 0.09 0.13],...
    'ForegroundColor',[0.2 0.8 1],'FontSize',8,'FontWeight','bold');

sumLabel = uilabel(sumPanel,'Text','Run a simulation to see stats.',...
    'Position',[5 3 panW-12 tableH],...
    'FontSize',8,'FontColor',[0.8 0.9 0.8],...
    'VerticalAlignment','top','WordWrap','on',...
    'BackgroundColor',[0.07 0.09 0.13]);

%% ===========================================================
%%  ============  RECORDS TAB  ================================
%% ===========================================================

RW = TW; RH = TH;

uilabel(tabRecords,'Text','Complete Session Records & Analysis',...
    'Position',[8 RH-30 RW-16 24],...
    'FontSize',12,'FontWeight','bold','FontColor',[0.2 0.85 1],...
    'HorizontalAlignment','center',...
    'BackgroundColor',[0.08 0.08 0.12]);

%-- Full Records Table --
uilabel(tabRecords,'Text','All Frame Records',...
    'Position',[8 RH-60 200 18],...
    'FontColor',[0.2 0.8 1],'FontWeight','bold','FontSize',9,...
    'BackgroundColor',[0.08 0.08 0.12]);

recTable = uitable(tabRecords,...
    'Position',[8 RH-260 RW-16 195],...
    'Data',{},...
    'ColumnName',{'Frame','Privacy Mode','PSNR(dB)','SSIM','Latency(ms)',...
                  'BW(MB/s)','Pkt Loss','Edge Delay(ms)','Cache Hit',...
                  'CPU(MHz)','Anon Ovhd(%)','Attack?','Flooded?','Succ Rate(%)','Status'},...
    'ColumnWidth',{42,130,65,60,75,65,58,90,65,65,80,60,60,80,60},...
    'RowName',{});

%-- Analysis Charts on Records Tab --
axR1 = uiaxes(tabRecords,'Position',[8 RH-490 (RW-40)/3 200]);
styleRecAx(axR1,'PSNR by Privacy Mode',[0.2 0.9 0.4]);

axR2 = uiaxes(tabRecords,'Position',[8+(RW-40)/3+12 RH-490 (RW-40)/3 200]);
styleRecAx(axR2,'Anonymization Overhead vs Success Rate',[1 0.5 0.2]);

axR3 = uiaxes(tabRecords,'Position',[8+2*((RW-40)/3)+24 RH-490 (RW-40)/3 200]);
styleRecAx(axR3,'CPU Cycles & Edge Processing Delay',[0.5 0.4 1]);

%-- Stats Summary on Records Tab --
recSumPanel = uipanel(tabRecords,'Title','Session Statistics',...
    'Position',[8 RH-690 RW-16 185],...
    'BackgroundColor',[0.07 0.09 0.13],...
    'ForegroundColor',[0.2 0.8 1],'FontSize',9,'FontWeight','bold');

recSumLabel = uilabel(recSumPanel,'Text','No session data yet.',...
    'Position',[8 5 RW-40 160],...
    'FontSize',9,'FontColor',[0.85 0.9 0.85],...
    'VerticalAlignment','top','WordWrap','on',...
    'BackgroundColor',[0.07 0.09 0.13]);

%-- Refresh & Export buttons on Records Tab --
uibutton(tabRecords,'push','Text','Refresh Analysis',...
    'Position',[8 RH-720 160 26],...
    'BackgroundColor',[0.1 0.4 0.6],'FontColor',[1 1 1],'FontWeight','bold','FontSize',9,...
    'ButtonPushedFcn',@(b,e) refreshRecords());

uibutton(tabRecords,'push','Text','Export Full Report CSV',...
    'Position',[178 RH-720 180 26],...
    'BackgroundColor',[0.35 0.1 0.5],'FontColor',[1 1 1],'FontWeight','bold','FontSize',9,...
    'ButtonPushedFcn',@(b,e) exportFullReport());

uibutton(tabRecords,'push','Text','Clear Records',...
    'Position',[368 RH-720 130 26],...
    'BackgroundColor',[0.5 0.12 0.12],'FontColor',[1 1 1],'FontWeight','bold','FontSize',9,...
    'ButtonPushedFcn',@(b,e) clearRecords());

%% ===== SHARED STATE =====
mediaData  = [];
mediaType  = 'Synthetic Hologram';
logData    = {};   % simulation tab table data
allRecords = {};   % full records for Records tab
psnrLog    = [];
ssimLog    = [];
latLog     = [];
edgeDelLog = [];
cacheLog   = [];
cpuLog     = [];
anonLog    = [];
attackLog  = {};
floodLog   = {};
succLog    = [];

%% ===== HELPER: styleAx =====
    function styleAx(ax,ttl,col)
        ax.Color=[0.05 0.05 0.1];
        ax.Title.String=ttl; ax.Title.Color=col; ax.Title.FontSize=10;
        ax.XColor=[0.4 0.4 0.5]; ax.YColor=[0.4 0.4 0.5];
        ax.XTick=[]; ax.YTick=[];
    end

    function styleRecAx(ax,ttl,col)
        ax.Color=[0.05 0.05 0.1];
        ax.Title.String=ttl; ax.Title.Color=col; ax.Title.FontSize=9;
        ax.XColor=[0.55 0.55 0.65]; ax.YColor=[0.55 0.55 0.65];
        grid(ax,'on'); ax.GridColor=[0.2 0.2 0.3];
    end

%% ===== LOAD MEDIA =====
    function loadMedia()
        mediaType = mediaDrop.Value;
        switch mediaType
            case 'Image'
                [file,path] = uigetfile({'*.png;*.jpg;*.bmp;*.tif','Images'});
                if isequal(file,0), return; end
                mediaData = imread(fullfile(path,file));
                if size(mediaData,3)==1, mediaData=repmat(mediaData,[1 1 3]); end
                imshow(mediaData,'Parent',axSource);
                axSource.Title.String='SOURCE - Image Loaded';
                setStatus('Image loaded. Click Start Transmission.','green');
                showHoloDepth(mediaData);

            case 'Synthetic Hologram'
                mediaData = generateHologram();
                imshow(mediaData,'Parent',axSource);
                axSource.Title.String='SOURCE - Hologram Generated';
                setStatus('Hologram ready. Click Start Transmission.','green');
                showHoloDepth(mediaData);

            case 'Video'
                [file,path] = uigetfile({'*.mp4;*.avi;*.mov','Videos'});
                if isequal(file,0), return; end
                mediaData = VideoReader(fullfile(path,file));
                f1 = readFrame(mediaData);
                mediaData.CurrentTime = 0;
                imshow(f1,'Parent',axSource);
                axSource.Title.String='SOURCE - Video Loaded';
                setStatus(sprintf('Video: %.0f frames @ %.0f fps — Ready.',...
                    floor(mediaData.Duration*mediaData.FrameRate),...
                    mediaData.FrameRate),'green');
                showHoloDepth(f1);
        end
    end

%% ===== GENERATE HOLOGRAM =====
    function holo = generateHologram()
        [X,Y]=meshgrid(linspace(-1,1,256),linspace(-1,1,256));
        p=(sin(10*pi*X).*cos(10*pi*Y)+cos(15*pi*(X.^2+Y.^2))+sin(8*pi*X.*Y))/3;
        p=(p-min(p(:)))/(max(p(:))-min(p(:)));
        R=uint8(255*(0.5+0.5*sin(p*pi)));
        G=uint8(255*(0.5+0.5*cos(p*pi*0.8)));
        B=uint8(255*(0.3+0.7*p));
        holo=cat(3,R,G,B);
    end

%% ===== DEPTH MAP =====
    function showHoloDepth(data)
        if ~isnumeric(data)||isempty(data), return; end
        gray=double(rgb2gray(data)); s=4;
        gS=gray(1:s:end,1:s:end);
        [X,Y]=meshgrid(1:size(gS,2),1:size(gS,1));
        surf(axHolo,X,Y,gS,'EdgeColor','none');
        colormap(axHolo,'jet'); view(axHolo,45,30);
        axHolo.Color=[0.02 0.02 0.05];
        axHolo.XColor=[0.3 0.7 1]; axHolo.YColor=[0.3 0.7 1]; axHolo.ZColor=[0.3 0.7 1];
        axHolo.Title.String='Holographic Depth Map'; axHolo.Title.Color=[0.2 0.8 1];
        drawnow;
    end

%% ===== START TRANSMISSION =====
    function startTransmission()
        if isempty(mediaData)
            uialert(fig,'Load media first!','No Media','Icon','error'); return;
        end
        logData={}; psnrLog=[]; ssimLog=[]; latLog=[];
        edgeDelLog=[]; cacheLog=[]; cpuLog=[]; anonLog=[];
        attackLog={}; floodLog={}; succLog=[];
        cla(axMetrics); cla(axEdgeMetrics);
        logTable.Data={}; sumLabel.Text='Processing...';

        switch mediaType
            case {'Image','Synthetic Hologram'}
                transmitFrame(mediaData,1);
            case 'Video'
                nF=min(frameCountField.Value,...
                    floor(mediaData.Duration*mediaData.FrameRate));
                mediaData.CurrentTime=0; fi=0;
                while hasFrame(mediaData)&&fi<nF
                    fi=fi+1; transmitFrame(readFrame(mediaData),fi);
                end
        end
        setStatus('Transmission Complete! See Records tab for full analysis.','cyan');
        updateSummary();
        refreshRecords();
    end

%% ===== TRANSMIT ONE FRAME =====
    function transmitFrame(frame, fnum)
        delay      = delayField.Value;
        packetLoss = lossField.Value;
        bandwidth  = bandField.Value;
        privMode   = privacyDrop.Value;
        encKey     = uint8(mod(keyField.Value,256));
        noiseLevel = noiseField.Value;

        % Edge-specific parameters
        edgeProcDelay = edgeProcDelayField.Value;   % ms
        cacheHit      = cacheHitField.Value;        % 0-1
        cpuMHz        = cpuCyclesField.Value;       % MHz
        attackProb    = attackProbField.Value;      % 0-1
        anonOverhead  = anonOverheadField.Value;    % %
        floodProb     = floodProbField.Value;       % 0-1
        floodMult     = floodMultField.Value;       % multiplier

        %-- Step 1: Source --
        imshow(frame,'Parent',axSource);
        axSource.Title.String=sprintf('SOURCE  Frame %d',fnum);
        setStatus(sprintf('[%d] Sending from Source Node...',fnum),'yellow');
        drawnow; pause(delay);

        %-- Step 2: Edge Node --
        tEdgeStart = tic;

        % Cache hit check — if cache hit, skip re-processing
        isCacheHit = rand < cacheHit;
        if isCacheHit
            processed = frame;  % serve from cache
            edgeNote = 'CACHE HIT';
        else
            processed = applyPrivacy(frame,privMode,encKey,noiseLevel);
            edgeNote = privMode;
        end

        % Add anonymization overhead delay
        anonDelayMs = edgeProcDelay * (1 + anonOverhead/100);
        pause(anonDelayMs/1000);

        actualEdgeDelayMs = toc(tEdgeStart)*1000 + edgeProcDelay;

        % Simulate CPU usage annotation
        cpuUsed = cpuMHz * (0.4 + 0.6*rand);  % simulated usage fraction

        imshow(processed,'Parent',axEdge);
        axEdge.Title.String=sprintf('EDGE  %s (%s)',edgeNote,privMode);
        setStatus(sprintf('[%d] Edge: %s | Delay:%.1fms | CPU:%.0fMHz | Cache:%s',...
            fnum,privMode,actualEdgeDelayMs,cpuUsed,...
            ternary(isCacheHit,'HIT','MISS')),'orange');
        drawnow; pause(delay*0.5);

        %-- Step 3: Bandwidth --
        dataBytes = numel(frame);
        txTime    = dataBytes/(bandwidth*1e6);

        % Flooding event
        isFlooded = rand < floodProb;
        if isFlooded
            effectiveBW = bandwidth / floodMult;
            txTime = dataBytes/(effectiveBW*1e6);
            setStatus(sprintf('[%d] FLOOD EVENT! BW reduced x%.1f — %.2fMB @ %.1fMB/s',...
                fnum,floodMult,dataBytes/1e6,effectiveBW),'red');
        else
            setStatus(sprintf('[%d] Transmitting %.2fMB @ %.1fMB/s',...
                fnum,dataBytes/1e6,bandwidth),'yellow');
        end
        pause(max(txTime,0.05));

        %-- Step 4: Interference Attack --
        isAttacked = rand < attackProb;
        attackStatus = 'None';
        if isAttacked
            % Attack corrupts random 5% of pixels
            attacked = processed;
            nPix = numel(attacked);
            idx = randperm(nPix, round(nPix*0.05));
            attacked(idx) = uint8(randi([0 255],1,length(idx)));
            processed = attacked;
            attackStatus = 'Attacked';
            setStatus(sprintf('[%d] INTERFERENCE ATTACK detected! %s mode active.',...
                fnum,privMode),'red');
            drawnow; pause(delay*0.3);
        end

        %-- Step 5: Packet Loss --
        if rand < packetLoss
            cla(axDest);
            axDest.Title.String='DESTINATION  PACKET LOST';
            text(axDest,0.5,0.5,'PACKET LOST','Units','normalized',...
                'HorizontalAlignment','center','FontSize',14,...
                'Color',[1 0.2 0.2],'FontWeight','bold');
            setStatus(sprintf('[%d] PACKET LOST (p=%.2f)',fnum,packetLoss),'red');
            addLogRow(fnum,privMode,'—','—',round(txTime*1000),bandwidth,...
                sprintf('%.0f%%',packetLoss*100),round(actualEdgeDelayMs,1),...
                ternary(isCacheHit,'Y','N'),round(cpuUsed),...
                sprintf('%.1f%%',anonOverhead),attackStatus,...
                ternary(isFlooded,'Y','N'),'LOST');
            drawnow; pause(delay); return;
        end

        %-- Step 6: Decrypt --
        final = decryptFrame(processed,privMode,encKey);

        %-- Step 7: Display destination --
        imshow(final,'Parent',axDest);
        axDest.Title.String=sprintf('DESTINATION  Frame %d',fnum);
        drawnow;

        %-- Step 8: Compute metrics --
        mseV = mean((double(frame(:))-double(final(:))).^2);
        psnrVal = ternaryNum(mseV<1e-10, 100, 10*log10(255^2/mseV));
        ssimVal = computeSSIM(rgb2gray(frame),rgb2gray(final));
        latMs   = round(txTime*1000 + delay*1000 + actualEdgeDelayMs);

        % Anonymization success rate:
        % Higher PSNR + lower attack prob = higher success
        % If attacked, success rate drops proportionally
        baseSucc = 85 + 15*(ssimVal);
        if isAttacked, baseSucc = baseSucc * 0.6; end
        if isCacheHit, baseSucc = min(100,baseSucc*1.05); end
        succRate = min(100,max(0,baseSucc));

        % Log
        psnrLog(end+1)=psnrVal;   ssimLog(end+1)=ssimVal;
        latLog(end+1)=latMs;      edgeDelLog(end+1)=actualEdgeDelayMs;
        cacheLog(end+1)=double(isCacheHit); cpuLog(end+1)=cpuUsed;
        anonLog(end+1)=anonOverhead;
        attackLog{end+1}=attackStatus; floodLog{end+1}=ternary(isFlooded,'Y','N');
        succLog(end+1)=succRate;

        addLogRow(fnum,privMode,round(psnrVal,2),round(ssimVal,4),...
            latMs,bandwidth,sprintf('%.0f%%',packetLoss*100),...
            round(actualEdgeDelayMs,1),...
            ternary(isCacheHit,'Y','N'),round(cpuUsed),...
            sprintf('%.1f%%',anonOverhead),attackStatus,...
            ternary(isFlooded,'Y','N'),'OK');

        setStatus(sprintf('[%d] OK | PSNR:%.1fdB SSIM:%.4f Lat:%dms EdgeDly:%.1fms Succ:%.1f%%',...
            fnum,psnrVal,ssimVal,latMs,actualEdgeDelayMs,succRate),'green');

        updateMetricsPlot();
        updateEdgeMetricsPlot();
        showHoloDepth(final);
        pause(delay*0.5);
    end

%% ===== ADD LOG ROW =====
    function addLogRow(varargin)
        logData(end+1,:)  = varargin;
        allRecords(end+1,:) = [varargin, {[]}];  % placeholder for succRate col added below
        % Fix: rebuild allRecords properly with succRate
        n = size(logData,1);
        if numel(succLog) >= n
            sr = succLog(n);
        else
            sr = 'N/A';
        end
        allRecords{n,15} = sr;
        logTable.Data = logData;
        recTable.Data  = allRecords;
        drawnow;
    end

%% ===== APPLY PRIVACY =====
    function out = applyPrivacy(img,mode,key,nlvl)
        out=img;
        switch mode
            case 'Gaussian Blur'
                h=fspecial('gaussian',[21 21],8);
                for c=1:3
                    out(:,:,c)=uint8(imfilter(double(img(:,:,c)),h,'replicate'));
                end
            case 'AES-like Encryption'
                out=bitxor(img,key);
            case 'Differential Privacy'
                out=uint8(min(255,max(0,double(img)+nlvl*randn(size(img)))));
            case 'Face Anonymization'
                [h,w,~]=size(img);
                r1=round(h*0.2):round(h*0.8);
                c1=round(w*0.2):round(w*0.8);
                reg=img(r1,c1,:);
                sm=imresize(reg,0.05,'box');
                out(r1,c1,:)=imresize(sm,[length(r1) length(c1)],'box');
            case 'Edge Masking'
                gray=rgb2gray(img);
                edges=edge(gray,'Canny');
                mask=repmat(~edges,[1 1 3]);
                tmp=double(img); tmp(mask)=tmp(mask)*0.15;
                out=uint8(tmp);
        end
    end

%% ===== DECRYPT =====
    function out = decryptFrame(img,mode,key)
        out=img;
        if strcmp(mode,'AES-like Encryption'), out=bitxor(img,key); end
    end

%% ===== SSIM =====
    function val = computeSSIM(A,B)
        A=double(A); B=double(B);
        muA=mean(A(:)); muB=mean(B(:));
        sigA=std(A(:)); sigB=std(B(:));
        sigAB=mean((A(:)-muA).*(B(:)-muB));
        c1=(0.01*255)^2; c2=(0.03*255)^2;
        val=(2*muA*muB+c1)*(2*sigAB+c2)/((muA^2+muB^2+c1)*(sigA^2+sigB^2+c2));
        val=max(0,min(1,val));
    end

%% ===== METRICS PLOT (Simulation Tab) =====
    function updateMetricsPlot()
        cla(axMetrics); n=length(psnrLog); if n==0,return;end
        x=1:n;
        yyaxis(axMetrics,'left');
        plot(axMetrics,x,psnrLog,'-o','Color',[0.2 0.9 0.4],'LineWidth',2,...
            'MarkerSize',5,'MarkerFaceColor',[0.2 0.9 0.4]);
        axMetrics.YColor=[0.2 0.9 0.4];
        ylabel(axMetrics,'PSNR (dB)');
        yyaxis(axMetrics,'right');
        plot(axMetrics,x,ssimLog,'-s','Color',[0.3 0.6 1],'LineWidth',2,...
            'MarkerSize',5,'MarkerFaceColor',[0.3 0.6 1]);
        axMetrics.YColor=[0.3 0.6 1];
        ylabel(axMetrics,'SSIM');
        xlabel(axMetrics,'Frame #');
        axMetrics.Title.String=sprintf('PSNR:%.2fdB | SSIM:%.4f (avg)',...
            mean(psnrLog),mean(ssimLog));
        axMetrics.Title.Color=[0.9 0.9 0.9]; axMetrics.Title.FontSize=8;
        grid(axMetrics,'on');
        legend(axMetrics,{'PSNR','SSIM'},'Location','best','FontSize',7);
        drawnow;
    end

%% ===== EDGE METRICS PLOT (Simulation Tab) =====
    function updateEdgeMetricsPlot()
        cla(axEdgeMetrics); n=length(edgeDelLog); if n==0,return;end
        x=1:n;
        yyaxis(axEdgeMetrics,'left');
        bar(axEdgeMetrics,x,edgeDelLog,0.5,'FaceColor',[1 0.6 0.1],'EdgeColor','none');
        axEdgeMetrics.YColor=[1 0.6 0.1];
        ylabel(axEdgeMetrics,'Edge Delay (ms)');
        yyaxis(axEdgeMetrics,'right');
        plot(axEdgeMetrics,x,cpuLog,'-^','Color',[0.7 0.3 1],'LineWidth',1.5,...
            'MarkerSize',4,'MarkerFaceColor',[0.7 0.3 1]);
        axEdgeMetrics.YColor=[0.7 0.3 1];
        ylabel(axEdgeMetrics,'CPU (MHz)');
        xlabel(axEdgeMetrics,'Frame #');
        axEdgeMetrics.Title.String=sprintf('EdgeDly:%.1fms | CPU:%.0fMHz (avg)',...
            mean(edgeDelLog),mean(cpuLog));
        axEdgeMetrics.Title.Color=[1 0.7 0.2]; axEdgeMetrics.Title.FontSize=8;
        grid(axEdgeMetrics,'on');
        legend(axEdgeMetrics,{'Edge Delay','CPU MHz'},'Location','best','FontSize',7);
        drawnow;
    end

%% ===== SUMMARY =====
    function updateSummary()
        if isempty(psnrLog), return; end
        nOK   = numel(psnrLog);
        nLost = size(logData,1)-nOK;
        nAtt  = sum(strcmp(attackLog,'Attacked'));
        nFld  = sum(strcmp(floodLog,'Y'));
        nCH   = sum(cacheLog);
        txt=sprintf(['Frames OK: %d  |  Lost: %d\n\n'...
            'PSNR  Avg:%.2fdB  Min:%.2f  Max:%.2f\n'...
            'SSIM  Avg:%.4f\n\n'...
            'Latency  Avg:%dms  Max:%dms\n\n'...
            'Edge Delay Avg:%.1fms\n'...
            'Cache Hits: %d/%d (%.0f%%)\n'...
            'CPU Avg: %.0f MHz\n\n'...
            'Interference Attacks: %d\n'...
            'Flood Events: %d\n'...
            'Succ Rate Avg: %.1f%%\n\n'...
            'Privacy: %s'],...
            nOK,nLost,...
            mean(psnrLog),min(psnrLog),max(psnrLog),...
            mean(ssimLog),...
            round(mean(latLog)),round(max(latLog)),...
            mean(edgeDelLog),...
            nCH,nOK,100*nCH/max(nOK,1),...
            mean(cpuLog),...
            nAtt,nFld,...
            mean(succLog),...
            privacyDrop.Value);
        sumLabel.Text=txt;
    end

%% ===== REFRESH RECORDS TAB =====
    function refreshRecords()
        if isempty(psnrLog), return; end
        recTable.Data = allRecords;

        % Chart 1: PSNR per frame (bar)
        cla(axR1); n=length(psnrLog);
        bar(axR1,1:n,psnrLog,'FaceColor',[0.2 0.85 0.4],'EdgeColor','none');
        xlabel(axR1,'Frame'); ylabel(axR1,'PSNR (dB)');
        axR1.Title.String='PSNR per Frame';
        axR1.Title.Color=[0.2 0.9 0.4]; axR1.Title.FontSize=8;
        axR1.XColor=[0.6 0.6 0.7]; axR1.YColor=[0.6 0.6 0.7];
        grid(axR1,'on');

        % Chart 2: Anon Overhead vs Success Rate (scatter)
        cla(axR2);
        if ~isempty(anonLog) && ~isempty(succLog)
            scatter(axR2,anonLog,succLog,50,[1 0.5 0.2],'filled',...
                'MarkerEdgeColor',[1 0.8 0.4]);
            xlabel(axR2,'Anon Overhead (%)'); ylabel(axR2,'Success Rate (%)');
            axR2.Title.String='Overhead vs Success Rate';
            axR2.Title.Color=[1 0.6 0.2]; axR2.Title.FontSize=8;
            axR2.XColor=[0.6 0.6 0.7]; axR2.YColor=[0.6 0.6 0.7];
            grid(axR2,'on');
        end

        % Chart 3: Edge Delay + CPU (dual-axis bar+line)
        cla(axR3);
        if ~isempty(edgeDelLog)
            yyaxis(axR3,'left');
            bar(axR3,1:n,edgeDelLog,0.6,'FaceColor',[0.5 0.4 1],'EdgeColor','none');
            axR3.YColor=[0.5 0.4 1];
            ylabel(axR3,'Edge Delay (ms)');
            yyaxis(axR3,'right');
            plot(axR3,1:n,cpuLog,'-o','Color',[1 0.4 0.7],'LineWidth',1.5,'MarkerSize',4);
            axR3.YColor=[1 0.4 0.7];
            ylabel(axR3,'CPU (MHz)');
            xlabel(axR3,'Frame');
            axR3.Title.String='Edge Delay & CPU Usage';
            axR3.Title.Color=[0.6 0.5 1]; axR3.Title.FontSize=8;
            grid(axR3,'on');
        end

        % Full stats summary
        nOK  = numel(psnrLog);
        nLost= size(allRecords,1)-nOK;
        nAtt = sum(strcmp(attackLog,'Attacked'));
        nFld = sum(strcmp(floodLog,'Y'));
        nCH  = sum(cacheLog);
        recSumLabel.Text=sprintf([...
            'SESSION SUMMARY\n'...
            '-------------------------------------------\n'...
            'Total Frames: %d  |  OK: %d  |  Lost: %d  |  Attacked: %d  |  Flooded: %d\n\n'...
            'QUALITY:  PSNR Avg=%.2fdB  Min=%.2fdB  Max=%.2fdB  |  SSIM Avg=%.4f\n\n'...
            'NETWORK:  Avg Latency=%dms  Max=%dms  |  Bandwidth=%.1fMB/s\n\n'...
            'EDGE NODE:  Avg Proc Delay=%.1fms  |  Cache Hits=%d/%d (%.0f%%)  |  Avg CPU=%.0fMHz\n\n'...
            'PRIVACY:  Anon Overhead=%.1f%%  |  Avg Success Rate=%.1f%%  |  Mode: %s'],...
            size(allRecords,1),nOK,nLost,nAtt,nFld,...
            mean(psnrLog),min(psnrLog),max(psnrLog),mean(ssimLog),...
            round(mean(latLog)),round(max(latLog)),mean(bandField.Value),...
            mean(edgeDelLog),nCH,nOK,100*nCH/max(nOK,1),mean(cpuLog),...
            mean(anonLog),mean(succLog),privacyDrop.Value);
    end

%% ===== STATUS =====
    function setStatus(msg,color)
        cols=struct('green',[0.2 1 0.4],'yellow',[1 0.9 0.2],...
            'red',[1 0.3 0.3],'orange',[1 0.6 0.1],'cyan',[0.2 0.9 1]);
        if isfield(cols,color), statusLabel.FontColor=cols.(color);
        else, statusLabel.FontColor=[0.9 0.9 0.9]; end
        statusLabel.Text=['Status: ' msg]; drawnow;
    end

%% ===== EXPORT LOG =====
    function exportLog()
        if isempty(logData)
            uialert(fig,'No data to export.','Export','Icon','warning'); return;
        end
        [file,path]=uiputfile('*.csv','Save Log');
        if isequal(file,0), return; end
        writeCSV(fullfile(path,file), logData,...
            {'Frame','Mode','PSNR','SSIM','Latency_ms','BW_MBs','PktLoss',...
             'EdgeDly_ms','CacheHit','CPU_MHz','AnonOvhd','Attack','Flood','Status'});
        setStatus(['Log saved: ' file],'cyan');
    end

%% ===== EXPORT FULL REPORT =====
    function exportFullReport()
        if isempty(allRecords)
            uialert(fig,'No records yet.','Export','Icon','warning'); return;
        end
        [file,path]=uiputfile('*.csv','Save Full Report');
        if isequal(file,0), return; end
        writeCSV(fullfile(path,file), allRecords,...
            {'Frame','Mode','PSNR','SSIM','Latency_ms','BW_MBs','PktLoss',...
             'EdgeDly_ms','CacheHit','CPU_MHz','AnonOvhd','Attack','Flood','Status','SuccRate'});
        setStatus(['Full report saved: ' file],'cyan');
    end

%% ===== WRITE CSV =====
    function writeCSV(fpath, data, headers)
        fid=fopen(fpath,'w');
        fprintf(fid,'%s\n',strjoin(headers,','));
        for i=1:size(data,1)
            r=data(i,:);
            strs=cellfun(@(x) num2str(x), r,'UniformOutput',false);
            fprintf(fid,'%s\n',strjoin(strs,','));
        end
        fclose(fid);
    end

%% ===== CLEAR RECORDS =====
    function clearRecords()
        allRecords={}; recTable.Data={};
        recSumLabel.Text='Records cleared.';
        cla(axR1); cla(axR2); cla(axR3);
    end

%% ===== RESET =====
    function resetAll()
        mediaData=[]; logData={}; allRecords={};
        psnrLog=[]; ssimLog=[]; latLog=[];
        edgeDelLog=[]; cacheLog=[]; cpuLog=[]; anonLog=[];
        attackLog={}; floodLog={}; succLog=[];
        cla(axSource); cla(axEdge); cla(axDest);
        cla(axMetrics); cla(axEdgeMetrics); cla(axHolo);
        styleAx(axSource,'SOURCE NODE',[0.2 0.9 0.4]);
        styleAx(axEdge,  'EDGE NODE (Privacy Engine)',[1 0.6 0.1]);
        styleAx(axDest,  'DESTINATION NODE',[0.2 0.6 1]);
        axMetrics.Title.String='PSNR & SSIM';
        axMetrics.Title.Color=[0.9 0.9 0.9];
        axEdgeMetrics.Title.String='Edge Node Metrics';
        axEdgeMetrics.Title.Color=[1 0.7 0.2];
        axHolo.Title.String='Holographic Depth Map';
        axHolo.Title.Color=[0.2 0.8 1];
        logTable.Data={}; recTable.Data={};
        sumLabel.Text='Run a simulation to see stats.';
        recSumLabel.Text='No session data yet.';
        setStatus('Reset complete. Load media to begin.','green');
    end

%% ===== UTILITY =====
    function s = ternary(cond, a, b)
        if cond, s=a; else, s=b; end
    end
    function v = ternaryNum(cond, a, b)
        if cond, v=a; else, v=b; end
    end

end