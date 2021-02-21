function [dominated_indices, dominating_indices] = ...
         get_multi_indices_of_dominated_strategy(payout)
  [~,dominating_indices] = max(payout,[],1)
  dominating_indices = sort(unique(dominating_indices))
  dominated_indices = setdiff(1:size(payout,1),dominating_indices);
end

