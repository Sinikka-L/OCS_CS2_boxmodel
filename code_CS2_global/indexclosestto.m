function [index]=indexclosestto(vectorlong, vectorshort)
% finds index on vectorlong for subsampling vectorlong at indices
% vectorshort
index=zeros(length(vectorshort),1);
for i=1:length(vectorshort)
    differ=vectorlong-vectorshort(i);
    differ(differ<0)=NaN;
    [val ind]=min(differ);
    index(i)=ind;
end
end