clc
clear all

%%%%%%%%%%%%%%%%%%%%%%%% Input parameters %%%%%%%%%%%%%%%%%%%%%
% Path to .mat file which contains: 1. Cell ID; 2. Time point; 3-5. position info; 6.Parent ID; 7.Intensity value; 8.Lineage ID
intensity_info_path = 'D:\Public\CSC_mechanical_force\extract-lineage\result\intensity_info.mat';  

% Path to .xlsx file which contains manual correction of cell type
manual_correction_path = 'D:\Public\CSC_mechanical_force\extract-lineage\dataset\02_lineage\cell_type_classification.xlsx'; 

% Last timepoint
last_timepoint = 400;


%%%%%%%%%%%%%%%%%%%%%%%% Plot the lineage tree %%%%%%%%%%%%%%%%%%%%%
load(intensity_info_path);
index = find(basic_info(:, 2) == last_timepoint);
basic_info = basic_info(1: index(end), :);
manual_correction = readmatrix(manual_correction_path);


t = basic_info(:,2);
parent_cell_id = basic_info(:,6);
lineage_id = basic_info(:,8);
cell_id = basic_info(:,1);
uniform_intensity = basic_info(:,7);

all_lineage = unique(lineage_id);
all_lineage(all_lineage == 0) = [];

lineage_num = length(all_lineage);

y = lineage_num * 600;

%start preparing

