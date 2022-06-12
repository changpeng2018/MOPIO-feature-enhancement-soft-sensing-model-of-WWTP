function [f] = fitness(x)
    load mnist;
    C = 2^-30; s = .8;
    train_x = double(train_x/255);
    train_y = double(train_y);
    test_x = double(test_x/255);
    test_y = double(test_y);
    train_y=(train_y-1)*2+1;
    test_y=(test_y-1)*2+1;
    
    for i=1:size(x,1)
        N11=x(i,1);%feature nodes  per window
        N2=x(i,2);% number of windows of feature nodes
        N33=x(i,3);% number of enhancement nodes
        
        N1=N11; N3=N33;
        [TestingErrorate] = bls_train(train_x,train_y,test_x,test_y,s,C,N1,N2,N3);
        f(i,1)=N11*N2+N33;
        f(i,2)=TestingErrorate*100;
    end
end


