defmodule Backend.Web.PageControllerTest do
  use Backend.Web.ConnCase
  import Backend.Web.PageController
  doctest Backend.Web.PageController

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "POST /charge", %{conn: conn} do
    conn = post conn, "/charge", %{
      "card" => %{
        "holder" => "KiiK Company",
        "number" => "4200000000000000",
        "expiration_month" => "12",
        "expiration_year" => "2017",
        "cvv" => "123"},
      "amount" => "10.00",
      "intermediaries" => [
        %{"fee": 1, "flat": 5, "description": "Tax of KiiK"},
        %{"fee": 0.24, "flat": 3, "description": "IOF"},
        %{"fee": 2, "flat": 15, "description": "IR"}
      ]
    }

    response = json_response(conn, 200) 

    assert nil != response["card_id"]
    assert nil != response["id"]
    assert "10.00" == response["amount"]
    assert [%{"amount" => 6,
              "description" => "Tax of KiiK", 
              "fee" => 1, 
              "flat" => 5},
            %{"amount" => 3.24, 
              "description" => "IOF", 
              "fee" => 0.24, 
              "flat" => 3},
            %{"amount" => 17, 
              "description" => "IR", 
              "fee" => 2,
              "flat" => 15}] == response["intermediaries"]
  end
end