arrowj=0;
jjl=0;
jkjk=0;
for i = 1: lineage_num
    lineage_i = all_lineage(i, 1);
    lineage_i_cell_id = cell_id(lineage_id == lineage_i); 
    lineage_i_parent_cell_id = parent_cell_id(lineage_id == lineage_i);
    lineage_i_t = t(lineage_id == lineage_i);
    lineage_i_uniform_intensity = uniform_intensity(lineage_id == lineage_i);
    
    t_start=lineage_i_t(1,1);
    t_end=lineage_i_t(length(lineage_i_t),1);
    
    lineage_length = t_end - t_start + 1;
    row = 1;
    oooo = zeros(50,6);
    
    for j = t_start: t_end
        lineage_i_t_cell_id = lineage_i_cell_id(lineage_i_t == j);
        %now_t_cell_color = need_color(now_t_cell_idx);
        jiaru2020=zeros(1,1);
        for k = 1: length(lineage_i_t_cell_id)
            Next_generation_cell_position = find(parent_cell_id == lineage_i_t_cell_id(k, 1));
            num_of_Next_generation_cell_position = length(Next_generation_cell_position);
            if num_of_Next_generation_cell_position == 2
                
                oooo(row,1) = j;
                oooo(row,2) = lineage_i_t_cell_id(k,1);
                oooo(row,3) = cell_id(Next_generation_cell_position(1,1),1);
                oooo(row,4) = cell_id(Next_generation_cell_position(2,1),1);
                row = row+1;
            end   
        end  
    end
    
    oooo(1,5) = 1;
    cell_d_times = row-1;
    i_u = 1;
    for split_kind = 2:cell_d_times
        
        mm = oooo(split_kind,2);
        [xmll,meiyouyongde] = find(oooo(1:split_kind-1,3:4) == oooo(split_kind,2));
        if isempty(xmll)
            while (i_u>0)
                zzyy=find(lineage_i_cell_id==mm);
                shangyidaipid=lineage_i_parent_cell_id(zzyy);
                [wsgjz,meiyouyong]=find(oooo(1:split_kind,3:4)==shangyidaipid);
                if isempty(wsgjz)
                    mm=shangyidaipid;
                else
                    oooo(split_kind,6)=oooo(wsgjz,meiyouyong+2);
                    break
                end
            end
        else
            oooo(split_kind,6)=oooo(xmll,meiyouyongde+2);
        end
    end
        
    spsp=2;
    if cell_d_times~=1
        for kexiao=1:cell_d_times
            need_frame_id=oooo(kexiao,3:4);
            [numnum,kaka]=find(need_frame_id==oooo(:,6));
            oooo(numnum,5)=oooo(kexiao,5)+1;
            
        end
    end
    
    
    %% plus one for fenlie houyige shjian dian zidai  daiti mudai
    
    %syz=1;
    
    %while oooo(syz,1)~=0
        %one_zidaii=oooo(syz,3);
        %two_zidaii=oooo(syz,4);
        %now_id_one=find(id==one_zidaii);
        %now_id_two=find(id==two_zidaii);
        
        %now_ppid_one=find(pid==one_zidaii);
        %now_ppid_two=find(pid==two_zidaii);
        
         %zhongzhong=itst(now_ppid_one,1);
        %zhongzhong2=itst(now_ppid_two,1);
        %itst(now_id_one,1)=zhongzhong;
        %itst(now_id_two,1)=zhongzhong2;
        %syz=syz+1;
       
        
    %end
    
    
    
    
    %%
    %popo Part
    
    wzjl=zeros(50,1);
    
     %VC GOLD PLUS1 part--------------------------------------------------------
    
    if oooo(2,6)==0&&oooo(1,2)==0
        zong_ku=1;
        now_id=lineage_i_cell_id(1);
        now_t=lineage_i_t(1);
        Zx=1;
        
        %test red????????????????????????????????????????????????????????????????????????????
        
       
        wzjl(1,1)=Zx;
        %test end????????????????????????????????????????????????????????????????????????????
    else
        zy=1;
        shinnypart=max(oooo(:,5));
        D_kuandu=3;
        D_space=1;
        kudu=zeros(30,2);
        ssm=shinnypart-1;
        kudu(shinnypart,1)=3;
        kudu(1,2)=1;
        
        for sm=1:shinnypart-1
            kudu(ssm,1)=kudu(ssm+1,1)*2-1;
            kudu(sm+1,2)=2^sm;
            ssm=ssm-1;
        end
        
        zong_ku=kudu(shinnypart,1)*kudu(shinnypart,2)+kudu(shinnypart,2)+1;
        Zx=ceil(zong_ku/2);
       
        
        %test red????????????????????????????????????????????????????????????????????????????
        
        
        wzjl(zy,1)=Zx;
        zy=zy+1;
        %test end????????????????????????????????????????????????????????????????????????????

        need_tier=oooo(:,5);
        need_sd=oooo(:,6);
        need_p=oooo(:,2);
        need_o_t=oooo(:,1);
        need_s_s=oooo(:,3);
        need_s_b=oooo(:,4);
        IO=1;
        now_right=Zx+floor(kudu(1,1)/2);
        now_left=Zx-floor(kudu(1,1)/2);
        %last_right=
        %last_left=
        
        for xunhuan=2:shinnypart
            need_xunhuan=find(need_tier==xunhuan);
            richuri=length(need_xunhuan);
            for pikapika=1:richuri
                
                hua1=need_xunhuan(pikapika);
                    
                now_tier=need_tier(hua1);
                now_sd=need_sd(hua1);
                now_p=need_p(hua1);
                now_t=need_o_t(hua1);
                now_s_s=need_s_s(hua1);
                now_s_b=need_s_b(hua1);
           
                %seek now_left and now right
                x=ceil(zong_ku/2);%basic value
                kou=now_tier;
                now_ssd=now_sd;
                for sek=1:now_tier-1
                    beijianjia=floor(kudu(kou-1,1)/2);
                    [sgs,buyong]=find(oooo(:,3:4)==now_ssd);
                    kyk=find(oooo(sgs,:)==now_ssd);
                    if kyk==3
                        x=x-beijianjia;
                    else
                        x=x+beijianjia;
                    end
                    kou=kou-1;
                    now_ssd=need_sd(sgs);
                end
                now_zuobiao=x;
                kou=now_tier;
                now_ssd=now_sd;
                wzjl(zy,1)=now_zuobiao;
                zy=zy+1;
                [kelahang,liejiaer]=find(oooo(:,3:4)==now_sd);
                last_time=need_o_t(kelahang);
                
               
                
                %test red stick????????????????????????????????????????????????????????????
                last_2_t=last_time;
                now_2_time=now_t;
                shangyidai=now_sd;
                zhongzhuanxiaowangzi=find(lineage_i_cell_id==shangyidai);
                
                for VC=last_2_t:now_2_time-1
                    xiayidaixuhao=find(lineage_i_parent_cell_id==shangyidai);
                    xiayidai=lineage_i_cell_id(xiayidaixuhao);
                    
                    
                    
                    shangyidai=xiayidai;
                    
                end
                
                %testend????????????????????????????????????????????????????????????????????
                
                
                
               
            end
        end
        
        %HeartGold part
        wakaba=find(oooo(:,1)~=0);
        town=max(max(wakaba));
        for sh=1:town
            now_shq=oooo(sh,3);
            now_shh=oooo(sh,4);
            now_sht=oooo(sh,1);
            
            [pikachu,buyong]=find(oooo(:,6)==now_shq);
            [raichu,buyong]=find(oooo(:,6)==now_shh);
            if isempty(pikachu)
                %CalTLasT
                startp=now_shq;
                i_u=1;
                while (i_u>0)
                    [ceshi2020,gundanla]=size(startp);
                    if ceshi2020==2
                    end
                    nowshunxu=find(lineage_i_parent_cell_id==startp);
                    if isempty(nowshunxu)
                        break
                    end
                    nownowid=lineage_i_cell_id(nowshunxu);
                    startp=nownowid;
                end
                Ho_Oh=find(lineage_i_cell_id==startp);
                Ho_Oh_t=lineage_i_t(Ho_Oh,1);
                %CalTloc
                Ho_Oh_x=ceil(zong_ku/2);%basic place
                
                now_hotier=oooo(sh,5);
                now_sjd=oooo(sh,6);
                zailai=now_sjd;
                kkk=floor(kudu(now_hotier,1)/2);
                Ho_Oh_x=Ho_Oh_x-kkk;
                htou=now_hotier-1;
                for sek=1:now_hotier-1
                    HoOh=floor(kudu(htou,1)/2);
                    if now_sjd~=0
                        [Ho,buyong]=find(oooo(:,3:4)==now_sjd);
                        Oh=find(oooo(Ho,:)==now_sjd);
                    else
                        Oh=3;
                    end
                    
                    if Oh==3
                        Ho_Oh_x=Ho_Oh_x-HoOh;
                    else
                        Ho_Oh_x=Ho_Oh_x+HoOh;
                    end
                    if htou~=1
                        htou=htou-1;
                        now_sjd=need_sd(Ho);
                    end
                end
                HoOh_zuobiao=Ho_Oh_x;
                
               
                
                %testred????????????????????????????????????????????????????????????????????
                
                wzjl(zy,1)=HoOh_zuobiao;
                zy=zy+1;
                %testend????????????????????????????????????????????????????????????????????
                
                
                
            end
            if isempty(raichu)
                %CalTLasT
                startp=now_shh;
                i_u=1;
                while (i_u>0)
                    nowshunxu=find(lineage_i_parent_cell_id==startp);
                    if isempty(nowshunxu)
                        break
                    end
                    nownowid=lineage_i_cell_id(nowshunxu);
                    startp=nownowid;
                end
                Ho_Oh=find(lineage_i_cell_id==startp);
                Ho_Oh_t=lineage_i_t(Ho_Oh,1);
                %CalTloc
                Ho_Oh_x=ceil(zong_ku/2);%basic place
                now_hotier=oooo(sh,5);
                kkk=floor(kudu(now_hotier,1)/2);
                Ho_Oh_x=Ho_Oh_x+kkk;
                now_sjd=oooo(sh,6);
                
                htou=now_hotier-1;
                for sek=1:now_hotier-1
                    HoOh=floor(kudu(htou,1)/2);
                    if now_sjd~=0
                        [Ho,buyong]=find(oooo(:,3:4)==now_sjd);
                        Oh=find(oooo(Ho,:)==now_sjd);
                    else
                        Oh=4;
                    end
                    
                    if Oh==3
                        Ho_Oh_x=Ho_Oh_x-HoOh;
                    else
                        Ho_Oh_x=Ho_Oh_x+HoOh;
                    end
                    if htou~=1
                        htou=htou-1;
                        now_sjd=need_sd(Ho);
                    end
                end
                HoOh_zuobiao=Ho_Oh_x;
                
                
                wzjl(zy,1)=HoOh_zuobiao;
                zy=zy+1;
                %testend????????????????????????????????????????????????????????????????????
                
                
            end
        end
    end
        wzjl_id=find(wzjl~=0);
        wzjl=wzjl(wzjl_id);
        zuobianbian=min(min(wzjl));
        youbianbian=max(max(wzjl));
        yuanxianku=youbianbian-zuobianbian+1;
        biaozhunku=8;
        blku=biaozhunku/yuanxianku;

    
    arrowy=1;
    %VC GOLD PLUS1 part--------------------------------------------------------
    
    if oooo(2,6)==0&&oooo(1,2)==0
        
        now_id=lineage_i_cell_id(1);
        now_t=lineage_i_t(1);
        Zx=1*blku/2;
        zong_ku=1*blku;
        %test red????????????????????????????????????????????????????????????????????????????
        last_1_t=now_t;
        now_1_time=lineage_i_t(end);
        shangyidai=now_id;
        NEED_DAXIAO=10; 
       
        for VC=last_1_t:now_1_time
            zheyidaiweizhi=find(lineage_i_cell_id==shangyidai);
            
            now_itst=lineage_i_uniform_intensity(zheyidaiweizhi,1);
            xiayidaiweizhi=find(lineage_i_parent_cell_id==shangyidai);
            xiayidai=lineage_i_cell_id(xiayidaiweizhi,1);
            next_itst=uniform_intensity(xiayidaiweizhi,1);
            
            now_weizhi=find(manual_correction(:,1)==shangyidai);
            neiwai=manual_correction(now_weizhi,2);
           
            %scatter(arrowj+Zx,VC,NEED_DAXIAO,now_itst,'filled');
            %hold on
                line([arrowj+Zx,arrowj+Zx],[VC,VC+1],'color',[0 .2 1]);
                hold on
                if VC==now_1_time
                    if isempty(neiwai)
                    else
                        if neiwai==1
                            plot(arrowj+Zx,VC+1,'xb','LineWidth',1);
                        elseif neiwai==2
                            plot(arrowj+Zx,VC+1,'ob','LineWidth',1);
                            hold on
                        end
                    end
                else
                    scatter(arrowj+Zx,VC,NEED_DAXIAO,now_itst,'filled');
                    hold on
                    scatter(arrowj+Zx,VC+1,NEED_DAXIAO,next_itst,'filled');
                    hold on
                    
                end
            
            shangyidai=xiayidai;
           
        end
        
        
        %test end????????????????????????????????????????????????????????????????????????????
    else
        zy=1;
        shinnypart=max(oooo(:,5));
        D_kuandu=3;
        D_space=1;
        kudu=zeros(30,2);
        ssm=shinnypart-1;
        kudu(shinnypart,1)=3;
        kudu(1,2)=1;
        
        for sm=1:shinnypart-1
            kudu(ssm,1)=kudu(ssm+1,1)*2-1;
            kudu(sm+1,2)=2^sm;
            ssm=ssm-1;
        end
        
        zong_ku=kudu(shinnypart,1)*kudu(shinnypart,2)+kudu(shinnypart,2)+1;
        Zx=(ceil(zong_ku/2)-zuobianbian)*blku+1;
        
        
        wo_start_id=find(lineage_i_t==t_start);
        wo_jieduanfinal_id=find(lineage_i_t==oooo(1,1)-1);
        
        NEED_DAXIAO=10; 
        %% 
        start_itst=lineage_i_uniform_intensity(wo_start_id,1);
        jieduan_final_itst=uniform_intensity(wo_jieduanfinal_id,1);
        
        
        
        scatter(arrowj+Zx,t_start,NEED_DAXIAO,start_itst,'filled');
        hold on
        
        scatter(arrowj+Zx,oooo(1,1)-1,NEED_DAXIAO,jieduan_final_itst,'filled');
        hold on
        
        %test red????????????????????????????????????????????????????????????????????????????
        last_1_t=t_start;
        now_1_time=oooo(1,1);
        shangyidai=lineage_i_cell_id(1,1);
        
        for VC=last_1_t:now_1_time-1
            xiayidaixuhao=find(lineage_i_parent_cell_id==shangyidai);
            xiayidai=lineage_i_cell_id(xiayidaixuhao,1);
            wo_itst=lineage_i_uniform_intensity(xiayidaixuhao,1);
            
            
                line([arrowj+Zx,arrowj+Zx],[VC,VC+1],'color',[0 .2 1]);
                hold on
                if VC==now_1_time-1
                    
                else
                    
                    scatter(arrowj+Zx,VC+1,NEED_DAXIAO,wo_itst,'filled');
                    hold on
                end
            
            shangyidai=xiayidai;
           
        end
        
        %test end????????????????????????????????????????????????????????????????????????????
        
        plot(arrowj+Zx+(floor(kudu(1,1)/2))*blku,oooo(1,1),'.b','LineWidth',1);
        plot(arrowj+Zx-(floor(kudu(1,1)/2))*blku,oooo(1,1),'.b','LineWidth',1);
        hold on
        line([arrowj+Zx+(floor(kudu(1,1)/2))*blku,arrowj+Zx-(floor(kudu(1,1)/2))*blku],[oooo(1,1),oooo(1,1)],'color',[.5 .5 .5]);
        
        
        need_tier=oooo(:,5);
        need_sd=oooo(:,6);
        need_p=oooo(:,2);
        need_o_t=oooo(:,1);
        need_s_s=oooo(:,3);
        need_s_b=oooo(:,4);
        IO=1;
        now_right=arrowj+Zx+(floor(kudu(1,1)/2))*blku;
        now_left=arrowj+Zx-(floor(kudu(1,1)/2))*blku;
        %last_right=
        %last_left=
        
        for xunhuan=2:shinnypart
            need_xunhuan=find(need_tier==xunhuan);
            richuri=length(need_xunhuan);
            for pikapika=1:richuri
                
                hua1=need_xunhuan(pikapika);
                    
                    
                
                now_tier=need_tier(hua1);
                now_sd=need_sd(hua1);
                now_p=need_p(hua1);
                now_t=need_o_t(hua1);
                now_s_s=need_s_s(hua1);
                now_s_b=need_s_b(hua1);
                
                
                
                
                
                %seek now_left and now right
                x=(ceil(zong_ku/2)-zuobianbian)*blku;%basic value
                kou=now_tier;
                now_ssd=now_sd;
                for sek=1:now_tier-1
                    beijianjia=(floor(kudu(kou-1,1)/2))*blku;
                    [sgs,buyong]=find(oooo(:,3:4)==now_ssd);
                    kyk=find(oooo(sgs,:)==now_ssd);
                    if kyk==3
                        x=x-beijianjia;
                    else
                        x=x+beijianjia;
                    end
                    kou=kou-1;
                    now_ssd=need_sd(sgs);
                end
                now_zuobiao=x+1;
                
                
                
                [kelahang,liejiaer]=find(oooo(:,3:4)==now_sd);
                last_time=need_o_t(kelahang);
                
               
                plot(arrowj+now_zuobiao,now_t-1,'.b','LineWidth',1);
                hold on
                
                %test red stick????????????????????????????????????????????????????????????
                last_2_t=last_time;
                now_2_time=now_t;
                shangyidai=now_sd;
                zhongzhuanxiaowangzi=find(lineage_i_cell_id==shangyidai);
                
                wo_difang=find(lineage_i_cell_id==shangyidai);
                wo_itst=lineage_i_uniform_intensity(wo_difang,1);
                scatter(arrowj+now_zuobiao,last_2_t,NEED_DAXIAO,wo_itst,'filled');
                hold on
                
                for VC=last_2_t:now_2_time-1
                    xiayidaixuhao=find(lineage_i_parent_cell_id==shangyidai);
                    xiayidai=lineage_i_cell_id(xiayidaixuhao);
                    wo_itst=lineage_i_uniform_intensity(xiayidaixuhao);
                    
                    
                    line([arrowj+now_zuobiao,arrowj+now_zuobiao],[VC,VC+1],'color',[0 .2 1]);
                    hold on
                    if VC==now_2_time-1
                        
                    else
                        
                        scatter(arrowj+now_zuobiao,VC+1,NEED_DAXIAO,wo_itst,'filled');
                        hold on
                    end
                    
                    shangyidai=xiayidai;
                    
                end
                %%
                
                %testend????????????????????????????????????????????????????????????????????
                
                
                
                plot(arrowj+now_zuobiao-(floor(kudu(xunhuan,1)/2))*blku,now_t,'.b','LineWidth',1);
                hold on
                plot(arrowj+now_zuobiao+(floor(kudu(xunhuan,1)/2))*blku,now_t,'.b','LineWidth',1);
                hold on
                line([arrowj+now_zuobiao-(floor(kudu(xunhuan,1)/2))*blku,arrowj+now_zuobiao+(floor(kudu(xunhuan,1)/2))*blku],[now_t,now_t],'color',[.5 .5 .5]);
                hold on
            end
        end
        
  %%      
        %HeartGold part
        wakaba=find(oooo(:,1)~=0);
        town=max(max(wakaba));
        for sh=1:town
            now_shq=oooo(sh,3);
            now_shh=oooo(sh,4);
            now_sht=oooo(sh,1);
            
            [pikachu,buyong]=find(oooo(:,6)==now_shq);
            [raichu,buyong]=find(oooo(:,6)==now_shh);
            if isempty(pikachu)
                %CalTLasT
                startp=now_shq;%???Z?@??_?l??Mid?X?Xnow_shq
                i_u=1;
                while (i_u>0)
                    nowshunxu=find(lineage_i_parent_cell_id==startp);
                    if isempty(nowshunxu)
                        break
                    end
                    nownowid=lineage_i_cell_id(nowshunxu,1);
                    startp=nownowid;
                end
                Ho_Oh=find(lineage_i_cell_id==startp);%startp?X?X???Z?@???Mid
                Ho_Oh_t=lineage_i_t(Ho_Oh,1);%?X?X???Z?@????
                %CalTloc
                Ho_Oh_x=(ceil(zong_ku/2)-zuobianbian)*blku;%basic place
                
                now_hotier=oooo(sh,5);
                now_sjd=oooo(sh,6);
                zailai=now_sjd;
                kkk=(floor(kudu(now_hotier,1)/2))*blku;
                Ho_Oh_x=Ho_Oh_x-kkk;
                htou=now_hotier-1;
                for sek=1:now_hotier-1
                    HoOh=(floor(kudu(htou,1)/2))*blku;
                    if now_sjd~=0
                        [Ho,buyong]=find(oooo(:,3:4)==now_sjd);
                        Oh=find(oooo(Ho,:)==now_sjd);
                    else
                        Oh=3;
                    end
                    
                    if Oh==3
                        Ho_Oh_x=Ho_Oh_x-HoOh;
                    else
                        Ho_Oh_x=Ho_Oh_x+HoOh;
                    end
                    if htou~=1
                        htou=htou-1;
                        now_sjd=need_sd(Ho);
                    end
                end
                HoOh_zuobiao=Ho_Oh_x+1;
                
                now_weizhi=find(manual_correction(:,1)==startp);
                neiwai=manual_correction(now_weizhi,2);
                if neiwai==1
                    plot(arrowj+HoOh_zuobiao,Ho_Oh_t,'xb','LineWidth',1);
                elseif neiwai==2
                    plot(arrowj+HoOh_zuobiao,Ho_Oh_t,'ob','LineWidth',1);
                    hold on
                end
                
                %testred????????????????????????????????????????????????????????????????????
                last_2_t=now_sht;
                now_2_time=Ho_Oh_t;
                
                shangyidai=now_shq;
                zhongzhuanxiaowangzi=find(lineage_i_cell_id==shangyidai);
                
                
                wo_difang=find(lineage_i_cell_id==shangyidai);
                wo_itst=lineage_i_uniform_intensity(wo_difang,1);
                scatter(arrowj+HoOh_zuobiao,last_2_t,NEED_DAXIAO,wo_itst,'filled');
                hold on
                
                VC=last_2_t+1;
                
                while (i_u>0)
                   
                    xiayidaixuhao=find(lineage_i_parent_cell_id==shangyidai);
                     if isempty(xiayidaixuhao)
                        break
                    end
                    zheyidaixuhao=find(lineage_i_cell_id==shangyidai);
                    xiayidai=lineage_i_cell_id(xiayidaixuhao,1);
                    wo_itst=lineage_i_uniform_intensity(xiayidaixuhao,1);
                    
                    xiayidai_tp=lineage_i_t(xiayidaixuhao,1);
                    zheyidai_tp=lineage_i_t(zheyidaixuhao,1);
                    dff_tp =xiayidai_tp-zheyidai_tp;
                    VCD=VC+dff_tp;
                    
                    
                    if isempty(wo_itst)
                        wo_itst=0.01;
                    end
                    
                    line([arrowj+HoOh_zuobiao,arrowj+HoOh_zuobiao],[VC,VCD],'color',[0 .2 1]);
                    hold on
                    
                    scatter(arrowj+HoOh_zuobiao,VCD,NEED_DAXIAO,wo_itst,'filled');
                    hold on
                    
                    shangyidai=xiayidai;
                    VC=VCD;
                    
                end
               
                %testend????????????????????????????????????????????????????????????????????
                
                
                
            end
            if isempty(raichu)
                %CalTLasT
                startp=now_shh;
                i_u=1;
                while (i_u>0)
                    nowshunxu=find(lineage_i_parent_cell_id==startp);
                    if isempty(nowshunxu)
                        break
                    end
                    nownowid=lineage_i_cell_id(nowshunxu);
                    startp=nownowid;
                end
                Ho_Oh=find(lineage_i_cell_id==startp);
                Ho_Oh_t=lineage_i_t(Ho_Oh,1);
                %CalTloc
                Ho_Oh_x=(ceil(zong_ku/2)-zuobianbian)*blku;%basic place
                now_hotier=oooo(sh,5);
                kkk=(floor(kudu(now_hotier,1)/2))*blku;
                Ho_Oh_x=Ho_Oh_x+kkk;
                now_sjd=oooo(sh,6);
                
                htou=now_hotier-1;
                for sek=1:now_hotier-1
                    HoOh=(floor(kudu(htou,1)/2))*blku;
                    if now_sjd~=0
                        [Ho,buyong]=find(oooo(:,3:4)==now_sjd);
                        Oh=find(oooo(Ho,:)==now_sjd);
                    else
                        Oh=4;
                    end
                    
                    if Oh==3
                        Ho_Oh_x=Ho_Oh_x-HoOh;
                    else
                        Ho_Oh_x=Ho_Oh_x+HoOh;
                    end
                    if htou~=1
                        htou=htou-1;
                        now_sjd=need_sd(Ho);
                    end
                end
                HoOh_zuobiao=Ho_Oh_x+1;
                
              
                
                now_weizhi=find(manual_correction(:,1)==startp);
                neiwai=manual_correction(now_weizhi,2);
                if neiwai==1
                    plot(arrowj+HoOh_zuobiao,Ho_Oh_t,'xb','LineWidth',1);
                elseif neiwai==2
                    plot(arrowj+HoOh_zuobiao,Ho_Oh_t,'ob','LineWidth',1);
                    hold on
                end
                
                %testred????????????????????????????????????????????????????????????????????
                last_2_t=now_sht+1;
                now_2_time=Ho_Oh_t;
                
                shangyidai=now_shh;
                zhongzhuanxiaowangzi=find(lineage_i_cell_id==shangyidai);
                
              
                
                wo_difang=find(lineage_i_cell_id==shangyidai);
                wo_itst=lineage_i_uniform_intensity(wo_difang,1);
                scatter(arrowj+HoOh_zuobiao,last_2_t,NEED_DAXIAO,wo_itst,'filled');
                hold on
                
                 VC=last_2_t+1;
                
                while (i_u>0)
                   
                    xiayidaixuhao=find(lineage_i_parent_cell_id==shangyidai);
                     if isempty(xiayidaixuhao)
                        break
                    end
                    zheyidaixuhao=find(lineage_i_cell_id==shangyidai);
                    xiayidai=lineage_i_cell_id(xiayidaixuhao,1);
                    wo_itst=lineage_i_uniform_intensity(xiayidaixuhao,1);
                    
                    xiayidai_tp=lineage_i_t(xiayidaixuhao,1);
                    zheyidai_tp=lineage_i_t(zheyidaixuhao,1);
                    dff_tp =xiayidai_tp-zheyidai_tp;
                    VCD=VC+dff_tp;
                    
                    
                    if isempty(wo_itst)
                        wo_itst=0.01;
                    end
                    
                    line([arrowj+HoOh_zuobiao,arrowj+HoOh_zuobiao],[VC,VCD],'color',[0 .2 1]);
                    hold on
                    
                    scatter(arrowj+HoOh_zuobiao,VCD,NEED_DAXIAO,wo_itst,'filled');
                    hold on
                    
                    shangyidai=xiayidai;
                    VC=VCD;
                    
                end
                
                %testend????????????????????????????????????????????????????????????????????
                
                
            end
        end
    end
    
    arrowj=arrowj+10;
    set(gca,'YDir','reverse');
    set(gca,'yLim',[0 460]);
    set(gca,'xLim',[0 arrowj]);
    set (gcf,'Position',[600,800,y,600]);
    %set(gca,'xtick',[]);
    %set(gca,'ytick',[]);
    line([arrowj,arrowj],[0,638],'LineWidth',1,'LineStyle','--');
   
end
