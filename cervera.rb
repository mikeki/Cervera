require 'sinatra'
require 'twitter'
require 'dalli'

set :static, true
set :public_folder, File.dirname(__FILE__) + '/public'
set :cache, Dalli::Client.new

get '/' do
  @twitter = get_twitter_feed
  erb :index, :layout => false
end

get '/:page_name' do
  begin
    erb params[:page_name].to_sym, :layout => :content
  rescue
    erb :notFound
  end
end

helpers do
  def link_to name, url_fragment, options = {}
    link = "<a href='#{url_fragment}' "
    link += "target='_blank' " if options[:mode] == :new_window
    link += "class='#{options[:class]}'" if options[:class]
    link += ">#{name}</a>"
  end
  
  def javascript_include_tag(src)
    "<script src='/javascripts/#{src}'></script>"
  end
  
  def img(name)
    "<img src='images/#{name}' alt='#{name}' />"
  end
  
  def get_twitter_feed
    begin
      twitter = Twitter.user_timeline("MiguelCervera")[0..5]
    rescue
      twitter = []
    end
    twitter.insert 0, "Follow me at @MiguelCervera"
  end
end
