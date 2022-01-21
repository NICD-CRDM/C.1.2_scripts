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
nameFig = 'ancestral_C_1_2_SW.emf';

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

%Copy of AllExp....PNRT50...2ndWavePlasma_beta_delat_C.1.2_020921_AS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    

    %beta virus mean 
    excelMatrix1 =[0.082816171	0.008991046	0.012617519	0.031613492	0.117398171	0.001306546	0.042276885	0.016027966	-0.002319927
0.176069824	0.050177912	0.083896305	0.120593091	0.177365984	0.038866439	0.064899832	0.008559492	-0.002319927
0.360678869	0.127630011	0.169464957	0.254385529	0.208492056	0.079405725	0.153446877	0.062956591	0.020302019
0.583450906	0.23327477	0.242858529	0.406742888	0.570627246	0.161779957	0.280850976	0.196145931	0.031397466
0.753121505	0.393317128	0.355540209	0.552108307	0.724928345	0.277224503	0.400570075	0.396943602	0.091581305
0.785975791	0.570843272	0.553961585	0.740252863	0.727906738	0.515582567	0.641258451	0.538205013	0.186949243
0.956033462	0.757396058	0.628650818	0.933626542	0.818398024	0.680762585	0.884322622	0.667336826	0.390077227


];



    %beta virus std
    excelMatrix2=[0.032892021	0.006304499	0.001175892	0.017783039	0.016014312	0.004563025	0.008165507	0.014515439	0.000565583
0.034355241	0.013265448	0.019921595	0.010239035	0.029021099	0.007525824	0.00331374	0.01482024	0.000565583
0.052348714	0.031058974	0.007590144	0.036429476	0.091075433	0.01720069	0.045834488	0.091749355	0.012043416
0.001863801	0.02603034	0.052731116	0.067136801	0.081542487	0.003278087	0.019516113	0.035065523	0.007220316
0.084228431	0.006191246	0.016461741	0.107669301	0.01718601	0.014387506	0.00406597	0.001062638	0.030789826
0.048633686	0.070979764	0.166654582	0.180143744	0.054002788	0.036300835	0.094484247	0.024822295	0.049741064
0.028842125	0.110787994	0.16360021	0.029758649	0.008086506	0.012669112	0.068713275	0.085997159	0.152248896


];



%%c.1.2 virus mean 
excelMatrix3 =[0.003438114	0.02209483	0.029264288	0.056769199	0.178649972	0.017777028	0.053331085	0	0
0.076012374	0.075425916	0.118442659	0.194161804	0.334032197	0.014045685	0.128170542	0.038992171	0.014338914
0.346773011	0.216256634	0.24640061	0.400983784	0.599888573	0.138484884	0.427022549	0.093202944	0.076012374
0.579047298	0.336751899	0.433898777	0.488028912	0.838452629	0.328328886	0.580220215	0.282460487	0.17433217
0.792291001	0.674009618	0.658922969	0.691493417	0.79618362	0.461777556	0.674090256	0.566760989	0.329501803
0.788134475	0.783574759	0.8742486	0.915718558	1.043808463	0.773209102	0.766545465	0.663614638	0.508232414
0.937600798	0.790106442	0.874380553	0.94322347	0.96121309	0.778032724	1.085439697	0.762733484	0.700554203




];


%%c.1.2 virus std 
excelMatrix4 =[0.004862227	0.021522354	0.021937043	0.016960776	0.009911065	0.00403285	0.012098549	0	0
0.029702093	0.009423805	0.011911939	0.031474888	0.081901058	0.009309766	0.022953031	0.012927927	0.000829378
0.11115736	0.052997242	0.105351716	0.129476242	0.046279281	0.037539713	0.039882705	0.005390956	0.029702093
0.09928689	0.135883186	0.03015825	0.078054819	0.088152493	0.031620029	0.139843465	0.008967648	0.035466268
0.075639256	0.165512708	0.10865886	0.151340715	0.182701563	0.127931526	0.292044659	0.169431518	0.008936546
0.151869443	0.253281614	0.283377661	0.108638125	0.040846857	0.130761778	0.024093425	0.053567439	0.125557432
0.246553287	0.096311497	0.040452902	0.069740306	0.050685351	0.050063318	0.03747751	0.107715442	0.030334493



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

   


