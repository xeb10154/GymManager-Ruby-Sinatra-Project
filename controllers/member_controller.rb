require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/member")
require_relative("../models/gymClass")
require_relative("../models/booking")
also_reload("../models/*")

get "/member" do
  @members = Member.find_all()
  erb(:"member/index")
end

get "/member/new" do
  erb(:"member/new")
end

get "/member/:id" do
  @member = Member.find(params[:id])
  erb(:"member/show")
end

get "/member/:id/edit" do
  @member = Member.find(params[:id])
  erb(:"member/edit")
end

post "/member" do
  @member = Member.new(params)
  @member.save()
  erb(:"member/confirm")
end
