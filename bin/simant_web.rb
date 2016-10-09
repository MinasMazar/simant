require "simant"
require "sinatra"
require "haml"

settings.views = File.expand_path "../../assets/views/", __FILE__

helpers do
  def next_iteration
  end
  def prev_iteration
  end
end

get "/" do
  haml :simulate
end

get "/iteration" do
  haml <<-EOH
%table#world
  %tr
    %td 1
    %td 2
  %tr
    %td 3
    %td 4
EOH

end
