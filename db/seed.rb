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

      member4 = Member.new({
        "first_name" => "Leah",
        "last_name" => "Meromy",
        "member_type" => "premium"
        })
        member4.save()

        #--- Gym Class Objects

        spinClass1 = GymClass.new({
          "instructor_name" => "Jane Doe",
          "class_name" => "Spin Class",
          "max_spaces" => 20,
          "start_time" => "Tue Oct 2 08:30:20 GMT 2018"
          })
          spinClass1.save()

          pumpClass1 = GymClass.new({
            "instructor_name" => "John Doe",
            "class_name" => "Pump Class",
            "max_spaces" => 10,
            "start_time" => "Tue Oct 2 10:15:00 GMT 2018"
            })
            pumpClass1.save()

            bumsClass1 = GymClass.new({
              "instructor_name" => "Selina J",
              "class_name" => "Bums Class",
              "max_spaces" => 3,
              "start_time" => "Tue Oct 2 12:45:00 GMT 2018"
              })
              bumsClass1.save()



              Member.find_all()
              GymClass.find_all()

              # member1.book(spinClass1)
              # member2.book(spinClass1)
              # member1.book(spinClass1)

              member1.first_name = "Ray"
              member1.update

              # spinClass1.book(member3)
              # spinClass1.book(member3)

              # spinClass1.cancelBooking(member3)

              pumpClass1.book(member2)

              spinClass1.instructor_name = "bob"
              spinClass1.update

              spinClass1.book(member4)

              # Testing time conditions
              t1 = Time.new(2018, 10, 2, 7, 0, 10, 0)
              t2 = Time.new(2018, 10, 2, 9, 0, 10, 0)

              p1 = t1.strftime("%H%M%S%N")
              p2 = t2.strftime("%H%M%S%N")

              test1 = p1 < p2

              bool_true = spinClass1.start_time.between?(t1, t2)
              bool_false = pumpClass1.start_time.between?(t1, t2)

              # Testing extra functionality - filtering

              reduced = spinClass1.reducedList

              binding.pry
              nil
