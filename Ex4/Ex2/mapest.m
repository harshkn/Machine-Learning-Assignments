clear all
%% Reading x and y 
y = dlmread('y.txt');
xgt = dlmread('x_gt.txt');
%% Show Images
%imshowpair(xgt,y,'montage'); 

h = 0.8;
beta = 1.2;
eta = 2.1;
%% ICM 
Ed = getEdges(y);
x = y;
lvalt = 1000;
fprintf('h = %f   beta = %f    eta = %f \n', h, beta, eta);
for icmi = 1 : 1000
    imshowpair(x, xgt, 'montage');
    for iter = 1: numel(y)
        % replacing each pixel with 1 and -1  
        x(iter) = 1;
        un = findunary(x);
        smprior = findpairwise(x, Ed);
        pairpotential = findimpairsum(x, y);
        E1 = h * un - beta * smprior - eta * pairpotential;

        x(iter) = -1;
        un = findunary(x);
        smprior = findpairwise(x, Ed);
        pairpotential = findimpairsum(x, y);
        E2 = h * un - beta * smprior - eta * pairpotential;

        if(E1 < E2)
            x(iter) = 1;
            E = E1;
        else
            E = E2;
        end
        
        %fprintf('Energy = %d \n', E);
        %fprintf('loss value = %d \n', lval(iter));
        %imshow(x)
    end
    
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





