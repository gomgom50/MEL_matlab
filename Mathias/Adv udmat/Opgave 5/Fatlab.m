function Fatlab
% FATLAB Fatigue Analysis Software
% by M.M. Pedersen, Aarhus University, Dept. of Mechanical & Production Engineering, Denmark
% Bug-reports/good ideas/comments welcome at: mmp@mpe.au.dk
% Download from: https://sourceforge.net/projects/fatlab/
% Requirements: Windows 64bit with Matlab R2022b+.

    clc; 
    close all;
    folder = fileparts(which(mfilename));
    cd(folder);

    % get Fatlab version no.
    load vers.mat 

    % check Matlab version
    MatlabVersion = ver('Matlab');
    if str2num(MatlabVersion.Version) < 9.13
        errordlg({'Matlab version R2022b+ required.' 'Update your Matlab or use older version of Fatlab.'},'Error');
        return
    end
    
    % establish gui
    setup_gui('',vers);
    setup_toolbar;
    fprintf(1,'FATLAB %s\n',vers);

    % initialize structs
    cb_new_file();  

end

function init_view()

    h = getappdata(gcf,'handles');
    axes(h.max);
    view(40,20);
    h.max.Clipping = 'off';

    cb_toggle_cs();
    cb_resize();

    xlim([-.1 2]);
    ylim([-.1 2]);
    zlim([-.1 2]);
    
    h.camlight = camlight('right');
    
    dragzoom(h.max); % enable fancy zooming, panning and rotating by mouse
    h.WindowButtonDownFcn = h.fig.WindowButtonDownFcn;
    
    setappdata(h.fig,'handles',h);

end

function setup_gui(inp_file,vers)
    
    h.inp_file = [];
    
    % global front/background colors
    h.back_col  = 'w';
    h.front_col = 'k';
    
    % selectable stress components
    h.stresses = {'Sxx  ','Syy  ','Szz  ','Txy  ','Tyz  ','Txz  ','Svm  ','Ssvm ','P1   ','P2   ','P3   ','Pnmax',...
                  'Tmax ','CP   ','Pall ','Pdir ','Sall ','Tall ','Shyd ','Pmdir','Pi   '};
    h.n_stress = 14; % selectable fatigue stresses

    % main figure window
    grey = [0.941176 0.941176 0.941176];
    h.fig  = figure('name','Fatlab ','menu','none','NumberTitle','off','units','characters','position', [4 10 250 55],...
                    'color',grey,'resizefcn',@cb_resize,'toolbar','figure'); 
    h.axp  = uipanel('units','characters','pos',[0 0 140 50],'bordertype','none','backgroundcolor','w');
    
    h.ptit = uicontrol('Style','text','string',['Fatlab ' vers],'units','normalized','pos',[0.005 0.93 0.2 0.07],...
                       'parent',h.axp,'HorizontalAlignment','left','fontweight','bold','backgroundcolor','w');
    h.max  = axes('pos',[0.01 0.01 0.98 0.98],'OuterPosition',[0.1 0.1 0.8 0.8],'parent',h.axp,...
                  'XLimMode','manual','YLimMode','manual','ZLimMode','manual', 'visible', 'off');
    
    % set rotate style to box          
    h.rot = rotate3d;
    % set(h.rot,'RotateStyle','box','Enable','on');
    rotate3d off;
    
    h.pan = uipanel('units','characters','pos',[140 0 110 50],'bordertype','none');
    h.tb  = findall(h.fig,'tag','FigureToolBar');
    
    set(0,'defaultuicontrolunits','characters');
    center_gui(h.fig);
    
    % panels
    h.ipan = uipanel('title','Setup'  ,'units','characters','pos',[1 32 105 17.5],'parent',h.pan,'bordertype','line','highlightcolor',0.5*[1 1 1]);    
    
    % setup panel
    b = 15.5-[1 3.5 5 7 9 11 13];
    h.txt(1) = uicontrol('Style','text','string','Analysis file:','pos',[2 b(1)+0.25 20 1],'parent',h.ipan,'HorizontalAlignment','left');
    h.inp    = uicontrol('Style','edit','pos',[16 b(1) 86 1.5],'parent',h.ipan,'backgroundcolor','w','HorizontalAlignment','left','string',inp_file);

    % view panel
    h.vpan   = uipanel('title','View','units','characters','pos',[32 0.5 72 13],'parent',h.ipan);
    h.txt    = uicontrol('Style','text','string','Transparency:','pos',[1 6.5 15 1.1],'HorizontalAlignment','left','parent',h.vpan);
    h.tmod   = uicontrol('style','slider','min',0,'max',1,'value',1,'pos',[1 5 22 1.2],'sliderstep',[0.1 0.1],'callback',@cb_set_transparancy,'parent',h.vpan);
    h.txt    = uicontrol('Style','text','string','Sectional views:','pos',[1 10.5 20 1.1],'HorizontalAlignment','left','parent',h.vpan);
    h.sect   = uicontrol('style','popup','string',{'All' 'X>0' 'X<0' 'Y>0' 'Y<0' 'Z>0'  'Z<0'},'pos',       [1 9.25 22 1.],'value',1,'callback',@cb_get_visible,'parent',h.vpan,'backgroundcolor','w');
    h.txt    = uicontrol('Style','text','string','Colorscale limits:','pos',[1 3.25 20 1.1],'HorizontalAlignment','left','parent',h.vpan);
    h.cmin   = uicontrol('Style','edit','string','0','pos',[1 1.8 10 1.25],'parent',h.vpan,'backgroundcolor','w','HorizontalAlignment','right','callback',@cb_update_colorbar);
    h.cmax   = uicontrol('Style','edit','string','1','pos',[13 1.8 10 1.25],'parent',h.vpan,'backgroundcolor','w','HorizontalAlignment','right','callback',@cb_update_colorbar);
    h.cauto  = uicontrol('Style','checkbox','string','Update automatically','pos',[1 0.25 25 1.25],'parent',h.vpan,'Value',1,'callback',@cb_plot_results);

    h.txt    = uicontrol('Style','text','string','Model parts:','pos',[25 10.5 15 1.1],'HorizontalAlignment','left','parent',h.vpan);
    h.parts  = uitable('ColumnName',{'Part name','Show','SN curve'},'RowName',[],'ColumnFormat', {'char','logical',{'Default'}},'ColumnEditable',[false true true],...
                       'parent',h.vpan,'units','characters','pos',[25 0.5 45 9.8],'ColumnWidth',{70 40 95},...
                       'CellSelectionCallback',@cb_mark_selected_part,'CellEditCallback',@cb_edit_parts_table);
    
    % analysis panel
    h.span   = uipanel('title','Analysis','units','characters','pos',[2 0.5 28 13],'parent',h.ipan);
    h.ploads = uicontrol('Style','pushbutton','String','Setup loads','pos',[1 10 25 1.75],'parent',h.span,'callback',@cb_setup_loads);
    h.model  = uicontrol('style','pushbutton','units','characters','string','Setup model','pos',[1 8 25 1.75],'callback', @cb_setup_model,'parent',h.span);
    h.sn     = uicontrol('style','pushbutton','units','characters','string','Setup SN curve','pos',[1 6 25 1.75],'callback',@cb_setupSN,'parent',h.span);
    h.run    = uicontrol('Style','pushbutton','String','Run analysis','pos',[1 4 25 1.75],'parent',h.span,'callback',@cb_run);
    h.export = uicontrol('Style','pushbutton','String','Export to Ansys','pos',[1 2 25 1.75],'parent',h.span,'callback',@cb_export);
    h.clear_res = uicontrol('style','pushbutton','units','characters','string','Clear results','pos',[1 0 25 1.75],'callback',@cb_clear_results,'parent',h.span);    
  
    % hide toolbar while it is manipulated
    set(h.tb,'visible','off');
    
    % results panel
    warning off MATLAB:uitabgroup:OldVersion
    h.tabgr = uitabgroup('units','characters','pos',[1 1 105 30.5],'parent',h.pan);
    h.tab(1) = uitab(h.tabgr,'title','Graph plot'); 
    h.tab(2) = uitab(h.tabgr,'title','Contour plot');
    h.tab(3) = uitab(h.tabgr,'title','Vector plot');
    h.tab(4) = uitab(h.tabgr,'title','Hot-spots');
    h.ptab   = uitab(h.tabgr,'title','Path plot');   
    
    % graph plot
    b = 28.5-[2.5 5 7 9 11 13];
    h.rax     = axes('units','normalized','pos',[0.12 0.135 0.865 0.73],'parent',h.tab(1));
    h.txt     = uicontrol('Style','text','string','Selected node:','pos',[1 b(1)+0.25 16 1],'parent',h.tab(1),'HorizontalAlignment','left');
    h.nno     = uicontrol('Style','edit','pos',[17 b(1)-.1 12 1.75],'parent',h.tab(1),'backgroundcolor','w','HorizontalAlignment','right','string','','callback',@cb_graph_results);
    h.txt     = uicontrol('Style','text','string','Graph:','pos',[40 b(1)+.25 7 1],'parent',h.tab(1),'HorizontalAlignment','left');
    h.gsel    = uicontrol('Style','popupmenu','pos',[48 b(1)+0.6 20 1],'string',...
        {'Results summary' 'Damage' 'Stress' 'Dominating load' 'Markov matrix' 'Stress spectrum' 'Goodman diagram' ...
        'Range distribution' 'Mean distribution' 'FE stress components' 'Mohrs circle' 'Multiaxiality analysis' ...
        'Critical plane damage','Node info','Probability of failure'},...
        'parent',h.tab(1),'callback',@cb_graph_results,'backgroundcolor','w');
    h.ssel(1) = uicontrol('Style','popupmenu','pos',[81 b(1)+0.6 10 1],'string',h.stresses,'parent',h.tab(1),'callback',@cb_graph_results,'backgroundcolor','w','visible','off');
    h.lcsel(1)= uicontrol('Style','popupmenu','string',{'LC1'},'pos',[70 b(1)+0.6 10 1],'parent',h.tab(1),'callback',@cb_graph_results,'backgroundcolor','w','visible','off');
    h.csel(2) = uicontrol('Style','popupmenu','string',' ','pos',[70 b(1)+0.6 10 1],'parent',h.tab(1),'callback',@cb_graph_results,'backgroundcolor','w','visible','off');
    h.cpsca   = uicontrol('style','popupmenu','string',{'Hide planes','Show critical plane','Show search planes','Show search plane normals'},'pos', [81 b(1)+0.6 10 1],'value',1,'parent',h.tab(1),'callback',@cb_graph_results,'visible','off');
    h.time(1) = uicontrol('style','slider','Interruptible','off','Busyaction','Cancel','min',1,'max',100,'value',1,'sliderstep',[0.01 0.1],'parent',h.tab(1),'pos',[10 .5 89 1.2],'callback',@cb_graph_results,'visible','off');
    h.txt     = uicontrol('Style','text','string','Time:','pos',[2 0.8 6 1],'parent',h.tab(1),'HorizontalAlignment','left','visible','off');
  
    % contour plot
    h.cpan    = uipanel('title','Fatigue results','units','characters','pos',[2 17 28 10],'parent',h.tab(2));
    h.txt     = uicontrol('Style','text','string','Result:','pos',[2 7 10 1],'parent',h.cpan,'HorizontalAlignment','left');
    h.rsel    = uicontrol('Style','popupmenu','string',{'Model only' 'Damage' 'Utilization' 'Eq. stress range @ NR1' 'Eq. stress range @ NR2' 'Max stress' 'Min stress' 'Max stress range' 'Reserve factor' 'DFF'},'value',3,'pos',[12 7+0.4 13 1],'parent',h.cpan,'callback',@cb_plot_results,'backgroundcolor','w');
    h.txt     = uicontrol('Style','text','string','LC no:','pos',[2 5 10 1],'parent',h.cpan,'HorizontalAlignment','left');
    h.lcsel(5)= uicontrol('Style','popupmenu','string',{'Sum'},'pos',[12 5+0.4 13 1],'parent',h.cpan,'callback',@cb_plot_results,'backgroundcolor','w');
    h.Dplot   = uicontrol('Style','pushbutton','pos',[2 0.7 23 1.75],'parent',h.cpan,'string','Plot','callback',@cb_plot_results);
    
    h.upan    = uipanel('title','FE stresses','units','characters','pos',[32 17 28 10],'parent',h.tab(2));
    h.pstr    = uicontrol('Style','pushbutton','String','Plot','pos',[2 0.7 23 1.75],'parent',h.upan,'callback',@cb_stress_plot);
    h.txt     = uicontrol('Style','text','string','Component:','pos',[2 7+.25 12 1],'parent',h.upan,'HorizontalAlignment','left');
    h.csel(1) = uicontrol('Style','popupmenu','string',' ','pos',[14 7+0.4 11 1],'parent',h.upan,'callback',@cb_stress_plot,'backgroundcolor','w');
    h.txt     = uicontrol('Style','text','string','Stress:','pos',[2 5+.25 10 1],'parent',h.upan,'HorizontalAlignment','left');
    h.ssel(2) = uicontrol('Style','popupmenu','string',h.stresses(1:h.n_stress),'pos',[14 5+0.4 11 1],'parent',h.upan,'callback',@cb_stress_plot,'backgroundcolor','w');
    h.txt     = uicontrol('Style','text','string','Load:','pos',[2 3+.25 10 1],'parent',h.upan,'HorizontalAlignment','left');
    h.lval    = uicontrol('Style','edit','string','1','pos',[14 3 11 1.5],'parent',h.upan,'HorizontalAlignment','right','callback',@cb_stress_plot,'backgroundcolor','w');
            
    h.tpan    = uipanel('title','Stress time series','units','characters','pos',[2 6 100 10],'parent',h.tab(2));
    h.txt     = uicontrol('Style','text','string','LC:','pos',                  [2 5.2 12 1],'parent',h.tpan,'HorizontalAlignment','left');
    h.lcsel(2)= uicontrol('Style','popupmenu','string',{'Sum'},'pos',           [14 5.4 13 1],'parent',h.tpan,'callback',@cb_plot_stress_time,'backgroundcolor','w');
    h.txt     = uicontrol('Style','text','string','Stress:','pos',              [2 7 12 1],'parent',h.tpan,'HorizontalAlignment','left');
    h.ssel(3) = uicontrol('Style','popupmenu','string',h.stresses(1:h.n_stress),'pos',[14 7.4 13 1],'parent',h.tpan,'callback',@cb_plot_stress_time,'backgroundcolor','w');
    h.time(2) = uicontrol('style','slider','Interruptible','off','pos',         [2 0.8 95 1.6],'Busyaction','Cancel','min',1,'max',100,'value',1,'sliderstep',[0.01 0.1],'parent',h.tpan,'callback',@cb_plot_stress_time);
    h.txt     = uicontrol('Style','text','string','Time step:','pos',           [2 2.7 12 1.5],'parent',h.tpan,'HorizontalAlignment','left');
    h.tsel    = uicontrol('Style','edit','string','1','pos',                    [14 2.8 13 1.6],'parent',h.tpan,'callback',@cb_plot_stress_time,'backgroundcolor','w','HorizontalAlignment','right');
    
    % vector plot
    h.span    = uipanel('title','Principal stress directions','units','characters','pos',[2 17 90 10],'parent',h.tab(3));
    h.pstr    = uicontrol('Style','pushbutton','String','Calculate','pos',[27 4.6 18 1.75],'parent',h.span,'callback',@cb_init_stress_vector);
    h.pstr    = uicontrol('Style','pushbutton','String','Clear','pos',[46 4.6 18 1.75],'parent',h.span,'callback',@cb_clear_stress_vector);
    h.txt     = uicontrol('Style','text','string','LC:','pos',[2 5 10 1],'parent',h.span,'HorizontalAlignment','left');
    h.lcsel(3)= uicontrol('Style','popupmenu','string',{'Sum'},'pos',[12 5.4 13 1],'parent',h.span,'callback',@cb_init_stress_vector,'backgroundcolor','w');
    h.txt     = uicontrol('Style','text','string','Scope:','pos',[2 7 10 1],'parent',h.span,'HorizontalAlignment','left');
    h.ssel(4) = uicontrol('Style','popupmenu','string',{'All nodes','Selected node'},'pos',[12 7+0.4 13 1],'parent',h.span,'callback',@cb_init_stress_vector,'backgroundcolor','w');
    h.time(3) = uicontrol('style','slider','Interruptible','off','Busyaction','Cancel','min',1,'max',100,'value',1,'sliderstep',[0.01 0.1],'parent',h.span,'pos',[12 0.75 75 1.2],'callback',@cb_plot_stress_vector);
    h.txt     = uicontrol('Style','text','string','Time:','pos',[2 0.5 10 1.5],'parent',h.span,'HorizontalAlignment','left');
    h.ssca    = uicontrol('style','checkbox','string','Scale by magnitude','pos', [27 7 25 1],'value',1,'parent',h.span,'callback',@cb_plot_stress_vector);
    h.sp1     = uicontrol('style','checkbox','string','Show P1','pos', [70 7 15 1],'value',1,'parent',h.span,'callback',@cb_plot_stress_vector);
    h.sp2     = uicontrol('style','checkbox','string','Show P2','pos', [70 5.5 15 1],'value',1,'parent',h.span,'callback',@cb_plot_stress_vector);
    h.sp3     = uicontrol('style','checkbox','string','Show P3','pos', [70 4 15 1],'value',1,'parent',h.span,'callback',@cb_plot_stress_vector);
    h.spm     = uicontrol('style','checkbox','string','Show Pnmax','pos', [70 2.5 17 1],'value',0,'parent',h.span,'callback',@cb_plot_stress_vector);
    h.anim    = uicontrol('Style','pushbutton','String','Animate...','pos',[27 2.6 18 1.75],'parent',h.span,'callback',@cb_anim_stress_vector);
    
    % hot-spots
    h.methods = {'Single node','3p extrapolation','0.4t 1.0t','0.5t 1.5t','5mm 15mm','0.4t 0.9t 1.4t','4mm 8mm 12mm','DNV 2 midpoints'};
    h.hotspot_stresses = h.stresses(1:h.n_stress);
    h.hotspot_stresses{15} = 'Sperp';
    %h.hotspot_stresses{16} = 'Tpara';
    columnname   = {'# 1' ,'# 2','# 3' ,'Method','Stress','SN curve','DLC','D','UR'};
    columnedit   = [true      true     true      true    true true false false false];
    columnwidth  = {50        50       50        90     60    60    50    50    50};
    columnformat = {'numeric','numeric','numeric',h.methods,h.hotspot_stresses,{'Default'},'char','numeric','bank'};
    h.hstable = uitable('ColumnName', columnname,'ColumnFormat', columnformat,...
                      'ColumnEditable',columnedit,'parent',h.tab(4),'units','normalized',...
                      'ColumnWidth',columnwidth,'pos',[0.01 0.02 0.99 0.85],'RowName',[],...
                      'CellSelectionCallback',@cb_select_or_edit_hotspot,'CellEditCallback',@cb_select_or_edit_hotspot);
    
    h.hsadd = uicontrol('Style','pushbutton','String','Add row','pos',[2 b(1) 15 1.5],'parent',h.tab(4),'callback',@cb_add_hotspot);
    h.hsrem = uicontrol('Style','pushbutton','String','Remove row','pos',[20 b(1) 15 1.5],'parent',h.tab(4),'callback',@cb_rem_hotspot);
    h.hscal = uicontrol('Style','pushbutton','String','Calculate','pos',[73 b(1) 15 1.5],'parent',h.tab(4),'callback',@cb_calc_hotspots);
    h.hsDLC = uicontrol('Style','checkbox','String','DLC','pos',[90 b(1) 8 1.5],'parent',h.tab(4));
    
    
    % path plot
    h.lcsel(4)= uicontrol('Style','popupmenu','string',{'LC1'},'pos',[77 b(1)+0.6 10 1],'parent',h.ptab,'callback',@cb_path_plot,'backgroundcolor','w');
    h.ssel(5) = uicontrol('Style','popupmenu','pos',[88 b(1)+0.6 10 1],'string',h.stresses(1:13),'parent',h.ptab,'callback',@cb_path_plot,'backgroundcolor','w');
    h.txt     = uicontrol('Style','text','string','Path nodes:','pos',[1 b(1)+0.25 12 1],'parent',h.ptab,'HorizontalAlignment','left');
    h.pnodes  = uicontrol('Style','edit','pos',[13 b(1)-.1 53 1.75],'parent',h.ptab,'backgroundcolor','w','HorizontalAlignment','left','string','','callback',@cb_path_plot);
    h.ppick   = uicontrol('Style','togglebutton','String','Pick','pos',[67 b(1)-0.1 8 1.75],'parent',h.ptab,'callback',@cb_def_path);
    h.pax     = axes('units','normalized','pos',[0.1 0.15 0.885 0.75],'parent',h.ptab);
    h.time(4) = uicontrol('style','slider','Interruptible','off','Busyaction','Cancel','min',1,'max',100,...
        'value',1,'sliderstep',[0.01 0.1],'parent',h.ptab,'pos',[10 0 89 1.2],'callback',@cb_path_plot);
    h.txt     = uicontrol('Style','text','string','Time:','pos',[2 -0.8 6 1],'parent',h.ptab,'HorizontalAlignment','left');

    h.vers = vers;
    assignin('base','h',h);
    axis(h.max);
    setappdata(h.fig,'handles',h);
    
