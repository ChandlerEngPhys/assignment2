%% Beginning of Assignment 2
clear
close all

nx = 30;
ny = 20;
x = linspace(0,1,nx*ny);
G = zeros(nx*ny , nx*ny);
B = zeros(1,nx*ny);
cMap = zeros(nx, ny);

Lb = 5;
Wb = 5;
    for i = 1:nx
        for j = 1:ny
            cMap(i, j) = 1;
            if i >= (nx/2 - Lb) && i <= (nx/2 + Lb) && (j >= (ny/2 + Wb) || j <= (ny/2 - Wb))
                cMap(i, j)= 1e-2;
            end
        end
    end
for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        
        if i == 1
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 1;%Set boundary conditions 1
        elseif i == nx
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 1;%Set boundary conditions 2
        elseif j == 1
            nxm = j + (i - 2) * ny;
            nxp = j + (i) * ny;
            nyp = j + 1 + (i - 1) * ny;

            
            rxm = (cMap(i, j) + cMap(i - 1, j)) / 2.0;
            rxp = (cMap(i, j) + cMap(i + 1, j)) / 2.0;
            ryp = (cMap(i, j) + cMap(i, j + 1)) / 2.0;
            
            G(n, n) = -4;
            G(n, nxm) = rxm;
            G(n, nxp) = rxp;
            G(n, nyp) = ryp;

        elseif j ==  ny
            nxm = j + (i - 2) * ny;
            nxp = j + (i) * ny;
            nym = j - 1 + (i - 1) * ny;
            
            rxm = (cMap(i, j) + cMap(i - 1, j)) / 2.0;
            rxp = (cMap(i, j) + cMap(i + 1, j)) / 2.0;
            rym = (cMap(i, j) + cMap(i, j - 1)) / 2.0;

            G(n, n) = -4;
            G(n, nxm) = rxm;
            G(n, nxp) = rxp;
            G(n, nym) = rym;
        else
            nxm = j+ (i-2)*ny;
            nxp = j+ (i)*ny;
            nym = j-1 + (i-1)*ny;
            nyp = j+1 + (i-1)*ny;
            
            
            rxm = (cMap(i,j) + cMap(i-1,j))/2.0;
            rxp = (cMap(i,j) + cMap(i+1,j))/2.0;
            rym = (cMap(i,j) + cMap(i,j-1))/2.0;
            ryp = (cMap(i,j) + cMap(i,j+1))/2.0;
            
            G(n,n) = -(rxm+rxp+rym+ryp);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
            G(n,nyp) = ryp;
        end
    end
end

figure;
spy(G)
V = G\B';

Vmap = zeros(nx,ny);
for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;

        Vmap(i, j) = V(n);
    end
end
figure;
surf(Vmap);

% [E,D] = eigs(G,9,'SM');
% d = diag(D);
% figure;
% plot(1:9,d,'x')
% 
% eMatrix = zeros(nx,ny);
% f = E(:,1);
% 
% eMatrix1 = reshape(E(:,1),[nx,ny])*d(1);
% eMatrix2 = reshape(E(:,2),[nx,ny])*d(2);
% eMatrix3 = reshape(E(:,3),[nx,ny])*d(3);
% eMatrix4 = reshape(E(:,4),[nx,ny])*d(4);
% eMatrix5 = reshape(E(:,5),[nx,ny])*d(5);
% eMatrix6 = reshape(E(:,6),[nx,ny])*d(6);
% eMatrix7 = reshape(E(:,7),[nx,ny])*d(7);
% eMatrix8 = reshape(E(:,8),[nx,ny])*d(8);
% eMatrix9 = reshape(E(:,9),[nx,ny])*d(9);
% 
% figure;
% subplot(3,3,1)
% surf(eMatrix1)
% subplot(3,3,2)
% surf(eMatrix2)
% subplot(3,3,3)
% surf(eMatrix3)
% subplot(3,3,4)
% surf(eMatrix4)
% subplot(3,3,5)
% surf(eMatrix5)
% subplot(3,3,6)
% surf(eMatrix6)
% subplot(3,3,7)
% surf(eMatrix7)
% subplot(3,3,8)
% surf(eMatrix8)
% subplot(3,3,9)
% surf(eMatrix9)


figure;
L = nx;
W = ny;
VanalyticalNew = zeros(L+1,W+1);
VanalyticalSum = zeros(L+1,W+1);
for n = 1:2:100
    for x = 1:(L+1)
        for y = 1:(W+1)
                p = x - L/2 - 1;
                q = y -1;
                VanalyticalNew(x,y) = 4/pi*(1/n)*(cosh((n*pi*p)/(W))/cosh((n*pi*(L)/2)/(W)))*sin((n*pi*q)/(W));
        end
    end
    VanalyticalSum = (VanalyticalSum + VanalyticalNew);
    surf(VanalyticalSum);
    %pause(0.5)
end
            
% [ex,ey]=gradient(V_new);
% figure;
% surf(-ex,-ey);
% figure;
% quiver(-ex,-ey);