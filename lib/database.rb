require 'sqlite3'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS [session] (
      [ids]             INTEGER  NOT NULL  check(typeof("ids") = 'integer'),
      [sensor_ids]      INTEGER  NOT NULL  check(typeof("sensor_ids") = 'integer'),
      [pressure_values] INTEGER  NOT NULL  check(typeof("pressure_values") = 'integer'),
      [time_stamps]     DATETIME NOT NULL
    );
    SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = ENV["TEST"] ? "test" : "production"
    database = "db/serial_parser_storage_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
  end
end
