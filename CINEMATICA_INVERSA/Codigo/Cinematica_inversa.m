clear all; close all; clc;
% CINEMATICA INVERSA DE UN ROBOT DIFERENCIAL

% Condiciones iniciales
t(1) = 0; x(1) = 0; y(1) = 0; theta(1) = 0;

% Tiempo de simulacion
ts = 20; ti = 0.02; t = 0:ti:ts;

% Parametros
L = 0.35; r = 0.08;

% Trayectoria deseada (círculo completo)
R = 2; omega_c = 0.25;
T_deseada = 2*pi/omega_c;
t_deseada = 0:ti:T_deseada;
x_deseada = R*cos(omega_c*t_deseada);
y_deseada = R*sin(omega_c*t_deseada);

% Velocidades inerciales
x_punto = -R*omega_c*sin(omega_c*t);
y_punto =  R*omega_c*cos(omega_c*t);
theta_punto = omega_c*ones(size(t));

% Cinemática inversa
for k = 1:length(t)-1
    u(k) = x_punto(k)*cos(theta_punto(k)) + y_punto(k)*sin(theta_punto(k));
    w(k) = theta_punto(k);
    VD(k) = u(k) + (L/2)*w(k);
    VI(k) = u(k) - (L/2)*w(k);
    dot_theta_RD(k) = VD(k)/r;
    dot_theta_RI(k) = VI(k)/r;
    x(k+1) = x(k) + ti*x_punto(k);
    y(k+1) = y(k) + ti*y_punto(k);
    theta(k+1) = theta(k) + ti*theta_punto(k);
end

% Completar vectores
u(end+1) = u(end); 
w(end+1) = w(end);
VD(end+1) = VD(end);
VI(end+1) = VI(end);
dot_theta_RD(end+1) = dot_theta_RD(end);
dot_theta_RI(end+1) = dot_theta_RI(end);

%% Figura 1: Trayectoria deseada
figure(1)
plot(x_deseada,y_deseada,'LineWidth',2);
axis equal; grid on
title("Trayectoria deseada (círculo completo)")
xlabel("$x$ [m]","Interpreter","latex"); ylabel("$y$ [m]","Interpreter","latex");
saveas(gcf,'trayectoria_deseada.png');

%% Figura 2: Trayectoria obtenida
figure(2)
plot(x,y,'LineWidth',2); hold on
plot(x(1),y(1),'go','MarkerSize',8,'MarkerFaceColor','g');
plot(x(end),y(end),'rs','MarkerSize',8,'MarkerFaceColor','r');
axis equal; grid on
title("Trayectoria obtenida en MATLAB (20 s)")
legend("Trayectoria","Inicio","Final")
xlabel("$x$ [m]","Interpreter","latex"); ylabel("$y$ [m]","Interpreter","latex");
saveas(gcf,'trayectoria_obtenida.png');

%% Figura 3: Comparación
figure(3)
plot(x_deseada,y_deseada,'--','LineWidth',2); hold on
plot(x,y,'LineWidth',2);
axis equal; grid on
legend("Deseada","Obtenida")
title("Comparación de trayectorias")
xlabel("$x$ [m]","Interpreter","latex"); ylabel("$y$ [m]","Interpreter","latex");
saveas(gcf,'comparacion_trayectorias.png');

%% Figura 4: Velocidad lineal
figure(4)
plot(t,u,'LineWidth',2); grid on
title("Velocidad lineal robot")
xlabel("Tiempo [s]","Interpreter","latex"); ylabel("$u$ [m/s]","Interpreter","latex");
saveas(gcf,'velocidad_lineal.png');

%% Figura 5: Velocidad angular
figure(5)
plot(t,w,'LineWidth',2); grid on
title("Velocidad angular robot")
xlabel("Tiempo [s]","Interpreter","latex"); ylabel("$\omega$ [rad/s]","Interpreter","latex");
saveas(gcf,'velocidad_angular.png');

