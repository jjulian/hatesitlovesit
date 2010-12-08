require 'crm114'
class User < ActiveRecord::Base
  serialize :twitter_profile
  before_validation(:on => :create) { |u| get_profile_from_twitter }
  delegate :screen_name, :to => :twitter_profile

  CONSUMER_KEY = 'nBW6AZvfl0eo6MZArFkqA'
  CONSUMER_SECRET = 'n0d4KapOmK9no3ZhGbnZlbobRzwLoahyzPXFDoHGW44'
  
  def train(type, text)
    crm114.train! "#{screen_name}_#{type.to_s}".to_sym, text
  end
  
  def classify(text)
    crm114.classify text
  end
  
  def self.twitter_oauth
    OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => 'http://api.twitter.com', :request_endpoint => 'http://api.twitter.com', :sign_in => true)
  end
  
  private
  
  def crm114
    @crm114 ||= Classifier::CRM114.new(["#{screen_name}_hate".to_sym,"#{screen_name}_love".to_sym], :path => "tmp")
  end
  
  def get_profile_from_twitter
    if self.twitter_oauth_token && self.twitter_oauth_secret
      begin
        User.twitter_oauth
        Twitter.configure do |config|
          config.consumer_key = CONSUMER_KEY
          config.consumer_secret = CONSUMER_SECRET
          config.oauth_token = twitter_oauth_token
          config.oauth_token_secret = twitter_oauth_secret
        end
        client = Twitter::Client.new
        self.twitter_profile = client.verify_credentials
      rescue Errno::ECONNRESET => e
        logger.error "could not connect to twitter to get user profile: #{e.message}"
        errors.add_to_base('We could not connect to twitter to get user profile.')
        false
      end
    else
      errors.add_to_base('This user is not linked to a twitter account.')
      false
    end
  end
end
