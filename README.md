# Transformations

Transformations is an Elixir library for translating, rotating, reflecting, scaling, shearing, projecting, orthogonalizing, and superimposing arrays of 3D homogeneous coordinates as well as for converting between rotation matrices, Euler angles, and quaternions. Also includes an Arcball control object and functions to decompose transformation matrices.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `transformations` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:transformations, "~> 0.1.0"}
  ]
end
```

## Usage

Create a matrix

#### matrix(mtx)

The following transformations are currently available:

#### transition(mtx, xt, yt, zt)

where xt, yt and zt are the x, y and z coordinates for the transform

#### scale(mtx, xs, ys, zs)

where xs, ys and zs are the scale factors along the x, y and z axes

#### rotatex(mtx, angle)
#### rotatey(mtx, angle)
#### rotatez(mtx, angle)

where angle refers to the angle of rotation along the specified axes

#### shearx(mtx, sy, sz)
#### sheary(mtx, sx, sz)
#### shearz(mtx, sx, sy)

where sx, sy and sz refer to the shear coefficients along each axis

## Examples

Transformations can be applied to points as well as shapes. Points are specified as a 4 x 1 matrix while shapes are specified as a 4 x n matrix. Transformations are also 4 x 1 and 4 x n matrices respectively.

```elixir

	iex(1)> point = Transformations.matrix([[1],[1],[1],[1]])
	#Matrex[4×1]
	┌     ┐
	│ 1.0 │
	│ 1.0 │
	│ 1.0 │
	│ 1.0 │
	└     ┘
	iex(2)> point |> Transformations.scale(1,2,3)
	#Matrex[4×1]
	┌     ┐
	│ 1.0 │
	│ 2.0 │
	│ 3.0 │
	│ 1.0 │
	└     ┘
	iex(3)> point |> Transformations.scale(1,2,3) |> Transformations.transition(3,4,7)
	#Matrex[4×1]
	┌      ┐
	│  4.0 │
	│  6.0 │
	│ 10.0 │
	│  1.0 │
	└      ┘
	iex(4)> shape = Transformations.matrix([
						[0,1,1,0,0,1,1,0],
						[0,0,0,0,1,1,1,1],
						[0,0,1,1,0,0,1,1],
						[1,1,1,1,1,1,1,1]
					])
	#Matrex[4×8]
	┌                                                              ┐
	│  0.0     1.0     1.0     0.0     0.0     1.0     1.0     0.0 │
	│  0.0     0.0     0.0     0.0     1.0     1.0     1.0     1.0 │
	│  0.0     0.0     1.0     1.0     0.0     0.0     1.0     1.0 │
	│  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
	└                                                                 ┘
	iex(5)> shape |> Transformations.scale(1,2,3) |> Transformations.transition(3,4,7)            
	#Matrex[4×8]         
	┌                                                              ┐
	│  3.0     4.0     4.0     3.0     3.0     4.0     4.0     3.0 │
	│  4.0     4.0     4.0     4.0     6.0     6.0     6.0     6.0 │
	│  7.0     7.0    10.0    10.0     7.0     7.0    10.0    10.0 │
	│  1.0     1.0     1.0     1.0     1.0     1.0     1.0     1.0 │
	└                                                              ┘

```

## Generating documentation

```elixir
	mix docs
```