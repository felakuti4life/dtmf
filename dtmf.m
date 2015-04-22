function y = dtmf(phone_number, tone_dur, fs, name)
dmtf_x = [1477, 1336, 1209];
dmtf_y = [697,770,852];
samples_per_tone = fs * tone_dur;
samples_per_pause = samples_per_tone * 0.2;
total_samples = samples_per_tone * length(phone_number) + samples_per_pause * length(phone_number);

%preallocate
y = 1:total_samples;
freq_x = 0;
freq_y = 0;
cursor = 1;
for n = 1:length(phone_number)
    if phone_number(n) < 0 || phone_number(n) > 9
        'ERROR: invalid digit'
        return
    end
    digit = phone_number(n);
    if digit == 0
        freq_x = 1336;
        freq_y = 941;
    else
        freq_x = dmtf_x(mod(digit,3) + 1);
        freq_y = dmtf_y(floor((digit-1) / 3)+1);
    end
    tone = additive([freq_x, freq_y], [1,1], fs, tone_dur, strcat('tone ', num2str(n)));
    tone_end = cursor + length(tone) -1;
    y(cursor:tone_end) = tone;
    cursor = tone_end + samples_per_pause + 1;
end
wavwrite(y, fs, name);
end
