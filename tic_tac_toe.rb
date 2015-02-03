# Draw board w/ positions 1-9
# Loop until winner or board full
#   Player picks square
#     Check for winner
#     Check for all squares full
#   Computer picks square
#     Check for winner
#     Check for all squares full
# Display result of game

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
  puts "Pick position (1-9)"
  position = gets.chomp.to_i
  b[position] = 'x'
end

def empty_positions(b)
  b.select { |k, v| v == " "}.keys
end

def comp_picks_position(b)
  position = empty_positions(b).sample
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
    if b[line[0]] == 'x' and b[line[1]] == 'x' and b[line[2]] == 'x'
      return "Player"
    elsif b[line[0]] == 'o' and b[line[1]] == 'o' and b[line[2]] == 'o'
      return "Computer"
    else
      return nil
    end
  end
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




