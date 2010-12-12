Hatesitlovesit::Application.routes.draw do
  match 'sign_in' => 'users#sign_in', :via => :get, :as => :sign_in
  match 'sign_in_callback' => 'users#sign_in_callback', :via => :get, :as => :sign_in_callback
  match 'sign_out' => 'users#sign_out', :via => :get, :as => :sign_out
  match 'hate' => 'tweets#hate', :via => :post, :as => :hate
  match 'love' => 'tweets#love', :via => :post, :as => :love
  match 'tweets/public' => 'tweets#public', :via => :get, :as => :twitter_public
  match 'tweets/search' => 'tweets#search', :via => :get, :as => :twitter_search
  root :to => "tweets#index", :via => :get
end
