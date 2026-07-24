clear all;
clc;
close all;

% PROGRAMA QUE CALCULA [x,y,theta] a partir del [u, w]   
% para un ROBOT DIFERENCIAL

% Condiciones iniciales
t(1)= 0;
x(1) = 0; % vector posicion x
y(1) = 0; % vector posicion y
theta(1) = 0; % vector orientacion theta

% PARAMETROS DEL CARRITO DIFERENCIAL (según tu tabla)
r = 0.08;   % radio de rueda [m]
L = 0.35;   % distancia entre ruedas [m]
ts = 20;    % tiempo de simulacion [s]
ti = 0.02;  % paso de integracion [s]

for k=1:ts/ti
    %exterior
    if t(k) < 3
        dot_theta_RD = 15; dot_theta_RI = 15;   % Lado 1
    elseif t(k) < 3.6
        dot_theta_RD = 15; dot_theta_RI = 0;    % Giro izquierda 120°
    elseif t(k) < 6
        dot_theta_RD = 15; dot_theta_RI = 15;   % Lado 2
    elseif t(k) < 6.6
        dot_theta_RD = 15; dot_theta_RI = 0;    % Giro izquierda 120°
    elseif t(k) < 9
        dot_theta_RD = 15; dot_theta_RI = 15;   % Lado 3
    elseif t(k) < 9.6
        dot_theta_RD = 15; dot_theta_RI = 0;    % Giro izquierda 120°

    % Hueco central
    elseif t(k) < 11.1
        dot_theta_RD = 15; dot_theta_RI = 15;   % Avanza mitad
    elseif t(k) < 11.3
        dot_theta_RD = 30; dot_theta_RI = 0;    % Giro
    elseif t(k) < 12.4
        dot_theta_RD = 15; dot_theta_RI = 15;   % Avanza otra mitad
    elseif t(k) < 12.9
        dot_theta_RD = 16;  dot_theta_RI = 0;   % Giro ~135°
    elseif t(k) < 13.9
        dot_theta_RD = 15; dot_theta_RI = 15;   % Avanza mitad siguiente
    elseif t(k) < 14.4
        dot_theta_RD = 18; dot_theta_RI = 0;    % Giro ~135°
    elseif t(k) <= 15.6
        dot_theta_RD = 15; dot_theta_RI = 15;   % Avanza al centro
    else
        dot_theta_RD = 0;  dot_theta_RI = 0;    % Fin
    end

    % Cinemática diferencial
    VRD = dot_theta_RD * r;
    VRI = dot_theta_RI * r;
    u = (VRD + VRI) / 2; % m/s
    w = (VRD - VRI) / L; % rad/s

    % Integración (Euler)
    x(k+1) = x(k) + ti*( u*cos(theta(k) ));
    y(k+1) = y(k) + ti*( u*sin(theta(k) ));
    theta(k+1) = theta(k) + ti*(w) ;
    t(k+1) = t(k) + ti;
end

% --- Trayectoria obtenida en MATLAB ---
figure(1)
plot(x,y,'LineWidth',5); 
hold on
plot(x(1),y(1),'o','MarkerSize',12,'LineWidth',3,'MarkerFaceColor','g');
plot(x(end),y(end),'s','MarkerSize',12,'LineWidth',3,'MarkerFaceColor','r');
xlabel("POSICION EN X [m]")
ylabel("POSICION EN Y [m]")
title("TRAYECTORIA OBTENIDA EN MATLAB")
grid on
axis equal
set(gca, 'FontSize', 23);

% Guardar la imagen final con el nombre solicitado
saveas(gcf,'trayectoria_libre.png');

% --- Animación del robot ---
figure(2)
hold on
grid on
axis equal
xlabel("POSICION EN X [m]")
ylabel("POSICION EN Y [m]")
title("MOVIMIENTO DEL ROBOT DIFERENCIAL")
set(gca, 'FontSize', 18);
plot(x,y,'--','LineWidth',2);

L_robot = 1.2; W_robot = 0.8;
robot_shape = [L_robot/2, W_robot/2; L_robot/2, -W_robot/2; -L_robot/2, -W_robot/2; -L_robot/2, W_robot/2]';
wheel_L = [-0.3, 0.08; 0.3, 0.08; 0.3, -0.08; -0.3, -0.08]';
wheel_R = wheel_L;
pos_wheel_L = [0; W_robot/2 + 0.08];
pos_wheel_R = [0; -W_robot/2 - 0.08];

% Inicializar GIF
filename = 'trayectoria_libre.gif';

for k = 1:20:length(t)
    cla
    plot(x(1:k),y(1:k),'LineWidth',3);
    hold on; grid on; axis equal
    R = [cos(theta(k)) -sin(theta(k)); sin(theta(k)) cos(theta(k))];
    p = [x(k); y(k)];
    robot_global = R*robot_shape + p;
    wheel_L_global = R*(wheel_L + pos_wheel_L) + p;
    wheel_R_global = R*(wheel_R + pos_wheel_R) + p;
    fill(robot_global(1,:), robot_global(2,:), [0.8 0.8 0.8]);
    fill(wheel_L_global(1,:), wheel_L_global(2,:), [0.1 0.1 0.1]);
    fill(wheel_R_global(1,:), wheel_R_global(2,:), [0.1 0.1 0.1]);
    plot(x(k),y(k),'ko','MarkerSize',8,'MarkerFaceColor','k');
    frente = R*[L_robot/2 + 0.5; 0] + p;
    quiver(x(k),y(k),frente(1)-x(k),frente(2)-y(k),'LineWidth',2,'MaxHeadSize',2);
    xlim([min(x)-2 max(x)+2]); ylim([min(y)-2 max(y)+2])
    set(gca, 'FontSize', 18);

    % Capturar cuadro y escribir en GIF
    frame = getframe(gcf);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);

    if k == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.05);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.05);
    end

    pause(0.01)
end
