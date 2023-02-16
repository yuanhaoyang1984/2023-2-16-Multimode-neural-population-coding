 startpoint=min(find(clas1(:,2)>=1362));
        endpoint=max(find(clas1(:,2)<1368));
        t1=clas1(startpoint:endpoint,2);
for i = 1:length(t1) %Loop through each spike time
line([t1(i) t1(i)], [0 1],'color','k') %Create a tick mark at x = t1(i) with a height of 1
end
% % % ylim([0 12]) %Reformat y-axis for legibility
xlabel('Time (sec)'); %Label x-axis;