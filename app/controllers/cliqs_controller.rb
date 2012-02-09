class CliqsController < ApplicationController
  
  before_filter :check_cliq_membership, :except => [:new, :create]
  
  def show
    @cliq = Cliq.find(params[:id])
    @current_cliq = @cliq
  end

  def new
    @cliq = Cliq.new
  end

  def create
    @cliq = Cliq.new(params[:cliq])
    if @cliq.save
      current_user.cliqs << @cliq
      flash[:success] = "New cliq created!"
      redirect_to users_path
    else
      render :new
    end
  end
  
  private
    
    def check_cliq_membership
      if defined?(params[:id])
        cliqmem = current_user.cliq_memberships.find_by_id(params[:id])
        if cliqmem.nil?
          # sorry, not allowed! (we emphasize privacy!)
          flash[:error] = "Scram! You're not a member of that cliq!"
          redirect_to users_path
        end
      end
    end
  
end
