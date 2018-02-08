require 'pry'

class Pokemon
  attr_accessor :name, :type, :db, :id, :hp

  def initialize(params)
    params.each do |k,v|
      self.send("#{k}=", v)
    end
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL

    pokemon = db.execute(sql, id)
    pokemon.flatten!
    pokemon_hash = {name: pokemon[1], id: pokemon[0], type: pokemon[2], hp: pokemon[3]}
    Pokemon.new(pokemon_hash)
  end

  def alter_hp(new_hp, db)
    # sql = <<-SQL
    #   UPDATE pokemon
    #   SET hp = ?
    #   WHERE id = ?
    # SQL

    db.execute('UPDATE pokemon SET hp = ? WHERE id = ?', new_hp, self.id)
  end


end
