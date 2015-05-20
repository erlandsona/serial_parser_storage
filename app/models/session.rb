class Session

  def self.find(id: nil, sensor_id: nil, pressure_value: nil)
    statement = "SELECT * FROM sessions"
    arguments = {id: id, sensor_id: sensor_id, pressure_value: pressure_value}.reject{|k, v| v.nil?}
    unless arguments.empty?
      statement << " WHERE"
      statement << arguments.map { |key, val| " #{key.to_s}=#{val.to_s}" }.join(' AND')
    end
    statement << ";"
    Database.execute(statement)
  end

  def self.pragma
    Database.execute("PRAGMA sessions")
  end

end

