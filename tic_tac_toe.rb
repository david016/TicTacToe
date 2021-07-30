class Board
  attr_accessor :all_rows, :p1_symbol, :p2_symbol, :end_of_game, :p1_symbols_placememt, :p2_symbols_placememt
  def initialize(rows=3, columns=3, symbols_needed=3, p1_symbol, p2_symbol)
    @rows=rows
    @columns=columns
    @p1_symbol = p1_symbol
    @p2_symbol = p2_symbol
    @p1_symbols_placememt=[]
    @p2_symbols_placememt=[]
    @used_field =[]
    @all_rows=[]
    @end_of_game = false
    @winning_combinations=[["11","12","13"],["21","22","23"], ["31","32","33"], ["11","21","31"], ["12","22","32"], ["13","23","33"], ["11","22","33"], ["13","22","31"]]
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
  
  def change_symbols(i)
    symbols = [@p1_symbol,@p2_symbol]
    return symbols[i]
  end

  def players_move(num_of_player)
    puts "Player #{num_of_player}: Where do you want to put your symbol?"
    print "Row: "
    row = gets.chomp.to_i
    while !(1..@rows).include?(row)
      puts "Write number between 1 - #{@rows}."
      print "Row: "
      row = gets.chomp.to_i
    end

    print "Column: "
    column = gets.chomp.to_i
    while !(1..@columns).include?(column)
      puts "Write number between 1 - #{@columns}."
      print "Column: "
      column = gets.chomp.to_i
    end
    
    @used_field.push(row.to_s+column.to_s)
    if num_of_player == 1
      if !@p2_symbols_placememt.include?(row.to_s+column.to_s)
        @p1_symbols_placememt.push(row.to_s+column.to_s)
      end
    else
      if !@p1_symbols_placememt.include?(row.to_s+column.to_s)
        @p2_symbols_placememt.push(row.to_s+column.to_s)
      end
    end
    if @winning_combinations.any? {|arr| arr.all?{|el| @p1_symbols_placememt.include?(el)}}
      @end_of_game=true
      puts "Player 1 won!"
    elsif @winning_combinations.any? {|arr| arr.all?{|el| @p1_symbols_placememt.include?(el)}}
      @end_of_game=true
      puts "Player 2 won!"
    end

    return [row,column]
  end
  
  def write_symbol(symbol,row_column)
    if @used_field.count(row_column[0].to_s+row_column[1].to_s)>1
      puts "That field is already taken. Choose another one."
      return
    else
      @all_rows[row_column[0]-1][row_column[1]*2+1]=symbol
    end
    return symbol
  end
  
  def gameplay
    num_of_moves=0
    i=0
    j=1
    while num_of_moves<9 do 
      if @end_of_game
        break
      end
      symbol = write_symbol(change_symbols(i),players_move(i+1))
      if !symbol
        next
      end
      i=i+1*j
      j*=-1
      num_of_moves+=1
      show_board    
    end
    if end_of_game==false
      puts "Nobody won."
    end
  end
end

class Player
  attr_reader :symbol
  def initialize(symbol)
    @symbol = symbol
  end
end

def choose_symbol
  print "Choose your symbol (x / o): "
  symbol_p1 = gets.chomp
  while !["x","o"].include?(symbol_p1)
    print "Choose your symbol (x / o): "
    symbol_p1 = gets.chomp
  end
  
  symbol_p1 == "x" ? symbol_p2 = "o" : symbol_p2 = "x"
  return [symbol_p1, symbol_p2]
end

symbols = choose_symbol
player1 = Player.new(symbols[0])
player2 = Player.new(symbols[1])

board1 = Board.new(3,3,3,player1.symbol, player2.symbol)
board1.build_rows
board1.show_board
board1.gameplay