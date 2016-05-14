clear all
%% Reading x and y 
y = dlmread('y.txt');
xgt = dlmread('x_gt.txt');
%% Show Images
%imshowpair(xgt,y,'montage'); 

h = 0;
beta = 0.8;
eta = 0.4;
%% ICM 
Ed = getEdges(y);
x = y;
lvalt = 1000;
fprintf('h = %f   beta = %f    eta = %f \n', h, beta, eta);
for icmi = 1 : 1000 
    for iter = 1: numel(y)
        % replacing each pixel with 1 and -1  
        ival = gibbsSampler(numel(x));
        x(ival) = 1;
        un = findunary(x);
        smprior = findpairwise(x, Ed);
        pairpotential = findimpairsum(x, y);
        E1 = h * un - beta * smprior - eta * pairpotential;

        x(ival) = -1;
        un = findunary(x);
        smprior = findpairwise(x, Ed);
        pairpotential = findimpairsum(x, y);
        E2 = h * un - beta * smprior - eta * pairpotential;

        if(E1 < E2)
            x(ival) = 1;
            E = E1;
        else
            E = E2;
        end

        %fprintf('Energy = %d \n', E);
        %fprintf('loss value = %d \n', lval(iter));
        %imshow(x)
    end
    imshowpair(x, xgt, 'montage');
    lval = lossfn(xgt, x);
    fprintf('loss value = %f \n', lval);
    if(lvalt < lval)
        x = xtemp;
        disp('End')
        break;
    else
        xtemp = x;
        lvalt = lval;
    end
end





