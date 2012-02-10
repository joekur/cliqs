class CliqMembershipsController < ApplicationController
  layout 'ajax', :only => [:ajax_nav_rank]
  
  def ajax_nav_rank
    rank_array = params[:data]
    index = 0
    
    rank_array.each do |cliq_mem_id|
      cliq_mem = CliqMembership.find_by_id(cliq_mem_id)
      if !cliq_mem.nil?
        cliq_mem.nav_rank = index
        cliq_mem.save
      end
      index += 1
    end
  end
  
end
