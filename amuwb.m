close all
clear all
clc

fs = 32000; % sampling frequency in Hz
bw = 4000; % UWB pulse bandwidth in Hz
message = double(rand(100,1)>=0.5); % generate a random message of 1000 bits (without error control etc.)
Npulse = ceil(fs/bw); % number of samples per pulse
Nwait = 2*Npulse; % wait Nwait samples between transmitting each pulse!
Nbit = Npulse + Nwait; % total bit duration comprises of pulse duration + waiting duration
t = (0:Nbit-1)'/fs; % UWB pulse time vector
tau = 3.5- 5.6918*((bw/fs)^1.65);
pulse = t .* exp(-(tau*t*bw).^2); % Generate one UWB pulse; Gaussian monocycle
pulse = pulse / sum(pulse); % energy normalization
% Modulate the digital message using the generated UWB pulse
tx = zeros(length(message)*Nbit,1); % Nbit samples per transmitted pulse required!
id = 1:Nbit;
for k = 1:length(message) % code the message using selected UWB modulation scheme
     
    tx(id) = pulse * (2*double(message(k) > 0.5)-1);
   
    id = id + Nbit;
end;
[Hpulse,fpulse] = freqz(pulse,1,16384,fs); % compute the spectrum of one pulse
[mv,mi] = min(abs(20*log10(abs(Hpulse))--3)); % find the -3dB bandwidth of the pulse
pulse3dBbandwidth = fpulse(mi);
%plot(tx,'r');
%soundsc(tx);
k=randi(20);
l=randi(20);
x1=0;
y1=0;
x2=5;
y2=0;
%tx=tx'
d=ceil(sqrt((k-x1).^2+(l-y1).^2));
d1=ceil(sqrt((x2-k).^2+(y2-l).^2));
y=zeros(size(tx,1)+d,size(tx,2));
y(end:-1:d+1)=tx(1:end);
%soundsc(y);
figure(1)
plot(tx);
hold on
plot(y);
%title('transmitted and target signal with delay')
z=zeros(size(y,1)+d1,size(y,2));
z(end:-1:end-length(tx)+1)=y(d+1:end);
%soundsc(z);
figure(2)
plot(y);
hold on
plot(z);
title('target and recived signal with delay')
delay=finddelay(tx,z);
figure(3)
plot(tx);
hold on
plot(z);
%title('transmitted and recived signal with delay')