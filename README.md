# Const

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

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  Add `const` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:const, "~> 0.1.0"}]
    end
    ```
