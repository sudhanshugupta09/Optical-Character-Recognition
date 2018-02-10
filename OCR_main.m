global I L HU H_index H_temp hcount htest H_dist s
pause on

[I.image map] =imread('ocr.png');
figure,imshow(I.image);
title('Original Image');
pause
    %if size(I.image,3)==3
        I.image=rgb2gray(I.image);
        figure,imshow(I.image);
        title('Grayscale image');
        pause
    %end
%end
%level=graythresh(I.image);
I.bin=~im2bw(I.image,graythresh(I.image));
%I.bin=bwmorph(I.bin,'erode');
I.bin=medfilt2(I.bin,[3 3]);
figure,imshow(I.bin);
title('Binary Image with noise removed');
pause
[L num]=bwlabel(I.bin);
I.totalchar=num;
fprintf('%d Objects have been detected \n \n' ,I.totalchar);
pause
S=regionprops(L,'Area');
I.bin2=ismember(L,find([S.Area]>15));
[L num]=bwlabel(I.bin2);
fprintf('%d Objects having greater than 15 pixels been detected \n \n' ,num);
pause
figure,imshow(I.bin2);
title('Binary Image with objects having less than 15 pixels removed');
%pause
%load('Training','hcount','HU','H_index');
prop=regionprops(L,'BoundingBox');
for n=1:size(prop,1)
    rectangle('Position',prop(n).BoundingBox,'EdgeColor','b','LineWidth',2)
end
fprintf(' Enter your choice: \n 1.Training \n 2.Recognition\n ---> ');
Ch=input('');
%hcount=0;
%save('Training','hcount','HU','H_index');
load('Training','hcount','HU','H_index');
if(Ch==1)
    re=I.bin2;
    while 1
    [fl re]=segmentlines(re);
    imgn=fl;
    figure,imshow(fl);pause(0.5)    
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
        [r c]=find(L==n);
        n1=imgn(min(r):max(r),min(c):max(c));
        imshow(~n1);
        hcount=hcount+1;
        HU(hcount,:) = humoment(n1);
        user_input=input('\n\nEnter Character --> ','s');
        H_index(hcount) = user_input;
        save('Training','hcount','HU','H_index');
        fprintf(' \nThe character has been stored successfully ..!!\n');
        pause(0.5);
    end
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
    end
elseif(Ch==2)
    re=I.bin2;
    while 1
    [fl re]=segmentlines(re);
    imgn=fl;
    figure,imshow(fl);pause(0.5)    
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
            [r c]=find(L==n);
            n1=imgn(min(r):max(r),min(c):max(c));
            imshow(~n1);
            pause(0.5);
            H_temp=humoment(n1);
            [b c]=size(HU);
            for i=1:b
                H_dist(i)=edist(H_temp,HU(i,:));
            end
            mt=min(H_dist);
            [~, t]=size(H_dist);
            for j=1:t
                if H_dist(j)==mt
                htest=j;
                end
            end
          s=char(H_index(htest));     
         fprintf('The recognized character number %d is %c: \n',n,s);
         pause(1);
     end
         %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
    end
   
else
    disp('Invalid Choice');
end
close all

