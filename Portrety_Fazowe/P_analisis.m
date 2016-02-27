function P_analisis(P,varargin)
%% P_analisis - shows how P transforms cartesian plane  
if nargin == 3
    fig1 = varargin{1};
    fig2 = varargin{2};
else
    fig1 = 1;
    fig2 = 2;
end
% P = [1 -5; 1 1]/sqrt(2);
p = -1;
k = 1;
wek = p:0.2:k;

for w = wek
    A1 = [w w; p k];
    A2 = [p k; w w];
    figure(fig1)
    plot([w,w],[p,k],'b',[p,k],[w,w],'r')
    hold on
    figure(fig2)
    PA1 = P*A1;
    PA2 = P*A2;
    plot(PA1(1,:),PA1(2,:),'b',PA2(1,:),PA2(2,:),'r')
    hold on
end
figure(fig1)
hold off
axis equal
title('Siatka układu kartezjańskiego')
figure(fig2)
hold off
axis equal
title(['Siatka układu wejściewego\newline','po przekształceniu płaszczyzny'])