end

function setup_toolbar()
    
    h = getappdata(gcf,'handles');
    load icon_data.mat
    
    % get handles of toolbar buttons
    h.tbb = findall(h.tb); 
    
    % new/save/load analysis
    h.toolbar.new  = uipushtool('parent',h.tb,'Tooltipstring','New analysis','CData',icons.new,'ClickedCallback',@cb_new_file);
    h.toolbar.open = uipushtool('parent',h.tb,'Tooltipstring','Open analysis...','CData',icons.open,'ClickedCallback',@cb_open_file);
    h.toolbar.save = uipushtool('parent',h.tb,'Tooltipstring','Save analysis...','CData',icons.save,'ClickedCallback',@cb_save_file);

    h.orbit = uitoggletool('parent',h.tb,'ToolTipString','Camera Orbit','Separator','off','ClickedCallback',@cb_toggle_orbit,'CData',icons.orbit);    
    h.mouse = uitoggletool('parent',h.tb,'TooltipString','Enable 3D connexion mouse','ClickedCallback',@cb_enable_3d_mouse,'CData',icons.mouse_3d);    
    
    h.csys  = uitoggletool('parent',h.tb,'Tooltipstring','Show coordinate system','ClickedCallback',@cb_toggle_cs,'CData',icons.cs,'Separator','on','State','on');
    h.light = uitoggletool('parent',h.tb,'Tooltipstring','Scene lightening','ClickedCallback',@cb_toggle_lights,'CData',icons.light,'State','on');
    h.wire  = uitoggletool('parent',h.tb,'Tooltipstring','Show wire frame','ClickedCallback',@cb_toggle_wire_frame,'CData',icons.wire_frame,'State','on');
    h.bw    = uitoggletool('parent',h.tb,'Tooltipstring','Toggle backgroundcolor','ClickedCallback',@cb_toggle_bg_color,'CData',icons.black_white,'State','off');
    cameratoolbar('SetCoordSys','none');
    
    % select/probe node
    h.select    = uitoggletool(h.tb,'CData',icons.select_single,'TooltipString','Select node','ClickedCallback',@cb_select_node,'Separator','On');
    h.probe     = uitoggletool(h.tb,'CData',icons.select_multi,'TooltipString','Probe nodes','ClickedCallback',@cb_select_node,'Separator','Off');
    h.sel_face  = uitoggletool(h.tb,'CData',icons.select_face,'TooltipString','Select face','ClickedCallback',@cb_select_face,'Separator','Off');
   
    % hide unsed buttons
    delete(h.tbb(2:end));
    set(h.tb,'visible','on');
    
    % create view toolbar buttons
    views = icons.view_names;
    for i = 1:length(views)
        h.tbview(i) = uipushtool('parent',h.tb,'Tooltipstring',['View ' views{i}],'CData',icons.view{i},'ClickedCallback',@cb_view,'tag',views{i});
    end
    
    h.pop_model = uipushtool('parent',h.tb,'Tooltipstring','Open model in new figure','CData',icons.popup_model,'ClickedCallback',@cb_popup_model,'Separator','on');
    h.pop_graph = uipushtool('parent',h.tb,'Tooltipstring','Open graph in new figure','CData',icons.popup_graph,'ClickedCallback',@cb_popup_graph);
    
    h.tbview(1).Separator ='on';
    
    h.show_nodes    = uitoggletool(h.tb,'CData',icons.nodes,'TooltipString','Show nodes','ClickedCallback',@cb_show_nodes,'Separator','On');
    h.show_node_nos = uitoggletool(h.tb,'CData',icons.node_numbers,'TooltipString','Show node numbers','ClickedCallback',@cb_show_nodes);
    h.show_elems    = uitoggletool(h.tb,'CData',icons.elements,'TooltipString','Show elements','ClickedCallback',@cb_update_plot,'State','on');
    h.show_borders  = uitoggletool(h.tb,'CData',icons.element_borders,'TooltipString','Show element borders','ClickedCallback',@cb_toggle_elem_borders,'State','on');
    h.part_colors   = uitoggletool(h.tb,'CData',icons.part_colors,'TooltipString','Show model parts by color','ClickedCallback',@cb_show_model_parts,'State','off');
    h.show_elem_nos = uitoggletool(h.tb,'CData',icons.element_numbers,'TooltipString','Show element numbers','ClickedCallback',@cb_show_elem_numbers);
    h.show_face_nos = uitoggletool(h.tb,'CData',icons.face_numbers,'TooltipString','Show face numbers','ClickedCallback',@cb_show_face_numbers);
    h.show_hotspots = uitoggletool(h.tb,'CData',icons.hot,'TooltipString','Show hotspots','ClickedCallback',@plot_hotspots,'State','on');
    
    h.show_face_normals = uitoggletool(h.tb,'CData',icons.face_normal,'TooltipString','Show face normals','ClickedCallback',@cb_show_face_normals,'State','off');
    h.show_node_normals = uitoggletool(h.tb,'CData',icons.node_normal,'TooltipString','Show node normals','ClickedCallback',@cb_show_node_normals,'State','off');
    
    h.help = uipushtool('parent',h.tb,'TooltipString','Documentation','ClickedCallback',@cb_documentation,'Separator','On','CData',icons.help);    
    
    setappdata(h.fig,'handles',h); 
    
end


%% GUI callbacks
function cb_toggle_orbit(hObj,~)

    h = getappdata(gcf,'handles');
        
    if strcmp(hObj.State,'on')
        h.cam = cameratoolbar(h.fig,'setmode','orbit');
    else
        h.cam = cameratoolbar(h.fig,'setmode','nomode');
    end

    setappdata(h.fig,'handles',h); 
    
end

function cb_enable_3d_mouse(~,~)
    
    h = getappdata(gcf,'handles');
    
    if ~isfield(h,'camlight')
        h.camlight = [];
    end
    
    if strcmp(h.mouse.State,'on')
        import mouse3D.* %#ok
        h.drv   = mouse3Ddrv;
        h.drv2  = mouse3DfigCtrl(h.drv,h.max,h.camlight);
    else
        delete(h.drv);
        delete(h.drv2);
    end

    setappdata(h.fig,'handles',h); 
    
end

function update_gui(feature)

    h = getappdata(gcf,'handles');
    
    options = getappdata(h.fig,'options');
    LC      = getappdata(h.fig,'LC');
    SN      = getappdata(h.fig,'SN');
    results = getappdata(h.fig,'results');
    model   = getappdata(h.fig,'model');
    
    switch feature
        
        case 'FillHStable'
            if isfield(results,'hotspot_table')
                set(h.hstable,'data',results.hotspot_table);
            else
                set(h.hstable,'data',[]);
            end

        case 'SNcurves->Partstable'
            % set list of SN curve names as selectable options in dropdown
            columnformat = get(h.parts,'ColumnFormat');
            columnformat{3} = {SN.name};
            set(h.parts,'ColumnFormat',columnformat);

            % write SN curve names in table
            parts_table = h.parts.Data;
            for i = 1:length(model.parts)
                parts_table{i,3} = SN(model.parts(i).SNcurve).name;
            end
            parts_table{end,3} = '';
            h.parts.Data = parts_table;

        case 'FillPartsTable'

            %fill everything but SN curves
            n_parts = length(model.parts);
            parts_table = cell(n_parts+1,3);
            for i = 1:n_parts
                parts_table{i,1} = model.parts(i).name;
                parts_table{i,2} = true;
            end
            parts_table{n_parts+1,1} = 'All parts';
            parts_table{n_parts+1,2} = true;
            h.parts.Data = parts_table;

            update_gui('SNcurves->Partstable');
        
        case 'SNcurves->HStable'
            columnformat = get(h.hstable,'ColumnFormat');
            columnformat{6} = {SN.name};
            set(h.hstable,'ColumnFormat',columnformat);
            
        case 'SetInputAndTitle'
            set(h.inp,'string',options.files.fat_file);
            
        case 'ResetAll'
            set(h.inp,'string','');
            set(h.nno,'string','');
            
            delete(findobj('tag','Colorbar'));
            cla(h.max);
            cla(h.rax);
            update_plottitle('')
            
            % clear load case selectors
            for i=1:5
                set(h.lcsel(i),'string',' ','value',1);
            end
            
            % empty parts table
            set(h.parts,'data',[]);
            
            % reset time sliders
            for i = 1:4 
                set(h.time(i),'max',100,'min',0,'value',0,'sliderstep',[1 10]);
            end
            
            % empty HS table
            set(h.hstable,'data',[]);
            
            % no section view
            set(h.sect,'value',1);
            
            % no transparancy
            set(h.tmod,'value',1);
                  
        case 'LoadCaseSelector'
            
            % list of load cases
            lc_string = {LC(:).desc};
            set(h.lcsel(2),'string',lc_string,'value',1);
            set(h.lcsel(3),'string',lc_string,'value',1);
            set(h.lcsel(4),'string',lc_string,'value',1);
            
            % list of load cases + accumulated values
            lc_string{end+1} = 'sum';
            set(h.lcsel(1),'string',lc_string,'value',1);
            set(h.lcsel(5),'string',lc_string,'value',1);

            set(h.csel(1),'string',LC(1).Lcomps,'value',1);
            set(h.csel(2),'string',LC(1).Lcomps,'value',1);
            
        case 'SetMaxTimeStep'
            for i = 1:4 % graph, stress, vector & path plots
                lc = get(h.lcsel(i),'value');
                if lc > options.n_LCs % =sum
                    lc = options.n_LCs;
                end
                step = 1/options.n_step(lc);
                set(h.time(i),'max',options.n_step(lc),'value',1,'sliderstep',[step 10*step]);
            end
    
        case 'SetFirstNode'
            selected_node.node_index = 1;
            selected_node.node_name  = model.surf.node_table(1,1);
            model.selected_node = selected_node;
            set(h.nno,'string',num2str(selected_node.node_name));
            setappdata(h.fig,'model',model);
                       
        otherwise
            
    end
    
    
    
end

function cb_resize(~,~)
    
    h = getappdata(gcf,'handles');
    
    set(gcf,'units','characters');
    fig_size = get(gcf, 'pos');
    set(gcf,'units','pixels');
    
    width  = fig_size(3);
    height = fig_size(4);
    
    if ~isempty(h)
        hpan_pos = get(h.pan,'pos');
        hpan_pos(1) = width-110;
        hpan_pos(4) = height;
        set(h.pan,'pos',hpan_pos);

        hipan_pos = get(h.ipan,'pos');
        hipan_pos(2) = height-17.5;
        set(h.ipan,'pos',hipan_pos);

        htabgr_pos = get(h.tabgr,'pos');
        htabgr_pos(2) = hipan_pos(2)-31;
        set(h.tabgr,'pos',htabgr_pos);

        haxp_pos = get(h.axp,'pos');
        haxp_pos(3) = width-110;
        haxp_pos(4) = height;
        set(h.axp,'pos',haxp_pos);

        h.cb = findobj('tag','Colorbar');
        if ~isempty(h.cb)
            cb_pos = get(h.cb,'pos');
            cb_pos(2) = height-30;
            set(h.cb,'pos',cb_pos);
        end
    end
end

function cb_view(hObj,~)
    % Switches the plot view direction: view(az,el)
    h = getappdata(gcf,'handles');
    axes(h.max);
    
    switch lower(get(hObj,'tag'))
        case '3d'
            view(40,20);
        case 'top'
            view(0,90);
        case 'bottom'
            view(0,-90);
        case 'left'
            view(0,0);
        case 'right'
            view(180,0);
        case 'front'
            view(90,0);
        case 'back'
            view(-90,0);
    end
    
    axis vis3d
    axis equal
    set(h.max,'OuterPosition',[0.1 0.1 0.8 0.8]);
    drawnow

end

