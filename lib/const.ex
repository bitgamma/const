defmodule Const do
  @moduledoc """
  A simple helper to define constants. Constants are defined as functions of the module and couple of helper functions are added.

  ```elixir
  defmodule Status do
    use Const, [:queued, :processed, :sent]
  end
  ```

  is equivalent to writing

  ```elixir
  defmodule Status do
    def queued, do: 0
    def processed, do: 1
    def sent, do: 2
    def all, do: [queued: 0, processed: 1, sent: 2]
    def by_value(val) do
      # returns the atom from the integer value. In case of duplicated values, the fist
      # associated atom is returned
    end
  end
  ```

  Note that the parameter passed to the use macro can also be a keyword list, where the values are explicitly given. You can even give only some
  of the values, in which case the behavior will be like in C, that is the unspecified value will be counted starting from the last explicitly given one

  ```elixir
  defmodule Status do
    use Const, [:queued, :processed, {:sent, 100}, :delivered, :received]
    # the final values will be: [queued: 0, processed: 1, sent: 100, delivered: 101, received: 102]
  end
  ```

  Duplicated values are allowed, but in that case the `by_value` function will not be really useful, at least for the duplicated values, since only the first atom will be returned.
  """
    
  defmacro __using__(constants) do
    const = constants |> format()
    [define_all(const), define_by_value(const) | define_constants(const)]
  end

  defp define_constants(const) do
    Enum.map(const, fn({constant, val}) ->
      quote do
        def unquote(constant)(), do: unquote(val)
      end
    end)
  end

  defp define_all(const) do
    quote do
      def all(), do: unquote(const)
    end
  end

  defp define_by_value(const) do
    quote do
      def by_value(val) do
        case Enum.find(unquote(const), fn({k, v}) -> v == val end) do
          {k, v} -> k
          nil -> nil
        end
      end
    end
  end

  defp format(constants) do
    {res, _} = Enum.reduce(constants, {[], 0}, fn
      (c = {_k, v}, {res, _idx}) ->
        {[c | res], v + 1}
      (k, {res, idx}) ->
        {[{k, idx} | res], idx + 1}
    end)
    Enum.reverse(res)
  end
end
