module ContestHelper
  
  def get_user_points(user)
    points = 0
    selections = user.user_contest_selections
    selections.each do |selection|
      if selection_has_supplier_winning_in_category(selection)
       points = points + 1
      end
    end
    return points
  end
  
  def get_user_ranking(user)
    ranking = 1
    @users_in_contest.each do |user_in_contest|
      if get_user_points(user_in_contest) > get_user_points(user)
        ranking = ranking + 1
      end
    end
    return ranking
  end
   
  def supplier_account_selectionable(ic_id)
    if !user_signed_in?
      return false
    end
    
    matri_dream_ics = MatriDreamIc.all
    industry_categories = []
    matri_dream_ics.each do |matri_dream_ic|
      industry_categories << matri_dream_ic.industry_category
    end 
    industry_category = IndustryCategory.find(ic_id)
    if !industry_categories.include?(industry_category)
      return false
    end
 
    selections = current_user.user_contest_selections
    selections.each do |selection|
      if selection.matri_dream_ic_id.to_s == ic_id.to_s and selection.confirmed
        return false
      end
    end
  return true
  end

  def selection_has_supplier_winning_in_category(selection)
    vote_results = ContestVoteCount.where(:matri_dream_ic_id => selection.matri_dream_ic_id)
    if !vote_results.empty?
      most_voted = vote_results.first
      vote_results.each do |vote_result|
        if most_voted.vote_count < vote_result.vote_count
          most_voted = vote_result
        end
      end
      my_vote = ContestVoteCount.where(:supplier_account_id => selection.supplier_account_id, :matri_dream_ic_id => selection.matri_dream_ic_id).first
      if my_vote.vote_count == most_voted.vote_count
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def supplier_winning_in_category(supplier_account_id, ic_id)
    vote_results = ContestVoteCount.where(:matri_dream_ic_id => ic_id)
    if !vote_results.empty?
      most_voted = vote_results.first
      vote_results.each do |vote_result|
        if most_voted.vote_count < vote_result.vote_count
          most_voted = vote_result
        end
      end
      supplier_vote = ContestVoteCount.where(:supplier_account_id => supplier_account_id, :matri_dream_ic_id => ic_id).first
      if supplier_vote.vote_count == most_voted.vote_count
        return true
      else
        return false
      end
    else
      return false
    end
  end
  

  def user_selected(selections, supplier_account, industry_category)
    selections.each do |selection|
      if selection.supplier_account_id == supplier_account.id and selection.matri_dream_ic_id.to_s == industry_category.to_s and selection.confirmed
        return true
      end
    end
    return false
  end

end
