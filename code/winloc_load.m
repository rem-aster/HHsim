function winloc_load

global handles

reposition=0;
if (exist('windowpos.mat'))
  try
    load 'windowpos.mat';
    if (length(windowpos)==9), reposition=1; end
  catch
    % ignore
  end
end
if (~reposition)
  ssize=get(0,'ScreenSize');
  width=ssize(3);
  height=ssize(4);

  % hardcoded defaults in here
  
  % hhsim is gui intensive, and hence needs a decent resolution to be
  % used effectively. 1024x768 or higher is recommended. 800x600 is a bare
  % minimum. Anything less than that will be extremely painful to use.

  if (width<1024 | height<768)
    windowpos=   [   10    40   700   500 ; 
                    105   122   320   350 ;
                     33   111   320   250 ;
                    127    19   480   550 ;
                    127    19   600   480 ;
                    109    20   500   550 ;
                    160   -85   600   650 ;
                    137  -113   600   650 ;
                    112  -141   600   650 ];

    reposition=1;
  elseif (width<1280 | height<1024)
    windowpos=   [   20    50   700   500 ;
                    347   369   320   350 ;
                     13   468   320   250 ;
                    532   170   480   550 ;
                    532   170   600   480 ;
                    511    52   500   550 ;
                    349    40   600   650 ;
                    375    58   600   650 ;
                    405    73   600   650 ];

    reposition=1;
  else
    windowpos=   [   20    50   700   500 ;
                    378   608   320   350 ;
                     27   606   320   250 ;
                    761   422   480   550 ;
                    761   422   600   480 ;
                    740    50   500   550 ;
                    359    72   600   650 ;
                    384    99   600   650 ;
                    408   127   600   650 ];
    reposition=1;
  end
end

if (reposition)
  set (handles.mainwindow,'Position',windowpos(1,:));
  set (handles.memwindow, 'Position',windowpos(2,:));
  set (handles.chanwindow,'Position',windowpos(3,:));
  set (handles.stimwindow,'Position',windowpos(4,:));
  set (handles.vclampwindow,'Position',windowpos(5,:));
  set (handles.drugwindow,'Position',windowpos(6,:));
  set (handles.HH_Na_gates,'Position',windowpos(7,:));
  set (handles.HH_K_gates,'Position',windowpos(8,:));
  set (handles.HH_user1_gates,'Position',windowpos(9,:));
end
