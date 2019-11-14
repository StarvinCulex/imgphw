function [img] = generateFigure(width, height)
dom = [0 2*pi];
ran = [-1 1];
img = uint8(zeros(height, width, 3));
for i = 1 : width
    for j = 1 : height
        img(j,i,:) = [255 255 255];
    end
end
coordx = @(x) x / width * (dom(2) - dom(1)) - dom(1);
pixy = @(y) height - (y - ran(1)) / (ran(2) - ran(1)) * (height - 1);
funs = {{(@(x) 0), [0 0 0]} {@sin, [255 0 0]} {@cos, [0 255 0]} {(@(x) x^2), [0 0 255]}
    };
for fun = funs
    lasty = 0;
    for x = 1 : width
        py = round(pixy(fun{1}{1}(coordx(x))));
        if py > 0 && py <= height
            img(py, x, :) = fun{1}{2};
        end
    end
end
imshow(img);
end