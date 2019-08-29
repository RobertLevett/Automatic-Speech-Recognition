function [vec] = logicalImg(InputFile)
%     mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
    R = InputFile(:,:,1);
    G = InputFile(:,:,2);
    B = InputFile(:,:,3);   
        
%     cm = mean(G);

    R(R<128) = 0;
    G(G<85) = 0;
    B(B<50) = 0;
    n = cat(3, R,G,B);
    a = rgb2gray(n);

    gsi = rgb2gray(n);
    J = dct2(gsi);
    J(abs(J)<20) = 0;
    K = idct2(J);
    figure
    imshowpair(gsi,K,'montage')
    
    pause;
    %to smooth the lip area
%     test = imgaussfilt(a,4);
    
%     imshow(test);
%     pause(eps);

%--------------------------------------------------------
% 180/4 = 45 % <-- for splitting image into 4?
% 172/4 = 43 % <-- for splitting image into 4?

    
%     B = a(1:32,1:32);
%     
%     for i = 1: 22
%         for j = 1: 24
%         
%           
%             B = a(((j*8)+1):((j+1)*8), ((i*8)+1):((i+1)*8))
%             
%         
%         end
%     end

%         Temporary = dct2(a);
%         Temporary = flip(Temporary);
%         Temporary = Temporary';
%         Temporary = triu(Temporary);
%         Temporary = Temporary';
%         Temporary = flip(Temporary);
%         Temporary = idct2(Temporary);
%         temp = mean2(Temporary);
%     for i = 1:177
%         for j = 1:199
%             
%         end
%     end
%--------------------------------------------------------

    L = (a>100);
    L2 = imcomplement(L);
    
        

    stats = regionprops(L2,'Area');
    biggest = max([stats.Area]);

    BW2 = bwareafilt(L2,[(biggest-500) (biggest+500)]);
    
    [row, column] = find(BW2);
    
    topLip = max(row);
    bottomLip = min(row);
    
    leftCorn = max(column);
    rightCorn = min(column);
    
    height = topLip - bottomLip;
    width = leftCorn - rightCorn;

    perimeter = bwperim(BW2, 8);
    perimeter = sum(perimeter(:));
    
    vec = [biggest,height,width,perimeter];

    imshow(BW2)
    drawnow;
    pause(eps);
    %     imshow(L2)
%     drawnow;
    
%   Green = G(:,:,2);

%     D = sqrt(double((G - cm).^2));
%     
%     
%     
%     imshow(D < std(D(:)))
end


