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
  def link_to name, url_fragment, mode=:path_only
    case mode
    when :path_only
      base = request.script_name
    when :full_url
      if (request.scheme == 'http' && request.port == 80 ||
          request.scheme == 'https' && request.port == 443)
        port = ""
      else
        port = ":#{request.port}"
      end
      base = "#{request.scheme}://#{request.host}#{port}#{request.script_name}"
    else
      raise "Unknown script_url mode #{mode}"
    end
    "<a href='#{base}#{url_fragment}'>#{name}</a>"
  end
  
  def javascript_include_tag(src)
    "<script src='/javascripts/#{src}'></script>"
  end
  
  def img(name)
    "<img src='images/#{name}' alt='#{name}' />"
  end
end