%% Figura 6: Velocidades de ruedas
figure(6)
subplot(2,1,1)
plot(t,VD,'LineWidth',2); hold on; plot(t,VI,'LineWidth',2);
legend("$V_D$","$V_I$","Interpreter","latex")
grid on; title("Velocidad lineal ruedas")
xlabel("Tiempo [s]","Interpreter","latex"); ylabel("Velocidad [m/s]","Interpreter","latex")

subplot(2,1,2)
plot(t,dot_theta_RD,'LineWidth',2); hold on; plot(t,dot_theta_RI,'LineWidth',2);
legend("$\dot{\theta}_D$","$\dot{\theta}_I$","Interpreter","latex")
grid on; title("Velocidad angular ruedas")
xlabel("Tiempo [s]","Interpreter","latex"); ylabel("Velocidad angular [rad/s]","Interpreter","latex")
saveas(gcf,'velocidades_ruedas.png');

%% Figura 7: Animación del robot
figure(7)
hold on; grid on; axis equal
xlabel("$x$ [m]","Interpreter","latex")
ylabel("$y$ [m]","Interpreter","latex")
title("Animación robot diferencial")
plot(x,y,'--','LineWidth',2);

% Definir forma del robot (eje X = frente)
L_robot = 0.5; W_robot = 0.3;
robot_shape = [L_robot/2, W_robot/2; L_robot/2, -W_robot/2; -L_robot/2, -W_robot/2; -L_robot/2, W_robot/2]';
wheel_L = [-0.1, 0.05; 0.1, 0.05; 0.1, -0.05; -0.1, -0.05]';
wheel_R = wheel_L;
pos_wheel_L = [0; W_robot/2 + 0.05];
pos_wheel_R = [0; -W_robot/2 - 0.05];

filename = 'cinematica_inversa.gif';

for k = 1:20:length(t)
    cla
    plot(x(1:k),y(1:k),'LineWidth',2);
    hold on; grid on; axis equal
    
    % Matriz de rotación con orientación del robot
    Rm = [cos(theta(k)) -sin(theta(k)); sin(theta(k)) cos(theta(k))];
    p = [x(k); y(k)];
    
    % Transformar robot y ruedas
    robot_global = Rm*robot_shape + p;
    wheel_L_global = Rm*(wheel_L + pos_wheel_L) + p;
    wheel_R_global = Rm*(wheel_R + pos_wheel_R) + p;
    
    % Dibujar
    fill(robot_global(1,:), robot_global(2,:), [0.8 0.8 0.8]);
    fill(wheel_L_global(1,:), wheel_L_global(2,:), [0.1 0.1 0.1]);
    fill(wheel_R_global(1,:), wheel_R_global(2,:), [0.1 0.1 0.1]);
    plot(x(k),y(k),'ko','MarkerSize',6,'MarkerFaceColor','k');
    
    xlim([min(x)-1 max(x)+1]); ylim([min(y)-1 max(y)+1]);

    % Guardar GIF
    frame = getframe(gcf);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    if k == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.05);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.05);
    end
end
%% Resultados en la terminal
error_trayectoria = sqrt((x_deseada(1:length(x))-x).^2 + (y_deseada(1:length(y))-y).^2);

disp('--- Tabla de resultados ---')
fprintf('u: min = %.3f m/s, max = %.3f m/s\n', min(u), max(u));
fprintf('w: min = %.3f rad/s, max = %.3f rad/s\n', min(w), max(w));
fprintf('dot_theta_D: min = %.3f rad/s, max = %.3f rad/s\n', min(dot_theta_RD), max(dot_theta_RD));
fprintf('dot_theta_I: min = %.3f rad/s, max = %.3f rad/s\n', min(dot_theta_RI), max(dot_theta_RI));
fprintf('Error de trayectoria: max = %.3f m\n', max(error_trayectoria));