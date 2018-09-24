class SoccerRank
  RGXP= /(\w+\s\w+|\w+)\s(\d+)..(\w+\s\w+|\w+)\s(\d+)/i

  def initialize
    @arr = []
    @table = {}
  end

  def action(filename)
    begin
      if File.exist?(filename)
        file = File.open(filename)
        file.readlines.each { |line| @arr << line.match(RGXP).captures }
        file.close
        create_table
        rank_calc
        show_table
      end
    rescue
      puts 'wrong file'
      nil
    end
  end

  private

  def create_table
    @arr.each do |game|
      @table[game[0]] = 0
      @table[game[2]] = 0
    end
  end

  def rank_calc
    unless @arr.empty?
      @arr.each do |team|
        if team[1] > team[3]
          @table[team[0]] += 3
        elsif team[1] < team[3]
          @table[team[2]] += 3
        else
          @table[team[0]] += 1
          @table[team[2]] += 1
        end
      end
    end
  end

  def show_table
    @table = @table.sort_by { |key, _val| key }.reverse.to_h # Сортируем по ключу, чтобы после сортировки по значению, команды
    @table = @table.sort_by { |_key, val| val }.reverse.to_h # с одинаковым количеством очков были отсортированы по алфавиту
    i = 0
    @table.each { |k, v| puts "#{i += 1}. #{k}, #{v} pts" }
  end
end