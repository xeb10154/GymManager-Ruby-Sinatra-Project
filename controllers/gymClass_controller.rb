require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/member")
require_relative("../models/gymClass")
require_relative("../models/booking")
also_reload("../models/*")

get "/gymclass" do
  @gymclasses = GymClass.find_all()
  erb(:"gymclass/index")
end

get "/gymclass/new" do
  erb(:"gymclass/new")
end

get "/gymclass/:id" do
  @gymclass = GymClass.find(params[:id])
  erb(:"gymclass/show")
end

get "/gymclass/:id/edit" do
  @gymclass = GymClass.find(params[:id])
  erb(:"gymclass/edit")
end

get "/gymclass/:id/booking" do
  @gymclass = GymClass.find(params[:id])

  @members = Member.find_all()

  # @members = @gymclass.reducedList
  erb(:"gymclass/booking")
end

get "/gymclass/:id/attendees" do
  @gymclass = GymClass.find(params[:id])
  @attendees = @gymclass.members()
  erb (:"gymclass/attendees")
end

post "/gymclass" do
  gymclass = GymClass.new(params)
  gymclass.save()
  # @result = "Successfully saved"
  erb(:"gymclass/create")
end

post "/gymclass/:id/edit" do
  gymclass = GymClass.new(params)
  gymclass.update()
  erb (:"/gymclass/edited")
end

post "/gymclass/:id/delete" do
  @gymclass = GymClass.find(params[:id])
  @gymclass.delete()
  erb (:"/gymclass/deleted")
end

post "/gymclass/:id/booking/:member_id" do
  # binding.pry
  member = Member.find(params[:member_id])
  @gymclass = GymClass.find(params[:id])

  @gymclass.book(member)
  @attendees = @gymclass.members()

  erb (:"gymclass/attendees")
end

post "/gymclass/:id/booking/:member_id/cancel" do

  member = Member.find(params[:member_id])
  @gymclass = GymClass.find(params[:id])

  @gymclass.cancelBooking(member)
  @attendees = @gymclass.members()

  erb (:"gymclass/attendees")
end
