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
end
  