%% 
start_ave=-2, step=0.05;ended_ave=4
ave_spike=zeros(121,4);
% timestamp=[];
%% 
for i=1;
    clas1=data(find(data(:,1)==i),[1,2]);
    for j=1:length(timestamp);               
        spkc=timestamp(j,1);
        start=spkc-2;
        ended=spkc+4;
        edges = [start:step:ended]; %Define the edges of the histogram
        num=(ended-start)/step+1;
        psth= zeros(num,1); %Initialize the PSTH with zeros
        startpoint=min(find(clas1(:,2)>=start));
        endpoint=max(find(clas1(:,2)<ended));
        matrix=clas1(startpoint:endpoint,:);  
        psth=(psth+histc(matrix(:),edges))/step;
%         bar(edges,psth,1,'b'); %Plot PSTH as a bar graph
        psth_alltrial(:,j)=psth;       
        ave_psth=mean(psth_alltrial,2);%
        meaning_baseline=mean(ave_psth(1:40));
        meaning_sniffing=mean(ave_psth(41:80));
    end   
    edges_ave = [start_ave:step:ended_ave];
%     bar(edges_ave,ave_psth,1,'k','FaceColor','k','EdgeColor','w'); %Plot PSTH as a bar graph   
    bar(edges_ave,ave_psth,1,'r','EdgeColor','r'); %Plot PSTH as a bar graph 
    ave_spike(:,i)=ave_psth;%
    %%     
    d=psth_alltrial;
    pre_all=d(1:40,:);
    pre_mean=mean(pre_all,2);
    pre=pre_mean(:);

    R=pre;
    % Normal distribution judgement
    al = 0.05;
    [mu, sigma] = normfit(R);
    P= normcdf(R, mu, sigma);
    [H1,s1] = kstest(R, [R, P], al);   
    if H1 == 0
       disp('data sets typically follow a normal distribution');
       for i=1:80;
       posti=d(40+i,:);
       [h_t,p_t] = ttest2(posti,pre);
       pp_t(i,1)=p_t;
    end
    else
       disp(' data sets do not typically follow a normal distribution');
       for i=1:80;
       posti=d(40+i,:);
       [p_w,h_w,stats] = ranksum(posti,pre);
       pp_w(i,1)=p_w;
       end
    end
end

