% 주파수 축 시각화 함수
% 교수님이 짠 ZOOMFFT 처럼 주파수 쪽으로 잘 볼 수 있도록 하는 유틸 함수
% INPUT : 메시지, 샘플링 주파수, 플롯 제목,  ...(교수님 함수 보면서 추가 필요)
% OUTPUT: 따로 만들기보단 그냥 바로 figure, plot(f, 20*log10(...)) 해서 눈에 보이게끔 하고 싶음
%               아 근데 subplot으로 비교하도록 코드 짜려면 figure은 안 넣는게 좋겠다
% + 캐리어 주파수 축을 눈에 보이도록 하는 것도 좋겠다!

function freq_view(m, fs, plot_title, fc)
% Plot title이랑 fc는 없을 경우도 생각할 것
fny = fs/2;
fr = fs/length(m);
freq = -fny : fr : fny-fr;
freq = freq./1000;
plot(freq, 20*log10(abs(fftshift(fft(m)))));
xtickformat('%g kHz')
ytickformat('%g dB')
xlabel('Freqency')
if nargin > 2 
    title(plot_title)
end
if nargin > 3
    xline(fc, 'Color', [1 0 0], 'LineWidth', 1.5, 'Label', 'f_c');
    xline(-fc, 'Color', [1 0 0], 'LineWidth', 1.5, 'Label', '-f_c');
end