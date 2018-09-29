DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS gymClasses;

CREATE TABLE members (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  member_type VARCHAR(255)
);

CREATE TABLE gymclasses (
  id SERIAL4 PRIMARY KEY,
  instructor_name VARCHAR(255),
  class_name VARCHAR(255),
  empty_spaces INT2
);

CREATE TABLE bookings (
  id SERIAL4,
  gymclass_id INT4 REFERENCES gymclasses(id) ON DELETE CASCADE,
  member_id INT4 REFERENCES members(id) ON DELETE CASCADE
  -- start_time VARCHAR(255)
);
