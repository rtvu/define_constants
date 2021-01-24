# DefineConstants

Elixir library to provide constants functionality.

## Usage

DefineConstants provides the `define` macro to create custom constants. Constants should live inside their own modules.

```elixir
defmodule MyConstants do
  use DefineConstants

  define(:name, "MyApplication")
  define(:number, 7)
end
```

The `define` macro takes atom keys and arbitrary values. The provided key/value pairs are used to create the `constant` macro.

Caller functions use the `constant` macro to retrieve the constant values.

```elixir
defmodule Caller do
  import MyConstants

  constant(:name)
  constant(:number) + 10
end
```

Since `constant` is a macro, at compile time, all `constant` calls are converted to their appropriate values.

## Installation

To use DefineConstants in your Mix projects, first add DefineConstants as a dependency:

```elixir
def deps do
  [
    {:define_constants, "~> 0.1.0"}
  ]
end
```

After adding DefineConstants as a dependency, run `mix deps.get` to install it.
