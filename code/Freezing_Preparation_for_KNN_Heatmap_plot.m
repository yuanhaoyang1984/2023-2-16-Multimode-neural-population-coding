crecelln=size(crezktsum);
crecells=crecelln(2);
ffcelln=size(ffzktsum);
ffcells=ffcelln(2);
crecellsmatrix=[];
for i=1:crecells
    crecellsmatrix=[crecellsmatrix,crezktsum{i}];
    
end
ffcellmatrix=[];
for i=1:ffcells
    ffcellmatrix=[ffcellmatrix,ffzktsum{i}];
end

% 
ffmatrixmean=[]
for i=1:ffcells
    ffmatrixmean=[ffmatrixmean,mean(ffzktsum{i},2)];
end

crematrixmean=[]
for i=1:crecells
    crematrixmean=[crematrixmean,mean(crezktsum{i},2)];
end
crematrixmean=crematrixmean';
ffmatrixmean=ffmatrixmean';

fla=find(crematrix(:,122)==1);
crepositivecell=crematrix(fla,1:121);
crepcells=size(crepositivecell);
% ones(crepcells(1),1)
fla=find(crematrix(:,122)==-1);
crenegativecell=crematrix(fla,1:121);
crencells=size(crenegativecell);

fla=find(crematrix(:,122)==-0);
crenoncell=crematrix(fla,1:121);
crenocells=size(crenoncell);
% a=size(crepositivecell);
fla=find(ffmatrix(:,122)==1);
ffpositivecell=ffmatrix(fla,1:121);
ffpcells=size(ffpositivecell);

fla=find(ffmatrix(:,122)==-1);
ffnegativecell=ffmatrix(fla,1:121);
ffncells=size(ffnegativecell);

fla=find(ffmatrix(:,122)==-0);
ffnoncell=ffmatrix(fla,1:121);
ffnocells=size(ffnoncell);

 ffpossum=[];
 ffnegsum=[];
 ffnonsum=[];
  crepossum=[];
 crenegsum=[];
 crenonsum=[];
 
for i=1:ffpcells(1)
       ffpossum(i,:)=(ffpositivecell(i,:)-mean(ffpositivecell(i,1:60)))/std(ffpositivecell(i,1:60));
end

for i=1:ffncells(1)
       ffnegsum(i,:)=(ffnegativecell(i,:)-mean(ffnegativecell(i,1:60)))/std(ffnegativecell(i,1:60));
end

for i=1:ffnocells(1)
       ffnonsum(i,:)=(ffnoncell(i,:)-mean(ffnoncell(i,1:60)))/std(ffnoncell(i,1:60));
end


for i=1:crepcells(1)
       crepossum(i,:)=(crepositivecell(i,:)-mean(crepositivecell(i,1:60)))/std(crepositivecell(i,1:60));
end

for i=1:crencells(1)
       crenegsum(i,:)=(crenegativecell(i,:)-mean(crenegativecell(i,1:60)))/std(crenegativecell(i,1:60));
end

for i=1:crenocells(1)
       crenonsum(i,:)=(crenoncell(i,:)-mean(crenoncell(i,1:60)))/std(crenoncell(i,1:60));
end



ffpossum(:,122)=sum(ffpossum(:,60:121),2);
ffpossum=sortrows(ffpossum,122);
z1tt=ffpossum(:,1:121);
ffpos=smoothdata(z1tt,'gaussian',5);
ffnegsum(:,122)=sum(ffnegsum(:,60:121),2);
ffnegsum=sortrows(ffnegsum,122);
z1tt=ffnegsum(:,1:121);
ffneg=smoothdata(z1tt,'gaussian',5);

crepossum(:,122)=sum(crepossum(:,60:121),2);
crepossum=sortrows(crepossum,122);
crepos=smoothdata(crepossum(:,1:121),'gaussian',5);
crenegsum(:,122)=sum(crenegsum(:,60:121),2);
crenegsum=sortrows(crenegsum,122);
creneg=smoothdata(crenegsum(:,1:121),'gaussian',5);

cres=[crepossum(:,1:121);crenonsum;crenegsum(:,1:121)];
cres(:,122)=sum(cres(:,40:121),2);
cres=sortrows(cres,122);
cres_s=smoothdata(cres(:,1:121),'gaussian',5);

