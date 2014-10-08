#! /usr/bin/octave

function Usage()
    prog_name=program_name();
    printf('====================================================\n');
    printf('Usage: ./%s [photo_file] [kernel_size]\n',prog_name);
    printf('Eg: ./%s myphoto.png 3\n',prog_name);
    printf('====================================================\n');
    exit;
end

function v=foo(matrix_r,filter)
    v=0;
    tmp=sum(sum(matrix_r.*filter));
    if tmp>255
        tmp=255;
    end
    v=tmp;
end

function [r g b]=RGB(matrix_rgb,filter)
    r=foo(matrix_rgb(:,:,1),filter);
    g=foo(matrix_rgb(:,:,2),filter);
    b=foo(matrix_rgb(:,:,3),filter);
end

argc=nargin;
argv_list=argv();
if argc<2
    Usage();
else
    image_file=argv_list{1};
    % Kernel size
    k=argv_list{2};
end

% Read image data
im=imread(image_file);
[m,n,a]=size(im);
g_im=double(im);

% Show the original image
printf('=============================================\n');
printf('Your original photo:\n');
printf('\nPress any key to continue...\n\n');
imagesc(im);
pause;

% Gaussian Filter
printf('The Gaussian Filter is processing...\n\n');
sigma=1;
w=floor(k/2);
filter=fspecial('gaussian',k,sigma);
for i= w+1:m-w
    for j= w+1:n-w
        [r g b]=RGB( im(i-w:i+w,j-w:j+w,:) , filter );
        g_im(i,j,1)=r;
        g_im(i,j,2)=g;
        g_im(i,j,3)=b;
    end
end

% Show the processed image
printf('The photo after processed:\n');
imagesc(g_im);

% Exit
printf('\nPress any key to quit...\n');
pause;
