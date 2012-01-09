require 'sinatra'

set :static, true
set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  erb :index, :layout => !request.xhr?
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
end
