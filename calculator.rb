#asks user what they want
#get inputs
#lets them try again if invalid input
#outputs results

begin
  puts 'Type add, subtract, multiply or divide.'
  action = gets.chomp.downcase
  puts 'Enter to first number'
  num1 = gets.chomp.to_f
  puts 'Enter second number'
  num2 = gets.chomp.to_f
  case action
  when 'add'
    result = num1 + num2
  when 'subtract'
    result = num1 - num2
  when 'multiply'
    result = num1 * num2
  when 'divide'
    result = num1 / num2
  else
    puts "Sorry, I don't recognize that."
  end
  puts "That equals #{result}"
  puts 'Would you like to go again y/n'
  again = gets.chomp
end while again == 'y'

