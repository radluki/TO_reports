close all;
figure;
hold on;
grid;
A=[-1 0;0 -4];
P = [1 1; 2 8];
det(P);
A=P\A*P;
T=6;
a=0:(pi/10):(2*pi);
X1=[cos(a); sin(a)];
X2=X1./[max(abs(X1));max(abs(X1))];
for k=1:size(X2,2)
    x0=X2(:,k);
    sim('mojmodel',T);
    plot(x(:,1),x(:,2),'k');
end
[w J]=eig(A);
w=w./[max(abs(w));max(abs(w))];
plot(w(1,1)*[-1,1],w(2,1)*[-1,1],'b',...
    w(1,2)*[-1,1],w(2,2)*[-1,1],'b',...
    'LineWidth',2);
title(['lambda (A)= [',num2str(J(1,1)),...
    ', ',num2str(J(2,2)),' ]']);
xlabel('x1');
ylabel('x2');
axis equal;
axis([-1 1 -1 1]);
hold off;
% W sprawozdaniu sformulowanie zadania, cel cwiczenia, portret fazowy z
% opisem Jordan, podobienstwo, przeksztalcony portret, co oznacza ta
% macierz P (obrot, dylatacja).