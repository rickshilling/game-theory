function [output_payout_1, output_payout_2, ...
          indices_1, indices_2] = ...
         iterate_on_dominated_strategies(payout_1,payout_2)
  % output_payout_1 = payout_1(indices_1,indices_2)
  % output_payout_2 = payout_2(indices_2,indices_1)

  stop_flag = false;

  indices_1 = 1:size(payout_1,1);
  indices_2 = 1:size(payout_2,1);

  output_payout_1 = payout_1;
  output_payout_2 = payout_2;

  while ~stop_flag
    [p1_dominated_indices, p1_dominating_indices] = ...
      get_indices_of_dominated_strategy(output_payout_1);
    output_payout_1 = output_payout_1(p1_dominating_indices,:);
    output_payout_2 = output_payout_2(:,p1_dominating_indices);

    [p2_dominated_indices, p2_dominating_indices] = ...
      get_indices_of_dominated_strategy(output_payout_2);
    output_payout_1 = output_payout_1(:,p2_dominating_indices);
    output_payout_2 = output_payout_2(p2_dominating_indices,:);

    indices_1 = indices_1(p1_dominating_indices);
    indices_2 = indices_2(p2_dominating_indices);

    stop_flag = isempty(p1_dominated_indices) && isempty(p2_dominated_indices);
  end

end
