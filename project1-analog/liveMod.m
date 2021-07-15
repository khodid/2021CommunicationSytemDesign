a0 = dsp.AudioFileReader('voice/news1.mp3');
a1 = dsp.AudioFileReader('voice/news2.mp3');
a2 = dsp.AudioFileReader('voice/news3.mp3');
a3 = dsp.AudioFileReader('voice/news4.mp3');
a4 = dsp.AudioFileReader('voice/news5.mp3');

deviceWriter = audioDeviceWriter('SampleRate',fileReader1.SampleRate);

t = 0 : 1/a0.SampleRate : (a0.SamplesPerFrame - 1)/a0.SampleRate;
c = cos(2*pi*fc*t)';

% Process 정의 section
process_BaseBand = @(m) filter(BPF, m); % Baseband 변조
process_Modulation = @(m) filter(BPF, m).*c; % 
process_Sum = @(b, m) filter(HPF(1), m(:, 1)) + filter(HPF(2), m(:, 2))...
    + filter(HPF(3), m(:, 3)) + filter(HPF(4), m(:, 4)) + b;

% 첫 프레임 사전 연산

d0 = a0(); d1 = a1(); d2 = a2(); d3 = a3(); d4 = a4();
d0 = d0(:, 1); d = [d1(:, 1) d2(:, 1) d3(:, 1) d4(:, 1)];

myProcessedSignal = process_Sum(process_BaseBand(d0), ...
    process_Modulation(d));

store = zeros(44100 * 200, 1); % Preallocation for 300 secs, (5min)
store(1:a0.SamplesPerFrame, 1) = myProcessedSignal; framenum = 1;

while ~(isDone(a0) & isDone(a1) & isDone(a2) & isDone(a3) & isDone(a4))
    deviceWriter(myProcessedSignal);
    % 받아오기 & 변조하기
    d0 = a0(); d1 = a1(); d2 = a2(); d3 = a3(); d4 = a4();
    d0 = d0(:, 1); d = [d1(:, 1) d2(:, 1) d3(:, 1) d4(:, 1)];
    myProcessedSignal = process_Sum(process_BaseBand(d0), ...
        process_Modulation(d));
    % 결과물 저장
    store(framenum*a0.SamplesPerFrame + 1: (framenum + 1)*a0.SamplesPerFrame, 1) = ... 
        myProcessedSignal; framenum = framenum + 1;
end

% 모든 걸 끝낸 후 송출 음원을 따로 저장
audiowrite('modulated_audio.wav', store, fileReader1.SampleRate);

release(a0); release(a1); release(a2); release(a3); release(a4);
release(deviceWriter)