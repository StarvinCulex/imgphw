# 图像处理作业 1

**姓名**：孟逊

**学号**：3017218132

---



1. >  使用matlab写一个函数 img=generateFigure（imgW,imgH）,其作用为产生一副彩色图像，图像中用红色显示[0，2*pi]的正弦波，用绿色显示[0，2*pi]的余弦波，蓝色显示[0，2*pi]的y=x^2图像。

   函数在 *generateFigure.m* 中

   ```matlab
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
   ```

   执行 `generateFigure(800, 600)` 结果如下

   ![1](F:\documents\MATLAB\1.png)


2. > 不使用for循环，实现bilinear interpolation

   使用了while循环完成（实在不知道怎么不用循环写，我感觉怎么也得循环一遍吧）

   函数在 *biin.m* 中

   ```matlab
   function [dest] = biin(src, z)
       if z > 0
           [src_w, src_h, cs] = size(src);
           dest_h = round(src_h * z);
           dest_w = round(src_w * z);
           dest = uint8(zeros(dest_w, dest_h, cs));
           x = 1;
           while x <= dest_w
               y = 1;
               while y <= dest_h
                   u = x / dest_w * src_w;
                   if u < 1
                       u = 1;
                   end
                   if u > src_w
                       u = src_w;
                   end
                   v = y / dest_h * src_h;
                   if v < 1
                       v = 1;
                   end
                   if v > src_h
                       v = src_h;
                   end
                   fu = floor(u);
                   fv = floor(v);
                   au = u - fu;
                   av = v - fv;
                   am = [(1-au)*(1-av); au*(1-av);
                         (1-au)*av;     au*av];
                   r = 0;
                   if am(1) > 0
                       r = r + am(1) * src(fu, fv, :);
                   end
                   if am(2) > 0
                       r = r + am(2) * src(fu+1, fv, :);
                   end
                   if am(3) > 0
                       r = r + am(3) * src(fu, fv+1, :);
                   end
                   if am(4) > 0
                       r = r + am(4) * src(fu+1, fv+1, :);
                   end
                   dest(x, y, :) = r;
                   y = y + 1;
               end
               x = x + 1;
           end
       end
   end
   ```

   执行 ` imshow(biin(imread("img.jpg"), 2.5)); ` 。

   原图如下：

   ![原图](F:\documents\MATLAB\img.jpg)

结果图如下：

![2](F:\documents\MATLAB\2.png)