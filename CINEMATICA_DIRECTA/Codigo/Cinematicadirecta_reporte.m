clear all; close all; clc;

% Parámetros del robot
r = 0.08; L = 0.35; T = 20; dt = 0.02;
t = 0:dt:T;

% Caso 1: thetaD=10, thetaI=10
x(1)=0; y(1)=0; theta(1)=0;
thetaD=10; thetaI=10;
u=(r/2)*(thetaD+thetaI); w=(r/L)*(thetaD-thetaI);
for k=1:length(t)-1
    x(k+1)=x(k)+u*cos(theta(k))*dt; y(k+1)=y(k)+u*sin(theta(k))*dt; theta(k+1)=theta(k)+w*dt;
end
disp(['Caso 1 -> u=',num2str(u),' m/s, w=',num2str(w),' rad/s, x=',num2str(x(end)),' m, y=',num2str(y(end)),' m, θ=',num2str(theta(end)),' rad'])
figure; plot(x,y,'LineWidth',3); hold on; grid on; axis equal;
plot(x(1),y(1),'go','MarkerFaceColor','g'); % inicio
plot(x(end),y(end),'ro','MarkerFaceColor','r'); % fin
title('Trayectoria Caso 1'); xlabel('X [m]'); ylabel('Y [m]')
X1=x; Y1=y;

%% Caso 2: thetaD=-10, thetaI=-10
x(1)=0; y(1)=0; theta(1)=0;
thetaD=-10; thetaI=-10;
u=(r/2)*(thetaD+thetaI); w=(r/L)*(thetaD-thetaI);
for k=1:length(t)-1
    x(k+1)=x(k)+u*cos(theta(k))*dt; y(k+1)=y(k)+u*sin(theta(k))*dt; theta(k+1)=theta(k)+w*dt;
end
disp(['Caso 2 -> u=',num2str(u),' m/s, w=',num2str(w),' rad/s, x=',num2str(x(end)),' m, y=',num2str(y(end)),' m, θ=',num2str(theta(end)),' rad'])
figure; plot(x,y,'LineWidth',3); hold on; grid on; axis equal;
plot(x(1),y(1),'go','MarkerFaceColor','g'); plot(x(end),y(end),'ro','MarkerFaceColor','r');
title('Trayectoria Caso 2'); xlabel('X [m]'); ylabel('Y [m]')
X2=x; Y2=y;

%% Caso 3: thetaD=12, thetaI=6
x(1)=0; y(1)=0; theta(1)=0;
thetaD=12; thetaI=6;
u=(r/2)*(thetaD+thetaI); w=(r/L)*(thetaD-thetaI);
for k=1:length(t)-1
    x(k+1)=x(k)+u*cos(theta(k))*dt; y(k+1)=y(k)+u*sin(theta(k))*dt; theta(k+1)=theta(k)+w*dt;
end
disp(['Caso 3 -> u=',num2str(u),' m/s, w=',num2str(w),' rad/s, x=',num2str(x(end)),' m, y=',num2str(y(end)),' m, θ=',num2str(theta(end)),' rad'])
figure; plot(x,y,'LineWidth',3); hold on; grid on; axis equal;
plot(x(1),y(1),'go','MarkerFaceColor','g'); plot(x(end),y(end),'ro','MarkerFaceColor','r');
title('Trayectoria Caso 3'); xlabel('X [m]'); ylabel('Y [m]')
X3=x; Y3=y;

%% Caso 4: thetaD=6, thetaI=12
x(1)=0; y(1)=0; theta(1)=0;
thetaD=6; thetaI=12;
u=(r/2)*(thetaD+thetaI); w=(r/L)*(thetaD-thetaI);
for k=1:length(t)-1
    x(k+1)=x(k)+u*cos(theta(k))*dt; y(k+1)=y(k)+u*sin(theta(k))*dt; theta(k+1)=theta(k)+w*dt;
end
disp(['Caso 4 -> u=',num2str(u),' m/s, w=',num2str(w),' rad/s, x=',num2str(x(end)),' m, y=',num2str(y(end)),' m, θ=',num2str(theta(end)),' rad'])
figure; plot(x,y,'LineWidth',3); hold on; grid on; axis equal;
plot(x(1),y(1),'go','MarkerFaceColor','g'); plot(x(end),y(end),'ro','MarkerFaceColor','r');
title('Trayectoria Caso 4'); xlabel('X [m]'); ylabel('Y [m]')
X4=x; Y4=y;

