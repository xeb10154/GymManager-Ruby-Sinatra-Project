require("pry-byebug")
require_relative("../db/sql_runner")
require_relative("./booking")

class Member

  attr_accessor :first_name, :last_name, :member_type
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @member_type = options["member_type"]
  end

  def save()
    sql = "INSERT INTO members (first_name, last_name, member_type)
    VALUES
    ($1, $2, $3)
    RETURNING id"

    values = [@first_name, @last_name, @member_type]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def delete()
    sql = "DELETE FROM members WHERE id = $1"

    values = [@id]
    SqlRunner.run(sql, values)

  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def self.find_all()
    sql = "SELECT * FROM members"
    members_hash = SqlRunner.run(sql)
    return members_hash.map {|member| Member.new(member)}
  end

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1"

    values = [id]
    member_hash = SqlRunner.run(sql, values).first
    return Member.new(member_hash)
  end

  def fullName()
    return "#{@first_name} #{@last_name}"
  end

  def book(aClass)
    if (aClass.empty_spaces > 0) && (doubleBooked(aClass) == false)
      booking = Booking.new(
        "member_id" => @id,
        "gymclass_id" => aClass.id
      )
      booking.save()

      aClass.empty_spaces -= 1
      aClass.update()
    end
  end

  def doubleBooked(aClass)
    booked = false
    for each in aClass.member
      if each.id == @id
        booked = true
      end
      # binding.pry
    end
    return booked
  end



end
