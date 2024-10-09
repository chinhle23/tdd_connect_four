class ConnectFour
  def initialize(board=[
    ['☐','☐','☐','☐','☐','☐','☐'],
    ['☐','☐','☐','☐','☐','☐','☐'],
    ['☐','☐','☐','☐','☐','☐','☐'],
    ['☐','☐','☐','☐','☐','☐','☐'],
    ['☐','☐','☐','☐','☐','☐','☐'],
    ['☐','☐','☐','☐','☐','☐','☐'],
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
end
  