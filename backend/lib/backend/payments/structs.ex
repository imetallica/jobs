defmodule Backend.Payments.Card do
  @moduledoc """
  Card struct.
  """
  @derive [Poison.Encoder]
  defstruct [:holder, :number, :cvv, :expiration_month, :expiration_year]

  @type t :: %__MODULE__{holder: String.t, 
                         number: String.t, 
                            cvv: String.t,
                expiration_year: String.t,
               expiration_month: String.t}


  @doc """
  Parses a map from controller params to a card struct.
  """
  @spec from_map(to_parse :: map) :: t
  def from_map(%{"holder" => holder, 
                 "number" => number,
       "expiration_month" => exp_mth,
        "expiration_year" => exp_year,
                    "cvv" => cvv}) do
    %__MODULE__{holder: holder, 
                number: number, 
                cvv: cvv, 
                expiration_month: exp_mth, 
                expiration_year: exp_year}
  end

  @doc """
  Generates a random UUID, based on card number.
  """
  @spec card_id(t) :: String.t
  def card_id(%__MODULE__{} = card) do
    UUID.uuid5(:dns, card.number)
  end
end

defmodule Backend.Payments.Intermediary do
  @moduledoc """
  The intermediary struct.
  """
  @derive [Poison.Encoder]
  defstruct [:fee, :flat, :description, :amount]

  @type t :: %__MODULE__{fee: number, 
                        flat: number, 
                 description: String.t, 
                      amount: number}

  @doc """
  Parses a map from controller params to a intermediary struct.
  """
  @spec from_map(to_pase :: map) :: t
  def from_map(%{"fee" => fee, "flat" => flat, "description" => desc}) do
    %__MODULE__{fee: fee, flat: flat, description: desc}
  end

  @doc """
  Calculates the amount of fees and flats for the given intermediary.
  """
  @spec calculate_amount(its :: list(t)) :: list(t)
  def calculate_amount(intermediaries) do
    Enum.map(intermediaries, fn (it) -> %__MODULE__{fee: it.fee, 
                                                   flat: it.flat, 
                                            description: it.description, 
                                                 amount: it.fee + it.flat} end)
  end
end