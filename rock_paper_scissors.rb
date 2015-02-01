
begin
  puts  'Lets play rock paper scissors'
  puts 'Pick R/P/S'
  choice = gets.chomp.downcase
  comp = rand(2)
  case comp
  when 0
    comp = 'r'
  when 1
    comp = 'p'
  when 2
    comp = 's'
  end
  # converts rand num to r/p/s
  if choice == 'r' && comp == 'r'
    puts "It's a tie"
  elsif choice == 'r' && comp == 'p'
    puts "You Lose. Paper wraps rock"
  elsif choice == 'r' && comp == 's'
    puts "You WIN! Rock smashes paper"
  elsif choice == 'p' && comp == 'r'
    puts "You WIN! Paper wraps rock"
  elsif choice == 'p' && comp == 'p'
    puts "It's a tie"
  elsif choice == 'p' && comp == 's'
    puts "You Lose. Scissors cut paper"
  elsif choice == 's' && comp == 'r'
    puts "You Lose. Rock smashes scissors"
  elsif choice == 's' && comp == 'p'
    puts "You WIN! Scissors cut paper"
  elsif choice == 's' && comp == 's'
    puts "It's a tie"
  else
    puts "I didn't recognize your choice."
  end
  #Logic to find winner
  puts "Do you want to play again? y/n"
  again = gets.chomp
end while again == 'y'
    

