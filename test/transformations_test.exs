defmodule TransformationsTest do
  use ExUnit.Case, async: true

  test "#scale a point" do
  	point = Transformations.matrix([[1],[1],[1],[1]]) |> Transformations.scale(1,2,3)
    expected = Transformations.matrix([[1],[2],[3],[1]])
    assert point == expected
  end

  test "#scale and transition a point" do
    point = Transformations.matrix([[1],[1],[1],[1]]) |> Transformations.scale(1,2,3) |> Transformations.transition(3,4,7)
    expected = Transformations.matrix([[4],[6],[10],[1]])
    assert point == expected
  end

  test "#scale and transition a shape" do
    shape = Transformations.matrix([[0,1,1,0,0,1,1,0],[0,0,0,0,1,1,1,1],[0,0,1,1,0,0,1,1],[1,1,1,1,1,1,1,1]])
    transformed = shape |> Transformations.scale(1,2,3) |> Transformations.transition(3,4,7) 
    expected = Transformations.matrix([[3,4,4,3,3,4,4,3],[4,4,4,4,6,6,6,6],[7,7,10,10,7,7,10,10],[1,1,1,1,1,1,1,1]])
    assert transformed == expected
  end

end
