class Board
  
  def initialize(rows=3, columns=3, symbols_needed=3)
    @rows=rows
    @columns=columns
    @all_rows=[]
  end

  def build_row
    basic_row=[0]
    for i in 1..@columns+1 do
      basic_row.push(" ")
      basic_row.push("|")
    end
    basic_row
  end

  def build_rows
    for i in 1..@rows do
      basic_row=self.build_row
      basic_row[0]=i
      @all_rows.push(basic_row)
    end

    @all_rows  
  end
  
  def show_board
    @all_rows.each do |row|
      puts row.join
    end
  end

  def show_rows
    p @all_rows
  end
end
 

puts "How many rows do you want in your game of tic-tac-toe?"
rows = gets.chomp.to_i

puts "How many columns do you want in your game of tic-tac-toe?"
columns=gets.chomp.to_i

puts "How many same symbols are neede for a win?"
symbols_needed = gets.chomp.to_i


board1 = Board.new(rows, columns, symbols)
board1.build_rows
board1.show_board