class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  before_action :set_search

  private

  def not_authenticated
    redirect_to login_path, warning: "ログインしてください"
  end

  def set_search
    @q = Vtuber.ransack(params[:q])
    @vtubers = @q.result(distinct: true).order(:id).page(params[:page]).per(20)
  end
end
