require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("./controllers/member_controller")
require_relative("./controllers/gymclass_controller")
also_reload("./models/*")

get "/" do
  erb(:index)
end
