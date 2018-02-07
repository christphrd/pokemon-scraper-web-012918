require 'pry'

class Pokemon
  attr_reader :name, :type, :db, :id

  def initialize(params)
    @name = params[:name]
    @type = params[:type]
    @id = params[:id]

    @db = params[:db]
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
    pokemon_hash = {name: pokemon[1], id: pokemon[0], type: pokemon[2]}
    Pokemon.new(pokemon_hash)
  end
end
