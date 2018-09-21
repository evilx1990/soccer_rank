require_relative './class/soccer.rb'

if ARGV.length > 0
  rank = SoccerRank.new
  rank.action(ARGV[0])
else
  puts 'please add argument(path to file)'
end