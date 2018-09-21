class SoccerRank
  TEAM = /((\w+\s\w+|\w+)\s)/i
  COUNT = /(\d+)$/

  def initialize
    @arr = []
    @table = {}
  end

  def action(filename)
    begin
      if File.exist?(filename)
        file = File.open(filename)
        file.readlines.each { |line| @arr << line.chomp }
        file.close
        create_table!
        rank_calc
        show_table
      end
    rescue
      puts 'wrong file'
      nil
    end
  end

  private

  def show_table
    @table = @table.sort_by { |_key, val| val }.reverse.to_h
    i = 0
    @table.each { |k, v| puts "#{i += 1}. #{k}, #{v} pts" }
  end

  def create_table!
    unless @arr.empty? # если есть записи
      @arr.each do |str| # итерируемся по ним
        str.split(', ').each { |str1| @table[str1[TEAM].chomp(' ')] = 0 } # создаем таблицу команд в хеше
      end
    end
  end

  def rank_calc
    unless @arr.empty?
      @arr.each do |str|
        tmp_arr = str.split(', ')

        count1 = tmp_arr[0][COUNT]
        count2 = tmp_arr[1][COUNT]
        team1 = tmp_arr[0][TEAM].chomp(' ')
        team2 = tmp_arr[1][TEAM].chomp(' ')

        if count1 > count2
          @table[team1] += 3
        elsif count1 < count2
          @table[team2] += 3
        else
          @table[team1] += 1
          @table[team2] += 1
        end
      end
    end
  end
end
