clear;close;clc
p1=[10 5 3; ...
     0 4 6; ...
     2 3 2];
p2=[ 4 3 2; ...
     1 6 0; ...
     1 5 8]';

[po1, po2, i, j] = iterate_on_dominated_strategies(p1,p2)

return
ii = [3 2 1];
jj = [2 1 3];
p1=p1(ii,:);
p2=p2(:,ii);
p1=p1(:,jj);
p2=p2(jj,:);

[po1, po2, i, j] = iterate_on_dominated_strategies(p1,p2);

dimensions = [2 3 4];
p3 = reshape(1:prod(dimensions),dimensions);
%[si, di] = get_multi_indices_of_dominated_strategy(p3);

dim = 2;%1;
other_dims=setdiff(1:ndims(p3),dim);
[maxValues, indices] = max(p3,[],dim);
size(maxValues);


[m,i]=max(p3,[],1);
l = reshape(1:prod(size(m)),size(m));
[i1,i2,i3] = ind2sub(size(m),l);
ll = sub2ind(size(p3),i(:)',i2(:)',i3(:)');

assert(all( m(:) == p3(ll)' ));

clear i1 i2 i3
dimensions = [2 3 4 5];
A = reshape(1:prod(dimensions),dimensions);
[m,i]=max(A,[],1);
l = reshape(1:prod(size(m)),size(m));
rh1 = '[i1,';
rh2 = 'l = sub2ind(size(A),i(:)'',';
for cv=2:(ndims(m)-1)
  rh1 = [rh1 'i' num2str(cv) ','];
  rh2 = [rh2 'i' num2str(cv) '(:)'','];
end
expression1 = [rh1 'i' num2str(cv+1) '] = ind2sub(size(m),l);'];
expression2 = [rh2 'i' num2str(cv+1) '(:)'');' ];
eval(expression1)
eval(expression2)

assert(all( m(:) == A(l)' ));

%-------------------------
clear
dimensions = [2 3];
A = reshape(1:prod(dimensions),dimensions);
dim = 2;
[m,k]=max(A,[],dim);
l = reshape(1:prod(size(m)),size(m));
rh1 = '[';
rh2 = 'l = sub2ind(size(A),';
for cv = 1:(ndims(m)-1)
  rh1 = [rh1 'i' num2str(cv) ','];
  if cv == dim
    rh2 = [rh2 'k(:)'','];
  else
    rh2 = [rh2 'i' num2str(cv) '(:)'','];
  end
end
expression1 = [rh1 'i' num2str(cv+1) '] = ind2sub(size(m),l);'];
if (cv+1) == dim
  expression2 = [rh2 'k(:)'');' ];
else
  expression2 = [rh2 'i' num2str(cv+1) '(:)'');' ];
end
eval(expression1)
eval(expression2)

assert(all( m(:) == A(l)' ));


%-------------------------
clear
dimensions = [2 3];
A = reshape(1:prod(dimensions),dimensions);
dim = 2;
[maxValues, linearIndices] = myMax(A,dim)
