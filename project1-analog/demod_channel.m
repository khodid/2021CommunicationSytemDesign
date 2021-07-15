function data = demod_channel(m, ch_num, LPF, HPF)

% d = demod_channel(m, 0, LPF, HPF)

fs = 44100;
fc = [4150; 8250; 12350; 16450];

t = 0 : 1/fs : (length(m)-1)/fs;
c = cos(2*pi*fc*t)';

switch ch_num
    case 0
        data = m;
    case 1
        data = filter(HPF(1), m);
        data = data.*c(:, ch_num);
    case 2
        data = filter(HPF(2), m);
        data = data.*c(:, ch_num);
    case 3
        data = filter(HPF(3), m);
        data = data.*c(:, ch_num);
    case 4
        data = filter(HPF(4), m);
        data = data.*c(:, ch_num);
end
data = filter(LPF, data);
end