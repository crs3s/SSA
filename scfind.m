function [ind]=scfind(station,sc)
% ����̨վ������station�е�λ��
% �ҵ������кţ�δ�ҵ��򷵻�-1��

ind=-1;
for i=1:size(station,1)
    if(station{i,2}==sc)
        ind=i;
        break;
    end
end

end