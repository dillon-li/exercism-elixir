defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(fn x -> rotate(x, shift, range(x)) end)
    |> List.to_string
  end

  def rotate(char, shift, first..last) do
    abs(last - (char + shift)) + first
  end
  def rotate(char, _shift, false) do
    char
  end

  def range(char) do
    cond do
      char in 65..90 ->
        65..90
      char in 97..122 ->
        97..122
      true ->
        false
    end
  end
end
