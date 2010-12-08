module Twitter
  class Search
    def total_pages
      (1500 / (@query[:per_page] || 10)).to_i
    end
    def current_page
      @query[:page].to_i
    end
    def previous_page
      @query[:page].to_i - 1
    end
    def next_page
      @query[:page].to_i + 1
    end
  end
end

class TweetsController < ApplicationController

  def index
    render 'home/index' unless current_user
    search = Twitter::Search.new
    @tweets = search.containing('ruby').language('en').page(params[:page] || 1).per_page(params[:per_page] || 10)
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
