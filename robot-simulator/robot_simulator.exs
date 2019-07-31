defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    with {:ok, _} <- validate_direction(direction),
         {:ok, _} <- validate_position(position)
    do
        %{
          direction: direction,
          position: position
        }
    else
      err -> err
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  def simulate(robot, [head | tail]) do
    simulate(instruction(robot, head), tail)
  end

  def simulate(robot, []) do
    robot
  end

  def simulate({:error, err}, _tail) do
    {:error, err}
  end

  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    simulate(robot, String.graphemes(instructions))
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end

  def validate_direction(direction) do
    if direction in [:north, :south, :east, :west] do
      {:ok, direction}
    else
      {:error, "invalid direction"}
    end
  end

  def validate_position({x, y} = position) do
    if is_integer(x) and is_integer(y) do
      {:ok, position}
    else
      {:error, "invalid position"}
    end
  end

  def validate_position(position) do
    {:error, "invalid position"}
  end

  @turn_map %{
    north: %{left: :west, right: :east},
    east: %{left: :north, right: :south},
    south: %{left: :east, right: :west},
    west: %{left: :south, right: :north}
  }
  # Takes robot, and 'L' or 'R' and returns a robot with a new direction
  def instruction(robot, "L") do
    new_direction = @turn_map |> Map.get(direction(robot)) |> Map.get(:left)
    robot |> Map.put(:direction, new_direction)
  end
  def instruction(robot, "R") do
    new_direction = @turn_map |> Map.get(direction(robot)) |> Map.get(:right)
    robot |> Map.put(:direction, new_direction)
  end
  def instruction(%{direction: direction, position: {x, y}} = robot, "A") do
    case direction do
      :north -> robot |> Map.put(:position, {x, y + 1})
      :east -> robot |> Map.put(:position, {x + 1, y})
      :south -> robot |> Map.put(:position, {x, y - 1})
      :west -> robot |> Map.put(:position, {x - 1, y})
    end
  end
  def instruction(_robot, _invalid) do
    {:error, "invalid instruction"}
  end
end
