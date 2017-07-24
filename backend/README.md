# Resolução Teste Back-end

1. Para rodar a app, instale Erlang e Elixir.
2. Faça `mix deps.get` e depois `mix compile`.
3. Rode os testes com `mix test`. Deve estar tudo OK. :)
4. Profit! 

# Teste Back-end
Nesse teste é preciso fazer uma API REST (JSON), com um endpoint para criar transação:

#### [POST] /charge
###### params:
* card (map)
    * holder
    * number
    * cvv
    * expiration_month
    * expiration_year
* amount
* intermediaries (opcional) (array)
    * fee (opcional)
    * flat (opcional)
    * description (opcional)
    
###### return:
* id
* card_id
* amount
* intermediaries (array)
    * fee
    * flat
    * amount
    * description
* inserted_at
* updated_at

### Input/Output
Request
```json
{
  "amount": 10,
  "card": {
    "holder": "KiiK Company",
    "number": "4200000000000000",
    "expiration_month": "12",
    "expiration_year": "2017",
    "cvv": "123"
  },
  "intermediaries": [
    {
      "fee": 0,
      "flat": 5,
      "description": "Tax of KiiK"
    }
  ]
}
```
Response
```json
{
  "id": "a5fd213e-52e5-4dd0-b5df-85c3de190514",
  "amount": 10,
  "card_id": "1a348d1f-5028-45e4-ad66-a91a19cd5549",
  "intermediaries": [
    {
      "fee": 0,
      "flat": 5,
      "amount": 5,
      "description": "Tax of KiiK"
    }
  ]
}
```

#### Obs
* Não é preciso persistir os dados em um banco
* `intermediaries` é uma array com os intermediarios que receberam uma porcentagem (fee) e/ou valor fixo (flat) da transação
* `amount` no retorno dos intermediarios precisa ser calculado sobre o `fee` e o `flat`
* `card_id` e `id` no retorno podem ser randômicos
* Ao terminar, abra um PR do repo principal e entraremos em contato

## Boa sorte e que a força esteja com você !
