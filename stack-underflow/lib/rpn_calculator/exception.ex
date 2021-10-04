defmodule RPNCalculator.Exception do
  alias RPNCalculator.Exception.{DivisionByZeroError, StackUnderflowError}

  def divide(stack) when length(stack) < 2 do
    raise StackUnderflowError, "when dividing"
  end

  def divide([0, _rest]) do
    raise DivisionByZeroError
  end

  def divide([head, tail]) do
    tail / head
  end

  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @default_message "stack underflow occurred"
    defexception message: @default_message

    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}

        _ ->
          %StackUnderflowError{message: "#{@default_message}, context: #{value}"}
      end
    end
  end
end
