require_relative "player"
require_relative "die"
require_relative "game_turn"
require_relative "treasure_trove"
require "csv"

class Game
  attr_reader :title
  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(a_player)
    @players << a_player
  end

  def print_name_and_health(player)
    puts "#{player.name} (#{player.health})"
  end

  def print_stats
    strong_players = @players.select { |player| player.strong? }
    wimpy_players = @players.reject { |player| player.strong? }

    # or

    # strong_players, wimpy_players = @players.partition { |player| player.strong? }
    puts "\n#{@title} Statistics:"

    puts "\n#{strong_players.size} strong players:"
    strong_players.each { |player| print_name_and_health(player) }

    puts "\n#{wimpy_players.size} wimpy players:"
    wimpy_players.each { |player| print_name_and_health(player) }
    sorted_players = @players.sort { |a, b| b.score <=> a.score }
    puts "\n#{@title} High Scores:"
    @players.sort.each { |player| puts high_score_entry(player) }
    @players.sort.each do |player|
      puts "\n#{player.name}'s point totals:"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      puts "#{player.points} grand total points"
    end
    puts "#{total_points} total points from treasures found"
  end

  def play(rounds)
    treasures = TreasureTrove::TREASURES
    puts "\nThere are #{treasures.size} treasures to be found:"
    treasures.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points"
    end
    puts "There are #{@players.size} players in #{@title}: "
    @players.each { |player| puts player }

    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  def total_points
    @players.reduce(0) { |sum, player| sum + player.points }
  end

  def load_players(from_file)
    File.readlines(from_file).each { |line| add_player(Player.from_csv(line)) }
  end

  def save_high_scores(to_file = "high_scores.txt")
    File.open(to_file, "w") do |file|
      file.puts "#{@title} High Scores:"
      @players.sort.each { |player| file.puts high_score_entry(player) }
    end
  end

  def high_score_entry(player)
    formatted_name = player.name.ljust(20, ".")
    "#{formatted_name} #{player.score}"
  end
end
