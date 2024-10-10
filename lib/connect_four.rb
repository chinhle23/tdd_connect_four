class ConnectFour
  def initialize(board=[
    ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
    ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
    ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
    ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
    ['☐', '☐', '☐', '☐', '☐', '☐', '☐'],
    ['☐', '☐', '☐', '☐', '☐', '☐', '☐']
  ])
    @board = board
    @current_piece = '☑'
  end

  def display(board=@board)
    board_str = ''

    board.each do |row|
      board_str << "\n"
      board_str << row.join(' ')
    end

    puts board_str
  end

  def drop_piece(column, piece)
    column -= 1
    lowest_empty_spot = 5
    @board.each_with_index { |row, index| lowest_empty_spot = index if row[column] == '☐' }
    @board[lowest_empty_spot][column] = piece
  end

  def read_input
    column_input = gets.chomp

    exit if column_input == 'exit' || column_input == 'q'

    if column_input.to_i.to_s != column_input || column_input.to_i > 7 || column_input.to_i < 1 
      puts 'Invalid input: Please input a number between 1 and 7'
      return 
    end

    drop_piece(column_input.to_i, @current_piece)
    @current_piece = @current_piece == '☑' ? '☒' : '☑'
  end

  def horizontal_win?(piece)
    @board.any? { 
      |row| row[0..3].all? { |item| item == piece } || row[1..4].all? { |item| item == piece } || row[2..5].all? { |item| item == piece } || row[3..6].all? { |item| item == piece } 
    }
  end

  def vertical_win?(piece)
    for i in 0..6
      column = []

      for j in 0..5
        column << @board[j][i]
      end
      
      return true if column[0..3].all? { |item| item == piece } || column[1..4].all? { |item| item == piece } || column[2..5].all? { |item| item == piece } 
    end
    false   
  end
end
  