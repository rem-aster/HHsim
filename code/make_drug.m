function make_drug(num,xstart,ystart,abbr,name,desc,concunit,concmin,concmax,ic50)

global vars handles

bwidth = 70; bheight = 20;
boxbgndcolor= [0 0 0];
boxfgndcolor = [1 1 0];

drug.ic50=ic50;

drug.concbox = make_valbox(['ginh' int2str(num)], xstart+50, ystart+10, 0, ...
               0, 100, 1, ['update_drugbox(' int2str(num) ')'], ...
               '%3.0f','+',1);

drug.axis = axes('Units','pixel', ...
    'Position',[xstart + 65, ystart + 70, 400 80]);

subplot(drug.axis)
xvals=[ic50*concmin:1:ic50*concmax];
yvals=100-100*ic50./(ic50+xvals);
drug.xmax=ic50*concmax;
drug.xmin=ic50*concmin;
drug.line=semilogx(xvals,yvals,'Color',vars.drugcolor);
hold on
xlabel(['concentration (' concunit ')'])
ylabel('% inhbition')
title([abbr ' (' name ') - ' desc],'Color',vars.drugcolor,'FontSize',11);

drug.helpt = text(20,45,'click here to apply drug','FontSize',12,'Color','c');
drug.cursor = line('XData',[0 0],'YData',[0 100], ...
    'LineStyle',':','Color', 'c', 'HitTest','off', ...
    'Visible','off','parent',drug.axis);

handles.(['drug' int2str(num)]) = drug;
