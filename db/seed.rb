require("pry-byebug")
require_relative("../models/member")
require_relative("../models/gymClass")
require_relative("../models/booking")

Member.delete_all()
GymClass.delete_all()
Booking.delete_all()

#--- Member objects

member1 = Member.new({
"first_name" => "Raymond",
"last_name" => "Yau",
"member_type" => "premium"
})
member1.save()

member2 = Member.new({
  "first_name" => "Rique",
  "last_name" => "Batista",
  "member_type" => "standard"
  })
  member2.save()

  member3 = Member.new({
    "first_name" => "Colin",
    "last_name" => "Bell",
    "member_type" => "standard"
    })
    member3.save()

    #--- Gym Class Objects

    spinClass1 = GymClass.new({
      "instructor_name" => "Jane Doe",
      "class_name" => "Spin Class",
      "empty_spaces" => 20
      })
      spinClass1.save()

      pumpClass1 = GymClass.new({
        "instructor_name" => "John Doe",
        "class_name" => "Pump Class",
        "empty_spaces" => 10
        })
        pumpClass1.save()


        Member.find_all()
        GymClass.find_all()

        member1.book(spinClass1)
        member2.book(spinClass1)
        member1.book(spinClass1)

        member1.first_name = "Ray"
        member1.update

        spinClass1.book(member3)
        spinClass1.book(member3)

        spinClass1.cancelBooking(member3)

        spinClass1.instructor_name = "bob"
        spinClass1.update


        binding.pry
        nil
