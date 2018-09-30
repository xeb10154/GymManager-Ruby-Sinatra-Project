require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/member")
require_relative("../models/gymClass")
require_relative("../models/booking")
also_reload("../models/*")

get "/member" do
  erb(:"member/index")
end

get "/member/new" do
  @member =
  erb(:"member/new")
end

get "/member/:id" do
  # @member
  erb(:"member/show")
end
