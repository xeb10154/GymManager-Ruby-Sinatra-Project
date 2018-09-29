require("pry-byebug")
require_relative("../db/sql_runner")

class GymClass

  attr_accessor :instructor_name, :class_name, :empty_spaces
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @instructor_name = options["instructor_name"]
    @class_name = options["class_name"]
    @empty_spaces = options["empty_spaces"].to_i
  end

  def save()
    sql = "INSERT INTO gymclasses (instructor_name, class_name, empty_spaces)
    VALUES
    ($1, $2, $3)
    RETURNING id"

    values = [@instructor_name, @class_name, @empty_spaces]
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
    sql = "UPDATE gymclasses SET empty_spaces = $1 WHERE id = $2"

    values = [@empty_spaces ,@id]
    SqlRunner.run(sql, values)
  end

  # Only select members.* so that only those variables are mapped
  def member()
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



end
