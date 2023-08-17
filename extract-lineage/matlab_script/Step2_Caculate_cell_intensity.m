clc
clear all

%%%%%%%%%%%%%%%%%%%%%%%% Input parameters %%%%%%%%%%%%%%%%%%%%%
% Path to .mat file which contains 1. Cell ID; 2. Time point; 3-5. position info; 6.Parent ID
basic_info_path = 'D:\Public\CSC_mechanical_force\extract-lineage\result\basic_info.mat';  

% Path to folder which contains TIFF images
img_path = 'D:\Public\CSC_mechanical_force\extract-lineage\dataset\00_image_after_move_correction\Dataset';

% Output path
output_path = 'D:\Public\CSC_mechanical_force\extract-lineage\result\intensity_info.mat';

%%%%%%%%%%%%%%%%%%%%%%%% Calculate cell intensity %%%%%%%%%%%%%%%%%%%%%
load(basic_info_path);
basic_info(:, 7: 8) = 0;

% Extract cell locations for each time point
cell_id = basic_info(:, 1);
t = basic_info(:, 2);
x = basic_info(:, 3);
y = basic_info(:, 4);
z = basic_info(:, 5);
parent_cell_id = basic_info(:, 6);

% Define a circular mask to extract cell fluorescence brightness. 
r = 5;
[X, Y] = meshgrid(-r: r, -r: r);
circle = X.^2 + Y.^2;
mask = zeros(2*r + 1, 2*r + 1);
mask(circle <= r*r) = 1;
mask(circle > r*r) = 0;

% Caculate the average fluorescence brightness of cell one by one
cell_num = size(cell_id);
for i = 1: cell_num
    col_i = round(x(i));
    row_i = round(y(i));
    slice_i = round(z(i));
    if slice_i <= 0
        slice_i = 1;
    end
    
    col_min = col_i - r;
    col_max = col_i + r;
    row_min = row_i - r;
    row_max = row_i + r;
    
    if col_min <= 0
        col_min = 1;
    end
    if row_min <= 0
        row_min = 1;
    end
    
    img = imread([img_path, '\', num2str(t(i)), '.tif'], slice_i);
    img = double(img);
    [img_height, img_width] = size(img);
    if col_max > img_width
        col_max = img_width;
    end
    if row_max > img_height
        row_max = img_height;
    end 
    
    cell_intensity = img(row_min: row_max, col_min: col_max).* mask(1: row_max - row_min + 1, 1: col_max - col_min + 1);
    scale = sum(sum(cell_intensity~=0));
    
    if scale == 0
        uniform_intensity = 1;
    else
        uniform_intensity = round(sum(sum(cell_intensity)) / scale);
    end
    basic_info(i,7) = uniform_intensity;
    
end

%%%%%%%%%%%%%%%%%%%%%%%% Organize lineage ID information into cell information %%%%%%%%%%%%%%%%%%%%%
basic_info(t == 0, 8) = 1: length(find(t == 0));

for i = length(find(t == 0))+1: cell_num
    if parent_cell_id(i) ~= 0
        basic_info(i,8) = basic_info(cell_id == parent_cell_id(i), 8);
    end
end

save(output_path, 'basic_info');
