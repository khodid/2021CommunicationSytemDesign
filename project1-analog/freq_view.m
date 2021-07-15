% ���ļ� �� �ð�ȭ �Լ�
% �������� § ZOOMFFT ó�� ���ļ� ������ �� �� �� �ֵ��� �ϴ� ��ƿ �Լ�
% INPUT : �޽���, ���ø� ���ļ�, �÷� ����,  ...(������ �Լ� ���鼭 �߰� �ʿ�)
% OUTPUT: ���� ����⺸�� �׳� �ٷ� figure, plot(f, 20*log10(...)) �ؼ� ���� ���̰Բ� �ϰ� ����
%               �� �ٵ� subplot���� ���ϵ��� �ڵ� ¥���� figure�� �� �ִ°� ���ڴ�
% + ĳ���� ���ļ� ���� ���� ���̵��� �ϴ� �͵� ���ڴ�!

function freq_view(m, fs, plot_title, fc)
% Plot title�̶� fc�� ���� ��쵵 ������ ��
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