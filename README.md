# Fourier-Series
Matlab scripts to generate truncated fourier series of a function and analyse the function in time as well as in frequency domain. 

The variable named choice captures the analysis domain i.e time or frequency. For time domain plot of the truncated fourier series, set the choice variable to "time". For frequency spectrum of the signal, set the choice variable to "freq" and to see the behaviour of the function in both domains, set the choice variable to "both".

Set the Time period of the function in the variable T.

Define the function over one period in the variable x. For example if you want to analyse triangular wave, then set x = piecewise(t<T/2,t,t<T,-(t-T)).

Truncated Fourier series means that we only consider a number of harmonics in the reconstruction. Set the number of harmonics you want to consider in the variable N_vals. This can be a vector. For example if N_vals = [5 10 15], then the time domain plot will contain three curves with 5, 10 and 15 harmonics. Whereas for the frequency spectrum, the plot will be made by considering only -N_vals(1):N_vals(1) harmonics. 

Set the number of periods you want on the time domain plot in the variable num_time_periods.

