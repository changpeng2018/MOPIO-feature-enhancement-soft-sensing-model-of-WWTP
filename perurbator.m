function [x] = perurbator(x)
    
    d_max=max(x);
    d_min=min(x);
    x_noise=makenoise(x);
    delt=d_max-d_min;
    for i=1:size(delt,2)
        x_noise(:,i)=delt(i)*x_noise(:,i);
    end
    x=x+x_noise;
end

%% 生成噪声
function [X_noise] = makenoise(X)
    X_row_size = size(X,1);
    X_column_size = size(X,2);
    X_nose = zeros(X_row_size,X_column_size);
    for i=1:X_row_size
        for j=1:X_column_size
            ll=0.01*randn(1,1);%生成均值为0，方差为0.01的正态分布的数
            X_nose(i,j) =ll;
        end
    end
    X_noise=X_nose;
    clear X;
    clear X_nose;
   
end