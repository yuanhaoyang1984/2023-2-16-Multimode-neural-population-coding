%cre_delay
[x,y]=find(credelay<=0.05);
x1=x+41;
credelaymatrix=zeros(121,103);
for i=1:length(y)
    if crematrix(y(i),x1(i))-mean(crematrix(y(i),1:40),2)>=0
        credelaymatrix(x1(i),y(i))=1;
    end
    if crematrix(y(i),x1(i))-mean(crematrix(y(i),1:40),2)<0
        credelaymatrix(x1(i),y(i))=-1;
    end
end

credelaymatrix_re=credelaymatrix';

for i=1:103
    for j=2:120
        if (credelaymatrix_re(i,j)~=credelaymatrix_re(i,j+1)) & (credelaymatrix_re(i,j)~=credelaymatrix_re(i,j-1))
            credelaymatrix_re(i,j)=0;
        end
    end
end
stcre=crematrix(:,122);
crematrix=[credelaymatrix_re,stcre];
%%
%ff-delay
[x,y]=find(ffdelay<=0.05);
x1=x+41;
ffdelaymatrix=zeros(121,103);
for i=1:length(y)
    if ffmatrix(y(i),x1(i))-mean(ffmatrix(y(i),1:40),2)>=0
        ffdelaymatrix(x1(i),y(i))=1;
    end
    if ffmatrix(y(i),x1(i))-mean(ffmatrix(y(i),1:40),2)<0
        ffdelaymatrix(x1(i),y(i))=-1;
    end
end

ffdelaymatrix_re=ffdelaymatrix';

for i=1:103
    for j=2:120
        if (ffdelaymatrix_re(i,j)~=ffdelaymatrix_re(i,j+1)) & (ffdelaymatrix_re(i,j)~=ffdelaymatrix_re(i,j-1))
            ffdelaymatrix_re(i,j)=0;
        end
    end
end
stff=cffmatrix(:,122);
ffmatrix=[ffdelaymatrix_re,stff];
%%
%%processing
fla=find(crematrix(:,122)==1);
credelaypositivecell=crematrix(fla,1:121);
credelaypcells=size(crepositivecell);

fla=find(crematrix(:,122)==-1);
credelaynegativecell=crematrix(fla,1:121);
credelayncells=size(crenegativecell);

fla=find(credelaypositivecell==-1);
credelaypositivecell(fla)=0;
credelayp=sortrows(credelaypositivecell,41:121);

fla=find(ffdelaypos==-1);
ffdelaypos(fla)=0;
ffdelayp=sortrows(ffdelaypos,41:121);
fla=find(ffdelayneg==1);
ffdelayneg(fla)=0;
ffdelayn=sortrows(ffdelayneg,41:121);
ffdelay_r=[ffdelayp;ffdelayn]

fla=find(credelaynegativecell==1);
credelaynegativecell(fla)=0;
credelayn=sortrows(credelaynegativecell,41:121);
credelay_r=[credelayp;credelayn]
credelayp_r=credelayp;
credelayn_r=credelayn;
ffdelayp_r=ffdelayp;
ffdelayn_r=ffdelayn;
%%
for i=1:size(credelayp,1)
    fla=find(credelayp(i,:)==1);
    credelayp_r(i,fla(1):fla(end))=1;
end
for i=1:size(credelayn,1)
    fla=find(credelayn(i,:)==-1);
    credelayn_r(i,fla(1):fla(end))=-1;
end

for i=1:size(ffdelayp,1)
    fla=find(ffdelayp(i,:)==1);
    ffdelayp_r(i,fla(1):fla(end))=1;
end
for i=1:size(ffdelayn,1)
    fla=find(ffdelayn(i,:)==-1);
    ffdelayn_r(i,fla(1):fla(end))=-1;
end
credelay_r=[credelayp_r;credelayn_r];
ffdelay_r=[ffdelayp_r;ffdelayn_r];
%%
%%plot
figure
h=heatmap(credelay_r(:,1:81), 'GridVisible' , 'off')
YourYticklabel=cell(size(h.YDisplayLabels))
[YourYticklabel{:}]=deal('');

h.YDisplayLabels=YourYticklabel

YourXticklabel=cell(size(h.XDisplayLabels))
[YourXticklabel{:}]=deal('');
[YourXticklabel{1}]=deal('0')
[YourXticklabel{21}]=deal('1')
[YourXticklabel{41}]=deal('2')
h.XDisplayLabels=YourXticklabel
map=[0 0 1
            1 1 1
            1 0 0]
colormap(map)

figure 
h=heatmap(ffdelay_r(:,1:81), 'GridVisible' , 'off')
YourYticklabel=cell(size(h.YDisplayLabels))
[YourYticklabel{:}]=deal('');

h.YDisplayLabels=YourYticklabel

YourXticklabel=cell(size(h.XDisplayLabels))
[YourXticklabel{:}]=deal('');
[YourXticklabel{1}]=deal('0')
[YourXticklabel{21}]=deal('1')
[YourXticklabel{41}]=deal('2')
h.XDisplayLabels=YourXticklabel

map=[0 0 1
            1 1 1
            1 0 0]
colormap(map)



