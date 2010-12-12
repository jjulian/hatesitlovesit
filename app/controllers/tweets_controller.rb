class TweetsController < ApplicationController
  
  before_filter do
    render 'home/index' unless current_user
  end

  def index
    @tweets = current_user.twitter.home_timeline
  end
  
  def public
    @tweets = Twitter.public_timeline
    render :index
  end
  
  def search
    if params[:q].present?
      search = Twitter::Search.new
      @tweets = search.containing(params[:q]).language('en').per_page(params[:per_page] || 25)
    end
    render :index
  end
  
  def user
    if params[:screen_name].present?
      @tweets = Twitter.user_timeline(params[:screen_name])
    end
    render :index
  end

  def hate
    train(:hate)
  end

  def love
    train(:love)
  end
  
  private
  
  def train(type)
    current_user.train(type, params[:text])
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { render :json => {:success => true} }
    end
  end

end
