defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    if code > 31 do
      []
    else
      handshake = code
        |> Integer.digits(2)
        |> Enum.reverse
        |> Enum.with_index
        |> Enum.map(fn x -> addCommand(elem(x, 0), rem(elem(x,1), 5)) end)
        |> Enum.filter(fn x -> x end)
        |> reverse
        |> Enum.filter(fn x -> x != "reverse" end)
    end
  end

  defp reverse(handshake) do
    num_reverse = handshake
    |> Enum.count(fn x -> x == "reverse" end)
    |> rem(2)
    case num_reverse do
      0 ->
        handshake
      1 ->
        handshake |> Enum.reverse
    end
  end

  defp addCommand(0, int) do
    nil
  end
  defp addCommand(1, 0) do
    "wink"
  end
  defp addCommand(1, 1) do
    "double blink"
  end
  defp addCommand(1, 2) do
    "close your eyes"
  end
  defp addCommand(1, 3) do
    "jump"
  end
  defp addCommand(1, 4) do
    "reverse"
  end

end
