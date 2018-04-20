require 'minitest/autorun'
require './board'
require 'pry'

class BoardTest  < Minitest::Test
  def test_it_should_be_able_to_compute_a_cells_neighbors
    state = (0..2).map do
      (0..2).map do
        Cell.new
      end
    end
    board = Board.new(state) 
    cell = state[1][1]
    neighbors = board.cell_neighbors(cell: cell, row: 1, column: 1)
   
    assert_equal neighbors.count, 8
    assert_equal neighbors, [
      state[0][0],
      state[0][1],
      state[0][2],
      state[1][0],
      state[1][2],
      state[2][0],
      state[2][1],
      state[2][2],
    ] 
  end

  def test_it_should_be_able_to_compute_a_another_cells_neighbors
    state = (0..2).map do
      (0..2).map do
        Cell.new
      end
    end
    board = Board.new(state) 
    cell = state[0][0]
    neighbors = board.cell_neighbors(cell: cell, row: 0, column: 0)

    assert_equal neighbors, [
      state[0][1],
      state[1][0],
      state[1][1],
    ] 
  end

  def test_it_should_tick
    state = (0..2).map do
      (0..2).map do
        Cell.new
      end
    end
    board = Board.new(state) 
    board[0][1].live!
    board[1][1].live!
    board[2][1].live!
   
    p board
    board.tick
    p board

    result = board.state.flatten.map {|cell| cell.alive}
    assert_equal result, [
      false,
      false,
      false,
      true,
      true,
      true,
      false,
      false,
      false,
    ] 
  end
end
