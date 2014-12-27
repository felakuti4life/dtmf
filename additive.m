function y = additive(f,Z,fs,dur,  name)
%f: vector of frequencies in Hz
%Z: vector of complex amplitudes A*exp(j*phi)
%fs: sampling rate in Hz
%dur: total duration of the signal in seconds
%name: name of the output audio file
%f and Z should be of the same length:
%Z(1) corresponds to f(1) and so on.
%Ethan Geller / Lab 2-2
samples = dur*fs;
signal = 1:samples;
for n = 1:samples
signal(n) = sum(Z.*sin(2*pi.*f*n/fs));
end
wavwrite(signal, fs, name);
y = signal;
end
