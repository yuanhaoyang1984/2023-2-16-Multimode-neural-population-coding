crecopy=crematrix;
crematrix=crematrixmean;
ffcopy=ffmatrix;

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
crepossum=[];
crenegsum=[];
for i=1:crepcells(1)
       crepossum(i,:)=(crepositivecell(i,:)-mean(crepositivecell(i,1:40)))/std(crepositivecell(i,1:40));
end

for i=1:crencells(1)
       crenegsum(i,:)=(crenegativecell(i,:)-mean(crenegativecell(i,1:40)))/std(crenegativecell(i,1:40));
end
ffpossum=[];
ffnegsum=[];
for i=1:ffpcells(1)
       ffpossum(i,:)=(ffpositivecell(i,1:121)-mean(ffpositivecell(i,1:40)))/std(ffpositivecell(i,1:40));
end

for i=1:ffncells(1)
       ffnegsum(i,:)=(ffnegativecell(i,1:121)-mean(ffnegativecell(i,1:40)))/std(ffnegativecell(i,1:40));
end

% 
maxcrepos=max(crepossum(:,40:80),[],2);
mincreneg=min(crenegsum(:,40:80),[],2);
maxcrepos=[maxcrepos,creposs(:,2)];
mincreneg=[mincreneg,crenegs(:,2)];

% 
maxffpos=max(ffpossum(:,40:80),[],2);
minffneg=min(ffnegsum(:,40:80),[],2);
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

