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