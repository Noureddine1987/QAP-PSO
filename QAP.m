function QAP

run =30;                         %run   
iteration=2000;     %generation
pop_no=50;
f=dlmread('f_nug30.dat'); 
d=dlmread('d_nug30.dat');     %read from text file
N = 30 ;
x=1:iteration ;
c1=[0.1 0.5 1 1.5 2];
c2=[0.1 0.5 1 1.5 2];
weight=[0.1 0.5 1 1.5 2];
z_temp=[];
size_c=size(c1);
size_w=size(weight);
for jj=1:size_c(2)
    for w=1:size_w(2)
        filename=['temp data\c_' int2str(c1(jj)) ' w_' int2str(weight(w)) '.mat'];
        if exist(filename)==2
            load(filename);
        else
            for i=1:run
                mean_tempdec(i,:)=PSO_find(pop_no,d,f,iteration,c1(jj),c2(jj),weight(w));
                disp(['End of run ',num2str(i),' th.']) ;
            end
            y=mean(mean_tempdec,1);
            z_temp=[z_temp,y(iteration)];
            filename=['temp data\c_' int2str(c1(jj)) ' w_' int2str(weight(w)) '.mat'];
            save(filename,'z_temp');
        end
    end
end
z_fitness=zeros(size_c(2),size_w(2));    % (x,y)
z_fitness(:)=z_temp; 
[max_z I_z]=min(z_temp);
size_x=size_c(2);
size_y=size_w(2);
c_max=c1(ceil(I_z/size_y));
ceil(I_z/size_y)
mod(I_z,size_y)
if mod(I_z,size_x)~=0
    w_max=weight(mod(I_z,size_y));
else
    w_max=weight(size_y);
end
h= figure;
surf(weight,c1,z_fitness);  %(x,y,z)
colormap gray;
alpha(0.4);
axis auto ;
dlm_str=[max_z w_max c_max];
dlmwrite('new\res 3d.txt',dlm_str);
dlmwrite('new\res 3d z.txt',z_fitness);
hgsave(h,'new\fig 3d');

end
