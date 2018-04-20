class Cell
  def initialize(alive=false)
    @alive = alive
  end

  attr_reader :alive

  def live!
    @alive = true
  end

  def die!
    @alive = false
  end
end
