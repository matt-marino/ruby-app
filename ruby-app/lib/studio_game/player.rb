require_relative "treasure_trove"
require_relative "playable"

module StudioGame
  class Player
    include Playable

    attr_accessor :name
    attr_accessor :health
    def initialize(name, health = 100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def to_s
      "I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score}."
    end

    def score
      @health + points
    end

    def <=>(other)
      other.score <=> score
    end

    def found_treasure(treasure)
      @found_treasures[treasure.name] += treasure.points
      puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
      puts "#{@name}'s treasures: #{@found_treasures}"
    end

    def points
      @found_treasures.values.reduce(0, :+)
    end

    def each_found_treasure
      @found_treasures.each { |name, points| yield Treasure.new(name, points) }
    end

    def self.from_csv(string)
      name, health = string.split(",")
      Player.new(name, Integer(health))
    end
  end
end
