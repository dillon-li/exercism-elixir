defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """

  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    to_roman(number, "")
  end

  def to_roman(0, string) do
    string
  end

  def to_roman(number, string) do
    base = find_base(number)
    new_string = string <> map[base]
    to_roman(number - base, new_string)
  end

  def map do
    %{
      1 => "I",
      4 => "IV",
      5 => "V",
      9 => "IX",
      10 => "X",
      40 => "XL",
      50 => "L",
      90 => "XC",
      100 => "C",
      400 => "CD",
      500 => "D",
      900 => "CM",
      1000 => "M"
    }
  end

  def find_base(number) do
    list = [1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000, 3001]
    index = list
    |> Enum.find_index(fn x -> number - x < 0 end)
    list |> Enum.fetch!(index - 1)
  end

end
