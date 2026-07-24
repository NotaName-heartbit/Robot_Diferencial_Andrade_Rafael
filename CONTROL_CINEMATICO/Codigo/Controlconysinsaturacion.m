clear all; clc; close all;

% CONTROL CINEMATICO DE UN ROBOT DIFERENCIAL
% Comparación con y sin saturación

% TIEMPO DE SIMULACION
ts = 20; ti = 0.02; t = 0:ti:ts;

% PARAMETROS DEL ROBOT
L = 0.35; r = 0.08;
thetaDot_max = 18;   % Velocidad angular maxima [rad/s]

% CONDICIONES INICIALES
x0 = 0; y0 = 0; theta0 = 0;

% POSICION DESEADA
xd = 2.5; yd = 1.5;

% GANANCIAS DEL CONTROLADOR
k_rho = 1.0; k_theta = 2.0;
tol_llegada = 0.05;

% ---------- SIMULACION SIN SATURACION ----------
[x_sin,y_sin,theta_sin,u_sin,w_sin,thetaDot_D_sin,thetaDot_I_sin,rho_sin,e_theta_sin] = ...
    sim_robot(ts,ti,L,r,thetaDot_max,x0,y0,theta0,xd,yd,k_rho,k_theta,tol_llegada,false);

% ---------- SIMULACION CON SATURACION ----------
[x_con,y_con,theta_con,u_con,w_con,thetaDot_D_con,thetaDot_I_con,rho_con,e_theta_con] = ...
    sim_robot(ts,ti,L,r,thetaDot_max,x0,y0,theta0,xd,yd,k_rho,k_theta,tol_llegada,true);

%% 1. Trayectoria comparada
figure(1)
plot(x_sin,y_sin,'LineWidth',3); hold on
plot(x_con,y_con,'LineWidth',3);
plot(x0,y0,'go','MarkerSize',12,'MarkerFaceColor','g');
plot(xd,yd,'rp','MarkerSize',18,'MarkerFaceColor','r');
legend("Sin saturación","Con saturación","Inicio","Meta")
xlabel("x [m]"); ylabel("y [m]")
title("Comparación de trayectorias"); grid on; axis equal
saveas(gcf,'trayectoria_comparada.png')

%% 2. Error de posición
figure(2)
plot(t,rho_sin,'LineWidth',3); hold on
plot(t,rho_con,'LineWidth',3);
legend("Sin saturación","Con saturación")
xlabel("Tiempo [s]"); ylabel("Error de posición [m]")
title("Error de posición vs tiempo"); grid on
saveas(gcf,'error_posicion.png')

%% 3. Error angular
figure(3)
plot(t,e_theta_sin,'LineWidth',3); hold on
plot(t,e_theta_con,'LineWidth',3);
legend("Sin saturación","Con saturación")
xlabel("Tiempo [s]"); ylabel("Error angular [rad]")
title("Error angular vs tiempo"); grid on
saveas(gcf,'error_angular.png')

%% 4. Velocidad lineal u
figure(4)
plot(t,u_sin,'LineWidth',3); hold on
plot(t,u_con,'LineWidth',3);
legend("Sin saturación","Con saturación")
xlabel("Tiempo [s]"); ylabel("u [m/s]")
title("Velocidad lineal"); grid on
saveas(gcf,'velocidad_lineal.png')

%% 5. Velocidad angular w
figure(5)
plot(t,w_sin,'LineWidth',3); hold on
plot(t,w_con,'LineWidth',3);
legend("Sin saturación","Con saturación")
xlabel("Tiempo [s]"); ylabel("w [rad/s]")
title("Velocidad angular"); grid on
saveas(gcf,'velocidad_angular.png')

%% 6. Velocidades de ruedas sin saturación
figure(6)
subplot(2,1,1)
plot(t,thetaDot_D_sin,'LineWidth',3); grid on
ylabel("\thetaDot_D [rad/s]"); title("Rueda derecha sin saturación")
subplot(2,1,2)
plot(t,thetaDot_I_sin,'LineWidth',3); grid on
ylabel("\thetaDot_I [rad/s]"); xlabel("Tiempo [s]")
title("Rueda izquierda sin saturación")
saveas(gcf,'ruedas_sin_saturacion.png')

%% 7. Velocidades de ruedas con saturación
figure(7)
subplot(2,1,1)
plot(t,thetaDot_D_con,'LineWidth',3); grid on
ylabel("\thetaDot_D [rad/s]"); title("Rueda derecha con saturación")
subplot(2,1,2)
plot(t,thetaDot_I_con,'LineWidth',3); grid on
ylabel("\thetaDot_I [rad/s]"); xlabel("Tiempo [s]")
title("Rueda izquierda con saturación")
saveas(gcf,'ruedas_con_saturacion.png')

