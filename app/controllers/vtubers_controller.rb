class VtubersController < ApplicationController
  before_action :require_login, except: %i[index show]
  # before_action :youtube

  def index; end

  def show
    @vtuber = Vtuber.find(params[:id])
    @comment = Comment.new
    @comments = @vtuber.comments
  end

  def name_input
    @vtuber = Vtuber.find_by(name: params[:name])

    if @vtuber
      redirect_to action: 'edit', id: @vtuber.id
    else
      redirect_to action: 'new', name: params[:name]
    end
  end

  def new
    @vtuber = Vtuber.new(name: params[:name])
    @vtuber_place = @vtuber.vtuber_places.new
  end

  def create
    @vtuber = current_user.vtubers.new(vtuber_params)
    
    # binding.pry
    if @vtuber.save
      VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save
      # VtuberPlace.new(vtuber_id: @vtuber.id, place_id: params[:vtuber][:place_id], url: params[:vtuber][:url]).save
      # binding.pry
      redirect_to show_path(@vtuber)
      flash[:success] = "VTuberを登録しました"
    else
      flash.now[:danger] = "VTuberを登録できませんでした"
      render :new
    end
  end

  def edit
    @vtuber = Vtuber.find_by(id: params[:id])
  end

  def update
    @vtuber = Vtuber.find(params[:id])
    # @vtuber_user = VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id)
    # @vtuber_place = VtuberPlace.find_by(url: params[:vtuber][:url])
=begin
    if @vtuber_place
      @vtuber_place.update(vtuber_id: current_user.id, place_id: params[:vtuber][:place_ids], url: params[:vtuber][:url])
    end
=end
    if @vtuber.update(vtuber_params)
      @vtuber_user = VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id)
      @vtuber_user.save
      redirect_to show_path(@vtuber)
      flash[:success] = "VTuberを更新しました"
    else
      flash.now[:danger] = "VTuberを更新できませんでした"
      render :edit
    end
  end

  private

  def youtube
    require 'google/apis/youtube_v3'
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = ENV['GOOGLE_API_KEY']
  end

  def vtuber_params
    # params.require(:vtuber).permit( :name, :image, :debut_date, :fan_name, :like, :unlike, :gender, :name_x, content_ids: [] )
    params.require(:vtuber).permit(:name, :image, :debut_date, :fan_name, :like, :unlike, :gender, :name_x, content_ids: [], vtuber_places_attributes: [:place_id, :url, :_destroy, :id])
  end
end
# if  @vtuber_place.update


=begin
@_runteq_
UCwjx6ZG4pwCvAPSozYEWymA
=end

=begin
https://www.youtube.com/@_runteq_
=end