% plot_ca_data.m

% including the data files and data file path
data_path = 'data/';
% data_path = './';

load EPSC_1.txt;

if 0
    file_reg = [data_path '*.txt'];
    file_struct = dir(file_reg);
    filenames = cell(1, length(file_struct));
    disp('reading data files')
    for ifile = 1:length(file_struct)
        filenames(1,ifile)=cellstr(file_struct(ifile).name);
        cmd=['load ' filenames{1,ifile} ';'];
        eval(cmd)
        disp(filenames{1,ifile}(1:(end-4)))
    end
end

last_stop_index = 0;
for k = 1:50
    period = 1000/k;
    time_lengths(k) = 500 + 10*period + 500;
    index_lengths(k) = 1 + floor(time_lengths(k)/0.025+0.5);
    start_index(k) = last_stop_index + 1;
    stop_index(k) = last_stop_index + index_lengths(k);
    last_stop_index = stop_index(k);
end
figure
collection = [1, 13, 50];
for index = 1: length(collection)
    k = collection(index);
    chunk = EPSC_1(start_index(k):stop_index(k));
    time_vec = [0:(length(chunk)-1)].*0.025;
    subplot(1,length(collection),index)
    plot(time_vec, chunk)
    % set(gca,'xaxisLocation','top')
    xlabel(['period ' num2str(k) ])
end

