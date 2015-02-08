# ititialize a deck
# ask player how many chips they want to buy
# ask player for bet
# deal cards to player and dealer
# ask player to hit or stay
#   if player goes over 21 they bust
# show dealer cards
#   if dealer is soft 17 or lower they hit
#     bust if they go over 21
#   if 17 or higher they stay
# if both computer and player have not busted compare hands
#   if player wins credit chip count
#   elsif player loses debit chip count
#   else must be a push player gets original bet back
# ask if they want to play another hand
require 'pry'

def initialize_deck
  { '2 Clubs' => 2, '3 Clubs' => 3, '4 Clubs' => 4, '5 Clubs' => 5, '6 Clubs' => 6, '7 Clubs' => 7, '8 Clubs' => 8, '9 Clubs' => 9, '10 Clubs' => 10, 'Jack Clubs' => 10, 'Queen Clubs' => 10, 'King Clubs' => 10, 'Ace Clubs' => [1, 11], 
    '2 Diamonds' => 2, '3 Diamonds' => 3, '4 Diamonds' => 4, '5 Diamonds' => 5, '6 Diamonds' => 6, '7 Diamonds' => 7, '8 Diamonds' => 8, '9 Diamonds' => 9, '10 Diamonds' => 10, 'Jack Diamonds' => 10, 'Queen Diamonds' => 10, 'King Diamonds' => 10, 'Ace Diamonds' => [1, 11],
    '2 Hearts' => 2, '3 Hearts' => 3, '4 Hearts' => 4, '5 Hearts' => 5, '6 Hearts' => 6, '7 Hearts' => 7, '8 Hearts' => 8, '9 Hearts' => 9, '10 Hearts' => 10, 'Jack Hearts' => 10, 'Queen Hearts' => 10, 'King Hearts' => 10, 'Ace Hearts' => [1, 11],
    '2 Spades' => 2, '3 Spades' => 3, '4 Spades' => 4, '5 Spades' => 5, '6 Spades' => 6, '7 Spades' => 7, '8 Spades' => 8, '9 Spades' => 9, '10 Spades' => 10, 'Jack Spades' => 10, 'Queen Spades' => 10, 'King Spades' => 10, 'Ace Spades' => [1, 11], }
end

def deal(deck) #deck must be in array
  [deck[0], deck[1]]
end

def deck_update(deck) #deck must be in array
  2.times { deck.delete_at(0) }
end

def sum(cards) #cards must be in hash
  sum = 0
  if cards.values.count([1, 11]) == 1
    cards.each do |k, v|
      if v != [1, 11]
        sum += v
      end
    end
    if sum < 11
      sum += 11
    else
      sum += 1 
    end
  elsif cards.values.count([1, 11]) == 2
    cards.each do |k, v|
      if v != [1, 11]
        sum += v
      end
    end
    if sum < 10
      sum += 12
    else
      sum += 2
    end
  elsif cards.values.count([1, 11]) == 3
    cards.each do |k, v|
      if v != [1, 11]
        sum += v
      end
    end
    if sum < 9
      sum += 13
    else
      sum += 3
    end
  elsif cards.values.count([1, 11]) == 4
    cards.each do |k, v|
      if v != [1, 11]
        sum += v
      end
    end
    if sum < 8
      sum += 14
    else
      sum += 4
    end  
  else 
    cards.each do |k, v|
    sum = sum + v
    end
  end
  sum
end

def display_cards(cards, player) #cards must be in hash
  total = sum(cards)
  puts "#{player} cards are #{cards.keys} for a total of #{total}"
end

def hit_or_stay(cards, deck) #cards must be in hash
  puts "Would you like to hit or stay? (h/s)"
  decision = gets.chomp.downcase
  if decision == 's'
    total = sum(cards)
    puts "You are staying at #{total}"
  elsif decision == 'h'
    begin
      cards[deck[0][0]] = deck[0][1]
      total = sum(cards)
      puts "Your card is #{deck[0][0]} for a total of #{total}"
      deck.delete_at(0)
      if total < 21
        puts "Would you like to hit again? (y/n)"
        answer = gets.chomp
      else
        break
      end
    end while answer == 'y'
  end
end

def dealer_plays(dealers_cards, deck)
  while sum(dealers_cards) < 17
    dealers_cards[deck[0][0]] = deck[0][1]
    display_cards(dealers_cards, "Dealer's")
    deck.delete_at(0)
  end
end

puts "Welcome to Blackjack sucker"
puts "How many chips would you like to buy?"
players_chips = gets.chomp.to_i
deck = initialize_deck.to_a.shuffle

begin
  puts "What would you like to bet this hand?"
  bet = gets.chomp.to_i
  players_cards = deal(deck).to_h
  deck_update(deck)
  dealers_cards = deal(deck)
  deck_update(deck)
  display_cards(players_cards, 'Your')
  if sum(players_cards) == 21
    puts "BLACKJACK!!!"
    winnings = bet * 1.5
    players_chips += winnings
    puts "You won $#{winnings} and have a total of $#{players_chips} in chips."
  else
    puts "The dealer is showing #{dealers_cards[0][0]}"
    dealers_cards = dealers_cards.to_h
    hit_or_stay(players_cards, deck)
    if sum(players_cards) > 21
      puts "You busted"
      players_chips -= bet
      puts "You lost $#{bet} and now have $#{players_chips} in chips."
    else
      display_cards(dealers_cards, "Dealer's")
      dealer_plays(dealers_cards, deck)
      dealer_total = sum(dealers_cards)
      player_total = sum(players_cards)
      if player_total == dealer_total
        puts "It's a push, keep your chips"
      elsif dealer_total > 21
        puts "Dealer busts"
        players_chips += bet
        puts "You won $#{bet} and have a total of $#{players_chips} in chips."
      elsif dealer_total > player_total
        puts "Dealer wins"
        players_chips -= bet
        puts "You lost $#{bet} and now have $#{players_chips} in chips."
      elsif player_total > dealer_total 
        puts "You WIN"
        players_chips += bet
        "You won $#{bet} and have a total of $#{players_chips} in chips."
      end
    end
  end
  cards_left = deck.count
  if cards_left < 15
    puts "There are less than 15 cards left. We're going to reshuffle."
    deck = initialize_deck.to_a.shuffle
  end
  puts "Would you like to play again (y/n)"
  play_again = gets.chomp
end while play_again == 'y' 







