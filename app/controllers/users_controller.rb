class UsersController < ApplicationController
  include TicketsHelper
  layout 'loggedout', :only => [:useTicket, :acceptInvite, :new, :create]
  skip_before_filter :require_login, :only => [:new, :create, :useTicket, :acceptInvite]
  
  def index
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "New account successfully created!"
      sign_in @user
      redirect_to users_path
    else
      render :new
    end
  end
  
  def changePassword
    @user = current_user
    if request.put?
      old_pass = params[:user][:old_password]
      params[:user].delete :old_password
      if User.authenticate(@user.email, old_pass)
        if @user.update_attributes(params[:user])
          flash[:success] = "Password changed!"
          redirect_to account_path
        end
      else
        flash.now[:error] = "Wrong password!"
      end
    end
  end
  
  def useTicket
    sign_out
    @ticket = check_ticket(params[:token]) # will also purge expired tickets
    if !@ticket.nil?
      #valid ticket
      session[:ticketid] = @ticket.id
      
      if @ticket.cliq_id
        # cliq invite
        redirect_to '/users/acceptInvite'
        
      elsif @ticket.user_id
        # TODO- password reset
        raise "invalid ticket error no pass reset"
      else
        # TODO- invalid ticket
        raise "invalid ticket error"
      end
      
    else
      flash[:error] = "Sorry, your ticket is lost or expired"
      redirect_to root_path
    end
  end
  
  def acceptInvite
    if !defined?(session[:ticketid])
      redirect_to root_path, flash => {:error => "No thank you!"}
    end
    @ticket = Ticket.find(session[:ticketid])
    @cliq = Cliq.find(@ticket.cliq_id)
    @user = User.new(:email => @ticket.email)
    
    if request.post?
      if !params[:user].nil? # new user
        @user = User.new(params[:user])
        if @user.save
          @user.cliqs << @cliq
          @user.profiles << Profile.new({:cliq_id => @cliq.id})
          sign_in @user
          redirect_to users_path, :flash => {:success => "Welcome to cliqs!"}
        end
      else # existing user
        login_user = User.authenticate(params[:session][:email], params[:session][:password])
        if login_user.nil?
          flash.now[:error] = "Invalid login info"
        else # good login info => create cliq association
          sign_in login_user
          # check we are not already a member
          if login_user.cliqs.find_by_id(@cliq).nil?
            login_user.cliqs << @cliq
            redirect_to users_path, :flash => {:success => "Joined new cliq!"}
          else
            redirect_to users_path, :flash => {:error => "You are already in that cliq!"}
          end
        end
      end
    end
  end
  
  def remove_new_user_box
    me = current_user
    me.update_attribute(:how_to_box, false)
  end
  
end
