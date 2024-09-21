class VtubersController < ApplicationController
  before_action :require_login, except: %i[index show]

  def index; end

  def show
    @vtuber = Vtuber.find(params[:id])
    @comment = Comment.new
    @comments = @vtuber.comments
  
    place_url = @vtuber.vtuber_places.last.url
    if place_url.include?("youtube")
      require 'google/apis/youtube_v3'
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = ENV['GOOGLE_API_KEY']

      if place_url.include?("@")
        youtube_handle = place_url[place_url.index("@")..-1]
        youtube_id = Rails.cache.fetch("youtube_handle_to_id_#{youtube_handle}", expires_in: 12.hours) do
          youtube_handle_to_id = youtube.list_searches("snippet", q: youtube_handle, type: "channel", max_results: 1).to_h
          youtube_handle_to_id[:items][0][:id][:channel_id]
        end
      elsif place_url.include?("/UC")
        youtube_id = place_url[place_url.index("/UC")+1..-1]
      end
      
      @youtube_channel = Rails.cache.fetch("youtube_channel_#{youtube_id}", expires_in: 12.hours) do
        youtube.list_channels("statistics", id: youtube_id).to_h
      end
      @youtube_video = Rails.cache.fetch("youtube_video_#{youtube_id}", expires_in: 12.hours) do
        youtube.list_searches("snippet", channel_id: youtube_id, type: 'video', max_results: 1, order: :date).to_h
      end
    end
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

  def vtuber_params
    params.require(:vtuber).permit(:name, :name_x, :gender, :birthday, :debut_date, :like, :unlike, :image, vtuber_places_attributes: [:place_id, :url, :_destroy, :id], content_ids: [])
  end
end