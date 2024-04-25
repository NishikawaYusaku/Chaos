class VtubersController < ApplicationController
  before_action :require_login, except: %i[index show]
  # before_action :youtube

  def index; end

  def show
    @vtuber = Vtuber.find(params[:id])
    @comment = Comment.new
    @comments = @vtuber.comments
  end

  def autocomplete_names
    term = params[:term]
    names = Vtuber.where('name LIKE ?', "%#{term}%").pluck(:name)
    render json: names
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
    @tag = params[:vtuber][:tag]
    if @vtuber.save
      VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save
      tag_list = params[:vtuber][:tag].delete(' ').delete('　').split('、')
      @vtuber.save_tags(tag_list)
      redirect_to vtuber_path(@vtuber)
      flash[:success] = "VTuberを登録しました"
    else
      flash.now[:danger] = "VTuberを登録できませんでした"
      render :new
    end
  end

  def edit
    @vtuber = Vtuber.find_by(id: params[:id])
    @tag = @vtuber.tags.pluck(:name).join('、')
  end

  def update
    @vtuber = Vtuber.find(params[:id])
    @tag = params[:vtuber][:tag]
    if @vtuber.update(vtuber_params)
      VtuberUser.new(user_id: current_user.id, vtuber_id: @vtuber.id).save
      tag_list = params[:vtuber][:tag].delete(' ').delete('　').split('、')
      @vtuber.save_tags(tag_list)
      redirect_to vtuber_path(@vtuber)
      flash[:success] = "VTuberを更新しました"
    else
      flash.now[:danger] = "VTuberを更新できませんでした"
      render :edit
    end
  end

  private

  # def youtube
  #   require 'google/apis/youtube_v3'
  #   @youtube = Google::Apis::YoutubeV3::YouTubeService.new
  #   @youtube.key = ENV['GOOGLE_API_KEY']
  # end

  def vtuber_params
    params.require(:vtuber).permit(:name, :name_x, :gender, :birthday, :debut_date, :like, :unlike, :image, vtuber_places_attributes: [:place_id, :url, :_destroy, :id], content_ids: [])
  end
end