%% Caso 5: thetaD=10, thetaI=-10
x(1)=0; y(1)=0; theta(1)=0;
thetaD=10; thetaI=-10;
u=(r/2)*(thetaD+thetaI); w=(r/L)*(thetaD-thetaI);
for k=1:length(t)-1
    x(k+1)=x(k)+u*cos(theta(k))*dt; y(k+1)=y(k)+u*sin(theta(k))*dt; theta(k+1)=theta(k)+w*dt;
end
disp(['Caso 5 -> u=',num2str(u),' m/s, w=',num2str(w),' rad/s, x=',num2str(x(end)),' m, y=',num2str(y(end)),' m, θ=',num2str(theta(end)),' rad'])
figure; plot(x,y,'LineWidth',3); hold on; grid on; axis equal;
plot(x(1),y(1),'go','MarkerFaceColor','g'); plot(x(end),y(end),'ro','MarkerFaceColor','r');
title('Trayectoria Caso 5'); xlabel('X [m]'); ylabel('Y [m]')
X5=x; Y5=y;

%% Caso 6: thetaD=10, thetaI=0
x(1)=0; y(1)=0; theta(1)=0;
thetaD=10; thetaI=0;
u=(r/2)*(thetaD+thetaI); w=(r/L)*(thetaD-thetaI);
for k=1:length(t)-1
    x(k+1)=x(k)+u*cos(theta(k))*dt; y(k+1)=y(k)+u*sin(theta(k))*dt; theta(k+1)=theta(k)+w*dt;
end
disp(['Caso 6 -> u=',num2str(u),' m/s, w=',num2str(w),' rad/s, x=',num2str(x(end)),' m, y=',num2str(y(end)),' m, θ=',num2str(theta(end)),' rad'])
figure; plot(x,y,'LineWidth',3); hold on; grid on; axis equal;
plot(x(1),y(1),'go','MarkerFaceColor','g'); plot(x(end),y(end),'ro','MarkerFaceColor','r');
title('Trayectoria Caso 6'); xlabel('X [m]'); ylabel('Y [m]')
X6=x; Y6=y;

%% Caso 7: thetaD=10, thetaI=8
x(1)=0; y(1)=0; theta(1)=0;
thetaD=10; thetaI=8;
u=(r/2)*(thetaD+thetaI); w=(r/L)*(thetaD-thetaI);
for k=1:length(t)-1
    x(k+1)=x(k)+u*cos(theta(k))*dt; y(k+1)=y(k)+u*sin(theta(k))*dt; theta(k+1)=theta(k)+w*dt;
end
disp(['Caso 7 -> u=',num2str(u),' m/s, w=',num2str(w),' rad/s, x=',num2str(x(end)),' m, y=',num2str(y(end)),' m, θ=',num2str(theta(end)),' rad'])
figure; plot(x,y,'LineWidth',3); hold on; grid on; axis equal;
plot(x(1),y(1),'go','MarkerFaceColor','g'); plot(x(end),y(end),'ro','MarkerFaceColor','r');
title('Trayectoria Caso 7'); xlabel('X [m]'); ylabel('Y [m]')
X7=x; Y7=y;

%% Caso 8: thetaD=10, thetaI=2
x(1)=0; y(1)=0; theta(1)=0;
thetaD=10; thetaI=2;
u=(r/2)*(thetaD+thetaI); w=(r/L)*(thetaD-thetaI);

for k=1:length(t)-1
    x(k+1)=x(k)+u*cos(theta(k))*dt;
    y(k+1)=y(k)+u*sin(theta(k))*dt;
    theta(k+1)=theta(k)+w*dt;
end

disp(['Caso 8 -> u=',num2str(u),' m/s, w=',num2str(w),' rad/s, x=',num2str(x(end)),' m, y=',num2str(y(end)),' m, θ=',num2str(theta(end)),' rad'])

figure; 
plot(x,y,'LineWidth',3); hold on; grid on; axis equal;
plot(x(1),y(1),'go','MarkerFaceColor','g'); % punto inicial
plot(x(end),y(end),'ro','MarkerFaceColor','r'); % punto final
title('Trayectoria Caso 8'); xlabel('X [m]'); ylabel('Y [m]')

X8=x; Y8=y;
 
%% Comparación de todas las trayectorias
colores = lines(8);
figure(9); % fuerza a que sea la figura número 10
hold on;

