class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  before_action :set_search

  private

  def not_authenticated
    redirect_to login_path, warning: "ログインしてください"
  end

  def set_search
    if params[:tag]
      @q = Vtuber.joins(:tags).where(tags: { name: params[:tag] })
      @vtubers = @q.order(:id).page(params[:page]).per(20)
      @tag_name = params[:tag]
    else
      @query = { name_or_affiliation_or_gender_or_like_or_unlike_or_contents_name_or_places_name_or_tags_name_cont: params[:q] }
      @q = Vtuber.ransack(@query)
      @vtubers = @q.result(distinct: true).order(:id).page(params[:page]).per(20)
    end
  end
end