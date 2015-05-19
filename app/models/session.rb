class Session

  def self.all
    Database.execute("SELECT * FROM sessions")
  end

  def self.count
    0
  end

end