plot(X1,Y1,'Color',colores(1,:),'LineWidth',2);
plot(X2,Y2,'Color',colores(2,:),'LineWidth',2);
plot(X3,Y3,'Color',colores(3,:),'LineWidth',2);
plot(X4,Y4,'Color',colores(4,:),'LineWidth',2);
plot(X5,Y5,'Color',colores(5,:),'LineWidth',2);
plot(X6,Y6,'Color',colores(6,:),'LineWidth',2);
plot(X7,Y7,'Color',colores(7,:),'LineWidth',2);
plot(X8,Y8,'Color',colores(8,:),'LineWidth',2);

% puntos iniciales y finales
plot(X1(1),Y1(1),'go','MarkerFaceColor','g'); plot(X1(end),Y1(end),'ro','MarkerFaceColor','r');
plot(X2(1),Y2(1),'go','MarkerFaceColor','g'); plot(X2(end),Y2(end),'ro','MarkerFaceColor','r');
plot(X3(1),Y3(1),'go','MarkerFaceColor','g'); plot(X3(end),Y3(end),'ro','MarkerFaceColor','r');
plot(X4(1),Y4(1),'go','MarkerFaceColor','g'); plot(X4(end),Y4(end),'ro','MarkerFaceColor','r');
plot(X5(1),Y5(1),'go','MarkerFaceColor','g'); plot(X5(end),Y5(end),'ro','MarkerFaceColor','r');
plot(X6(1),Y6(1),'go','MarkerFaceColor','g'); plot(X6(end),Y6(end),'ro','MarkerFaceColor','r');
plot(X7(1),Y7(1),'go','MarkerFaceColor','g'); plot(X7(end),Y7(end),'ro','MarkerFaceColor','r');
plot(X8(1),Y8(1),'go','MarkerFaceColor','g'); plot(X8(end),Y8(end),'ro','MarkerFaceColor','r');

grid on; axis equal;
title('Comparación de Trayectorias - 8 Casos')
xlabel('Posición X [m]'); ylabel('Posición Y [m]')
legend('Caso 1','Caso 2','Caso 3','Caso 4','Caso 5','Caso 6','Caso 7','Caso 8')

%% Animación del Caso 5 en GIF
figure(10)
hold on; grid on; axis equal
xlabel("Posición en X [m]")
ylabel("Posición en Y [m]")
title("Movimiento del Robot Diferencial - Caso 5")
set(gca, 'FontSize', 14);

L_robot = 1.2; W_robot = 0.8;
robot_shape = [L_robot/2, W_robot/2; L_robot/2, -W_robot/2; -L_robot/2, -W_robot/2; -L_robot/2, W_robot/2]';
wheel_L = [-0.3, 0.08; 0.3, 0.08; 0.3, -0.08; -0.3, -0.08]';
wheel_R = wheel_L;
pos_wheel_L = [0; W_robot/2 + 0.08];
pos_wheel_R = [0; -W_robot/2 - 0.08];

for k = 1:20:length(t)
    cla
    plot(X5(1:k),Y5(1:k),'LineWidth',3);
    hold on; grid on; axis equal
    R = [cos(theta(k)) -sin(theta(k)); sin(theta(k)) cos(theta(k))];
    p = [X5(k); Y5(k)];
    robot_global = R*robot_shape + p;
    wheel_L_global = R*(wheel_L + pos_wheel_L) + p;
    wheel_R_global = R*(wheel_R + pos_wheel_R) + p;
    fill(robot_global(1,:), robot_global(2,:), [0.8 0.8 0.8]);
    fill(wheel_L_global(1,:), wheel_L_global(2,:), [0.1 0.1 0.1]);
    fill(wheel_R_global(1,:), wheel_R_global(2,:), [0.1 0.1 0.1]);
    plot(X5(1),Y5(1),'go','MarkerFaceColor','g'); % inicio
    plot(X5(end),Y5(end),'ro','MarkerFaceColor','r'); % fin
    frente = R*[L_robot/2 + 0.5; 0] + p;
    quiver(X5(k),Y5(k),frente(1)-X5(k),frente(2)-Y5(k),'LineWidth',2,'MaxHeadSize',2);
    xlim([min(X5)-2 max(X5)+2]); ylim([min(Y5)-2 max(Y5)+2])
    drawnow;

    % Guardar frames en GIF
    frame = getframe(gcf);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    if k == 1
        imwrite(A,map,'cinematica_directa.gif','gif','LoopCount',Inf,'DelayTime',0.05);
    else
        imwrite(A,map,'cinematica_directa.gif','gif','WriteMode','append','DelayTime',0.05);
    end
end
