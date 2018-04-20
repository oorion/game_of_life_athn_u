require 'pry'

class Cell
  def initialize(alive=false)
    @alive = alive
  end

  attr_reader :alive

  def change
    @alive = !alive
  end

  def live!
    @alive = true
  end

  def to_s
    if alive
      '*'
    else
      '-'
    end
  end
end

class Board
  attr_reader :state
  
  def initialize(state)
    @state = state
  end

  def tick
    cells_that_should_change = []
    (0..state.length - 1).each do |i|
      (0..state.length - 1).each do |j|
        cell = state[i][j]
        if cell_should_change?(cell: cell, row: i, column: j)
          cells_that_should_change << cell
        end
      end
    end

    cells_that_should_change.each do |cell|
      cell.change
    end
  end

  def cell_neighbors(cell:, row:, column:)
    neighbor_indexes = (-1..1).to_a.repeated_permutation(2).to_a - [[0, 0]]
    neighbor_indexes.map do |row_offset, column_offset|
      r = row + row_offset
      c = column + column_offset
      unless (r < 0 || r > state.length-1 || c < 0 || c > state.length-1)
        state[r][c]
      end
    end.compact
  end

  def cell_should_change?(cell:, row:, column:)
    neighbors_alive_count = cell_neighbors(cell: cell, row: row, column: column).count do |neighbor|
      neighbor.alive
    end

    if cell.alive
      case neighbors_alive_count 
      when 0, 1
        true
      when 2, 3
        false
      when 4, 5, 6, 7, 8
        true
      end
    else
      neighbors_alive_count == 3 ? true : false
    end
  end

  def [](i)
    state[i]
  end

  def to_s
    state.map do |row|
      row.map do |cell|
        cell.to_s
      end.join('') + "\n"
    end.join('') + "\n"
  end
end

class Game
  attr_reader :board, :dimension, :iterations
  def initialize(dimension: 3, iterations: 5)
    @dimension = dimension
    @iterations = iterations
    @board = create_board
  end

  def start
    set_starting_board_state

    puts board
    (1..iterations).each do |_|
      board.tick
      puts board
    end
  end 

  private

  def create_board
    Board.new(
      (0..2).map do 
        (0..2).map do
          Cell.new
        end
      end
    )
  end

  def set_starting_board_state
    board[0][1].live!
    board[1][1].live!
    board[2][1].live!
  end
end

Game.new.start

