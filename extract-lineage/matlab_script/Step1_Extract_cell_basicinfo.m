clc
clear all

%%%%%%%%%%%%%%%%%%%%%%%% Input parameters %%%%%%%%%%%%%%%%%%%%%
% Path to export MaMuT data
path = 'D:\Public\CSC_mechanical_force\extract-lineage\dataset\01_MaMuT\mamut_after_manual_correction.txt';

% Output path
output_path = 'D:\Public\CSC_mechanical_force\extract-lineage\result\basic_info.mat';

%%%%%%%%%%%%%%%%%%%%%%%% Organize cell information %%%%%%%%%%%%%%%%%%%%%
% Load export MaMuT data
export_mamut = importdata(path);
% Locate the range of rows that contain track point information
frame_start_row_index = find(contains(export_mamut,'SpotsInFrame frame')) + 1;
frame_end_row_index = find(contains(export_mamut,'</SpotsInFrame>')) - 1;

% Count the total number of tracking points
spotnum = length(find(contains(export_mamut,'<Spot ID')));

% Pre-allocate memory to variables Basic_info for subsequent storage of cell information
basic_info = zeros(spotnum, 5);

% Find cell information based on parameter name
basic_info_row = 1;
for i = 1:length(frame_start_row_index)
    for j = frame_start_row_index(i):frame_end_row_index(i)
        Spot_ID = regexp(export_mamut{j}, '<Spot ID="\d*\.?\d*', 'match');
        Spot_ID = regexp(Spot_ID, '\d*\.?\d*', 'match');
        basic_info(basic_info_row, 1) = str2double(Spot_ID{1});
        
        Frame = regexp(export_mamut{j}, 'FRAME="\d*\.?\d*', 'match');
        Frame = regexp(Frame, '\d*\.?\d*', 'match');
        basic_info(basic_info_row, 2) = str2double(Frame{1});
        
        x_position = regexp(export_mamut{j}, 'POSITION_X="(-)?\d*\.?\d*', 'match');
        x_position = regexp(x_position, '(-)?\d*\.?\d*', 'match');
        basic_info(basic_info_row, 3) = str2double(x_position{1});
        
        y_position = regexp(export_mamut{j}, 'POSITION_Y="(-)?\d*\.?\d*', 'match');
        y_position = regexp(y_position, '(-)?\d*\.?\d*', 'match');
        basic_info(basic_info_row, 4) = str2double(y_position{1});
        
        z_position = regexp(export_mamut{j}, 'POSITION_Z="(-)?\d*\.?\d*', 'match');
        z_position = regexp(z_position, '(-)?\d*\.?\d*', 'match');
        basic_info(basic_info_row, 5) = str2double(z_position{1});
        
        basic_info_row = basic_info_row + 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%% Organize parent cell ID information %%%%%%%%%%%%%%%%%%%%%
% Count the total number of edges
edgenum = length(find(contains(export_mamut,'Edge SPOT_SOURCE_ID')));
edge_index = find(contains(export_mamut,'Edge SPOT_SOURCE_ID'));
lineage_info = zeros(edgenum, 2);
lineage_info_row = 1;

% Find lineage information based on parameter name
for i = 1:edgenum
    SPOT_SOURCE_ID = regexp(export_mamut{edge_index(i)}, 'SPOT_SOURCE_ID="\d*\.?\d*', 'match');
    SPOT_SOURCE_ID = regexp(SPOT_SOURCE_ID, '\d*\.?\d*', 'match');
    lineage_info(lineage_info_row, 1) = str2double(SPOT_SOURCE_ID{1});
    
    SPOT_TARGET_ID = regexp(export_mamut{edge_index(i)}, 'SPOT_TARGET_ID="\d*\.?\d*', 'match');
    SPOT_TARGET_ID = regexp(SPOT_TARGET_ID, '\d*\.?\d*', 'match');
    lineage_info(lineage_info_row, 2) = str2double(SPOT_TARGET_ID{1});
    lineage_info_row = lineage_info_row + 1;
end

%%%%%%%%%%%%%%%%%%%%%%%% Organize parent cell ID information into cell information %%%%%%%%%%%%%%%%%%%%%
for i = 1:spotnum
    cell_ID = basic_info(i, 1);
    cell_position_in_lineage = find(lineage_info(:,2) == cell_ID);
    if ~isempty(cell_position_in_lineage)
        parent_cell_ID = lineage_info(cell_position_in_lineage,1);
        basic_info(i, 6) = parent_cell_ID;
    end
end

save(output_path, 'basic_info');