%% 8. Animación
filename = 'control_cinematico.gif';
figure(8)
for k = 1:20:length(t)
    plot(x_sin(1:k),y_sin(1:k),'b','LineWidth',2); hold on
    plot(x_con(1:k),y_con(1:k),'r','LineWidth',2);
    plot(xd,yd,'rp','MarkerSize',18,'MarkerFaceColor','r');
    legend("Sin saturación","Con saturación","Meta")
    xlabel("x [m]"); ylabel("y [m]"); title("Animación control cinemático")
    grid on; axis equal
    xlim([min([x_sin,x_con])-1 max([x_sin,x_con])+1])
    ylim([min([y_sin,y_con])-1 max([y_sin,y_con])+1])
    frame = getframe(gcf);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    if k==1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.05);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.05);
    end
    cla
end

%% 9. Indicadores en terminal
error_final_sin = rho_sin(end);
error_final_con = rho_con(end);

tiempo_llegada_sin = t(find(rho_sin <= tol_llegada,1));
tiempo_llegada_con = t(find(rho_con <= tol_llegada,1));

distancia_sin = sum(sqrt(diff(x_sin).^2 + diff(y_sin).^2));
distancia_con = sum(sqrt(diff(x_con).^2 + diff(y_con).^2));

fprintf('\n--- Comparación de desempeño ---\n');
fprintf('Error final sin saturación = %.3f m\n', error_final_sin);
fprintf('Error final con saturación = %.3f m\n', error_final_con);
fprintf('Tiempo de llegada sin saturación = %.2f s\n', tiempo_llegada_sin);
fprintf('Tiempo de llegada con saturación = %.2f s\n', tiempo_llegada_con);
fprintf('Velocidad máxima rueda D sin saturación = %.2f rad/s\n', max(thetaDot_D_sin));
fprintf('Velocidad máxima rueda D con saturación = %.2f rad/s\n', max(thetaDot_D_con));
fprintf('Velocidad máxima rueda I sin saturación = %.2f rad/s\n', max(thetaDot_I_sin));
fprintf('Velocidad máxima rueda I con saturación = %.2f rad/s\n', max(thetaDot_I_con));
fprintf('Distancia recorrida sin saturación = %.2f m\n', distancia_sin);
fprintf('Distancia recorrida con saturación = %.2f m\n', distancia_con);

%% FUNCION DE SIMULACION
function [x,y,theta,u,w,thetaDot_D,thetaDot_I,rho,e_theta] = sim_robot(ts,ti,L,r,thetaDot_max,x0,y0,theta0,xd,yd,k_rho,k_theta,tol_llegada,con_saturacion)

t = 0:ti:ts;
x(1)=x0; y(1)=y0; theta(1)=theta0;
rho=zeros(1,length(t)); e_theta=zeros(1,length(t));
u=zeros(1,length(t)); w=zeros(1,length(t));
thetaDot_D=zeros(1,length(t)); thetaDot_I=zeros(1,length(t));

for k=1:length(t)-1
    % Errores de posición
    ex = xd - x(k); ey = yd - y(k);
    rho(k) = sqrt(ex^2 + ey^2);
    theta_d = atan2(ey,ex);
    e_theta(k) = atan2(sin(theta_d - theta(k)), cos(theta_d - theta(k)));

    % Control cinemático
    u(k) = k_rho*rho(k);
    w(k) = k_theta*e_theta(k);

    % Detener si llega cerca de la meta
    if rho(k) < tol_llegada
        u(k)=0; w(k)=0;
    end

    % Cinemática inversa hacia ruedas
    thetaDot_D(k) = (u(k) + (L/2)*w(k))/r;
    thetaDot_I(k) = (u(k) - (L/2)*w(k))/r;

    if con_saturacion
        % Saturación proporcional
        valor_max = max(abs([thetaDot_D(k), thetaDot_I(k)]));
        if valor_max > thetaDot_max
            alpha = thetaDot_max/valor_max;
            thetaDot_D(k) = alpha*thetaDot_D(k);
            thetaDot_I(k) = alpha*thetaDot_I(k);
        end
        % Velocidades reales después de saturar
        u_real = (r/2)*(thetaDot_D(k)+thetaDot_I(k));
        w_real = (r/L)*(thetaDot_D(k)-thetaDot_I(k));
        x(k+1) = x(k) + u_real*cos(theta(k))*ti;
        y(k+1) = y(k) + u_real*sin(theta(k))*ti;
        theta(k+1) = theta(k) + w_real*ti;
    else
        % Modelo sin saturación
        x(k+1) = x(k) + u(k)*cos(theta(k))*ti;
        y(k+1) = y(k) + u(k)*sin(theta(k))*ti;
        theta(k+1) = theta(k) + w(k)*ti;
    end
end

% Completar vectores
rho(end)=rho(end-1); e_theta(end)=e_theta(end-1);
u(end)=u(end-1); w(end)=w(end-1);
thetaDot_D(end)=thetaDot_D(end-1); thetaDot_I(end)=thetaDot_I(end-1);
end