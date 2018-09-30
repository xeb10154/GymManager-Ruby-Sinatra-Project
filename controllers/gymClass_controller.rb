require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/member")
require_relative("../models/gymClass")
require_relative("../models/booking")
also_reload("../models/*")

get "/gymclass" do
  erb(:"gymclass/index")
end

get "/gymclass/:id" do
  @gymclass
  erb(:"gymclass/show")
end
