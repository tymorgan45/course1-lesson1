# Edge cases & additional logic
# Have computer block two in a row
# Only allow user to pick an empty position
require 'pry'

def initialize_board
  b = {}
  (1..9).each { |position| b[position] = " "}
  b
end

def draw_board(b)
  system ('clear')
  puts "#{b[1]}|#{b[2]}|#{b[3]}"
  puts "-+-+-"
  puts "#{b[4]}|#{b[5]}|#{b[6]}"
  puts "-+-+-"
  puts "#{b[7]}|#{b[8]}|#{b[9]}"
end

board = initialize_board
draw_board(board)

def player_picks_position(b)
  begin
    puts "Pick any open position (1-9)"
    position = gets.chomp.to_i
    if b[position] != " "
      puts "Oops, that position is taken. Try again"
    end
  end until b[position] == " "
  b[position] = 'x'
end

def empty_positions(b)
  b.select { |k, v| v == " "}.keys
end

def comp_picks_position(b)
  position = empty_positions(b).sample
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    if b.values_at(*line).count('x') == 2 and b.values_at(*line).count("o") == 0
      line.each do |key|
        position = key if b[key] == " "
      end
    end 
  end
  b[position] = 'o'
end

def all_positions_full?(b)
  if empty_positions(b).empty?
    return true
  else
    nil
  end
end

def winner?(b)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    return "Player" if b.values_at(*line).count('x') == 3
    return "Computer" if b.values_at(*line).count('o') == 3
  end
  nil
end

begin
  player_picks_position(board)
  draw_board(board)
  winner = winner?(board)
  if winner
    break
  end
  comp_picks_position(board)
  draw_board(board)
  winner = winner?(board)
end until winner || all_positions_full?(board)

if winner
  puts "#{winner} won!"
else
  puts "Cat's Game"
end




