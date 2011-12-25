require 'sinatra'

set :static, true
set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  erb :index, :layout => !request.xhr?
end

get '/:page_name' do
  erb params[:page_name].to_s, :layout => !request.xhr?
end

helpers do
  def link_to name, url_fragment, mode=:same_window
    case mode
    when :same_window
      "<a href='#{url_fragment}'>#{name}</a>"
    when :new_window
      "<a href='#{url_fragment}' target='_blank'>#{name}</a>"
    else
      raise "Unknown script_url mode #{mode}"
    end
  end
  
  def javascript_include_tag(src)
    "<script src='/javascripts/#{src}'></script>"
  end
  
  def img(name)
    "<img src='images/#{name}' alt='#{name}' />"
  end
end
