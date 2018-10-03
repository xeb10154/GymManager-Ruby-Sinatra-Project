require("pry-byebug")
require("time")
require_relative("../db/sql_runner")
require_relative("../models/member")

class GymClass

  attr_accessor :instructor_name, :class_name, :empty_spaces, :max_spaces, :start_time
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @instructor_name = options["instructor_name"]
    @class_name = options["class_name"]
    @max_spaces = options["max_spaces"].to_i
    @empty_spaces = self.calcSpaces
    @start_time = Time.parse(options["start_time"])
    # @finish_time
  end

  def save()
    sql = "INSERT INTO gymclasses (instructor_name, class_name, max_spaces, empty_spaces, start_time)
    VALUES
    ($1, $2, $3, $4, $5)
    RETURNING id"

    values = [@instructor_name, @class_name, @max_spaces, @empty_spaces, @start_time]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def delete()
    sql = "DELETE FROM gymclasses WHERE id = $1"

    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM gymclasses"
    SqlRunner.run(sql)
  end

  def self.find_all()
    sql = "SELECT * FROM gymclasses"
    classes_hash = SqlRunner.run(sql)
    # binding.pry
    result = classes_hash.map {|aClass| GymClass.new(aClass)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM gymclasses WHERE id = $1"

    values = [id]
    aClass_hash = SqlRunner.run(sql, values).first
    return GymClass.new(aClass_hash)
  end

  def update()
    sql = "UPDATE gymclasses SET (instructor_name, class_name, max_spaces, empty_spaces, start_time)
    = ($1, $2, $3, $4, $5) WHERE id = $6"

    values = [@instructor_name, @class_name, @max_spaces, @empty_spaces, @start_time, @id]
    SqlRunner.run(sql, values)
  end

  def book(member)
    # check member premium status
    if (@empty_spaces > 0) && member.member_type == "premium" && !doubleBooked(member)

      confirmBooking(member)

      # check the time
    elsif (@empty_spaces > 0) && member.member_type == "standard" && !doubleBooked(member) && peakTime(member) == false

      confirmBooking(member)

      # binding.pry
    end
  end

  def peakTime(member)
    peaktime = false
    # Hard coded times
    # Morning peak times
    t1 = Time.new(2018, 1, 1, 7, 0, 0, 0).strftime("%H%M%S%N")
    t2 = Time.new(2018, 1, 1, 9, 0, 0, 0).strftime("%H%M%S%N")
    # Evening peak times
    t3 = Time.new(2018, 1, 1, 17, 0, 0, 0).strftime("%H%M%S%N")
    t4 = Time.new(2018, 1, 1, 20, 0, 0, 0).strftime("%H%M%S%N")

    current_time = self.start_time.strftime("%H%M%S%N")

    if current_time.between?(t1,t2) || current_time.between?(t3,t4)
      peaktime = true
    end
    return peaktime
  end

  def doubleBooked(member)
    booked = false
    for each in member.gymclasses
      if each.id == @id
        booked = true
      end
      # binding.pry
    end
    return booked
  end

  def cancelBooking(member)
    if (@empty_spaces <= @max_spaces)
      sql = "DELETE FROM bookings WHERE member_id = $1"

      values = [member.id]
      SqlRunner.run(sql, values)

      @empty_spaces += 1
      self.update()
    end
  end

  def confirmBooking(member)
    booking = Booking.new(
      "member_id" => member.id,
      "gymclass_id" => @id
    )
    booking.save()

    @empty_spaces -= 1
    self.update()
  end

  # Only select members.* so that only those variables are mapped
  def members()
    sql = "SELECT members.*
    FROM members INNER JOIN bookings
    ON members.id = bookings.member_id
    WHERE gymclass_id = $1"

    values = [@id]
    member_hash = SqlRunner.run(sql, values)
    result = member_hash.map {|member| Member.new(member)}
    # binding.pry
    return result
  end

  def calcSpaces
    @empty_spaces = @max_spaces - self.members.length
  end

  def reducedList
    reduced = []

    for each in Member.find_all()
      for mem in self.members()
        if each == mem
          # do nothing
        else
          reduced.push(each)
        end
      end
    end

    return reduced

  end

end
