require_relative('../db/sql_runner.rb')

class Type

  attr_accessor :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = 'INSERT INTO types
    (name) VALUES ($1)
    RETURNING id'
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def update
    sql = 'UPDATE types
    SET name = $1
    WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE from types
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM types"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM types ORDER BY name"
    results = SqlRunner.run(sql)
    types = results.map {|type| Type.new(type)}
    return types
  end

  def self.find(id)
    sql = "SELECT * FROM types
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Type.new(results.first)
  end

end
