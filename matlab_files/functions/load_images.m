function [imagePoints_,worldPoints]=load_images(imageFolder,squareSize,board_size,show_image)
imds = imageDatastore(imageFolder);
image_num = size(imds.Files,1);
imagePoints_=zeros(board_size(1)*board_size(2),2,image_num);
for i = 1:1:image_num
    I = imread(imds.Files{i});
    [imagePoints,boardSize] = detectCheckerboardPoints(I);
    boardSize
    if boardSize(1)~=board_size(1)+1 || boardSize(2)~=board_size(2)+1 
        disp(string(imds.Files{i})+"  this image has not correct bordsize")
        filename = char(imds.Files{i})
        filename = filename(end-5:end-3)
        delete(imds.Files{i});
        delete("./Poses/"+filename+"txt");

        continue;
    end
    worldPoints = generateCheckerboardPoints(boardSize, squareSize);
    imagePoints_(:,:,i)=imagePoints;
    if show_image==1
        fig =figure(i);
        imshow(I)
        hold on;
        plot(imagePoints(:,1),imagePoints(:,2),'ro');
        hold off;
        saveas(fig,string(i-1)+"_imagepoints.png")
        pause(0.5)
    end
end


end