class UsersController < ApplicationController
before_filter :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    Stripe.api_key = "sk_test_Aljpxmr0B3B61NXZCx4eXOsG"
    token = params[:stripeToken]
 
    if @user.valid?
      begin
        charge = Stripe::Charge.create(
          :amount => 999,
          :currency => "usd",
          :card => token,
          :description => @user.email
        )
        @user.save
        handle_invitation
        MyflixMailer.send_welcome_email(@user).deliver
        flash[:success] = "You have successfully registered. Please sign in."
        redirect_to sign_in_path
      rescue Stripe::CardError => e
        flash[:error] = e.message
        render :new
      end
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.where(token: params[:invitation_token]).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end
  
end