function LABELS = buildLabels(GTdir, TNdir)

fid = fopen(TNdir, 'r');
imageNames = textscan(fid, '%s');
imageNames = imageNames{1};
fclose(fid);

labelNames = strcat([DIR.groundTruth, '/'], regexprep(imageNames, '\.(bmp|jpg)$', '_GT.bmp'));

LABELS = [[0; 0; 0]];

Z = numel(labelNames);

for i = 1:Z
    im = imread(labelNames(i));
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