function cb_popup_model(~,~)
% opens the model view in a new (non-GUI) figure window - for saving pictures
    
    h = getappdata(gcf,'handles');
    
    hf2 = figure;
    copyobj(h.max,hf2)
    %cameratoolbar
    
    
   
end

function cb_popup_graph(~,~)
% opens the model view in a new (non-GUI) figure window - for saving pictures
    
    h = getappdata(gcf,'handles');
    
    hf2 = figure;
    copyobj(h.rax,hf2)
   
end

function cb_setup_model(~,~)

    h = getappdata(gcf,'handles');
    
    FE      = getappdata(h.fig,'FE');
    LC      = getappdata(h.fig,'LC');
    model   = getappdata(h.fig,'model');
    options = getappdata(h.fig,'options');

    if isempty(LC)
        errordlg('Please setup loads first.','Error');
        return;
    end
    
    [options,model,FE] = setup_model_nonlinear(options,model,FE);
       
    setappdata(h.fig,'options',options);
    save_to_ws();
    
    if ~isempty(model) % user pressed OK, not cancel
        setappdata(h.fig,'model',model);
        setappdata(h.fig,'FE',FE);
        save_to_ws();
        update_gui('FillPartsTable');
        update_gui('SetFirstNode');
        save_to_ws();
        
        % plot model & clear result graph
        plot_model();
        axes(h.max);
        if model.dim == 2
            view(0,90);
            h.light.State = 'off';
            delete(h.camlight);
            
        else
            view(40,20);
        end
        
        delete(findobj('tag','wire'));
        cb_toggle_wire_frame;
    end
        
    if ~isempty(FE) 
        
        % check 2D interp for boundary violations
        for i=1:length(FE)
        
            if FE(i).load_type==4 % 2Dinterp
                
                min_FE_load = min([FE(i).ULC(:).load_val]);
                max_FE_load = max([FE(i).ULC(:).load_val]);
                min_FE_var  = min([FE(i).ULC(:).var_val]);
                max_FE_var  = max([FE(i).ULC(:).var_val]);
                
                for j=1:length(LC)
                    if (min(LC(j).L(:,i)) < min_FE_load) || (max(LC(j).L(:,i)) > max_FE_load) 
                        errordlg('loads are not within boundaries of FE load cases. This will result in stresses calculated as NaN.','Warning');
                        break;
                    elseif (min(LC(j).L(:,i+1)) < min_FE_var) || (max(LC(j).L(:,i+1)) > max_FE_var)
                        errordlg('2nd var for 2D load-stress interpolation is not within boundaries of FE load cases. This will result in stresses calculated as NaN.','Warning');
                        break;
                    end
                end
            end
        end
    end

end

function cb_setup_loads(~,~)
    
    h = getappdata(gcf,'handles');

    LC      = getappdata(h.fig,'LC');
    FE      = getappdata(h.fig,'FE');
    options = getappdata(h.fig,'options');
    
    [LC,options] = setup_loads(LC,options);
    
    setappdata(h.fig,'LC',LC);
    setappdata(h.fig,'options',options);
    save_to_ws();
    
    if ~isempty(LC)
        update_gui('LoadCaseSelector');
        update_gui('SetMaxTimeStep');
        
        if isempty(FE) % initiate FE struct
            
            n_loads = length(LC(1).Lcomps);
            
            for i = 1:n_loads
                FE(i).load_name = LC(1).Lcomps{i};
                FE(i).load_type = 1;
                FE(i).ULC       = [];
            end
            
        end
        setappdata(h.fig,'FE',FE);
        save_to_ws();
    end
end

function cb_setupSN(~,~)

    h = getappdata(gcf,'handles');
    
    allSN   = getappdata(h.fig,'SN');
    model   = getappdata(h.fig,'model');
    options = getappdata(h.fig,'options');
    options.stresses = h.stresses(1:h.n_stress);
    
     % select nodes
    if options.node_scope == 4
        options.nodelist  = model.selected_node.node_name;
        options.nodelisti = model.selected_node.node_index;
    end
    
    [allSN,options] = setup_SNcurve(allSN,options,model);
    
    setappdata(h.fig,'SN',allSN);
    setappdata(h.fig,'options',options);
    save_to_ws();
    
    if ~isempty(model)
        update_gui('SNcurves->HStable');
        update_gui('SNcurves->Partstable');
    end
        
end

function cb_run(~,~)
    % Run fatigue analysis

    % get data
    h = getappdata(gcf,'handles'); 
    options = getappdata(h.fig,'options');
    model   = getappdata(h.fig,'model');
    results = getappdata(h.fig,'results');
    LC      = getappdata(h.fig,'LC');
    FE      = getappdata(h.fig,'FE');   
    allSN   = getappdata(h.fig,'SN');

    % run analysis
    loc_h = h;
    [results,options] = run_analysis(options,model,LC,FE,allSN,results);
    h = loc_h;
    assignin('caller','h',h);
    
    % store and plot
    if ~isempty(results)
        setappdata(h.fig,'results',results);
        setappdata(h.fig,'options',options);
        setappdata(h.fig,'SN',allSN);
        
        % find and select node with highest utilization
        [~,ni_worst] = max(results.UR);
        n_worst = model.surf.node_table(ni_worst,1);
        set(h.nno,'string',num2str(n_worst));
        selected_node.node_index = ni_worst;
        selected_node.node_name  = n_worst;
        
        delete(findobj('tag','refdir'));
        delete(findobj('tag','selected'));
        model.selected_node = selected_node;
        setappdata(h.fig,'model',model);
        
        cb_plot_results(0);
        cb_graph_results(0);
        save_to_ws();

        if options.autosave
            cb_save_file('autosave');
        end

        set(h.rsel,'value',3);
        
    end
    
    set(h.fig,'Pointer','arrow');
    
end


function update_plottitle(string)
    
    h = getappdata(gcf,'handles');
    
    title_str{1} = ['Fatlab ' h.vers];
    
    if iscell(string)
        for i=1:length(string)
            title_str{i+1} = string{i}; %#ok
        end
    else
        title_str{2} = string;
    end
    
    set(h.ptit,'string',title_str);

end

function cb_update_colorbar(~,~)

    h = getappdata(gcf,'handles');
    
    Cmin = str2double(get(h.cmin,'string'));
    Cmax = str2double(get(h.cmax,'string'));
    
    show_colorbar(Cmin,Cmax);
    
end

function set_colorbar_limits(Cmin,Cmax)
    
    h = getappdata(gcf,'handles');
    
    % update, if the "update automatically" checkbox is ticked
    if h.cauto.Value
        set(h.cmin,'string',num2str(Cmin,'%10.4g'));
        set(h.cmax,'string',num2str(Cmax,'%10.4g'));
    end
end

function show_colorbar(Cmin,Cmax)

    h = getappdata(gcf,'handles');
    
    old_cb = findobj('tag','Colorbar');
    delete(old_cb);
    
    if Cmin==Cmax % can't do it
        Cmax = Cmin + 1;
    end
    
    clim([Cmin Cmax]);
    cmap = colormap(jet(12));
    colormap(cmap);
    
    set(h.fig,'units','characters');
    fig_size = get(h.fig,'pos');
    set(h.fig,'units','pixels');
    height = fig_size(4);
    cb_height = height-30;
    h.cb = colorbar('peer',h.max,'units','characters','position',[7 cb_height 3.5 22]);
    
    setappdata(gcf,'handles',h);
    
end

function cb_clear_results(~,~)

    h = getappdata(gcf,'handles');
    setappdata(h.fig,'results',[]);
    assignin('base','results',[]);

    plot_model([]);
    update_plottitle({''})
    old_cb = findobj('tag','Colorbar');
    delete(old_cb);

end

function cb_export(~,~)

    h = getappdata(gcf,'handles');
    options = getappdata(h.fig,'options');
    results = getappdata(h.fig,'results');
    model   = getappdata(h.fig,'model');  

    export2ansys(options,model,results);

end

function cb_documentation(~,~)

    web('https://sourceforge.net/projects/fatlab/files/');
    
end

function save_to_ws()

    h = getappdata(gcf,'handles'); 
    
    options = getappdata(h.fig,'options');
    LC      = getappdata(h.fig,'LC');
    SN      = getappdata(h.fig,'SN');
    FE      = getappdata(h.fig,'FE');   
    results = getappdata(h.fig,'results');
    model   = getappdata(h.fig,'model');    
    
    assignin('base','options',options);
    assignin('base','LC',LC);
    assignin('base','SN',SN);
    assignin('base','FE',FE);
    assignin('base','results',results);
    assignin('base','model',model);    
    
end


%% Path plot
function cb_path_plot(~,~)
    
    h = getappdata(gcf,'handles');
    
    options   = getappdata(h.fig,'options');
    model     = getappdata(h.fig,'model');
    FE        = getappdata(h.fig,'FE');
    LC        = getappdata(h.fig,'LC');
    pnodes    = str2num(get(h.pnodes,'string'));
    
    if length(pnodes)<3
        errordlg('Please select at least 3 nodes for path plot.','Error');
        return
    end
    
    path_lc     = get(h.lcsel(4),'value');
    path_stress = h.stresses{get(h.ssel(5),'value')};
    t = round(get(h.time(4),'value'));
    
    time = LC(path_lc).t(t);
    update_plottitle({[path_stress ' stress'],['@ t=' num2str(time,'%.2f')]});
    
    d = 0;
    n1 = model.surf.mapping.node2ni(pnodes(1));
    p1 = model.surf.node_table(n1,2:4)';
    path = p1;
    
    % calc stress in pnodes
    for i = 1:length(pnodes)
        ni = model.surf.mapping.node2ni(pnodes(i));
        St = calc_stress(ni,FE,LC(path_lc).L,path_stress,options.multi);
        S(i) = St(t);
        
        if i>1
            pi = model.surf.node_table(ni,2:4)';
            path(:,i) = pi;
            d(i) = norm(pi - p1);
        end
        
    end
    
    % plot path on 3D model
    axes(h.max);
    plot3(path(1,:),path(2,:),path(3,:),'-ro','markerfacecolor','r','markersize',5,'tag','selected','linewidth',2);
    
    
    %plot stress along path
    axes(h.pax);
    plot(d,S,'ro-','markerfacecolor','r')
    
    % plot fit 
    Pfit = polyfit(d(2:end),S(2:end),1); hold on
    Sfit = polyval(Pfit,d);
    plot(d,Sfit,'r--')
    plot(d(1),Sfit(1),'ro','markerfacecolor','w')
    
    %xlabel('Path length')
    ylabel([path_stress '[MPa]'])
    hold off
  
end

function cb_def_path(hObj,~)

    h = getappdata(gcf,'handles');

    if ~get(hObj,'value')
        set(h.fig,'WindowButtonDownFcn',h.WindowButtonDownFcn,'Pointer','arrow');
        cb_path_plot();
    else
        set(h.pnodes,'string','');
        cb_select_node(2);
    end
    
end



%% Graph plot
function cb_graph_results(hObj,~)
    
    h = getappdata(gcf,'handles');
    persistent stress Pt smin smax tmax
    
    delete(findobj('tag','stress_dir'));
    axes(h.rax);
    h.rax.XScale = 'linear';    
    legend off
    hold off

    options   = getappdata(h.fig,'options');
    model     = getappdata(h.fig,'model');
    FE        = getappdata(h.fig,'FE');
    LC        = getappdata(h.fig,'LC');
    results   = getappdata(h.fig,'results');
    node      = str2num(get(h.nno,'string')); %#ok

    graph = lower(get_current_popup_string(h.gsel));
    
    if isempty(results) && (strcmp(graph,'results summary') || strcmp(graph,'damage'))
        cla
        text(0.5,0.5,'No results found.','color','r','horizontalalignment','center','units','normalized')
        return;
    end
    
    lc          = get(h.lcsel(1),'value');
    n_LC        = options.n_LCs;
    stress_mode = options.stress_mode;
  
    
    % only show relevant ui elements
    set(h.lcsel(1),'visible','off');
    set(h.ssel(1), 'visible','off');
    set(h.csel(2), 'visible','off');
    set(h.cpsca,   'visible','off');
    set(h.time(1), 'visible','off');
    show_node_marker = true;
    switch graph
        case 'stress'
            set(h.lcsel(1),'visible','on');
            set(h.ssel(1),'visible','on');
        case 'dominating load'
            set(h.lcsel(1),'visible','on');
        case 'fe stress components'
            set(h.csel(2),'visible','on');
            set(h.ssel(1),'visible','on');
        case 'mohrs circle'
            set(h.lcsel(1),'visible','on');
            set(h.time(1),'visible','on');
            show_node_marker = false;
        case 'multiaxiality analysis'
            set(h.lcsel(1),'visible','on');
        case 'critical plane damage'
            set(h.lcsel(1),'visible','on');
            set(h.cpsca,'visible','on');
            show_node_marker = false;
    end
    
    % handle selection of LC=sum if not meaningfull for graph-type
    if any(strcmp(graph,{'stress','mohrs circle','multiaxiality analysis'})) && (lc == n_LC+1)
        cla
        text(0.5,0.5,'Select other LC than ''sum'' ','color','r','horizontalalignment','center','units','normalized')
        return
    end

    
    % does node exist in model?
    ni = model.surf.mapping.node2ni(node); %find(ismember(model.node_names,nodename),1);
    
    if isempty(ni)
        cla
        text(0.5,0.5,'Node number not recognized.','color','r','horizontalalignment','center','units','normalized')
        return
    else
        % get SN curve for node 
        allSN = getappdata(h.fig,'SN');
        SNno  = getSNcurveForNode(ni,model,allSN);
        SN    = allSN(SNno);

        if show_node_marker % mark node with magenta square
            selected_node.node_index = ni;
            selected_node.node_name  = node;
            model.selected_node = selected_node;
            setappdata(h.fig,'model',model);
            coord = model.surf.node_table(ni,2:4);
            axes(h.max);
            plot3(coord(1),coord(2),coord(3), 'sm','MarkerSize', 15,'tag','selected'); 
            plot3(coord(1),coord(2),coord(3), '.m','MarkerSize', 5,'tag','selected'); 
            axes(h.rax);
        end

