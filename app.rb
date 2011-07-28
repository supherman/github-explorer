require 'sinatra'
require 'net/http'
require 'uri'
require 'git'

get '/' do
  erb :index
end

post '/search' do
  url = URI.parse(params[:project])
  http = Net::HTTP.new(url.host, 443) 
  http.use_ssl = true
  
  valid_uri = false
  begin 
  res = http.start { |h| 
    h.head(url.path)
  }
  valid_uri = true
  rescue Errno::ECONNREFUSED
    # log data
  end
  
  res_status = false
  begin
    res.value
    res_status = true
  rescue
    # log data 
  end
  
  if valid_uri
    if res_status
      project_name = url.path.match(/[\w-]+$/)
      unless Dir.exist? "repos/" + project_name[0]
        g = Git.clone("git://github.com" + url.path + ".git", "repos/" + project_name[0])
      end
      g = Git.open("repos/" + project_name[0])
      commits = g.log
      erb :commits, :locals => {:commits => commits}
    else
      "The project doesn't exist on Github"
    end
  else
    "Invalid URL"
  end
end