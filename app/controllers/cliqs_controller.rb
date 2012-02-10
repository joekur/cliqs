class CliqsController < ApplicationController
  include TicketsHelper
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
      send_cliq_invites(params[:invites], params[:invite_message], @cliq, current_user)
      flash[:success] = "New cliq created!"
      redirect_to users_path
    else
      @invites = params[:invites]; @invite_message = params[:invite_message]
      render :new
    end
  end
  
  private
    
    def check_cliq_membership
      if defined?(params[:id])
        cliqmem = current_user.cliq_memberships.where(:cliq_id => params[:id]).first
        if cliqmem.nil?
          # sorry, not allowed! (we emphasize privacy!)
          flash[:error] = "Scram! You're not a member of that cliq!"
          redirect_to users_path
        end
      end
    end
    
  
end