%         if results.SNno(ni)==0
%             cla
%             text(0.5,0.5,'No results found.','color','r','horizontalalignment','center','units','normalized')
%             return;
%         end
    end
          
    switch graph 
        case 'results summary'
            plot([0 1],[0 1],'w');
            Dtot   = num2str(results.Dtot(ni),'%.3f');
            UR     = num2str(results.UR(ni),'%.3f');
            [Smax,lcMax] = max(results.Smax(ni,1:end-1));
            [Smin,lcMin] = min(results.Smin(ni,1:end-1));
            dSmax  = num2str(max(results.dSmax(ni,:)),'%.1f');
            dSeq   = num2str(results.dSeq(ni,:),'%.1f');
            dSeq1  = num2str(results.dSeq1(ni,:),'%.1f');
            dSeq2  = num2str(results.dSeq2(ni,:),'%.1f');
            if results.SNno(ni)==0
                SNno = '0';
                SNname = 'none';
            else
                SNno   = num2str(results.SNno(ni));
                SNname = allSN(results.SNno(ni)).name;
            end
            Nlife = CommaFormat(round(sum(results.Nlife(ni,:))));
            Nload = CommaFormat(round(sum(results.Nload(ni,:))));
            NR1   = CommaFormat(SN.N1);
            NR2   = CommaFormat(SN.N2);

            result_set = getappdata(h.fig,'result_set');
            if ~isempty(result_set)
                node_res = num2str(result_set(ni));
            else
                node_res = '-';
            end
            
            res_str = {['Fatigue stress: ' stress_mode]
                       ['Total damage: ' Dtot ' (from all LCs)']
                       ['Utilization ratio: ' UR]
                       ['Applied load cycles: ' Nload]
                       ['Endurable life cycles: ' Nlife]
                       ['Max stress range: ' dSmax ' MPa (between all LCs)']
                       ['Eq. stress range: ' dSeq ' MPa @ ' Nload ' cycles']
                       ['Eq. stress range: ' dSeq1 ' MPa @ ' NR1 ' cycles']
                       ['Eq. stress range: ' dSeq2 ' MPa @ ' NR2 ' cycles']
                       ['Min stress: ' num2str(Smin,'%.1f') ' MPa in LC' num2str(lcMin) ': ' LC(lcMin).desc]
                       ['Max stress: ' num2str(Smax,'%.1f') ' MPa in LC' num2str(lcMax) ': ' LC(lcMax).desc]
                       ['Currently shown result: ' node_res]
                       ['SN curve used: ' SNname ' (' SNno ')']};
            
            xlim([0 1]);ylim([0 1])
            ht(1) = text(0.04,.95,['Results summary for node ' num2str(node) ' (' num2str(ni) ')'],...
                'fontweight','bold');
            
            ht(2) = text(0.04,.91,res_str,'verticalalignment','top','fontsize',9,'Interpreter','none');
            set(ht,'fontsmoothing','off');
            xlabel(''); ylabel('');
            set(gca,'xtick',[]); set(gca,'ytick',[]);
            
        case 'damage'
            damage(1) = results.Dtot(ni);
            xlabels = {'sum'};
            for idx = 1:n_LC
                damage(idx+1)  = results.Dlc(ni,idx); %#ok
                xlabels{idx+1} = num2str(idx);
            end
            h.bar = bar(damage,'b');
            set(h.rax,'xticklabel',xlabels);
            xlabel('LC');
            ylabel('Damage per LC');
            xlim([0 n_LC+2]);
            
        case 'stress'
            [stress_mode_local,sno] = get_current_popup_string(h.ssel(1));
            
            t = LC(lc).t;
            options.multi.node_normal = model.surf.node_normals(ni,:)';
            options.multi.node_axis   = model.surf.node_axis(ni,:)';
            
            % calculate full stress tensor over time [n_time_steps x 6] and
            % export to base workspace  [Sxx Syy Szz Txy Txz Tyz]
            Sfull = calc_stress_nonlinear(FE(1).load_table,FE(1).ULC_table,FE(1).node_stress(ni).table,LC(lc).L);
            assignin('base','full_stress_tensor_over_time',Sfull)
            
            S  = calc_stress(ni,FE,LC(lc).L,stress_mode_local,options.multi);
            n_stresses = size(S,2); % usually = 1, Pall = 3, CP = 18-36...
            cols = [1 0 0; % first 3 colors are red, green, blue
                    0 1 0;
                    0 0 1];
            if n_stresses>3
                more_cols = colormap(h.rax,lines(n_stresses-3)); % remaining colors are random
                cols = [cols;
                        more_cols];
            end

            if n_stresses==1 % one stress
                h.pgra = plot(t,S,'k-','color',cols(1,:));
            else % multiple stresses, e.g. CP or Pall -> plot one at the time
                for idx=1:n_stresses
                    h.pgra(idx) = plot(t,S(:,idx),'k-','color',cols(idx,:)); 
                    hold on
                end
                hold off
            end
            
            % limiting curves: Pmax for CP method
            if strcmp(stress_mode_local,'CP   ')
                Slim = calc_stress(ni,FE,LC(lc).L,'Pall ',options.multi);
                hold on
                plot(t,Slim(:,1),'r--','linewidth',2); 
                plot(t,Slim(:,3),'r--','linewidth',2);
                hold off
            end
            
            % label y axis
            switch stress_mode_local
                case 'Pall '
                    ylabel('All 3 principal stresses [MPa]');
                case 'Sall '
                    ylabel('Normal stresses, Sxx, Syy, Szz [MPa]');
                case 'Tall '
                    ylabel('Shear stresses, Txy, Txz, Tyz [MPa]');
                case 'CP   '
                    ylabel('Normal stress on search planes [MPa]');
                case 'Pdir '
                    ylabel('Principal frame Bryant angles [rad]');
                case 'Pmdir'
                    ylabel('Pnmax unit direction vector components');
                otherwise
                    ylabel([h.stresses{sno} ' stress [MPa]']);
            end
            
            xlabel('Time [s]');
            xlim([t(1) t(end)]);

            % build up and show text with min/max etc.
            rf = cycle_counter(S(:,1),1,options);
            Nrep = LC(lc).n;
            Ntot = sum(rf(4,:));
            dSeq = equivalent_stress(rf,4);
            S = remrowinfnan(S);
            minmaxstring = {['Max:      ' num2str(max(S),'%.1f  ')] ...
                            ['Min:       ' num2str(min(S),'%.1f  ')] ...
                            ['Mean:    ' num2str(mean(S),'%.1f  ')] ...
                            ['Range:  ' num2str(range(S),'%.1f  ')] ...
                            ['dSeq4:  ' num2str(dSeq,'%.1f  ')] ...
                            ['Cycles: ' num2str(Ntot,'%.1f  ') 'x' CommaFormat(Nrep)]};
        
            h.tmax = text(0.02,0.8,minmaxstring,'units','normalized','color','b','fontsize',8,'fontsmoothing','off');
            hold on
            plot([t(1) t(end)],[0 0],'k-'); % add black line at y=0.
            hold off
            
        case 'dominating load'
            [D,Lcomps] = dominating_load(ni,lc,FE,LC,allSN,options,model,results);

            h.bar = bar(D,'b');
            set(h.rax,'xticklabel',Lcomps);
            ylabel('Damage contribution estimate');
            xlim([0 length(D)+1]);
        
        case 'markov matrix'
            [dS,Sm] = rfc_all_lc(ni,FE,LC,options,stress_mode,results,model);

            if length(dS)>2
                histogram2(dS,Sm,'DisplayStyle','tile','ShowEmptyBins','on');
                xlabel('Stress range, \Delta\sigma [MPa]');
                ylabel('Mean stress, \sigma_m [MPa]');
                colorbar
            else
                cla;
                text(0.5,0.5,{'Markov matrix cannot be constructed' 'from single cycle load only'},...
                     'color','r','horizontalalignment','center','units','normalized')
            end
            
        case 'stress spectrum'
            [dS,~,n,rf] = rfc_all_lc(ni,FE,LC,options,stress_mode,results,model);

            [Sp,logN] = rf2spectrum(dS,n);
            loglog(logN,Sp,'b-'); hold on

            xlabel('Cumulative cycles N')
            ylabel(['\Delta\sigma_{' options.stress_mode '}[MPa]']);

            plotSNcurve(SN.ds1,SN.N1,SN.N2,SN.m1,SN.m2,SN.maxS,SN.minS,SN.gf,'notext');

            % present damage for 1st/2nd part of SN curve
            [D,D_m1,D_m2] = damage_calc(rf,SN);
            Dstr = sprintf('Damage:   %5.3f\n- from m1: %5.3f\n- from m2: %5.3f\n ',D,D_m1,D_m2);
            h.tmax = text(0.75,0.82,Dstr,'units','normalized','color','b','fontsize',8,'fontsmoothing','off','BackgroundColor','w');

