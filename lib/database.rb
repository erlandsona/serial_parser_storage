require 'sqlite3'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS [sessions] (
      [id]             INTEGER  NOT NULL  check(typeof("id") = 'integer'),
      [sensor_id]      INTEGER  NOT NULL  check(typeof("sensor_id") = 'integer'),
      [pressure_value] INTEGER  NOT NULL  check(typeof("pressure_value") = 'integer'),
      [time_stamp]     DATETIME NOT NULL
    );
    SQL
  end

  def self.initialize_database
    environment = ENV["TEST"] ? "test" : "production"
    database = "db/serial_parser_storage_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.prepare(*args)
    initialize_database unless defined?(@@db)
    @@db.prepare(*args)
  end

  def self.transaction(*args, &block)
    initialize_database unless defined?(@@db)
    @@db.transaction(*args, &block)
  end

end
