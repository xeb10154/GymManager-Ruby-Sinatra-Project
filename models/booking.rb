require("pry-byebug")
require_relative("../db/sql_runner")
require_relative("./gymClass")
require_relative("./member")

class Booking

  attr_accessor :member_id, :gymclass_id
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @member_id = options["member_id"].to_i
    @gymclass_id = options["gymclass_id"].to_i
  end

  def save()
    sql = "INSERT INTO bookings (member_id, gymclass_id)
    VALUES
    ($1, $2)
    RETURNING id"

    values = [@member_id, @gymclass_id]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM bookings"

    SqlRunner.run(sql)

  end

end
