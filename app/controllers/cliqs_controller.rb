class CliqsController < ApplicationController
  include TicketsHelper
  before_filter :check_cliq_membership, :except => [:new, :create]
  
  def show
    @cliq = Cliq.find(params[:id])
    @current_cliq = @cliq
    @posts = @current_cliq.posts.order("created_at DESC")
    @photos = @current_cliq.photos.order("created_at DESC")
    @stories = Cliq.order_stories(@posts, @photos)
  end

  def new
    @cliq = Cliq.new
  end

  def create
    @cliq = Cliq.new(params[:cliq])
    if @cliq.save
      current_user.cliqs << @cliq
      current_user.profiles << Profile.new({:cliq_id => @cliq.id});
      send_cliq_invites(params[:invites], params[:invite_message], @cliq, current_user)
      flash[:success] = "New cliq created!"
      redirect_to users_path
    else
      @invites = params[:invites]; @invite_message = params[:invite_message]
      render :new
    end
  end
  
  def new_invites
    @current_cliq = Cliq.find(params[:id])
  end
  
  def create_invites
    @current_cliq = Cliq.find(params[:id])
    send_cliq_invites(params[:invites], params[:invite_message], @current_cliq, current_user)
    flash[:success] = "Invites sent!"
    redirect_to @current_cliq
  end
  
  def members
    @current_cliq = Cliq.find(params[:id])
    @members = @current_cliq.users
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
