
# Dealer

Dealer is a program written in Elixir to evaluate Poker Hands and find the winner.

## Pre-requirements

You must have Elixir installed on your machine to test it. Please follow this guide: https://elixir-lang.org/install.html

## Usage

On the root folder, run :

```
iex -S mix
````

To evaluate two Poker Hands, you must call Dealer.check_winner(player, dealer) with two arguments, being a string with 5 representations of a Card.

For Example:

````
      player_input = "AS KS QS JS TS"
      dealer_input = "2H 4H 6H 7H 9H"

      Dealer.check_winner(player_input, dealer_input)

      ##This will return "Player wins - Straight Flush"
````

The Cards are represented by two values: 
The first one being its value (2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A)

The second one being its suit (S, H, C, D)

The winner is the player whose hand has the highest ranking according to this order:

From best to worst:

Straight Flush

Four Of A Kind

Full House

Flush

Straight

Three Of A Kind

Two Pairs

Pair

High Card

In case of a tie, the second criteria is the highest value among the cards. In case of another tie, we have a tie.
