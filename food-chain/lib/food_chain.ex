defmodule FoodChain do
  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """

  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Enum.map(&recite_one/1)
    |> Enum.join("\n")
  end

  defp recite_one(8), do: """
  I know an old lady who swallowed a horse.
  She's dead, of course!
  """
  defp recite_one(verse_number) do
    verses()
    |> Enum.take(verse_number)
    |> Enum.reverse()
    |> verse_generator("")
  end

  defp verse_generator(verses, accumulator)
  defp verse_generator([], accumulator), do: accumulator
  defp verse_generator([{intro, chain} | rest], ""), do: verse_generator(rest, intro <>  chain)
  defp verse_generator([{_intro, chain} | rest], accumulator) do
    verse_generator(rest, accumulator <> "\n" <> chain)
  end

  defp verses() do
    [
      {"I know an old lady who swallowed a fly.\n",
       "I don't know why she swallowed the fly. Perhaps she'll die.\n"},
      {"""
       I know an old lady who swallowed a spider.
       It wriggled and jiggled and tickled inside her.
       """, "She swallowed the spider to catch the fly."},
      {
        """
        I know an old lady who swallowed a bird.
        How absurd to swallow a bird!
        """,
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
      },
      {"""
       I know an old lady who swallowed a cat.
       Imagine that, to swallow a cat!
       """, "She swallowed the cat to catch the bird."},
      {
        """
        I know an old lady who swallowed a dog.
        What a hog, to swallow a dog!
        """,
        "She swallowed the dog to catch the cat."
      },
      {
        """
        I know an old lady who swallowed a goat.
        Just opened her throat and swallowed a goat!
        """,
        "She swallowed the goat to catch the dog."
      },
      {
        """
        I know an old lady who swallowed a cow.
        I don't know how she swallowed a cow!
        """,
        "She swallowed the cow to catch the goat."
      },

    ]
  end
end
