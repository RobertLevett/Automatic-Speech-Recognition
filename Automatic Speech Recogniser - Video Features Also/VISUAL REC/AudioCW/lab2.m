for n=1:320,
    x(n) = sin(2*pi*50*n/320);
end
xF = fft(x);

magSpec = abs(xF);
phaseSpec = angle(xF);

fs = 16000;
f=[fs/320:fs/320:fs];

plot(f,phaseSpec);