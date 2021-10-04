# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> [] end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state end)
  end

  def register(pid, register_to) do
    plot = %Plot{plot_id: 1, registered_to: register_to}
    :ok = Agent.update(pid, fn state -> [plot | state] end)
    plot
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state -> Enum.filter(state, fn plot -> plot.plot_id != plot_id end) end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      Enum.find(state, {:not_found, "plot is unregistered"}, fn plot ->
        plot.plot_id == plot_id
      end)
    end)
  end
end
