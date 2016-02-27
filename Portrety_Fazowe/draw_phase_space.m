function draw_phase_space(A1,varargin)
%% draw_phase_space - rysuje wykres fazowy
% A1 macierz systemu 2x2
% varargin{1} - macierz podobieństwa P (opcjonalna)
% varargin{2:3} - numery figure na których funkcja ma rysować wykresy

if nargin==4
    P = varargin{1};
    fig1 = varargin{2};
    fig2 = varargin{3};
    A2=P\A1*P;
elseif nargin == 2
    P = varargin{1};
    fig1 = 1;
    fig2 = 2;
    A2=P\A1*P;
else
    fig1 = 1;
end

T=0:0.01:6; % czas symulacji
a=0:(pi/10):(2*pi);
X1=[cos(a); sin(a)]; 
% wiersze X1 stanowią punkty startowe i są rozmieszczone na okręgu.
X2=X1./[max(abs(X1));max(abs(X1))];
% X2 to punkty startowe, przeskalowane w ten sposób, że okrąg jednostkowy
% zamieniony został na kwadrat od -1 do 1 na obu osiach
for iter=1:min([nargin, 2])
    if iter == 1
        A=A1;
        figure(fig1)
        hold on;
    else
        A=A2;
        figure(fig2)
        hold on;
    end
    ss1 = ss(A,[0;0],eye(2),[0;0]); % state space system
    for k=1:size(X2,2)
        x0=X2(:,k);
        x = lsim(ss1,T,T,x0);% system,input,time,initial point
        plot(x(:,1),x(:,2),'k');
    end
    [w J]=eig(A); % w - kolumny tej macierzy to wektory własne, J - m. Jordana
    w=w./[max(abs(w));max(abs(w))]; % przeskalowanie (jak wyżej)
    plot(w(1,1)*[-1,1],w(2,1)*[-1,1],'b',...
        w(1,2)*[-1,1],w(2,2)*[-1,1],'b',...
        'LineWidth',2); % wykreślenie asymptot, 
    % tzn. lini odpowiadającym stanom początkowym 
    % będącym wielokrotnościemi wektorów własnych
    string = ['lambda (A)= [',num2str(round(100*J(1,1))/100),...
        ', ',num2str(round(100*J(2,2))/100),' ]'];
    if iter == 1
        title(['A1 - ',string]);
    else
        title(['A2 = inv(P)*A1*P  - ',string]);
    end
    xlabel('x1');
    ylabel('x2');
    axis equal;
    axis([-1 1 -1 1]);
    hold off;
end