%             % show equivalent stresses
%             Neq1  = results.Nload(ni);
%             dSeq1 = results.dSeq(ni);
%             loglog([1e3 Neq1 Neq1],[dSeq1 dSeq1 1],'m--');
%             Neq2  = SN.N2;
%             dSeq2 = results.dSeq2(ni);
%             loglog([1e3 Neq2 Neq2],[dSeq2 dSeq2 1],'m--');
           
            xlim([10^3 10^10]);
            ylim([10 1000]);

            hold off

        case 'goodman diagram'
            
            plotMean(SN)
            
            [dS,Sm] = rfc_all_lc(ni,FE,LC,options,stress_mode,results,model);

            hold on
            plot(Sm,dS/2,'b+')
            hold off

            
        case 'range distribution'
            dS = rfc_all_lc(ni,FE,LC,options,stress_mode,results,model);
            histogram(dS);
            xlabel('Stress range, \Delta\sigma [MPa]');
            ylabel('Cycle count, N');
            
        case 'mean distribution'
            [~,Sm] = rfc_all_lc(ni,FE,LC,options,stress_mode,results,model);
            histogram(Sm);
            xlabel('Mean stress, \sigma_m [MPa]');
            ylabel('Cycle count, N');
            
        case 'fe stress components' 
            load = get(h.csel(2),'value');
            [stress_name,sno] = get_current_popup_string(h.ssel(1));
            if sno>6
                set(h.ssel(1),'value',1)
                [stress_name,sno] = get_current_popup_string(h.ssel(1));
            end
            
            for idx = 1:length(FE(load).ULC)
                F(idx) = [FE(load).ULC(idx).load_val];
                s(idx) = [FE(load).ULC(idx).stress(ni,sno)];

                if FE(load).load_type == 4
                    v(idx) = [FE(load).ULC(idx).var_val];
                end
            end
            
            if FE(load).load_type == 4
                Fs = unique(F);
                vs = unique(v);
                ss = zeros(length(Fs),length(vs));
                for k = 1:length(s)
                    idx = find(Fs==F(k));
                    j = find(vs==v(k));
                    ss(idx,j) = s(k);
                end
            end
            
            k = 1.25;
            k2 = 1.4;            
            k3 = 0.4;
            cla;
            view(0,90)
            switch FE(load).load_type 
                case 1
                    plot(k*[-F F],k*[-s s],'b'); hold on
                    plot(F,s,'ro','markerfacecolor','r');
                    xlim(k2*[-abs(F) abs(F)])
                    if s == 0
                        ylim([-1 1])
                    else
                        ylim(k2*[-abs(s) abs(s)])
                    end
                    
                case 2
                    F = [F(1) 0 F(2)];
                    s = [s(1) 0 s(2)];
                    plot(k*F,k*s,'b'); hold on
                    plot(F,s,'ro','markerfacecolor','r');
                    xlim([min(F)-k3*abs(min(F)) max(F)+k3*abs(max(F))])
                    ylim([min(s)-k3*abs(min(s)) max(s)+k3*abs(max(s))])
                    
                case 3
                    plot(F,s,'b'); hold on
                    plot(F,s,'ro','markerfacecolor','r');

                    xlim([min(F)-k3*abs(min(F)) max(F)+k3*abs(max(F))])
                    ylim([min(s)-k3*abs(min(s)) max(s)+k3*abs(max(s))])
                    
                case 4
                    C = ss'*0-Inf;
                    mesh(Fs,vs,ss',C); hold on
                    hidden off
                    plot3(F,v,s,'ro','markerfacecolor','r');
                    view(20,45)
                    xlim([min(F)-k3*abs(min(F)) max(F)+k3*abs(max(F))])
                    ylim([min(v)-k3*abs(min(v)) max(v)+k3*abs(max(v))])
                    zlim([min(s)-k3*abs(min(s)) max(s)+k3*abs(max(s))])
                    
            end
            
            if FE(load).load_type < 4
                xlims = get(h.rax,'xlim');	plot([xlims(1) xlims(2)],[0 0],'k');
                ylims = get(h.rax,'ylim');	
                plot([0 0],[ylims(1) ylims(2)],'k');
                xlabel(FE(load).load_name);
                ylabel([stress_name ' [MPa]']);
            elseif FE(load).load_type == 5
                xlabel(FE(load).load_name);
                ylabel(FE(load+1).load_name);
                zlabel([stress_name ' [MPa]']);
                
            end
            
            hold off
        
        case 'mohrs circle'
            if hObj==h.gsel || hObj==h.nno || hObj==h.lcsel(1) || hObj==0 % initiate
                set(h.time(1),'value',1);
                cb_init_stress_vector(0);
                stress = getappdata(h.fig,'stress_time');
                Pt = [stress.mag]; % principal stress over time
                smax = max(Pt(1,:));
                smin = min(Pt(3,:));
                tmax = max(abs( (Pt(1,:) - Pt(3,:))/2 ));
            end
            
            t = round(get(h.time(1),'value'));
            P = Pt(:,t); % principal stress at time t
            tau = (P(1)-P(3))/2;
           
            axes(h.rax);
            plot(P(1),0,'ro','markerfacecolor','r'); hold on
            plot(P(2),0,'go','markerfacecolor','g');
            plot(P(3),0,'bo','markerfacecolor','b');

            xlim([smin-5 smax+5]);
            ylim([-tmax-5 tmax+5]);
            axis equal

            xlims = get(h.rax,'xlim');	plot([xlims(1) xlims(2)],[0 0],'k'); hold on
            ylims = get(h.rax,'ylim');	plot([0 0],[ylims(1) ylims(2)],'k');

            xlabel('Normal stress [MPa]','pos',[2 -tmax*0.9],'horizontalalignment','left');
            ylabel('Shear stress [MPa]')

            
            hc = circle((P(1)+P(3))/2,0,tau);
            set(hc,'color','k');
            hold off
            
            plot_stressdir(stress(t),t)
            
        case 'multiaxiality analysis'

            Pnmax = calc_stress(ni,FE,LC(lc).L,'Pnmax',options.multi);
            angle = multiaxiality_analysis(ni,FE,LC(lc).L,options,model,'');
            
            plot(rad2deg(angle'),Pnmax,'dr','markerfacecolor','r','markersize',2);
            
            xlabel('Angle [deg]');
            ylabel('Pnmax [MPa]');
            xlim([-180 180])
              
        case 'critical plane damage'
            if strcmpi(options.stress_mode,'CP   ')
                npt = options.multi.n_planes(1);
                npp = options.multi.n_planes(2);
                [theta,~] = search_plane_angles(options.multi.n_planes);
                n_planes = npt*npp;
                theta(end+1) = pi;
                theta = rad2deg(theta);
                
                if lc <= n_LC % damage per LC
                    D = permute(results.Dall(ni,lc,:),[2,3,1])';
                else % damage from all LCs
                    D = zeros(n_planes,1);
                    for l = 1:n_LC
                        D = D + permute(results.Dall(ni,l,:),[2,3,1])';
                    end
                end
                
                [Dmax,j] = max(D);
                D(end+1) = D(1);
                plot(theta,D,'-b.'); hold on
                plot(theta(j),Dmax,'ro','markerfacecolor','r');
                ylabel('Damage [-]');
                xlabel('Plane angle [deg]');
                xlim([0 180]);
                plot_critical_plane(ni,deg2rad(theta(j)),0)
                
                axes(h.rax);
                hold off
                
            else
                cla;
                text(0.5,0.5,{'Select critical plane mode & run first'},...
                     'color','r','horizontalalignment','center','units','normalized')
            end
            
        
            
 
            
        case 'node info'
            plot([0 1],[0 1],'w');

            faces    = nonzeros(model.surf.mapping.ni2face(ni,:))';
            ei       = nonzeros(model.surf.mapping.ni2ei(ni,:))';
            elements = model.surf.elem_table(ei,1)';
            part_nos = nonzeros(model.surf.mapping.ni2part_no(ni,:))';
            node_normal = model.surf.node_normals(ni,:);
            node_axis = model.surf.node_axis(ni,:);
            result_set = getappdata(h.fig,'result_set');
            if ~isempty(result_set)
                node_res = num2str(result_set(ni));
            else
                node_res = '-';
            end
            
        
            res_str = {['External node number: ' num2str(node)]
                       ['Internal node number: ' num2str(ni)]
                       ['Touches face number(s): ' num2str(faces)]
                       ['Touches element number(s): ' num2str(elements)]
                       ['Belongs to part(s): ' num2str(part_nos)]
                       ['Surface normal for CP: [' num2str(node_normal,' %.1f') '] (magenta)']
                       ['1st CP search plane normal: [' num2str(node_axis,' %.1f') '] (blue)']
                       ['Coordinates: [' num2str(coord,'  %.1f') ']']
                       ['Currently shown result: ' node_res]};
            
            xlim([0 1]);ylim([0 1])
            text(0.04,.95,'Selected node information','fontweight','bold');            
            text(0.04,.89,res_str,'verticalalignment','top','fontsize',9,'fontsmoothing','off');
            xlabel(''); ylabel(''); set(gca,'xtick',[]); set(gca,'ytick',[]);

            % plot surface normal & 1st CP search plane normal
            p1 = coord';
            p2 = p1 + 0.3*model.surf.esize*node_normal';
            p3 = p1 + 0.3*model.surf.esize*node_axis';
            axes(h.max);
            delete(findobj('tag','stress_dir'));
            plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'tag','stress_dir','color','m','linewidth',2);
            plot3([p1(1) p3(1)], [p1(2) p3(2)], [p1(3) p3(3)],'tag','stress_dir','color','b','linewidth',2);
        
        case 'probability of failure'

            % eq. stress range at applied no. cycles
            dSeq = results.dSeq(ni,:);
            Ntot   = sum(results.Nload(ni,:)); % total applied no. cycles
            Nest   = sum(results.Nlife(ni,:)); % predicted/estimated design life
            
            % get used SN curve
            SNno = results.SNno(ni);
            SN   = allSN(SNno);
            
            if dSeq>SN.ds2
                m = SN.m1;
            else
                m = SN.m2;
            end

            % Design, characteristic and mean fatigue lives:
            logNg = log10(Nest);            % design life, Ps=99.99%
            logNd = logNg + m*log10(SN.gf); % char. life,  Ps=97.7%
            logNm = logNd - SN.std*sqrt(2)*erfinv(2*(1-SN.Ps/100)-1); % mean life, Ps=50% (from CDF)

            Ng = 10^logNg;
            Nd = 10^logNd;
            Nm = 10^logNm;

            % Probabilities associated with above lives
            Pf = cdfnorm(log10(Ntot),logNm,SN.std)*100;
            Pd = cdfnorm(logNd,logNm,SN.std)*100;
            Pg = cdfnorm(logNg,logNm,SN.std)*100;

            % plot CDF curve for life at given eq. stress range
            logN = log10(logspace(3,10,100));
            Pp = cdfnorm(logN,logNm,SN.std)*100;
            semilogx(10.^logN,Pp,'LineWidth',1.5,'Color','r');
            hold on
            plot(10^logNm,50,'r.','MarkerSize',13)
            plot(10^logNd,Pd,'r.','MarkerSize',13)
            plot(10^logNg,Pg,'r.','MarkerSize',13)
            plot(Ntot*[1 1],[0 100],'b--','Linewidth',1) % applied no. cycles
                        
            xlim([10^3 10^10])
            xlabel('Cycles, N [-]')
            ylabel('Probability of failure, P_f [%]')

            Dstring = {['\Delta\sigma_{eq} = ' num2str(dSeq,'%.1f') 'MPa'],['N_{tot} = ' CommaFormat(round(Ntot)) 'cycles'],...
                ['D = ' num2str(results.Dtot(ni),'%.2f')],['UR = ' num2str(results.UR(ni),'%.2f')],...
                ['P_f = ' num2str(Pf,'%.3f') '%']};
            text(0.02,0.97,Dstring,'units','normalized','color','b','fontsize',8,'fontsmoothing','off','VerticalAlignment','Top');

            if 100-Pg > 99.999
                Psg_str = 'P_{s,incl.\gamma_M_f} > 99.999%';
            else
                Psg_str = ['P_{s,incl.\gamma_M_f} = ' num2str(100-Pg,'%.3f') '%'];
            end

            SNstring = {['SN curve: ' SN.name],['P_s = ' num2str(SN.Ps,'%.2f') '%, \gamma_M_f = ' num2str(SN.gf,'%.2f')],Psg_str};
            text(0.98,0.97,SNstring,'units','normalized','color','r','fontsize',8,'fontsmoothing','off','HorizontalAlignment','Right','VerticalAlignment','Top');


            text(Nm*1.2,50,['N_{50} = ' CommaFormat(round(Nm))],'units','data','color','r','fontsize',8,'fontsmoothing','off');
            text(Nd*1.4,4,['N_{' num2str(100-Pd,'%.1f') '} = ' CommaFormat(round(Nd))],'units','data','color','r','fontsize',8,'fontsmoothing','off');
            text(Ng/1.4,4,['N_{' num2str(min(100-Pg,99.9),'%.1f') '} = ' CommaFormat(round(Ng))],'units','data','color','r','fontsize',8,'fontsmoothing','off','HorizontalAlignment','Right');

            hold off

    end

end

function cb_select_node(hObj,~)
    
    h = getappdata(gcf,'handles');
    rotate3d off; zoom off; pan off; datacursormode off
    set(h.orbit,'state','off');
 
    model = getappdata(h.fig,'model');

    if isempty(model)
        hObj.State = 'off';
    else
        set(h.fig,'Pointer','hand')
 
        % find and delete any marked nodes
        sel = findobj(h.max,'tag','selected');
        if ~isempty(h)
            delete(sel)
        end

        % who calls this?
        if hObj == 1
            pick = true;
            pick_caller = 'hotspot';
        elseif hObj == 2
            pick = true;
            pick_caller = 'path';
        elseif hObj == h.select
            set(h.probe,'State','Off');
            state = (get(hObj,'State'));
            if strcmp(state,'on')
                pick = true;
            else
                pick = false;
            end
            pick_caller = 'toolbar';
        elseif hObj == h.probe
            set(h.select,'State','Off');
            state = (get(hObj,'State'));
            if strcmp(state,'on')
                pick = true;
            else
                pick = false;
            end
            pick_caller = 'probe';
        else
            pick = false;
        end
        setappdata(gcf,'pick_caller',pick_caller);
        
        % set mouse-button function
        if pick
            set(h.fig,'WindowButtonDownFcn',@cb_click_node); 
        else
            set(h.fig,'WindowButtonDownFcn',h.WindowButtonDownFcn);
            set(h.fig,'WindowButtonDownFcn','','Pointer','arrow');
        end
    end
    
end

function cb_click_node(~,~)
    
    h = getappdata(gcf,'handles');
    model = getappdata(h.fig,'model');
    
    point     = get(gca, 'CurrentPoint');   % mouse click position
    camPos    = get(gca, 'CameraPosition'); % camera position
    camTgt    = get(gca, 'CameraTarget');   % where the camera is pointing to
    camDir    = camPos - camTgt;            % camera direction
    camUpVect = get(gca, 'CameraUpVector'); % camera 'up' vector

    % build an orthonormal frame based on the viewing direction and the 
    zAxis  = camDir/norm(camDir);    
    upAxis = camUpVect/norm(camUpVect); 
    xAxis  = cross(upAxis, zAxis);
    yAxis  = cross(zAxis, xAxis);
    rot    = [xAxis; yAxis; zAxis]; % view rotation 

    pointCloud = model.surf.node_table(model.surf.vis_nodesi,2:4)';
    rotatedPointCloud = rot*pointCloud; 
    rotatedPointFront = rot*point';
    pointCloudIndex   = dsearchn(rotatedPointCloud(1:2,:)',rotatedPointFront(1:2));
    
    selected_node.node_index = model.surf.vis_nodesi(pointCloudIndex);
    selected_node.node_name  = model.surf.node_table(selected_node.node_index,1);
    setappdata(h.fig,'selected_node',selected_node);
    
    % update gui
    pick_caller = getappdata(gcf,'pick_caller');

    if strcmp(pick_caller,'toolbar')
        set(h.fig,'WindowButtonDownFcn',h.WindowButtonDownFcn,'Pointer','arrow');
        set(h.select,'State','Off');
        set(h.nno,'string',num2str(selected_node.node_name));
        cb_graph_results(h.nno);
        
    elseif strcmp(pick_caller,'probe')
        set(h.nno,'string',num2str(selected_node.node_name));
        cb_graph_results(h.nno);
        
    elseif strcmp(pick_caller,'hotspot')
        set(h.fig,'WindowButtonDownFcn',h.WindowButtonDownFcn,'Pointer','arrow');
        hotspot_table = get(h.hstable,'data');
        hotspot_table{h.hstable_selected_indices(1),h.hstable_selected_indices(2)} = selected_node.node_name;
        set(h.hstable,'data',hotspot_table);
        plot_hotspots(h.nno);
        
    elseif strcmp(pick_caller,'path')
        path_nodes = get(h.pnodes,'string');
        path_nodes = [path_nodes ' ' num2str(selected_node.node_name)];
        set(h.pnodes,'string',path_nodes);
        
        % mark with dot
        temp = gca;
        axes(h.max);
        plot3(pointCloud(1,pointCloudIndex),pointCloud(2,pointCloudIndex),pointCloud(3,pointCloudIndex), 'og','MarkerSize', 5,'markerfacecolor','g','tag','selected'); 
        axes(temp);

    end
    
    % return selected node
    model.selected_node = selected_node;
    setappdata(h.fig,'model',model);
    
end

function cb_click_face(~,~)
    
    h = getappdata(gcf,'handles');
    
    model = getappdata(h.fig,'model');
    
    point     = get(gca, 'CurrentPoint');   % mouse click position
    camPos    = get(gca, 'CameraPosition'); % camera position
    camTgt    = get(gca, 'CameraTarget');   % where the camera is pointing to
    camDir    = camPos - camTgt;            % camera direction
    camUpVect = get(gca, 'CameraUpVector'); % camera 'up' vector

    % build an orthonormal frame based on the viewing direction and the 
    zAxis  = camDir/norm(camDir);    
    upAxis = camUpVect/norm(camUpVect); 
    xAxis  = cross(upAxis, zAxis);
    yAxis  = cross(zAxis, xAxis);
    rot    = [xAxis; yAxis; zAxis]; % view rotation 

    % find the selected face
    % face_table = [node1, node2, node3, node4, elem_no, centr_x, centr_y, centr_z] single(n_faces x 8)
    pointCloud = model.surf.face_table(:,6:8)';
    rotatedPointCloud = rot*pointCloud; 
    rotatedPointFront = rot*point';
    selected_face_no = dsearchn(rotatedPointCloud(1:2,:)',rotatedPointFront(1:2));

    pick_caller = getappdata(h.fig,'pick_caller');
    if strcmp(pick_caller,'hotspot')
        % enter the face number in the hotspot table, in the selected cell
        hotspot_table = h.hstable.Data;
        hotspot_table{h.hstable_selected_indices(1),h.hstable_selected_indices(2)} = selected_face_no;
        h.hstable.Data = hotspot_table;
        plot_hotspots; % update the hotspot visualization
    else
        fc  = double(model.surf.face_table(selected_face_no,6:8)); % face centroid
        e   = model.surf.mapping.face2elem(selected_face_no);
        fno = {['F' num2str(selected_face_no)],['E' num2str(e)]}; % face & element no.
        text(fc(1),fc(2),fc(3),fno,'fontsize',8,'color','m','tag','face_nos');
        fprintf('Face no. %d selected\n',selected_face_no);
    end

    set(h.fig,'WindowButtonDownFcn',h.WindowButtonDownFcn,'Pointer','arrow');
    set(h.sel_face,'State','Off');

end
 
function cb_select_face(hObj,~)
    % main function for selecting a fac

    h = getappdata(gcf,'handles');
    rotate3d off; zoom off; pan off; datacursormode off
    h.orbit.State = 'off';
 
    model = getappdata(h.fig,'model');
    if isempty(model) % if no model is present
        h.sel_face.State = 'off';
        return
    end

    % where is this called from?
    pick = false;
    if hObj==1
        pick = true;
        pick_caller = 'hotspot';
    elseif hObj == h.sel_face
        if strcmp(h.sel_face.State,'on')
            pick = true;
        end
        pick_caller = 'toolbar';
    end
    setappdata(h.fig,'pick_caller',pick_caller);
        
    % go to the mouse clicking or turn off
    if pick == true
        set(h.fig,'Pointer','hand')
        set(h.fig,'WindowButtonDownFcn',@cb_click_face); 
    else
        set(h.fig,'WindowButtonDownFcn',h.WindowButtonDownFcn);
        set(h.fig,'WindowButtonDownFcn','','Pointer','arrow');
    end
 
    % find and delete any marked faces
    delete(findobj('tag','face_nos'));

end

function plot_critical_plane(ni,theta,phi)
    
    h = getappdata(gcf,'handles');
    axes(h.max);
    delete(findobj('tag','stress_dir'));
    delete(findobj('tag','selected'));

    model   = getappdata(h.fig,'model');
    options = getappdata(h.fig,'options');
    
    p   = model.surf.node_table(ni,2:4);  % node coordinates
    n_s = model.surf.node_normals(ni,:)'; % surface normal (local z')
    x   = model.surf.node_axis(ni,:)';  % local x'
    y   = cross(n_s,x);                 % local y'
    Ai  = [x y n_s];                    % intial frame
    scale = model.surf.max_dim/20;
    
    switch get_current_popup_string(h.cpsca) 
        
        case 'Show critical plane' % plot critical plane
            At  = RotA(Ai,theta,[0 0 1]'); % rotate local frame by theta around local z' (surface normal)
            A   = RotA(At,phi,[0 1 0]');

            % scaled vectors spanning the local frame of the critical plane
            y = A(:,2)*scale;
            z = A(:,3)*scale;

            % arrange for plotting
            verts = [p+(y+z)'; p+(-y+z)'; p+(-y-z)'; p+(y-z)'];

            patch('faces',[1 2 3 4],'vertices',verts,'facecolor','m','edgecolor','k','tag','stress_dir','facealpha',0.6,'edgealpha',1);
            plot3(p(1),p(2),p(3),'dm','markerfacecolor','m','markersize',5,'tag','stress_dir');
        
        case 'Show search planes'
            [theta,phi] = search_plane_angles(options.multi.n_planes);

            % calculate normal vectors for all search planes (double ended)
            for t = 1:length(theta)
                At  = RotA(Ai,theta(t),[0 0 1]');
                for ph = 1:length(phi)
                    A = RotA(At,phi(ph),[0 1 0]');
                    y = A(:,2)*scale;
                    z = A(:,3)*scale;
                    verts = [p+(y+z)'; p+(-y+z)'; p+(-y-z)'; p+(y-z)'];
                    patch('faces',[1 2 3 4],'vertices',verts,'facecolor','m','edgecolor','k','tag','stress_dir','facealpha',0.6,'edgealpha',1);
                end
                drawnow
            end    
            plot3(p(1),p(2),p(3),'dm','markerfacecolor','m','markersize',5,'tag','stress_dir');
            
        case 'Show search plane normals'
            [theta,phi] = search_plane_angles(options.multi.n_planes);
            k = 0.5*model.surf.max_dim(1)*[0.2 0.0025 0.02];

            % calculate normal vectors for all search planes (double ended)
            for t = 1:length(theta)
                At  = RotA(Ai,theta(t),[0 0 1]');
                for ph = 1:length(phi)
                    A = RotA(At,phi(ph),[0 1 0]');
                    n = A(:,1)*scale;
                    mArrow3((p'-n),(p'+n),'color','r','tag','stress_dir','stemWidth',k(2),'tipWidth',0*k(3));
                end
                drawnow
            end    
        
    end      
    
end

function plot_stressdir(stress,t_step)

    h = getappdata(gcf,'handles');
    axes(h.max);
    delete(findobj('tag','selected'));
    delete(findobj('tag','stress_dir'));

    p = stress.p1; 
    line(p(1,:), p(2,:), p(3,:),'tag','stress_dir','color','r','linewidth',2);
    p = stress.p2; 
    line(p(1,:), p(2,:), p(3,:),'tag','stress_dir','color','g','linewidth',2);
    p = stress.p3; 
    line(p(1,:), p(2,:), p(3,:),'tag','stress_dir','color','b','linewidth',2);
    
    LC = getappdata(h.fig,'LC');
    t  = LC(1).t(t_step);
    update_plottitle({'Principal stress',['directions @ t=' num2str(t,'%.2f')]});
    
end



%% Contour plot
function cb_update_plot(~,~)
    plot_model();
end

function cb_stress_plot(~,~)

    h = getappdata(gcf,'handles');
    options = getappdata(h.fig,'options');
    FE      = getappdata(h.fig,'FE');

    load_comp   = get(h.csel(1),'value');
    stress_mode = get_current_popup_string(h.ssel(2));
    load_value  = str2double(get(h.lval,'string'));
    nloads      = length(get(h.csel(1),'string'));
    n_nodes     = options.n_nodes_all;
    single_load = zeros(1,nloads,'single');
    single_load(load_comp) = load_value;
    
    set(gcf,'Pointer','watch'); drawnow;
    S = zeros(n_nodes,1);
    for ni = 1:n_nodes
        S(ni) = calc_stress(ni,FE,single_load,stress_mode,options.multi);
    end
    set(gcf,'Pointer','arrow'); drawnow;
    
    plot_model(S);
    
    set_colorbar_limits(min(S),max(S))
    show_colorbar(min(S),max(S));
    
    update_plottitle({['FE stress: ' get_current_popup_string(h.csel(1))],...
                      ['Stress: ' get_current_popup_string(h.ssel(2))]});
                  
end

function cb_plot_results(hObj,~)

    h = getappdata(gcf,'handles');
    options = getappdata(h.fig,'options');
    lc      = get(h.lcsel(5),'value');
    n_LC    = length(get(h.lcsel(5),'string'));
    results = getappdata(h.fig,'results');
    result  = get_current_popup_string(h.rsel);
    stress_mode = options.stress_mode;
    
    if isempty(results)
%         errordlg('No results found.','Error');
        return;
    end
    
    switch result 
        case 'Model only'
            R = 0*results.UR;
            update_plottitle({''})
        case 'Damage'
            R = results.Dlc;
            update_plottitle({'Damage [-]',['Stress: ' stress_mode]})
        case 'Utilization'
            R = results.UR;
            update_plottitle({'Utilization ratio [-]',['Stress: ' stress_mode]})
        case 'Eq. stress range @ NR1'
            R = results.dSeq1;
            update_plottitle({'Eq. stress range' '@ NR1'})
        case 'Eq. stress range @ NR2'
            R = results.dSeq2;
            update_plottitle({'Eq. stress range' '@ NR2'})
        case 'Max stress'
            R = results.Smax;
            update_plottitle({'Max stress [MPa]'})
        case 'Min stress'
            R = results.Smin;
            update_plottitle({'Min stress [MPa]'})
        case 'Max stress range'
            R = results.dSmax;
            update_plottitle({'Max stress range [MPa]'})
        case 'Reserve factor'
            R = 1./results.UR;
            update_plottitle({'Reserve factor [-]',['Stress: ' stress_mode]})
        case 'DFF'
            R = 1./results.Dtot;
            update_plottitle({'Design Fatigue Factor [-]',['Stress: ' stress_mode]})
    end
    
    if strcmp(result,'Damage') || strcmp(result,'Max stress') || ...
        strcmp(result,'Min stress') || strcmp(result,'Max stress range')
    
        if lc == n_LC && strcmp(result,'Damage') % user selected 'sum'
            D = results.Dtot;
        else
            D = R(:,lc);
        end
        
    else % other results are general, i.e. not lc specific
        D = R;
        set(h.lcsel(5),'value',length(get(h.lcsel(5),'string')));
    end
    
    if hObj==h.lcsel(5) || hObj==h.rsel
        set_colorbar_limits(0,max(D))
    end
    
    if strcmp(result,'Model only')
        plot_model([]);
        old_cb = findobj('tag','Colorbar');
        delete(old_cb);
    elseif strcmp(result,'Damage') || strcmp(result,'Utilization')
        plot_model(D);
        set_colorbar_limits(0,max(D))
        cb_update_colorbar();
    else
        plot_model(D);
        set_colorbar_limits(min(D),max(D))
        cb_update_colorbar();
    end
 
end

function cb_edit_parts_table(~,event)
% executes when user changes a value in parts table (show or SN curve)

    h = getappdata(gcf,'handles');
    allSN = getappdata(gcf,'SN');
    model = getappdata(gcf,'model');
    selected_part_id = event.Indices(1);  % indices of the clicked cell
    selected_col_no = event.Indices(2);
    parts_table = h.parts.Data;
    n_parts = length(model.parts);

    if selected_col_no == 2 % user changes visibility or selects material for highlighting
        
        cb_get_visible(h.parts,event)

    elseif selected_col_no == 3 % user changes SN curve
        
        if selected_part_id <= n_parts

            % copy from table to model-struct
            SNcurve_no = find(ismember(lower({allSN.name}),lower(parts_table{selected_part_id,3})));
            model.parts(selected_part_id).SNcurve = SNcurve_no; % store SN number, not name
            h.parts.Data{n_parts+1,3} = ''; % clear the common SN curve for all parts
        
        else % user clicked "Toogle all" to set a common SN curves for all parts
            
            common_SN = parts_table{selected_part_id,3};
            common_SN_no = find(ismember(lower({allSN.name}),lower(common_SN)));
            for i = 1:n_parts 
                parts_table{i,3} = common_SN;
                model.parts(i).SNcurve = common_SN_no;
            end
            h.parts.Data = parts_table;

        end

        setappdata(h.fig,'model',model);

    end

    save_to_ws;

end

function cb_get_visible(hObj,event)
    % Return reduced arrays of visible nodes/faces

    h = getappdata(gcf,'handles');

    model = getappdata(h.fig,'model');
    face_table = model.surf.face_table;
    node_table = model.surf.node_table;
    elem_table = model.surf.elem_table;
    
    parts_table  = get(h.parts,'data');
    show_parts   = double(cell2mat(parts_table(:,2)));
    n_parts      = length(show_parts);
    show_section = get(h.sect,'value');
    
    
    % toggle all parts
    if ~isempty(hObj) && hObj==h.parts && event.Indices(1)==n_parts
        if event.NewData == 1
            parts_table(:,2) = num2cell(true(n_parts,1));
        else
            parts_table(:,2) = num2cell(false(n_parts,1));
        end
        set(h.parts,'data',parts_table);
        show_parts = double(cell2mat(parts_table(:,2)));
    end
    show_parts(end) = [];
    
    
    % default to full model
    vis_facesi = (1:length(face_table))';
    vis_nodesi = (1:length(node_table))';
        
    
    % hide some parts
    if any(show_parts==0)
        vis_facesi = parts_view_mex(face_table,elem_table,show_parts);
        vis_nodesi = unique(face_table(vis_facesi,1:4));
    end
    
    
    % sectional view
    if show_section > 1
        vis_facesi2 = section_view_mex(face_table,elem_table,show_section);
        vis_nodesi2 = unique(face_table(vis_facesi2,1:4));
        
        vis_facesi = intersect(vis_facesi,vis_facesi2);
        vis_nodesi = intersect(vis_nodesi,vis_nodesi2);
    end
    
    
    %return
    model.surf.vis_facesi = vis_facesi;
    model.surf.vis_nodesi = vis_nodesi;
    setappdata(h.fig,'model',model);

    cb_update_plot();
    
end

function cb_mark_selected_part(hObj,event)
    
    h = getappdata(gcf,'handles');

    if size(event.Indices,1) >= 1
        part_idx = event.Indices(1);
        set(h.show_elems,'state','on');
        set(h.part_colors,'state','off');
        cb_show_model_parts(hObj,0,part_idx);
    else
        return; 
    end

end

function cb_show_model_parts(hObj,~,part_idx)

    h = getappdata(gcf,'handles');
    
    if nargin==2
        part_idx = 0;
        set(h.show_elems,'state','off');
    end
    
    model = getappdata(h.fig,'model');
    
    if isempty(model)
        return;
    end
	
    all_faces = model.surf.face_table(:,1:4);
    all_verts = model.surf.node_table(:,2:4); % all vertices 
        
    update_plottitle('Model parts');
    delete(findobj('tag','Colorbar'));
    delete(findobj('tag','model'));
    
    show_parts = double(cell2mat(h.parts.Data(:,2)));
    n_parts    = length(model.parts);
    
    axes(h.max);
    if hObj == h.part_colors
        cols = colormap(lines(n_parts)); % different color for each part
    else
        if part_idx <= n_parts % all=cyan, except selected=magenta
            cols = repmat([0 1 1],n_parts,1);
            cols(part_idx,:) = [1 0 1];
        else
            cols = repmat([1 0 1],n_parts,1);
        end
    end

    for i = 1:n_parts
        if show_parts(i) || i == part_idx
            h.mod(i) = patch('faces',all_faces(model.parts(i).faces,:),'vertices',all_verts,...
                             'facecolor',cols(i,:),'edgecolor','none','tag','model');
        end
    end
    
    setappdata(h.fig,'handles',h);
    
    cb_toggle_elem_borders();
    
end

function cb_set_transparancy(hObj,~)
    % set the level of transparancy for the element-model
    
    h = getappdata(gcf,'handles');
    
    t_val = get(hObj,'value');
    set(hObj,'tooltipstring',num2str(t_val));
    
    if strcmp(h.show_elems.State,'on')
        if isfield(h,'mod') && ishandle(h.mod)
            set(h.mod,'facealpha',t_val);
        end
    end
    
end

function cb_toggle_cs(~,~)
% plot coordinate system

    h = getappdata(gcf,'handles');
    axes(h.max);    
    
    model = getappdata(h.fig,'model');
    try
        max_dim = model.surf.max_dim;
    catch
        max_dim = 2;
    end
    
    if strcmp(h.csys.State,'on')
        T = eye(3);
        k = 0.5*max_dim(1)*[0.2 0.005 0.02];
        mArrow3([0 0 0]',k(1)*T(:,1),'color','r','tag','cs','stemWidth',k(2),'tipWidth',k(3));
        mArrow3([0 0 0]',k(1)*T(:,2),'color','g','tag','cs','stemWidth',k(2),'tipWidth',k(3));
        mArrow3([0 0 0]',k(1)*T(:,3),'color','b','tag','cs','stemWidth',k(2),'tipWidth',k(3));
    else
        delete(findobj('tag','cs'));
    end
    
end

function cb_toggle_lights(~,~)
   
    h = getappdata(gcf,'handles');
    axes(h.max);    
    
    if strcmp(h.light.State,'on')
        h.camlight = light;
    else
        delete(h.camlight);
    end

    setappdata(h.fig,'handles',h);
    
end

function cb_toggle_wire_frame(~,~)
   
    h = getappdata(gcf,'handles');
    axes(h.max);    

    model = getappdata(h.fig,'model');
        
    if isempty(model)
        return;
    end
    
    % plot wire frame
    if strcmp(h.wire.State,'on')
        wire_frame = model.surf.wire_frame;
        line(wire_frame(1,:), wire_frame(2,:), wire_frame(3,:),'tag','wire','color',h.front_col,'linewidth',1.5);
    else
        delete(findobj('tag','wire'));
    end

end

function cb_toggle_elem_borders(~,~) 

    h = getappdata(gcf,'handles');
    
    % if no model is currently shown
    if ~isfield(h,'mod')
        return;
    end
    
    % toggle edgecolor = element borders
    for i = 1:length(h.mod)
        if ishandle(h.mod(i))
            if strcmpi(h.show_borders.State,'on')
                set(h.mod(i),'edgecolor',h.front_col,'linewidth',0.5);
            else
                set(h.mod(i),'edgecolor','none');
            end
        end
    end
    
end

function cb_toggle_bg_color(hObj,~) 

    h = getappdata(gcf,'handles');
    
    % switch global front/background colors
    if strcmpi(hObj.State,'off')
        h.back_col  = 'w';
        h.front_col = 'k';
    else
        h.back_col  = 'k';
        h.front_col = 'w';
    end
    
    setappdata(gcf,'handles',h);
    
    set(h.ptit,'foregroundcolor',h.front_col,'backgroundcolor',h.back_col);
    set(h.axp,'backgroundcolor',h.back_col);
    
    if isfield(h,'cb')
        set(h.cb,'color',h.front_col);
    end
    
    % update plot
    cb_toggle_wire_frame();
    cb_toggle_elem_borders();
    cb_show_nodes();
    
end

function cb_show_nodes(~,~)
   
    h = getappdata(gcf,'handles');
    axes(h.max);    

    model = getappdata(h.fig,'model');
    if isempty(model)
        return;
    end
    
    all_verts = model.surf.node_table(:,2:4); % all vertices 
    vis_verts = all_verts(model.surf.vis_nodesi,:); % visible vertices
       
    if isempty(vis_verts)
        cla
        return;
    end
    
    % plot nodes
    if strcmp(h.show_nodes.State,'on')
        plot3(vis_verts(:,1),vis_verts(:,2),vis_verts(:,3),'.k','tag','nodes','markersize',12);
        
        % node numbers
        if strcmp(h.show_node_nos.State,'on')
            node = double(model.surf.node_table(model.surf.vis_nodesi,1));
            c = double(vis_verts);
            text(c(:,1),c(:,2),c(:,3),num2str(node),'fontsize',8,'color','b','tag','node_nos');
        else
            delete(findobj('tag','node_nos'));
        end
        
    else
        delete(findobj('tag','nodes'));
        delete(findobj('tag','node_nos'));
    end
    
end

function cb_show_elem_numbers(~,~)

    h = getappdata(gcf,'handles');
    axes(h.max);    

    model = getappdata(h.fig,'model');
    if isempty(model)
        return;
    end

    % element numbers on faces
    if strcmp(h.show_elem_nos.State,'on')
        for i = 1:length(model.surf.vis_facesi)
            f   = model.surf.vis_facesi(i);             % face index
            fc  = double(model.surf.face_table(f,6:8)); % face centroid
            eno = num2str(model.surf.face_table(f,5));  % element no.
            text(fc(1),fc(2),fc(3),eno,'fontsize',8,'color','m','tag','elem_nos');
        end
    else
        delete(findobj('tag','elem_nos'));
    end
    
end

function cb_show_face_numbers(~,~)

    h = getappdata(gcf,'handles');
    axes(h.max);    

    model = getappdata(h.fig,'model');
    if isempty(model)
        return;
    end
 
    % face numbers on faces
    if strcmp(h.show_face_nos.State,'on')
        for i = 1:length(model.surf.vis_facesi)
            f   = model.surf.vis_facesi(i);             % face index
            fc  = double(model.surf.face_table(f,6:8)); % face centroid
            fno = ['F' num2str(f)];                     % face & element no.
            text(fc(1),fc(2),fc(3),fno,'fontsize',8,'color','m','tag','face_nos');
        end
    else
        delete(findobj('tag','face_nos'));
    end
    
end

function cb_show_face_normals(hObj,~)

    if strcmp(hObj.State,'on')

        h = getappdata(gcf,'handles');
        model = getappdata(h.fig,'model');
        if isempty(model)
            return;
        end

        % arrange for fast plotting
        n_faces = length(model.surf.vis_facesi);
        pn = zeros(3,n_faces*3);
        kn = 0.7*model.surf.esize;
    
        for i = 1:n_faces

            f = model.surf.vis_facesi(i);
    
            Na = [NaN NaN NaN]';
            n  = [model.surf.face_norms(f,1)   model.surf.face_norms(f,2)   model.surf.face_norms(f,3)]';
            p1 = [model.surf.face_table(f,5+1) model.surf.face_table(f,5+2) model.surf.face_table(f,5+3)]';
            p2 = p1 + kn*n;
    
            pn(1:3,(i*3-2):(i*3)) = [p1 p2 Na]; 
    
        end    
        
        % plot
        axes(h.max);
        line(pn(1,:), pn(2,:), pn(3,:),'tag','face_normals','color','m','linewidth',2);

    else
        delete(findobj('tag','face_normals'));
    end
    
end

function cb_show_node_normals(~,~)

    h = getappdata(gcf,'handles');

    if strcmp(h.show_node_normals.State,'on')
    
        model = getappdata(h.fig,'model');
        if isempty(model)
            return;
        end

        % arrange for fast plotting
        n_nodes = length(model.surf.vis_nodesi);
        pn = zeros(3,n_nodes*3);
        kn = 0.7*model.surf.esize;
    
        for i = 1:n_nodes

            ni = model.surf.vis_nodesi(i);
    
            Na = [NaN NaN NaN]';
            n  = model.surf.node_normals(ni,:)';
            p1 = model.surf.node_table(ni,2:4)';
            p2 = p1 + kn*n;
    
            pn(1:3,(i*3-2):(i*3)) = [p1 p2 Na]; 
    
        end    
        
        % plot
        axes(h.max);
        line(pn(1,:), pn(2,:), pn(3,:),'tag','node_normals','color','m','linewidth',2);

    else
        delete(findobj('tag','node_normals'));
    end
    
end

function plot_model(result_set)

    h = getappdata(gcf,'handles');

    set(h.part_colors,'State','off');
    axes(h.max);
    
    if nargin==0
        result_set = [];
        update_plottitle('');
        delete(findobj('tag','Colorbar'));
    end
    
    % get faces/vertices of visible part of model
    model = getappdata(h.fig,'model');
    
    if isempty(model)
        return;
    end
    
    faces = model.surf.face_table(model.surf.vis_facesi,1:4);
    all_verts = model.surf.node_table(:,2:4); % all vertices 
    vis_verts = all_verts(model.surf.vis_nodesi,:); % visible vertices
       
    if isempty(vis_verts)
        cla
        return;
    end
    
    delete(findobj('tag','model'));
    hold on;

    % get & set plot limits
    if strcmp(h.csys.State,'on')
        dims = [0 0 0; vis_verts];
    else
        dims = vis_verts;
    end
    max_dim  = model.surf.max_dim;
    max_lims = max(dims)+0.15*max_dim;
    min_lims = min(dims)-0.15*max_dim;
    xlim([min_lims(1) max_lims(1)]);
    ylim([min_lims(2) max_lims(2)]);
    zlim([min_lims(3) max_lims(3)]);

    
    % plot model elements
    if strcmp(h.show_elems.State,'on')
        if isempty(result_set)
            h.mod = patch('Faces',faces,'Vertices',all_verts,'facecolor','c','edgecolor','none','tag','model');
        else % results
            h.mod = patch('Faces',faces,'Vertices',all_verts,'FaceVertexCData',result_set,'FaceColor','interp','edgecolor','none','tag','model');
        end
    end
    
    setappdata(h.fig,'handles',h);
    
    axis vis3d
    axis equal
    set(h.max,'OuterPosition',[0.1 0.1 0.8 0.8]);
    
    cb_toggle_cs();
    cb_toggle_wire_frame();
    cb_toggle_elem_borders();

    drawnow
    setappdata(h.fig,'result_set',result_set)
    assignin('base','RS',result_set)
    
end

function cb_plot_stress_time(hObj,~)
    
    h  = getappdata(gcf,'handles');

    options     = getappdata(h.fig,'options');
    model       = getappdata(h.fig,'model');
    FE          = getappdata(h.fig,'FE');
    LC          = getappdata(h.fig,'LC');

    selected_stress_mode = get_current_popup_string(h.ssel(3)); 
    selected_lc          = get(h.lcsel(2),'value');
    max_time_step        = options.n_step(selected_lc);

    % get time step
    if hObj==h.time(2) % slider sets timestep
        selected_time_step = round(h.time(2).Value);
    else % user entered time step in editbox
        selected_time_step = str2num(h.tsel.String);
        if ~isnumeric(selected_time_step)
            errordlg(['Timestep must be an number: [1 - ' num2str(max_time_step) ']'],'Error');
            return
        end
        if length(selected_time_step)>1 || floor(selected_time_step)~=ceil(selected_time_step)
            errordlg(['Timestep must be an integer: [1 - ' num2str(max_time_step) ']'],'Error');
            return
        end
    end

    % enforce limits on time step
    if selected_time_step > max_time_step
        selected_time_step = max_time_step;
    elseif selected_time_step < 1
        selected_time_step = 1;
    end

    % copy time step from slider to edit box or vice versa & obey limits
    if hObj==h.time(2)
        h.tsel.String = num2str(selected_time_step); % copy to editbox
    else
        h.time(2).Value = selected_time_step; % copy to slider
        h.tsel.String   = num2str(selected_time_step); % copy to editbox
    end

    % make sure model is ready
    if isempty(FE)
        errordlg('No FE stresses found.','Error');
        return;
    elseif isempty(LC)
        errordlg('No loads found.','Error');
        return;
    end
  
    % calculate stress at time step & plot
    calc_nodes = model.surf.vis_nodesi;
    n_nodes = length(calc_nodes);
    S = zeros(options.n_nodes_all,1);

    for i = 1:n_nodes
        S(calc_nodes(i)) = calc_stress(calc_nodes(i),FE,LC(selected_lc).L(selected_time_step,:),selected_stress_mode,options.multi)';
    end

    plot_model(S);
    
    show_colorbar(min(S),max(S));
    time = LC(selected_lc).t(selected_time_step);
    update_plottitle({[selected_stress_mode ' stress'],['@ t=' num2str(time,'%.2f')]});
    
end



%% Vector plot
function cb_init_stress_vector(hObj,~)
    
    h = getappdata(gcf,'handles');
    options     = getappdata(h.fig,'options');
    FE          = getappdata(h.fig,'FE');
    LC          = getappdata(h.fig,'LC');
    model       = getappdata(h.fig,'model');
    node        = str2num(get(h.nno,'string'));    
    ni          = model.surf.mapping.node2ni(node);
    scope       = get(h.ssel(4),'value');
    scale_vec   = get(h.ssca,'value');
    set(h.time(3),'value',1);
    
    if hObj==0 % called from 'Morhs circle plot' on graph tab
        lc = get(h.lcsel(1),'value');
    else
        lc = get(h.lcsel(3),'value');
    end
   
    % get node(s) scope
    if scope==2 && ~isempty(ni) || hObj==0 % single selected node
        nodes = ni;
    elseif scope==1 % all nodes
        nodes = model.surf.vis_nodesi;
    else % no node picked
        errordlg('Select node first.','Error')
        return
    end
    
    stress_time = stress_vector_plot(nodes,FE(1).load_table,FE(1).ULC_table,FE(1).node_stress,LC(lc),...
                  model.surf.esize,model.surf.node_table(nodes,2:4),scale_vec,options);
    
    setappdata(h.fig,'stress_time',stress_time);
    
    cb_plot_stress_vector;
    
end

function cb_plot_stress_vector(~,~)

    h = getappdata(gcf,'handles');
    model   = getappdata(h.fig,'model');
    LC      = getappdata(h.fig,'LC');
    
    scale = 10;
    stress_time = getappdata(h.fig,'stress_time');

    if isempty(stress_time)
        errordlg('Press calculate first.','Error');
        return;
    end
    
    t_step  = round(get(h.time(3),'value'));
    if t_step<1
        t_step = 1;
    end
    
    t       = LC(1).t(t_step);
    scope   = get(h.ssel(4),'value');
    set(h.time(3),'backgroundcolor','r'); drawnow;
    
    % reset time at end
    if round(get(h.time(3),'value')) == get(h.time(3),'max')
        set(h.time(3),'value',1);
    end
    
    % plot
    axes(h.max);
    delete(findobj('tag','stress_dir'));
    delete(findobj('tag','selected'));

    if 0 %scope==2 % single node, use fancy arrows
        
        node = str2num(get(h.nno,'string'));    
        ni   = model.surf.mapping.node2ni(node);
        c    = model.surf.node_table(ni,2:4)';
        k    = 0.75*model.surf.max_dim(1)*[0.2 0.0005 0.001];
        
        if get(h.sp1,'value')
            p1 = stress_time(t_step).p1(:,1); 
            p2 = stress_time(t_step).p1(:,2); 
            mArrow3(c,p1,'color','r','tag','stress_dir','stemWidth',k(2),'tipWidth',k(3));
            mArrow3(c,p2,'color','r','tag','stress_dir','stemWidth',k(2),'tipWidth',k(3));
        end
        if get(h.sp2,'value')
            p1 = stress_time(t_step).p2(:,1); 
            p2 = stress_time(t_step).p2(:,2); 
            mArrow3(c,p1,'color','g','tag','stress_dir','stemWidth',k(2),'tipWidth',k(3));
            mArrow3(c,p2,'color','g','tag','stress_dir','stemWidth',k(2),'tipWidth',k(3));
        end
        if get(h.sp3,'value')
            p1 = stress_time(t_step).p3(:,1); 
            p2 = stress_time(t_step).p3(:,2); 
            mArrow3(c,p1,'color','b','tag','stress_dir','stemWidth',k(2),'tipWidth',k(3));
            mArrow3(c,p2,'color','b','tag','stress_dir','stemWidth',k(2),'tipWidth',k(3));
        end
        if get(h.spm,'value')
            p1 = stress_time(t_step).pm(:,1); 
            p2 = stress_time(t_step).pm(:,2); 
            mArrow3(c,p1,'color','m','tag','stress_dir','stemWidth',k(2),'tipWidth',k(3));
            mArrow3(c,p2,'color','m','tag','stress_dir','stemWidth',k(2),'tipWidth',k(3));
        end
        
    else % all nodes, just use lines
        
        if get(h.sp1,'value')
            p = stress_time(t_step).p1; 
            line(p(1,:), p(2,:), p(3,:),'tag','stress_dir','color','r','linewidth',2);
        end
        if get(h.sp2,'value')
            p = stress_time(t_step).p2; 
            line(p(1,:), p(2,:), p(3,:),'tag','stress_dir','color','g','linewidth',2);
        end
        if get(h.sp3,'value')
            p = stress_time(t_step).p3; 
            line(p(1,:), p(2,:), p(3,:),'tag','stress_dir','color','b','linewidth',2);
        end
        if get(h.spm,'value')
            p = stress_time(t_step).pm; 
            line(p(1,:), p(2,:), p(3,:),'tag','stress_dir','color','m','linewidth',2);
        end
        
    end
    
    drawnow;
    set(h.time(3),'backgroundcolor',0.9412*[1 1 1]);
    
    update_plottitle({'Principal stress',['directions @ t=' num2str(t,'%.2f')]});
    colorbar off
       
end

function cb_anim_stress_vector(~,~)


    h       = getappdata(gcf,'handles');
    options = getappdata(h.fig,'options');
    stress_time = getappdata(h.fig,'stress_time');
    n_steps = length(stress_time);
    
    % reset time slider
    set(h.time(3),'value',1);
    file_path = [options.files.work_folder '\'];
    
    for i = 1:1:n_steps
        
        set(h.time(3),'value',i);

        cb_plot_stress_vector;
        pause(0.1);

        % create new figure window and write image file
%         hf2 = figure;
%         copyobj(h.max,hf2)
%         file_name{i} = ['fatlab_t' num2str(i) '.png'];
%         print(hf2,[file_path file_name{i}],'-dpng')
%         close gcf

    end
    
%     % This part is inspired by:
%     % image2animation by Moshe Lindner, Bar-Ilan University, Israel, September 2010
%     loops = 10000;
%     delay = 0.1; % sec
%     file_name2 = 'fatlab.gif';
%     h = waitbar(0,'0% done','name','Progress') ;
%     for i=1:length(file_name)
% 
%         a=imread([file_path,file_name{i}]);
%         [M, c_map]= rgb2ind(a,256);
% 
%         if i==1
%             imwrite(M,c_map,[file_path,file_name2],'gif','LoopCount',loops,'DelayTime',delay)
%         else
%             imwrite(M,c_map,[file_path,file_name2],'gif','WriteMode','append','DelayTime',delay)
%         end
%         
%         waitbar(i/length(file_name),h,[num2str(round(100*i/length(file_name))),'% done']) ;
%     end
%     close(h);
    
    %delete(file_name)
    
end

function cb_clear_stress_vector(~,~)
    delete(findobj('tag','stress_dir'));
    update_plottitle({''});
end




%% Hotspots
function cb_select_or_edit_hotspot(~,table)
% executes when user selects or edits values in the hotspot table.
    
    h = getappdata(gcf,'handles');
    h.hstable_selected_indices = table.Indices; % indices of the clicked cell
    set(h.hstable,'KeyPressFcn',@hotspot_enter);
    
    if ~isempty(h.hstable_selected_indices) 

        selected_row_no = h.hstable_selected_indices(1);
        selected_col_no = h.hstable_selected_indices(2);

        hotspot_table = h.hstable.Data; % get table contents
        selected_method = hotspot_table{selected_row_no,4};
        
        if selected_col_no <= 3 % user clicked one of first 3 columns (node/face number)
            
            if ~strcmp(selected_method,'DNV 2 midpoints')
                cb_select_node(1);
            else
                cb_select_face(1);
            end

        elseif selected_col_no == 4 % user wants to change method

%             % when switching to DNV 2 midpoints method, based on faces
%             % rather than nodes: clear potential nodes already in table
%             if strcmp(selected_method,'DNV 2 midpoints')
%                 for j = 1:3
%                     h.hstable.Data{selected_row_no,j} = [];  
%                 end
%             end

            plot_hotspots();

        end
    end
    
    setappdata(h.fig,'handles',h);
    
end

function hotspot_enter(~,event)
    
    % user entered node/face number manually w/o graphical picking.
    h = getappdata(gcf,'handles');
    
    if strcmp(event.Key,'return')
        rotate3d off; zoom off; pan off
        set(h.fig,'Pointer','arrow');
        set(h.fig,'WindowButtonDownFcn',h.WindowButtonDownFcn);
        plot_hotspots();
    elseif strcmp(event.Key,'escape')
        set(h.fig,'Pointer','arrow');
        set(h.fig,'WindowButtonDownFcn',h.WindowButtonDownFcn);
    end
    
end

function cb_add_hotspot(~,~)

    h = getappdata(gcf,'handles');
    
    options = getappdata(h.fig,'options');
    SN      = getappdata(h.fig,'SN');
    table   = get(h.hstable,'data');
    
    if isempty(table)
        columns = get(h.hstable,'ColumnName');
        table = cell(1,length(columns));
        table{1,4} = h.methods{1};
        table{1,5} = options.stress_mode;
        table{1,6} = SN(options.selectedSN).name;
        set(h.hstable,'data',table)
    else
        l = size(table,1);
        table{l+1,4} = h.methods{1};
        table{l+1,5} = options.stress_mode;
        table{l+1,6} = SN(options.selectedSN).name;
        set(h.hstable,'data',table)
    end

end

function cb_rem_hotspot(~,~)

    h = getappdata(gcf,'handles');
    table = get(h.hstable,'data');
    if ~isempty(table)
        l = size(table,1);
        table = table(1:l-1,:);
        set(h.hstable,'data',table)
        plot_hotspots();
    end

end

function plot_hotspots(~,~)
    
    % plot hotspots & weld extrapolation paths
    h = getappdata(gcf,'handles');
    
    delete(findobj('tag','hs'));
    delete(findobj('tag','selected'));

    if strcmp(h.show_hotspots.State,'on') % plot hotspots?
        
        model = getappdata(h.fig,'model');
        
        if isempty(model)
            return;
        end
        
        axes(h.max);
        
        hotspot = read_hotspot_table();
        if isempty(hotspot)
            return;
        end
        
        for i = 1:length(hotspot)

            for j = 1:length(hotspot(i).node_coord) % mark all selected nodes/faces with a dot
                coord = hotspot(i).node_coord{j};
                plot3(coord(1),coord(2),coord(3),'.m','markersize',15,'tag','hs');
            end

            if hotspot(i).fully_defined % mark fully defined HS with arrow
                switch hotspot(i).method
                    case 'Single node'
                        continue;
                    case '3p extrapolation'
                        p1  = hotspot(i).node_coord{1};
                        p2  = hotspot(i).node_coord{3};                        
                    case '0.4t 1.0t'
                        ext = (hotspot(i).node_coord{1} - hotspot(i).node_coord{2})*0.4/0.6;
                        p1  = hotspot(i).node_coord{1} + ext;
                        p2  = hotspot(i).node_coord{2};
                    case '0.5t 1.5t'
                        ext = (hotspot(i).node_coord{1} - hotspot(i).node_coord{2})*0.5;
                        p1  = hotspot(i).node_coord{1} + ext;
                        p2  = hotspot(i).node_coord{2};
                    case '5mm 15mm'
                        ext = (hotspot(i).node_coord{1} - hotspot(i).node_coord{2})*0.5;
                        p1  = hotspot(i).node_coord{1} + ext;
                        p2  = hotspot(i).node_coord{2};
                    case '0.4t 0.9t 1.4t'
                        ext = (hotspot(i).node_coord{1} - hotspot(i).node_coord{2})*0.4/1.4;
                        p1  = hotspot(i).node_coord{1} + ext;
                        p2  = hotspot(i).node_coord{3};
                    case '0.5t 1.5t 2.5t'
                        ext = (hotspot(i).node_coord{1} - hotspot(i).node_coord{2})*0.5/2.5;
                        p1  = hotspot(i).node_coord{1} + ext;
                        p2  = hotspot(i).node_coord{3};
                    case '4mm 8mm 12mm'
                        ext = (hotspot(i).node_coord{1} - hotspot(i).node_coord{2})*0.5;
                        p1  = hotspot(i).node_coord{1} + ext;
                        p2  = hotspot(i).node_coord{3};
                    case 'DNV 2 midpoints'
                        ext = (hotspot(i).node_coord{1} - hotspot(i).node_coord{2})*0.5;
                        p1  = hotspot(i).node_coord{1} + ext;
                        p2  = hotspot(i).node_coord{2};

                end

                % plot extrapolation path arrow
                p1 = double(p1);
                p2 = double(p2);
                k = norm(p2-p1);
                mArrow3(p2,p1,'color','m','tag','hs','stemWidth',k*0.035,'tipWidth',k*0.14,'tipLength',k*0.06);
                
            end
        end
    else
        delete(findobj('tag','hs'));
    end
    
end

function hotspot = read_hotspot_table()
    
    h = getappdata(gcf,'handles');
    hotspot = [];   
    model   = getappdata(h.fig,'model');
    allSN   = getappdata(h.fig,'SN');
    table   = get(h.hstable,'data');
    
    for i = 1:size(table,1)

        % get list of node names
        nodes = [];
        for j=1:3
            if ~isempty(table{i,j}) && ~isnan(table{i,j}) 
                nodes(j) = table{i,j};
            end
        end
        
        % if no nodes defined, skip step
        if isempty(nodes)
            continue;
        end
        
        hotspot(i).method = table{i,4}; % extrapolation method
        hotspot(i).stress = table{i,5}; % fatigue stress
        SNname = table{i,6}; % SN curve
        hotspot(i).selectedSN = find(ismember(lower({allSN.name}),lower(SNname)));
        
        % is hot spot fully defined?
        hotspot(i).fully_defined = false;
        switch hotspot(i).method
            case 'Single node'
                if length(nodes)>=1
                    hotspot(i).fully_defined = true;
                end
            case '3p extrapolation'
                if length(nodes)==3
                    hotspot(i).fully_defined = true;
                end
            case {'0.4t 1.0t','0.5t 1.5t','5mm 15mm'}
                if length(nodes)>=2
                    hotspot(i).fully_defined = true;
                end
            case {'0.4t 0.9t 1.4t','0.5t 1.5t 2.5t','4mm 8mm 12mm'}
                if length(nodes)==3
                    hotspot(i).fully_defined = true;
                end
            case 'DNV 2 midpoints'
                if length(nodes)>=2 % actually faces
                    hotspot(i).fully_defined = true;
                end
        end
        
        % find node index & coordinates
        for j=1:length(nodes)
            if strcmp(hotspot(i).method,'DNV 2 midpoints') % not nodes, but faces
                face_no = nodes(j);
                hotspot(i).face(j) = nodes(j);
                hotspot(i).ni(j) = j; % artificial node number, needed later.
                hotspot(i).node_coord{j} = model.surf.face_table(face_no,6:8);
            else
                ni(j) = model.surf.mapping.node2ni(nodes(j)); % find internal node number 
                hotspot(i).node(j) = nodes(j);
                hotspot(i).ni(j)   = ni(j);
                x = model.surf.node_table(ni(j),1+1); % and the nodal coordinates
                y = model.surf.node_table(ni(j),1+2);
                z = model.surf.node_table(ni(j),1+3);
                hotspot(i).node_coord{j} = [x y z];
            end
        end
        
    end
        
end

function cb_calc_hotspots(~,~)

    h = getappdata(gcf,'handles');
    options = getappdata(h.fig,'options');
    model   = getappdata(h.fig,'model');
    results = getappdata(h.fig,'results');
    LC      = getappdata(h.fig,'LC');
    allSN   = getappdata(h.fig,'SN');
    
    hotspot = read_hotspot_table(); 
    table   = get(h.hstable,'data');

    set(h.fig,'Pointer','watch'); drawnow;
    
    % construct manipulated FE datastructure with extrapolated unit stress values. 
    % Only local copy in this function.    
    for i = 1:length(hotspot)
        
        % start with a fresh set of FE stress data
        FE = getappdata(h.fig,'FE');
        
        if ~strcmp(hotspot(i).method,'DNV 2 midpoints') % node based
            FE1 = FE(1).node_stress(hotspot(i).ni(1)).table;
            
            try
                FE2 = FE(1).node_stress(hotspot(i).ni(2)).table;
            catch
                FE2 = [];
            end
            
            try
                FE3 = FE(1).node_stress(hotspot(i).ni(3)).table;
            catch
                FE3 = [];
            end

        else % face based: calculated FE stresses at face centers

            face_no1 = hotspot(i).face(1); % face(1) = 0.5t from weld
            nodes_on_face = model.surf.face_table(face_no1,1:4);
            FE1 = FE(1).node_stress(nodes_on_face(1)).table; 
            for j = 2:4
                FE1 = FE1 + FE(1).node_stress(nodes_on_face(j)).table; 
            end
            FE1 = FE1/4; % interpolation in center of linear stress field = average, 
                         % for 3-noded face, node 3=4 is duplicated -> no problems

            face_no2 = hotspot(i).face(2); % face(2) = 1.5t from weld
            nodes_on_face = model.surf.face_table(face_no2,1:4);
            FE2 = FE(1).node_stress(nodes_on_face(1)).table; 
            for j = 2:4
                FE2 = FE2 + FE(1).node_stress(nodes_on_face(j)).table; 
            end
            FE2 = FE2/4;

        end
        
        switch hotspot(i).method % extrapolation method
            case 'Single node'
                FE(1).node_stress(hotspot(i).ni(1)).table = FE1;
                
            case '3p extrapolation' 
                x1 = norm(hotspot(i).node_coord{2}' - hotspot(i).node_coord{1}');
                x2 = norm(hotspot(i).node_coord{3}' - hotspot(i).node_coord{1}');
                dx = norm(hotspot(i).node_coord{3}' - hotspot(i).node_coord{2}');
                a = x2/dx;
                b = x1/dx;
                FE(1).node_stress(hotspot(i).ni(1)).table = a*FE2 - b*FE3;
                
            case '0.4t 1.0t'
                FE(1).node_stress(hotspot(i).ni(1)).table = 1.67*FE1 - 0.67*FE2;
                
            case '0.5t 1.5t'
                FE(1).node_stress(hotspot(i).ni(1)).table = 1.5*FE1 - 0.5*FE2;
                
            case '5mm 15mm'
                FE(1).node_stress(hotspot(i).ni(1)).table = 1.5*FE1 - 0.5*FE2;
                
            case '0.4t 0.9t 1.4t'
                FE(1).node_stress(hotspot(i).ni(1)).table = 2.52*FE1 - 2.24*FE2 + 0.72*FE3;
                
            case '4mm 8mm 12mm'
                FE(1).node_stress(hotspot(i).ni(1)).table = 3*FE1 - 3*FE2 + FE3;

            case 'DNV 2 midpoints'
                FE(1).node_stress(hotspot(i).ni(1)).table = 1.5*FE1 - 0.5*FE2;
                
        end
        
        
    
        
        % hacks based on stress mode (local copies of 'options' and 'multi' modified)
        options.stress_mode = hotspot(i).stress; 
        multi = options.multi;    

        switch options.stress_mode
            case 'CP   '
                options.multiaxial = 1;
    
                if strcmp(hotspot(i).method,'Single node') % use node normal at selected node
                    multi.node_normal = model.surf.node_normals(hotspot(i).ni(1),:)';
                    multi.node_axis   = model.surf.node_axis(hotspot(i).ni(1),:)';
                else % extrapolated hotspot: use node normal etc. from node 2 (on surface, not in corner)
                    multi.node_normal = model.surf.node_normals(hotspot(i).ni(2),:)';
                    multi.node_axis   = model.surf.node_axis(hotspot(i).ni(2),:)';
                end

            case 'Sperp' % perpendicular weld stress 'Sperp'
                         % = CP method with one plane only defined by direction of hotspot arrow

                options.stress_mode = 'CP   ';
                options.multiaxial  = 1;
                multi.n_planes(1)   = 1;
                hotspot_dir_vec     = hotspot(i).node_coord{1}' - hotspot(i).node_coord{2}';
                multi.node_axis     = single(hotspot_dir_vec/norm(hotspot_dir_vec)); 

            otherwise

                options.multiaxial = 0;

        end


        % SN curve selected, local only
        SN = allSN(hotspot(i).selectedSN);
        
        % do fatigue calculations for single node (hotspot node 1) only
        % for which FE contains extrapolated unit stresses
        [Dtot,UR] = hotspot_calc(FE,LC,SN,options,multi,hotspot(i).ni(1),i,true);

        % estimate also dominating load component? 
        if h.hsDLC.Value
            
            % waitbar with abort option
            hwb = awaitbar(0,['Calculating DLC for HS #' num2str(i) ', please wait...']);

            Lcomps = LC(1).Lcomps;              % (string) names of the load components 
            D_DLC  = zeros(options.n_loads,1);  % damage estimate from individual loads
            
            for load_no = 1:options.n_loads

                % update waitbar
                abort = awaitbar(load_no/options.n_loads);
                if abort
                    return; 
                end	
            
                load_type = FE(1).load_table(load_no,1);
                
                if load_type < 5 % load_type = 5,6 not meaningful
                    
                    % modify FE: disable all but current load components
                    FEmod = FE;
                    FEmod(1).load_table(:,1) = 0;
                    FEmod(1).load_table(load_no,1) = load_type;
                    
                    D_DLC(load_no) = hotspot_calc(FE,LC,SN,options,multi,hotspot(i).ni(1),i,false);
            
                end
            end

            % get name (string) for dominating load component
            [~,iDLC] = max(D_DLC);
            DLC = Lcomps{iDLC};

            delete(hwb);

        else
            DLC = 'Disabled';
        end
                
        

        hotspot(i).Dext = Dtot;
        hotspot(i).UR   = UR;
        hotspot(i).DLC  = DLC;
        table{i,7}   = hotspot(i).DLC;
        table{i,8}   = hotspot(i).Dext;
        table{i,9}   = hotspot(i).UR;
        
    end
    
    set(h.fig,'Pointer','arrow');
    set(h.hstable,'data',table);
    results.hotspot_table = table;
    setappdata(h.fig,'results',results);
    
end



%% File handling
function cb_save_file(hObj,~)
    
    h       = getappdata(gcf,'handles');
    options = getappdata(gcf,'options');
    LC      = getappdata(gcf,'LC');
    SN      = getappdata(gcf,'SN');
    FE      = getappdata(gcf,'FE');   
    results = getappdata(gcf,'results');
    model   = getappdata(gcf,'model');    

    savefile_fatlab_version = eval(h.vers); % get & store fatlab version in .fat file
    
    if strcmp(hObj,'autosave') % called by autosave 

        [filepath,filename] = fileparts(options.files.fat_file);
        if isempty(filepath) % not saved yet
            filename = 'Autosave';
            filepath = options.files.work_folder;
            if strcmpi(filepath(end),'\')
                filepath(end) = []; % remove '\'
            end
        end
        fat_file = [filepath '\' filename '_' replace(num2str(fix(clock)),' ','') '.fat'];
        fprintf('Autosaving to: %s\n',fat_file)        
        save(fat_file,'-v7.3','options','LC','SN','FE','results','model','savefile_fatlab_version');

    else % user pressed toolbar button

	    [filename,filepath,~] = uiputfile('*.fat','Save analysis as...',options.files.work_folder);

        if ~isnumeric(filename)
            fat_file = [filepath filename];
            save(fat_file,'-v7.3','options','LC','SN','FE','results','model','savefile_fatlab_version');
            options = getappdata(gcf,'options');
            options.files.fat_file    = fat_file;
            options.files.work_folder = filepath;
            setappdata(gcf,'options',options);
            update_gui('SetInputAndTitle')
        end
    end
    
    

end

function cb_open_file(~,~)

    h = getappdata(gcf,'handles');
    options = getappdata(h.fig,'options');
    
    [load_filename,load_filepath] = uigetfile({'*.fat'},'Please select input file',options.files.work_folder);

    if isnumeric(load_filename) % user cancelled
        return
    end
            
    set(h.fig,'Pointer','watch'); drawnow
    load([load_filepath load_filename],'-mat');

    % check whether the loaded file may be missing new fields and warn.
    current_fatlab_version = eval(h.vers);
    if ~exist('savefile_fatlab_version') || current_fatlab_version > savefile_fatlab_version        
        fprintf(2,'Warning: The loaded file was created with an earlier version of Fatlab.\nMay not work properly.\n')
    end
    
    % add missing fields with default settings 
    if exist('model','var') && ~isempty(model)
        if ~isfield(model,'parts') || ~isfield(model.parts,'SNcurve')  || ~isfield(model.surf.mapping,'ni2part_id')
            model = create_model_parts(model);
        end
    end

    if ~isfield(options,'loads_format') 
        options.loads_format = 1;
    end

    if ~isfield(options,'autosave')
        options.autosave = true;
    end

    if ~isfield(options,'mat_interface')
        options.mat_interface = false;
    end

    if exist('SN','var') && ~isempty(SN)
        if ~isfield(SN,'Ps') 
            for i = 1:length(SN)
                SN(i).Ps  = 97.7;
                SN(i).std = 0.2;
            end
        end
    end

    options.files.fat_file = [load_filepath load_filename];   % update model name and path
    options.files.work_folder = load_filepath;                % based on the .fat file
    
    % check for parallel computing toolbox license
	options.n_cores = 1; % reset to single core. avoiding bugs with ParForProgmon path issues.
    options.toolbox_parallel_computing = 0;
    if license('test','distrib_computing_toolbox') && isToolboxAvailable('Parallel Computing Toolbox')
        options.toolbox_parallel_computing = 1;
    end
    
    setappdata(h.fig,'options',options);
    setappdata(h.fig,'LC',LC);
    setappdata(h.fig,'SN',SN);
    setappdata(h.fig,'FE',FE);   
    setappdata(h.fig,'model',model);    
    if exist('results','var')
        if ~isfield(results,'SNno') && isfield(options,'n_nodes')
            results.SNno = ones(options.n_nodes,1);
        end
        setappdata(h.fig,'results',results);
    else
        setappdata(h.fig,'results',[]);
    end

    % make all loaded data available in the base workspace as well
    save_to_ws;
    
    update_gui('ResetAll');
    update_gui('FillHStable');
    update_gui('SNcurves->HStable');
    update_gui('SetInputAndTitle')
    delete(findobj('tag','wire'));
    cb_toggle_lights;
    
    if ~isempty(LC)
        update_gui('LoadCaseSelector');
        update_gui('SetMaxTimeStep');
    end
    
    if ~isempty(model)
        update_gui('FillPartsTable');
        cb_get_visible([],[]);
        if isfield(model,'dim') && model.dim == 2 
            view(0,90); % show 2D models straight on
        else
            view(40,20);
        end
    end
    
    set(h.fig,'Pointer','arrow');
    
end

function cb_new_file(~,~)
% start new input file with default values where necesarry    

    h = getappdata(gcf,'handles'); 

    % default options
    def_options.files.work_folder   = '';
    def_options.files.fat_file      = '';
    def_options.files.model_file    = '';
    def_options.files.model_format  = 1; % 1=ansys, 2=simulation
    def_options.files.loads_file    = '';
    def_options.selectedSN          = 1;
    def_options.stress_mode         = 'Pnmax';
    def_options.cycle_count         = 1; %Reservoir
    def_options.n_cores             = 1;
    def_options.racetrack           = 0.05;
    def_options.sort_output         = 'damage';
    def_options.warnings            = false;
    def_options.multi.n_planes      = [36 1];
    def_options.multi.k             = [0.3 1.0];
    def_options.multi.shear_cycles  = 'LC   '; % LC=longest chord, MCC, MRH, length = 5
    def_options.multi.criterion     = 'Normal stress  '; % length = 15'
    def_options.multi.node_normal   = single([0 0 1]');
    def_options.multi.node_axis     = single([1 0 0]');
    def_options.node_scope          = 1; %all nodes
    def_options.stresses            = h.stresses(1:h.n_stress);
    def_options.reduced_loads       = 1;
    def_options.loads_format        = 1; % 1=XLS, 2=SOT, 3=MAT
    def_options.edge_detection      = 40;
    def_options.mat_interface       = false;
    def_options.accumulation        = 1;
    def_options.autosave            = true;
    def_options.multiaxial          = 0; % 0 = uniaxial, 1 = CP + normal stress only, 2 = CP + shear stress based criteria
    def_options.load_types          = {'Linear' 'Bilinear' '1D interpolation' '2D interpolation' 'Var. for 2D interp.' 'Disabled'};
    def_options.FE_format           = 1; % 1=ansys, 2=simulation .CSV, 3=simulation .STE
    def_options.ansys_stress_format = [7 12];   % Field widths in ANSYS stress listing: 
                                                % Defaults are 7 digits for node number and 12 for stresses (works with /FORMAT,7,E,12 in APDL output script) 
       
    % check for parallel computing toolbox
    def_options.toolbox_parallel_computing = 0;
    if license('test','distrib_computing_toolbox') && isToolboxAvailable('Parallel Computing Toolbox')
        def_options.toolbox_parallel_computing = 1;
        fprintf('Parallel Computing Toolbox installed and licensed.\n');
        feature('numCores');
    else
        fprintf('Parallel Computing Toolbox not found. Single core execution only.\n');
    end
    

    % default SN curve
    def_SN.type         = 'custom';
    def_SN.name         = 'Default';
    def_SN.comments     = '';
    def_SN.ds1          = 100;
    def_SN.N1           = 2e6;
    def_SN.N2           = 1e7;
    def_SN.m1           = 3;
    def_SN.m2           = 5;
    def_SN.minS         = 0;
    def_SN.maxS         = 10000;
    def_SN.gf           = 1.35;
    def_SN.ds2          = (((def_SN.ds1^def_SN.m1*def_SN.N1)/def_SN.N2)^(1/def_SN.m1))/def_SN.gf;
    def_SN.mean_mode    = 1; % none
    def_SN.M            = 0.20;
    def_SN.Re           = 235;
    def_SN.Rm           = 370;
    def_SN.mean_yield   = 0;
    def_SN.mean_comp    = 0;
    def_SN.Dal          = 1.0;
    def_SN.Ps           = 97.7;
    def_SN.std          = 0.2;
    
    
    setappdata(h.fig,'options',def_options);
    setappdata(h.fig,'LC',[]);
    setappdata(h.fig,'SN',def_SN);
    setappdata(h.fig,'FE',[]);   
    setappdata(h.fig,'results',[]);
    setappdata(h.fig,'model',[]);    

    save_to_ws;
        
    update_gui('ResetAll');
    update_gui('FillHStable');
    
    init_view();
    set(h.fig,'Pointer','arrow');

end