ffs=[ffpossum(:,1:121);ffnonsum;ffnegsum(:,1:121)];
cres=[crepossum(:,1:121);crenonsum;crenegsum(:,1:121)];

ffs(:,122)=sum(ffs(:,60:121),2);
z1tt=sortrows(ffs,122);
z1tt=z1tt(:,1:121);
ff=smoothdata(z1tt,'gaussian',5);

cresum(:,122)=cres(cresum(:,61:121),2);
z1tt=sortrows(cresum,122);
z1tt=z1tt(:,1:121);
cre=smoothdata(z1tt,'gaussian',5);
figure
xx=-3:0.05:3
y=1:103;
x=-3:0.05:3
[xx,yy]=meshgrid(x,y)
surf(xx,yy,ff,'edgecolor','none'); axis tight; axis tight;
view(2);
xlabel('Time (s)'); ylabel('Trial');
shading interp;
caxis([-2 4])
colormap('jet')
figure
xx=-3:0.05:3
y=1:94;
x=-3:0.05:3
[xx,yy]=meshgrid(x,y)
surf(xx,yy,cre,'edgecolor','none'); axis tight; axis tight;
view(2);
xlabel('Time (s)'); ylabel('Trial');
shading interp;
caxis([-2 4])
colormap('jet')


figure
xx=-3:0.05:3
y=1:28;
x=-3:0.05:3
[xx,yy]=meshgrid(x,y)
surf(xx,yy,ffpos,'edgecolor','none'); axis tight; axis tight;
view(2);
xlabel('Time (s)'); ylabel('Trial');
shading interp;
caxis([-2 4])
colormap('jet')

figure
xx=-3:0.05:3;
y=1:62;
x=-3:0.05:3;
[xx,yy]=meshgrid(x,y);
surf(xx,yy,ffneg,'edgecolor','none'); axis tight; axis tight;
view(2);
xlabel('Time (s)'); ylabel('Trial');
shading interp;
caxis([-2 4])
colormap('jet')

figure
xx=-3:0.05:3;
y=1:103;
x=-3:0.05:3;
[xx,yy]=meshgrid(x,y);
surf(xx,yy,ff,'edgecolor','none'); axis tight; axis tight;
view(2);
xlabel('Time (s)'); ylabel('Trial');
shading interp;
caxis([-2 4])
colormap('jet')

figure
xx=-3:0.05:3;
y=1:crepcells(1);
x=-3:0.05:3;
[xx,yy]=meshgrid(x,y);
surf(xx,yy,crepos,'edgecolor','none'); axis tight; axis tight;
view(2);
xlabel('Time (s)'); ylabel('Trial');
shading interp;
caxis([-2 4])
colormap('jet')

figure
xx=-3:0.05:3;
y=1:crencells(1);
x=-3:0.05:3;
[xx,yy]=meshgrid(x,y);
surf(xx,yy,creneg,'edgecolor','none'); axis tight; axis tight;
view(2);
xlabel('Time (s)'); ylabel('Trial');
shading interp;
caxis([-2 4])
colormap('jet')

figure
xx=-3:0.05:3;
y=1:94;
x=-3:0.05:3;
[xx,yy]=meshgrid(x,y);
surf(xx,yy,cres_s,'edgecolor','none'); axis tight; axis tight;
view(2);
xlabel('Time (s)'); ylabel('Trial');
shading interp;
caxis([-2 4])
colormap('jet')

crestneg=zeros(42,1);
ffstneg=ones(62,1);
stneg=[crestneg;ffstneg];
crestpos=zeros(28,1);
ffstpos=ones(28,1);
stnpos=[crestpos;ffstpos];
% 
possum=[crepossum(:,1:121);ffpossum(:,1:121)];

negsum=[crenegsum(:,1:121);ffnegsum(:,1:121)];
% 
negsums=smoothdata(negsum(:,1:121),'gaussian',2)
negs=tsne(negsums,'Exaggeration',2,'Algorithm','barneshut','Distance','spearman');
% poss=tsne(possums,'Exaggeration',2,'Algorithm','barneshut','Distance','spearman');
possums=smoothdata(possum(:,1:121),'gaussian',4);
poss=tsne(possums,'Exaggeration',2,'Algorithm','barneshut','Distance','spearman');