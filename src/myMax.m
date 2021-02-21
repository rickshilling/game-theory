function [maxValues, linearIndices] = myMax(A,dim)
  [maxValues, subIndices] = max(A,[],dim);
  linearIndices = reshape(1:prod(size(maxValues)),size(maxValues))
  rh1 = '[';
  rh2 = 'linearIndices = sub2ind(size(A),';
  for cv = 1:(ndims(maxValues)-1)
    rh1 = [rh1 'i' num2str(cv) ','];
    if cv == dim
      rh2 = [rh2 'subIndices(:)'','];
    else
      rh2 = [rh2 'i' num2str(cv) '(:)'','];
    end
  end
  expression1 = [rh1 'i' num2str(cv+1) '] = ind2sub(size(maxValues),linearIndices);'];
  if (cv+1) == dim
    expression2 = [rh2 'subIndices(:)'');' ];
  else
    expression2 = [rh2 'i' num2str(cv+1) '(:)'');' ];
  end
  eval(expression1)
  eval(expression2)
  linearIndices = reshape(linearIndices,size(maxValues));
end
