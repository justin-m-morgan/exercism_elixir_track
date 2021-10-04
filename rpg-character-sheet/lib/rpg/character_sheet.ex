defmodule RPG.CharacterSheet do
  def welcome() do
    msg = "Welcome! Let's fill out your character sheet together."
    IO.puts(msg)
  end

  def ask_name() do
    "What is your character's name?"
    |> Kernel.<>("\n")
    |> IO.gets()
    |> String.trim()
  end

  def ask_class() do
    "What is your character's class?"
    |> Kernel.<>("\n")
    |> IO.gets()
    |> String.trim()
  end

  def ask_level() do
    "What is your character's level?"
    |> Kernel.<>("\n")
    |> IO.gets()
    |> String.trim()
    |> Integer.parse()
    |> elem(0)
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()

    character_map = %{name: name, level: level, class: class}
    IO.inspect(character_map, label: "\nYour character")
  end
end
