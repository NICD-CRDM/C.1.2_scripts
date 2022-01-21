%FFU graphing script

%By Alex Sigal, 2021

clearvars

close all

%%%THIS SCRIPT USES THE NUMBER OF FOCI PER WELL from the same location as the image analysis script.
%%%%Interactive Import from excel

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START user inputs

%dir to save fig
directory = 'C:\SAforBackup\papersInProgress\c.1.2';

%name figure saved
nameFig = 'ancestral_C_1_2_pfizer.emf';

%either 1/10 (enter 10) or 1:25 (enter 25)
firstDil = 25;

%y-limits for graph

ymin =2;

ymax=10^5;

cd(directory)

%%%Plasma concentrations

%plasmaConc =[1/firstDil, 1/(firstDil*2) 1/(firstDil*4) 1/(firstDil*8) 1/(firstDil*16) 1/(firstDil*32) 1/(firstDil*64) 1/(firstDil*128)];

plasmaConc =[1/firstDil, 1/(firstDil*2) 1/(firstDil*4) 1/(firstDil*8) 1/(firstDil*16) 1/(firstDil*32) 1/(firstDil*64)];

%COLUMN PID:
% A2051....


%includes A02051 control column 1

%NUMBER REPEATS: 2

%%%DATA SOURCE:

%AllExp....PNRT50...PfizerPlasma_4viruses_-3 plasmas

%AllExp....PNRT50..0134_6518_27-7_260821...11PIDS_bySeq_AS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    

    %1313 virus mean 
    excelMatrix1 =[0.030406456	0	0.003271028	0	0.003593429	0	0
0.086611718	0	0	0	0.024186801	0	0.044457771
0.264442803	0	0.017322344	0.009813084	0.127798461	0	0.219985031
0.566848337	0	0.159863939	0.093523192	0.329816347	0.003271028	0.51976434
0.660049128	0.013728914	0.42859199	0.287709417	0.646320213	0.058509087	0.673039206
0.800239882	0.152677081	0.580899653	0.534507475	0.701235871	0.325947533	0.733899135
0.86602986	0.353405362	0.725469689	0.705427086	0.8486605	0.501844211	0.814888983

];



    %1313 virus std
    excelMatrix2=[0.017402445	-0.000954198	0.017962953	0.005164683	0.153746063	0.005725191	0.127028506
0.043559494	0.005164683	0.058039289	0.081393797	0.486501094	0.005164683	0.439184861
0.224977313	0.005164683	0.253890194	0.31008114	0.612241766	0.050238883	0.773060909
0.325681952	0.070277051	0.510976619	0.629524102	0.730789249	0.214421075	0.798657449
0.54937143	0.211058026	0.621163188	0.798657449	0.962279133	0.457588213	0.701222442
0.943315273	0.593885123	0.844338867	0.846534191	0.83756606	0.774742433	0.675112102
1.081854214	0.792491859	0.897680564	1.046775743	1.054622858	0.712385897	0.9828311

];



%%C1.2 virus mean 
excelMatrix3 =[0.006849315	0.006849315	0.006777	-0.001141553	0.014767867	-0.001141553	0.054577574
0.054432943	-0.001141553	0.014695552	0.038523523	0.157591066	-0.001141553	0.229291928
0.325110023	-0.001141553	0.149600198	0.16579888	0.55576045	0.038668154	0.459436145
0.474983987	0.014840183	0.538693981	0.515299903	0.52394161	0.070414678	0.500547532
0.999127048	0.094387281	0.499462799	0.610973367	0.787495609	0.214033348	0.603416393
0.929595653	0.308549763	0.816421827	0.929234075	0.763161429	0.59535321	0.739116511
0.818880555	0.492701295	0.707442303	0.714565384	1.018579929	0.817795822	0.699162173

];


%%C1.2 virus std 
excelMatrix4 =[0.009686394	0.009686394	0.012812923	0.001614399	0.001512129	0.001614399	0.009993203
0.035005431	0.001614399	0.024011446	0.0351077	0.113088288	0.001614399	0.078879099
0.034231104	0.001614399	0.124389081	0.034289543	0.024464355	0.009890934	0.246141067
0.358535382	0.020987188	0.335626987	0.189534831	0.024259815	0.012403844	0.170351972
0.625152289	0.021498536	0.167137783	0.121423262	0.352187361	0.123512484	0.002271847
0.015618032	0.168365019	0.54758078	0.096878553	0.205788396	0.031528264	0.149386699
0.217395998	0.204049812	0.194180794	0.064510217	0.477416514	0.120093757	0.092882732


];




%%%%END inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%start script



xAxis = plasmaConc;

IC50Vect1 = [];

confIntervalsMatrix1  = [];

RsqVect1= [];

