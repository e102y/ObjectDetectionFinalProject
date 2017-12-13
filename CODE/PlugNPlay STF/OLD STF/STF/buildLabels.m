function LABELS = buildLabels(GTdir)

fid = fopen(GTdir, 'r');
imageNames = textscan(fid, '%s');
imageNames = imageNames{1};
fclose(fid);

LABELS = [[0; 0; 0]];

Z = numel(imageNames);

for i = 1:Z
    im = imread(imageNames(i));
    for j = size(im, 1)
        for k = size(im, 2)
            T = 1;
            for m = size(LABELS)
               if max( LABELS(:, m) == im(j, k, :) ) 
                   T = 0;
                   break
               end
            end
            if(T)
               LABELS = [LABELS, im(j, k, :)];
            end
        end
    end
end