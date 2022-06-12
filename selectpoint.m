function [p_sole] = selectpoint(gAf,type)
	f=gAf;
    switch (type)
    case 1
        index = f(:,2)>10;
        f(index,:)=[];
        [~,n]=max((100-f(:,2))./f(:,1));
        p_sole=f(n,:);
    case 2
        rate_thre=0.01;
        
        best_adjr2=0;
        for i=0:5
            for j=1:5
                fuc_parameter=['rat',num2str(i),num2str(j)];
                [fitobj,goodness,~]=fit(f(:,1),f(:,2), fuc_parameter);
                if best_adjr2<goodness.adjrsquare
                   bestparm=fuc_parameter;
                   best_adjr2=goodness.adjrsquare; 
                   fitting_fuc=fitobj;
                end
            end
        end
        figure();
        plot(fitting_fuc);hold on
        output(gAf);
        x=0:1:max(gAf(:,1));
        rate=differentiate(fitting_fuc,x);
        num=find(abs(rate)<rate_thre,1);
        pre_chosenum=find(f(:,1)>num);
        p_pre=f(pre_chosenum,:);
        [~,num]=min(p_pre(:,1));
        p_sole=p_pre(num,:);
    otherwise
        
    end
    
end

