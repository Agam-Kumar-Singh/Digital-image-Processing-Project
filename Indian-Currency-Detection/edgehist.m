function edhist= edgehist(rgb_im)

%graphical representation of points in given ranges
%edge directional histogram
%Input image should be a rgb image,
%a 1x5 edge orientation histogram is computed (horizontal, vertical,
% 2 diagonals and 1 non-directional)


%convert rgb color space into ycbcr colorspace
%ycbcr for luminance
new_im=rgb2ycbcr(rgb_im);

% define the filters for the 5 types of edges
f1 = zeros(3,3,5);
f1(:,:,1) = [1 2 1;0 0 0;-1 -2 -1]; %vertical
f1(:,:,2) = [-1 0 1;-2 0 2;-1 0 1];   %horizontal
f1(:,:,3) = [2 2 -1;2 -1 -1; -1 -1 -1];% 45 diagonal
f1(:,:,4) = [-1 2 2; -1 -1 2; -1 -1 -1];%135 diagonal
f1(:,:,5) = [-1 0 1;0 0 0;1 0 -1]; % non directional

%extract only y component
y=double(new_im(:,:,1));

% iterate over the posible directions
for i = 1:5
% apply the sobel mask
g_im(:,:,i) = filter2(f1(:,:,i),y);
end
% calculate the max sobel gradient and index  of the orientation
% to find the approximate absolute gradient magnitude at each point in an input grayscale image
[m, p] = max(g_im,[],3);

%detect the edges using canny
%to detect a wide range of edges in images.
edim = edge(y, 'canny');

%figure,imshow(edim,'initialmagnification','fit');
%multiply edge image with the types of orientations detected
% by the Sobel masks
im2 =(p.*edim);

%find histogram
edhist=hist(im2(:),5)';

end








