class Admin::RegistrationsController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :authorize
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
    end
  end

  private
    def set_user
      @user = User.find(params[:user][:id])
    end

    def user_params
      params.require(:user)
        .permit(:id, :name, :email, :encrypted_password, :reset_password_token,
                :confirmation_token, :unconfirmed_email, :avatar, :admin)
      # authorizeメソッドで権限が確認されたadminユーザならブラウザでadminかどうか編集してよいことにする
    end

    def authorize
      redirect_to root_path unless current_user.admin?
    end
end
