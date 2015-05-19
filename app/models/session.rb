class Session

  def self.all
    Database.execute("SELECT * FROM sessions")
  end

end