IC50Vect2 = [];

confIntervalsMatrix2  = [];

RsqVect2= [];

% IC50Vect3 = [];
% 
% confIntervalsMatrix3  = [];
% 
% RsqVect3= [];


for virus = 1:2


    if virus ==1

        matrixData = excelMatrix1;

    elseif virus ==2

        matrixData = excelMatrix3;

%     elseif virus ==3
% 
%         matrixData = excelMatrix5;

    end


    
   for sample =1:numel(excelMatrix1(1,:)) %EVERY COLUMN IS ONE PLASMA TIMEPOINT       

     yDataFirst =matrixData(:,sample);


    yDataCleanFirst = yDataFirst;
                
              
    yDataCleanFirst(find(yDataCleanFirst>1))=1;

        [xData, yData1] = prepareCurveData(xAxis', yDataCleanFirst);

        ft = fittype( '1/(1+(x/a))', 'independent', 'x', 'dependent', 'y' );
        opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
        opts.Display = 'Off';
        opts.StartPoint = 0.964888535199277;

        % Fit model to data.
        [fitresult, gof] = fit(xData, yData1, ft, opts );


        IC50 = coeffvalues(fitresult);

        confIntervals = confint(fitresult);

        Rsq = gof.rsquare;
        
            if virus ==1

            IC50Vect1= [IC50Vect1,IC50];

            confIntervalsMatrix1= [confIntervalsMatrix1,confIntervals];

            RsqVect1= [RsqVect1,Rsq];

            elseif virus ==2

            IC50Vect2= [IC50Vect2,IC50];

            confIntervalsMatrix2= [confIntervalsMatrix2,confIntervals];

            RsqVect2= [RsqVect2,Rsq];

%             elseif virus ==3
% 
%             IC50Vect3= [IC50Vect3,IC50];
% 
%             confIntervalsMatrix3= [confIntervalsMatrix3,confIntervals];
% 
%             RsqVect3= [RsqVect3,Rsq];

            end

         
   end
   
end



PRNT50vect1 = 1./IC50Vect1;%v1 virus
PRNT50vect2 = 1./IC50Vect2;%v3 virus
%PRNT50vect3 = 1./IC50Vect3;%v7 virus

%%%first col is A02051

prnt50Matrix = [PRNT50vect1(2:end); PRNT50vect2(2:end)];
%prnt50Matrix2 = [PRNT50vect2(2:end); PRNT50vect3(2:end)];

geomeanVect1 = geomean(PRNT50vect1(2:end));
geomeanVect2 = geomean(PRNT50vect2(2:end));
%geomeanVect3 = geomean(PRNT50vect3(2:end));

%%%stats
[p1,h1,stats1] = ranksum(PRNT50vect1(2:end),PRNT50vect2(2:end), 'tail','right');
% [p2,h2,stats2] = ranksum(PRNT50vect2(2:end),PRNT50vect3(2:end), 'tail','right');
% [p3,h3,stats3] = ranksum(PRNT50vect1(2:end),PRNT50vect2(2:end), 'tail','right');

if p1>0.05
    stringToUse1 = 'ns';
elseif p1<0.05 && p1>0.01
    stringToUse1 = '*';
elseif p1<0.01 && p1>0.001
    stringToUse1 = '**';
elseif p1<0.001 && p1>0.0001
    stringToUse1 = '***';
elseif p1<0.0001 
    stringToUse1 = '****';
end

%%%fold change

foldChangeGeo1 = geomeanVect1/geomeanVect2;
%foldChangeGeo2 = geomeanVect2/geomeanVect3;

%label fold change on graph
stringToUse2 = [num2str((round(foldChangeGeo1*10))/10) 'X'];


figure3 = figure;

    axes3 = axes('Parent',figure3, 'FontSize',18);%, 'FontWeight','bold'
    
    pbaspect([4 3 1])

     hold(axes3,'on');

    xlabel("")
    ylabel("")
    
     H=gca;
    
    H.LineWidth=2;
    
    set(gca,'XColor','k', 'YColor','k')
    
    set(gca,'YScale', 'log');
                
    set(gca,'xlim',[0.7 2.3]);
    
    set(gca,'ylim',[ymin ymax]);
     
     set(gca,'xTick', [1, 2]);
    
    set(gca,'yTick', [10, 100, 1000, 10000, 100000]);
    
    set(gca,'XMinorTick','off','YMinorTick','off')

    hold on

     
    
 for pointSet= 1:numel(PRNT50vect1(2:end))
        
   
        plot(1:2, prnt50Matrix(:, pointSet),'LineStyle', '-',...
             'Color', '#636363', 'Marker', 'o', 'MarkerSize',10, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor','#636363', 'LineWidth', 1.5);
         
        
 end
    
     set(gca,'Xticklabels',{'','',''});

hold on

%%%plot geomean

plot(0.9:0.1:1.1, geomeanVect1.*ones(numel(0.9:0.1:1.1),1), 'Color', [0 0 0], 'Linewidth', 4, 'Linestyle', '-');

hold on

%%%plot geomean 2

plot(1.9:0.1:2.1, geomeanVect2.*ones(numel(0.9:0.1:1.1),1), 'Color', [0 0 0], 'Linewidth', 4, 'Linestyle', '-');

%plot level detection

hold on

plot(0:1:3, (1/(max(plasmaConc))).*ones(numel(0:1:3),1), 'Color', '#e41a1c', 'Linewidth', 2, 'Linestyle', ':');


hold on

% Create textbox
annotation(figure3,'textbox',...
    [0.465 0.684714288126858 0.124999996806894 0.104761902349336],...
    'String',{stringToUse1},...
    'HorizontalAlignment','center',...
    'FontSize',22,...
    'FontName','Arial',...
    'EdgeColor','none');

% Create textbox
annotation(figure3,'textbox',...
    [0.457142857142854 0.808523811510646 0.136607139318117 0.090476188489369],...
    'Color',[1 0 0],...
    'String',{stringToUse2},...
    'FontSize',18,...
    'FontName','Arial',...
    'EdgeColor','none');

% Create textbox
annotation(figure3,'textbox',...
    [0.210714285714286 0.810904763891584 0.127678568155638 0.090476188489369],...
    'String',{num2str(round(geomeanVect1))},...
    'HorizontalAlignment','center',...
    'FontSize',18,...
    'FontName','Arial',...
    'EdgeColor','none');

% Create textbox
annotation(figure3,'textbox',...
    [0.692857142857142 0.810904763891585 0.127678568155638 0.090476188489369],...
    'String',{num2str(round(geomeanVect2))},...
    'HorizontalAlignment','center',...
    'FontSize',18,...
    'FontName','Arial',...
    'EdgeColor','none');



saveas(gcf, nameFig,'meta')

%%%second figure

% figure4 = figure;
% 
%     axes4 = axes('Parent',figure4, 'FontSize',18);%, 'FontWeight','bold'
%     
%     pbaspect([4 3 1])
% 
%      hold(axes4,'on');
% 
%     xlabel("")
%     ylabel("")
%     
%      H=gca;
%     
%     H.LineWidth=2;
%     
%     set(gca,'XColor','k', 'YColor','k')
%     
%     set(gca,'YScale', 'log');
%                 
%     set(gca,'xlim',[0.7 2.3]);
%     
%     set(gca,'ylim',[5 10^6]);
%      
%      set(gca,'xTick', [1, 2]);
%     
%     set(gca,'yTick', [10, 100, 1000, 10000, 100000]);
%     
%     set(gca,'XMinorTick','off','YMinorTick','off')
% 
%     hold on
% 
%      
%     
%  for pointSet= 1:numel(PRNT50vect1(2:end))
%         
%    
%         plot(1:2, prnt50Matrix2(:, pointSet),'LineStyle', '-',...
%              'Color', '#636363', 'Marker', 'o', 'MarkerSize',10, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor','#636363', 'LineWidth', 1.5);
%          
%         
%  end
%     
%      set(gca,'Xticklabels',{'','',''});
% 
% hold on
% 
% %%%plot geomean
% 
% plot(0.9:0.1:1.1, geomeanVect2.*ones(numel(0.9:0.1:1.1),1), 'Color', [0 0 0], 'Linewidth', 4, 'Linestyle', '-');
% 
% hold on
% 
% %%%plot geomean 2
% 
% plot(1.9:0.1:2.1, geomeanVect3.*ones(numel(0.9:0.1:1.1),1), 'Color', [0 0 0], 'Linewidth', 4, 'Linestyle', '-');
% 
% 
% % plot min conc
% 
% plot(0:1:3, 10.*ones(numel(0:1:3),1), 'Color', '#e41a1c', 'Linewidth', 2, 'Linestyle', ':');
% 
% 
% saveas(gcf,'pid27fig1f.emf','meta')
% 
% 
% %%%stats
% [p1,h1,stats1] = ranksum(PRNT50vect1(2:end),PRNT50vect3(2:end), 'tail','right');
% [p2,h2,stats2] = ranksum(PRNT50vect2(2:end),PRNT50vect3(2:end), 'tail','right');
% [p3,h3,stats3] = ranksum(PRNT50vect1(2:end),PRNT50vect2(2:end), 'tail','right');
% 
% %%%fold change
% 
% foldChangeGeo1 = geomeanVect1/geomeanVect3;
% foldChangeGeo2 = geomeanVect2/geomeanVect3;

   


