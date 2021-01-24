defmodule DefineConstants do
  @moduledoc """
  Documentation for `DefineConstants`.
  """

  @doc false
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :define_constants, accumulate: true)

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro define(key, value) when is_atom(key) do
    quote do
      @define_constants {unquote(key), unquote(value)}
    end
  end

  defmacro define(key, _value) do
    raise(ArgumentError, message: "first argument \"#{Macro.to_string(key)}\" is not an atom")
  end

  defmacro __before_compile__(_environment) do
    quote do
      for {key, value} <- @define_constants do
        Module.eval_quoted(
          __MODULE__,
          quote do
            defmacro constant(unquote(key)) do
              unquote(value)
            end
          end
        )
      end

      defmacro constant(key) when is_atom(key) do
        raise(ArgumentError, message: "key \"#{Macro.to_string(key)}\" is not defined")
      end

      defmacro constant(key) do
        raise(ArgumentError, message: "key \"#{Macro.to_string(key)}\" is not an atom")
      end
    end
  end
end
