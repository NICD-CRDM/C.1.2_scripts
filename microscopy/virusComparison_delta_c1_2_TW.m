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
nameFig = 'delta_CP_1_2_TW.emf';

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
% A2051	02-0104	02-0106	02-0108	02-0109	13-0153	13-0140	13-0141	13-0142	13-0149	13-0157


%includes A02051 control column 1

%NUMBER REPEATS: 2

%%%DATA SOURCE:

%C:\SAforBackup\papersInProgress\c.1.2

%PNRT50..0134_6518_C.1.2_1313_deltaSeq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    

    %delta virus mean 
    excelMatrix1 =[0.043992894	-0.005141911	0.012515645	0.012379991	-0.005141911	-0.005141911	-0.000706215	0.002319769	0.014021453	-0.000706215
0.183178974	-0.005141911	0.061379143	-0.005141911	0.003890347	-0.005141911	0.002520893	0.013011272	0.057189716	-0.000706215
0.364406314	0.012786951	0.213570996	-0.000761436	0.008406476	-0.005141911	0.015027075	0.050936625	0.137076585	0.002520893
0.52386693	0.007999516	0.262841455	-0.005141911	0.061921757	-0.005141911	0.047709517	0.113074401	0.307546384	0.021686973
0.911208365	0.039476765	0.555751141	0.003890347	0.169087973	0.03509629	0.11347665	0.208296869	0.480233111	0.048116324
0.753782551	0.06205741	0.637177117	-0.000625782	0.253266583	0.133230247	0.259322661	0.304721525	0.680560493	0.179033543
0.882579838	0.293776091	0.842205983	0.082874561	0.487737898	0.377547741	0.358174485	0.455417313	0.838707003	0.344872921


];



    %delta virus std
    excelMatrix2=[0.014425903	0.005501781	0.017699794	0.030281493	0.005501781	0.005501781	0.000998738	0.001283171	0.00613787	0.000998738
0.136925608	0.005501781	0.022935508	0.005501781	0.007271761	0.005501781	0.005562558	0.00441838	0.014961738	0.000998738
0.033913948	0.007463604	0.068397715	0.011696709	0.013658532	0.005501781	0.015259063	0.010113485	0.016080131	0.005562558
0.025541374	0.024086565	0.100907098	0.005501781	0.027391288	0.005501781	0.005549666	0.013869128	0.010501055	0.003287094
0.014258041	0.008039132	0.04432942	0.007271761	0.0674385	0.01423406	0.005310355	0.039002366	0.021962173	0.017844744
0.262438846	0.039972987	0.171872996	0.00088499	0.037806761	0.04150773	0.053133769	0.006506102	0.054257803	0.043456602
0.246348021	0.082706	0.21403048	0.091655244	0.076635542	0.015329164	0.041123124	0.005122613	0.041556622	0.049597292


];



%%C1.2 virus mean 
excelMatrix3 =[0.007932999	-0.00132626	0.156302191	0.00795756	0.045043717	-0.00132626	0.084784262	0.288625619	0.597718289	0.024644202
0.017192259	-0.00132626	0.304646822	-0.00132626	0.100648394	-0.00132626	0.300581144	0.395245594	0.648097319	0.0540299
0.286201984	0.017241379	0.480818352	0.00795756	0.119240593	0.00795756	0.432687701	0.554207396	0.62082833	0.238814245
0.480867472	0.109907653	0.657014441	0.091389134	0.230376265	0.054278416	0.490297308	0.538869107	0.680271647	0.45595331
0.796099813	0.128475292	0.66624914	0.137783672	0.286152864	0.193314667	0.573909849	0.623127088	0.660001539	0.620467546
0.916740348	0.230523627	0.953777385	0.295338442	0.545829649	0.184129089	0.601695189	0.667490292	0.767551608	0.613366058
0.87032125	0.425262796	1.102048335	0.31385696	0.675483839	0.397386777	0.671957063	0.737727342	0.805975114	0.759520025

];


%%C1.2 virus std 
excelMatrix4 =[0.014970185	0.001875615	0.011531558	0.011253689	0.011323156	0.001875615	0.008605379	0.072952336	0.072882122	0.014192117
0.028064755	0.001875615	0.011809427	0.001875615	0.014796517	0.001875615	0.031212125	0.026465621	0.021501452	0.002433519
0.116670188	0.024382992	0.025251333	0.011253689	0.037685964	0.011253689	0.016552496	0.004646448	0.123695224	0.029166541
0.07769908	0.027891087	0.064917112	0.001701947	0.093225002	0.027995288	0.006271915	0.026978187	0.028966429	0.074287583
0.078289551	0.00163248	0.025598669	0.037720698	0.06422244	0.067070596	0.007222152	0.002183088	0.054331437	0.035743304
0.196522751	0.064118239	0.144144471	0.027543751	0.143380332	0.024695595	0.131822559	0.118238383	0.115792576	0.043610844
0.130876233	0.103818753	0.065750719	0.053732891	0.013719775	0.038206968	0.012591225	0.217568572	0.106152118	0.071509427

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

   


