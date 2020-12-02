class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:deactivate]
  before_action :authorize_can_manage_users

  add_breadcrumb I18n.t(:label_payments), :payments_path
  add_breadcrumb I18n.t(:label_users), :users_path

  def index
    page = params[:page] || 1
    @users = User.where.not(id: current_user.id).page page
  end

  def deactivate
    @user.active = false
    @user.save!

    respond_to do |format|
      format.html { redirect_to users_path }
      format.any  { head :ok }
    end
  end

  private

  def find_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
        format.any  { head :not_found }
      end
    end
  end

  def authorize_can_manage_users
    authorize! :manage_users, User.new
  end
end
