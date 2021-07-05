 %script initialisation
clear;
clc;
close all;
syms n t;

%options : 
%choice = 'time' will plot the time domain FS
%choice = 'freq' will plot the frequency spectrum
%choice = 'both' will plot both
choice = "time";

%Periodicity Properties
T = 2;
w0 = 2*pi/T;

%define x(t) over a period t -> [0,T]
% x = piecewise(t<-T/2,0,t<T/2,2,0);
x = piecewise(t<T/2,t,t<T,-(t-T));
%number of harmonics to be considered in truncated fourier series.
N_vals = 5;

%Range of t you want the plots for
fm = max(N_vals)*w0/2/pi;
fs = 2.5*fm;
num_time_periods = 3;
num_samples = num_time_periods*T*fs;
t_range = linspace(-num_time_periods*T/2,num_time_periods*T/2,num_samples);

%<--main script -->
%find the exponential fourier seriess coefficient using integration
cn = int(x*exp(-1i*w0*t*n),t,0,T)/T;

if(choice == "time" || choice == "both")    
    %calculate and plot the truncated FS for each N value specified in N_vals.
    hold on;
    for i = 1:length(N_vals)
        x_hat = 0;
        prev_difference = Inf*ones(1,length(t_range));
        for j = -N_vals(i):N_vals(i)
            x_hat = x_hat + limit(cn,n,j)*exp(1i*j*w0*t);
        end
        difference = (abs(subs(x_hat,t,t_range) - subs(x,t,t_range)));
        if(sum(prev_difference - double(difference) < 0))
           fprintf("\t Pinggg"); 
        else
            fprintf("\n"); 
        end
        
        prev_difference = double(difference);
        plot(t_range,subs(x_hat,t,t_range),'LineWidth',2);
    end
     Legend = cell(length(N_vals),1);
     for iter = 1:length(N_vals)
       Legend{iter}=strcat('N = ', num2str(N_vals(iter)));
     end
    legend(Legend)
    legend("Location","northwest",'FontSize',15)
    title("Truncated Fourier Series Plot",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman")
    grid on
    grid minor
    xlabel("Time, t",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman");
    ylabel("x(t)",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman");
end


if(choice == "freq" || choice == "both")    
    %<--Frequency domain calculation and plotting -->
    figure;
    blue = '#0072BD';
    red = '#D95319';
    n_range = -N_vals(1):N_vals(1);
    amp = zeros(1,length(n_range));
    phase = zeros(1,length(n_range));
    for i = 1:length(n_range)
       amp(i) = abs(limit(cn,n,n_range(i)));
       phase(i) = angle(limit(cn,n,n_range(i)));
    end
    subplot 211
    stem(n_range*1/T/1000,amp,'marker','^','color',red,'linewidth',2)
    title("Two sided magnitude spectrum",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman")
    grid on
    grid minor
    xlabel("f (kHz)",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman");
    ylabel("|Cn|",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman");
    subplot 212
    stem(n_range*1/T/1000,phase,'marker','V','color',blue,'linewidth',2)
    title("Two sided phase spectrum",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman")
    grid on
    grid minor
    xlabel("f (kHz)",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman");
    ylabel("<Cn",'FontSize',13,'FontWeight',"bold","FontName","TimesNewRoman");
end


