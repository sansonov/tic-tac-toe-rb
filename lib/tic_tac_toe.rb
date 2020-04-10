require 'pry'

WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #1 coluna
  [1, 4, 7], #2 coluna
  [2, 5, 8], #3 coluna
  [0, 4, 8], #1 diagonal
  [2, 4, 6] #2 diagonal
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(choice)
  choice_int = choice.to_i - 1 
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if (0..8).to_a.include?(index) && position_taken?(board, index) == false
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  choice = gets.strip
  index = input_to_index(choice)

  if valid_move?(board, index) == true
  move(board, index, current_player(board))
  display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X" || token == "O"
      counter +=1
    end
  end
  return counter
end


def current_player(board)
  turn = turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end

def full?(board)
  if board.any?(" ")
    false
  else
    true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    if board[won?(board)[0]] == "X"
      return "X"
    elsif board[won?(board)[0]] == "O"
      return "O"
    else
      nil
    end
  end
end


def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end


def introduction
  board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  
  puts "Welcome to Tic Tac Toe!"
  display_board(board)
end
  
  
def one_more?
  board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  puts "Do you wanna play again? (y/n)"
  again = gets.strip
  if again == "n"
    puts "Thank you for playing with us!"
  elsif again == "y"
    introduction
    play(board)
  else
    puts "I understand y or n, BITCH!"
    puts "Enter a valid command!"
    one_more?
  end
end


