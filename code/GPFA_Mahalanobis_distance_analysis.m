h=gca;
data=get(h,'Children');
xdata=get(data,'Xdata');
ydata=get(data,'Ydata');
zdata=get(data,'Zdata');
size=60;
dataset={}
for i=1:size
    matrix=[];
    for j=1:6
        matrixadd=[xdata{j}(i),ydata{j}(i),zdata{j}(i)]
        matrix=[matrix;matrixadd]
    end
    dataset{end+1}=matrix;
end
d={}
for i=1:size
    d{end+1}=pdist(dataset{i},'mahalanobis')
end

Groupintra=[3,4,5,7,8,9,10,11,12];
InerGroup=[1,2,6,13,14,15];
Groupintra_matrix=zeros(9,size);
InerGroup_matrix=zeros(6,size);
for i=1:size
    ma=d{i}(Groupintra);
    mas=ma';
    Groupintra_matrix(:,i)=mas;
    ma=d{i}(InerGroup);
    mas=ma';
    InerGroup_matrix(:,i)=mas;
end
figure
bin=1:size;
xx=[bin,bin(end:-1:1)]; 
InerGroup_mean=mean(InerGroup_matrix(1:3,:));
InerGroup_sem=std(InerGroup_matrix(1:3,:))./3;
ymaxmin=[InerGroup_mean+InerGroup_sem,InerGroup_mean(end:-1:1)-InerGroup_sem(end:-1:1)];
fill(xx,ymaxmin,[220,220,220]/255,'EdgeColor','none');
hold on
plot(bin,InerGroup_mean,'color',[0,0,0]/255,'LineWidth',0.8)
axis on
axis square
hold on

Groupintra_mean=mean(Groupintra_matrix);
Groupintra_sem=std(Groupintra_matrix)./9;
ymaxmin=[Groupintra_mean+Groupintra_sem,Groupintra_mean(end:-1:1)-Groupintra_sem(end:-1:1)];


fill(xx,ymaxmin,[255,228,200]/255,'EdgeColor','none');
hold on;
plot(bin,Groupintra_mean,'color',[255,0,0]/255,'LineWidth',0.8)
axis on
axis square
hold on
distance_ttest_h=zeros(size,1);
distance_ttest_p=zeros(size,1);
for i=1:size
    
%     [h,p]=ttest2(Groupintra_matrix(:,i),InerGroup_matrix(1:3,i));
%     DDiagnostics = detectdrift(InerGroup_matrix(1:3,i),Groupintra_matrix(:,i))
    [p, observeddifference, effectsize] = permutationTest(Groupintra_matrix(:,i), InerGroup_matrix(1:3,i), 1000);
    h=0;
    if p<=0.05
        h=1;
    end
    distance_ttest_h(i)=h;
    distance_ttest_p(i)=p;
    
end
bin=1:size+2;
ma=[Groupintra_mean,InerGroup_mean];
lim=max(ma)+0.5;
distance_ttest_h=distance_ttest_h.*lim;
distance_ttest_h=[0;distance_ttest_h;0]
    start_h=bin(islocalmax(distance_ttest_h,"FlatSelection","first"));
    end_h=bin(islocalmax(distance_ttest_h,"FlatSelection","last"));
    end_t=end_h
hold on
for i=1:length(end_h)
    plot(start_h(i)-1:end_h(i)-1,distance_ttest_h(start_h(i):end_h(i)),'linewidth',2)
    hold on
end
hold off
