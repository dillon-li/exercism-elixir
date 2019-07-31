defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.reduce(%{}, fn x, acc -> check_word(x, acc) end)
  end

  def check_word(word, map) do
    clean = clean_word(word)
    if clean != "" do
      new_count = (map |> Map.get(clean, 0)) + 1
      map |> Map.put(clean, new_count)
    else
      map
    end
  end

  def clean_word(word) do
    word
    |> String.downcase()
    |> String.replace(~r/\p{Po}|\p{S}/, "")
  end

end
