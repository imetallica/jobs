defmodule Backend.Web.PageController do
  use Backend.Web, :controller

  alias Backend.Payments.{Card, Intermediary}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def charge(conn, %{"card" => card, 
                     "amount" => amount, 
                     "intermediaries" => intermediaries}) do

    parsed_card = Card.from_map(card)
    parsed_intermediaries = Enum.map(intermediaries, &Intermediary.from_map(&1))

    result = my_business_model_function(parsed_card, amount, parsed_intermediaries)

    json conn, result
  end

  defp my_business_model_function(parsed_card, amount, parsed_intermediaries) do
    %{card_id: Card.card_id(parsed_card), 
      amount: amount,
      id: UUID.uuid4(),
      intermediaries: Intermediary.calculate_amount(parsed_intermediaries)}
  end
end
