defmodule Transformations do
  @moduledoc """
  Transformations is an Elixir library for translating, rotating, reflecting, scaling, shearing, projecting, orthogonalizing, and superimposing arrays of 3D homogeneous coordinates as well as for converting between rotation matrices, Euler angles, and quaternions. Also includes an Arcball control object and functions to decompose transformation matrices.
  """

  @doc """
  Create a new matrix.

  ## Examples

    ```elixir
      iex(1)> point = Transformations.matrix([[1],[1],[1],[1]])
      #Matrex[4×1]
      ┌     ┐
      │ 1.0 │
      │ 1.0 │
      │ 1.0 │
      │ 1.0 │
      └     ┘
    ```
  """

  def matrix(mtx) do
    Matrex.new(mtx)
  end


  @doc """
  Transition (shift) a shape by xt, yt and zt along the x, y and z axes.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.transition(1,2,3)
      #Matrex[4×8]
      ┌                                                              ┐
      │  1.0     2.0     2.0     1.0     1.0     2.0     2.0     1.0 │
      │  2.0     2.0     2.0     2.0     3.0     3.0     3.0     3.0 │
      │  3.0     3.0     4.0     4.0     3.0     3.0     4.0     4.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def transition(mtx, xt, yt, zt) do
    t = Matrex.new([
        [1,0,0,xt],
        [0,1,0,yt],
        [0,0,1,zt],
        [0,0,0,1],
    ])
    Matrex.dot(t, mtx)
  end


  @doc """
  Scale a shape by xs, ys and zs along the x, y and z axes.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.scale(1,2,3)
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     1.0     0.0     0.0     1.0     1.0     0.0 │
      │  0.0     0.0     0.0     0.0     2.0     2.0     2.0     2.0 │
      │  0.0     0.0     3.0     3.0     0.0     0.0     3.0     3.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def scale(mtx, xs, ys, zs) do
    s = Matrex.new([
        [xs,0,0,0],
        [0,ys,0,0],
        [0,0,zs,0],
        [0,0,0,1],
    ])
    Matrex.dot(s, mtx)
  end

  @doc """
  Rotate a shape by angle about the x axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.rotatex(45)
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     1.0     0.0     0.0     1.0     1.0     0.0 │
      │  0.0     0.0 -0.8509 -0.8509 0.52532 0.52532-0.32558-0.32558 │
      │  0.0     0.0 0.52532 0.52532  0.8509  0.8509 1.37623 1.37623 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def rotatex(mtx, angle) do
    rx = Matrex.new([
        [1,0,0,0],
        [0,:math.cos(angle),-:math.sin(angle),0],
        [0,:math.sin(angle), :math.cos(angle),0],
        [0,0,0,1],
    ])
    Matrex.dot(rx, mtx)
  end

  @doc """
  Rotate a shape by angle about the y axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.rotatey(45)
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0 0.52532 1.37623  0.8509     0.0 0.52532 1.37623  0.8509 │
      │  0.0     0.0     0.0     0.0     1.0     1.0     1.0     1.0 │
      │  0.0 -0.8509-0.32558 0.52532     0.0 -0.8509-0.32558 0.52532 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def rotatey(mtx, angle) do
    ry = Matrex.new([
        [:math.cos(angle),0,:math.sin(angle),0],
        [0,1,0,0],
        [-:math.sin(angle), 0, :math.cos(angle),0],
        [0,0,0,1],
    ])
    Matrex.dot(ry, mtx)
  end

  @doc """
  Rotate a shape by angle about the z axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.rotatez(45)
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0 0.52532 0.52532     0.0 -0.8509-0.32558-0.32558 -0.8509 │
      │  0.0  0.8509  0.8509     0.0 0.52532 1.37623 1.37623 0.52532 │
      │  0.0     0.0     1.0     1.0     0.0     0.0     1.0     1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def rotatez(mtx, angle) do
    rz = Matrex.new([
        [:math.cos(angle),-:math.sin(angle),0,0],
        [:math.sin(angle), :math.cos(angle),0,0],
        [0,0,1,0],
        [0,0,0,1],
    ])
    Matrex.dot(rz, mtx)
  end

  @doc """
  Rotate a shape by about any arbitrary axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.rotate(1,2,3,4,5,6,45)
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0 0.52532 0.52532     0.0 -0.8509-0.32558-0.32558 -0.8509 │
      │  0.0  0.8509  0.8509     0.0 0.52532 1.37623 1.37623 0.52532 │
      │  0.0     0.0     1.0     1.0     0.0     0.0     1.0     1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def rotate(mtx, x, y, z, p, q, r, angle) do
    to = Matrex.new([
        [1,0,0,-x],
        [0,1,0,-y],
        [0,0,1,-z],
        [0,0,0,1],
    ])

    a = p - x
    b = q - y
    c = r - z

    l2 = :math.pow(a, 2) + :math.pow(b, 2) + :math.pow(c, 2)
    l = :math.sqrt(l2)

    v2 = :math.pow(b, 2) + :math.pow(c, 2)
    v = :math.sqrt(v2)

    rx = Matrex.new([
        [1,0,0,0],
        [0,c/v,-b/v,0],
        [0,b/v, c/v,0],
        [0,0,0,1],
    ])

    ry = Matrex.new([
        [v/l,0,-a/l,0],
        [0,1,0,0],
        [a/l, 0, v/l,0],
        [0,0,0,1],
    ])

    ryi = Matrex.new([
        [v/l,0,a/l,0],
        [0,1,0,0],
        [-a/l, 0, v/l,0],
        [0,0,0,1],
    ])

    rxi = Matrex.new([
        [1,0,0,0],
        [0,c/v,b/v,0],
        [0,-b/v, c/v,0],
        [0,0,0,1],
    ])

    toi = Matrex.new([
        [1,0,0,x],
        [0,1,0,y],
        [0,0,1,z],
        [0,0,0,1],
    ])

    Matrex.dot(to, rx) |> Matrex.dot(ry) |> Transformations.rotatez(angle) |> Matrex.dot(ryi) |> Matrex.dot(rxi) |> Matrex.dot(toi) |> Matrex.dot(mtx)
  end

  @doc """
  Shear a shape by a factor of sy, sz along the y and z axes about the x axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.shearx(2,3)
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     1.0     0.0     0.0     1.0     1.0     0.0 │
      │  0.0     2.0     2.0     0.0     1.0     3.0     3.0     1.0 │
      │  0.0     3.0     4.0     1.0     0.0     3.0     4.0     1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def shearx(mtx, sy, sz) do
    shx = Matrex.new([
        [1,sy,sz,0],
        [0,1,0,0],
        [0,0,1,0],
        [0,0,0,1],
    ])
    mtx
    |> Matrex.transpose()
    |> Matrex.dot(shx)
    |> Matrex.transpose() 
  end

  @doc """
  Shear a shape by a factor of sx, sz along the x and z axes about the y axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.sheary(2,3)
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     1.0     0.0     2.0     3.0     3.0     2.0 │
      │  0.0     0.0     0.0     0.0     1.0     1.0     1.0     1.0 │
      │  0.0     0.0     1.0     1.0     3.0     3.0     4.0     4.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def sheary(mtx, sx, sz) do
    shy = Matrex.new([
        [1,0,0,0],
        [sx,1,sz,0],
        [0,0,1,0],
        [0,0,0,1],
    ])
    mtx
    |> Matrex.transpose()
    |> Matrex.dot(shy)
    |> Matrex.transpose() 
  end

  @doc """
  Shear a shape by a factor of sx, sy along the x and y axes about the z axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.shearz(2,3)
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     3.0     2.0     0.0     1.0     3.0     2.0 │
      │  0.0     0.0     3.0     3.0     1.0     1.0     4.0     4.0 │
      │  0.0     0.0     1.0     1.0     0.0     0.0     1.0     1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def shearz(mtx, sx, sy) do
    shz = Matrex.new([
        [1,0,0,0],
        [0,1,0,0],
        [sx,sy,1,0],
        [0,0,0,1],
    ])
    mtx
    |> Matrex.transpose()
    |> Matrex.dot(shz)
    |> Matrex.transpose()    
  end

  @doc """
  Mirror a shape around the yz plane or the x-axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.mirrorx()
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0    -1.0    -1.0     0.0     0.0    -1.0    -1.0     0.0 │
      │  0.0     0.0     0.0     0.0     1.0     1.0     1.0     1.0 │
      │  0.0     0.0     1.0     1.0     0.0     0.0     1.0     1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘

    ```
  """

  def mirrorx(mtx) do
    m = Matrex.new([
        [-1,0,0,0],
        [0,1,0,0],
        [0,0,1,0],
        [0,0,0,1],
    ])
    Matrex.dot(m, mtx)
  end


  @doc """
  Mirror a shape around the xz plane or the y-axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.mirrory()
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     1.0     0.0     0.0     1.0     1.0     0.0 │
      │  0.0     0.0     0.0     0.0    -1.0    -1.0    -1.0    -1.0 │
      │  0.0     0.0     1.0     1.0     0.0     0.0     1.0     1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def mirrory(mtx) do
    m = Matrex.new([
        [1,0,0,0],
        [0,-1,0,0],
        [0,0,1,0],
        [0,0,0,1],
    ])
    Matrex.dot(m, mtx)
  end

  @doc """
  Mirror a shape around the xy plane or the z-axis.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.mirrorz()
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     1.0     0.0     0.0     1.0     1.0     0.0 │
      │  0.0     0.0     0.0     0.0     1.0     1.0     1.0     1.0 │
      │  0.0     0.0    -1.0    -1.0     0.0     0.0    -1.0    -1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def mirrorz(mtx) do
    m = Matrex.new([
        [1,0,0,0],
        [0,1,0,0],
        [0,0,-1,0],
        [0,0,0,1],
    ])
    Matrex.dot(m, mtx)
  end

  @doc """
  Project a shape down to the yz plane.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.projectx()
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     0.0     0.0     0.0     0.0     0.0     0.0     0.0 │
      │  0.0     0.0     0.0     0.0     1.0     1.0     1.0     1.0 │
      │  0.0     0.0     1.0     1.0     0.0     0.0     1.0     1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def projectx(mtx) do
    m = Matrex.new([
        [0,0,0,0],
        [0,1,0,0],
        [0,0,1,0],
        [0,0,0,1],
    ])
    Matrex.dot(m, mtx)
  end

  @doc """
  Project a shape down to the xz plane.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.projecty()
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     1.0     0.0     0.0     1.0     1.0     0.0 │
      │  0.0     0.0     0.0     0.0     0.0     0.0     0.0     0.0 │
      │  0.0     0.0     1.0     1.0     0.0     0.0     1.0     1.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def projecty(mtx) do
    m = Matrex.new([
        [1,0,0,0],
        [0,0,0,0],
        [0,0,1,0],
        [0,0,0,1],
    ])
    Matrex.dot(m, mtx)
  end

  @doc """
  Project a shape down to the xy plane.

  ## Examples

    ```elixir
      iex(1)> shape = Transformations.matrix([
                        [0,1,1,0,0,1,1,0],
                        [0,0,0,0,1,1,1,1],
                        [0,0,1,1,0,0,1,1],
                        [1,1,1,1,1,1,1,1]
                      ])
              shape |> Transformations.projectz()
      #Matrex[4×8]
      ┌                                                              ┐
      │  0.0     1.0     1.0     0.0     0.0     1.0     1.0     0.0 │
      │  0.0     0.0     0.0     0.0     1.0     1.0     1.0     1.0 │
      │  0.0     0.0     0.0     0.0     0.0     0.0     0.0     0.0 │
      │  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
      └                                                              ┘
    ```
  """

  def projectz(mtx) do
    m = Matrex.new([
        [1,0,0,0],
        [0,1,0,0],
        [0,0,0,0],
        [0,0,0,1],
    ])
    Matrex.dot(m, mtx)
  end
end
