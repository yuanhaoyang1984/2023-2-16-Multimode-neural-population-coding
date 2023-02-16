crecopy=crematrix;
crematrix=crematrixmean;
ffcopy=ffmatrix;
% for i=1:75
%     crematrix(i,1:121)=(crematrix(i,1:121)-mean(crematrix(i,1:60)))/std(crematrix(i,1:60));
% end
% for i=1:110
%      ffmatrix(i,1:121)=(ffmatrix(i,1:121)-mean(ffmatrix(i,1:60)))/std(ffmatrix(i,1:60));
% end

fla=find(crematrix(:,122)==1);
crepositivecell=crematrix(fla,1:123);
crepcells=size(crepositivecell);
% ones(crepcells(1),1)
fla=find(crematrix(:,122)==-1);
crenegativecell=crematrix(fla,1:123);
crencells=size(crenegativecell);

fla=find(crematrix(:,122)==-0);
crenoncell=crematrix(fla,1:123);
crenocells=size(crenoncell);
% a=size(crepositivecell);
fla=find(ffmatrix(:,122)==1);
ffpositivecell=ffmatrix(fla,1:123);
ffpcells=size(ffpositivecell);

fla=find(ffmatrix(:,122)==-1);
ffnegativecell=ffmatrix(fla,1:123);
ffncells=size(ffnegativecell);

fla=find(ffmatrix(:,122)==-0);
ffnoncell=ffmatrix(fla,1:123);
ffnocells=size(ffnoncell);

creposs=crepositivecell(:,122:123);
crenegs=crenegativecell(:,122:123);
fla=find(crematrix(:,122)==1);
crepositivecell=crematrix(fla,1:121);
crepcells=size(crepositivecell);
% ones(crepcells(1),1)
fla=find(crematrix(:,122)==-1);
crenegativecell=crematrix(fla,1:121);
crencells=size(crenegativecell);

 mincreneg=mean((crenegativecell(:,61:121)-mean(crenegativecell(:,1:60),2))./std(crenegativecell(:,1:60),0,2),2);
 maxcreneg=mean((crepositivecell(:,61:121)-mean(crepositivecell(:,1:60),2))./std(crepositivecell(:,1:60),0,2),2);

maxcrepos=[maxcrepos,crepositivecell(:,123)];
mincreneg=[mincreneg,crenegativecell(:,123)];

 maxffpos=mean((ffpositivecell(:,61:121)-mean(ffpositivecell(:,1:60),2))./std(ffpositivecell(:,1:60),0,2),2);
 minffneg=mean((ffnegativecell(:,61:121)-mean(ffnegativecell(:,1:60),2))./std(ffnegativecell(:,1:60),0,2),2);
maxffpos=[maxffpos,ffpositivecell(:,123)];
minffneg=[minffneg,ffnegativecell(:,123)];


neg=[minffneg;mincreneg];
pos=[maxffpos;maxcrepos];

ffpos_r=corr(maxffpos(:,1),maxffpos(:,2),'type','pearson');
ffneg_r=corr(minffneg(:,1),minffneg(:,2),'type','pearson');
creneg_r=corr(mincreneg(:,1),mincreneg(:,2),'type','pearson');
crepos_r=corr(maxcrepos(:,1),maxcrepos(:,2),'type','pearson');


ff=[minffneg;maxffpos];
cre=[mincreneg;maxcrepos];
figure
[R,Pvaluecreneg]=corrplot(mincreneg);
figure
[R,Pvaluecrepos]=corrplot(maxcrepos);
figure
[R,Pvalueffneg]=corrplot(minffneg);
figure
[R,Pvalueffpos]=corrplot(maxffpos);

