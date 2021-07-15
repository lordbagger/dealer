
# Dealer

Dealer is a program written in Elixir to evaluate Poker Hands and find the winner.

## Pre-requirements

You must have Elixir installed on your machine to test it. Please follow this guide: https://elixir-lang.org/install.html

## Usage

On the root folder, run :

```
iex -S mix
````
Once inside the interactive mode, start the GenServer using: 

```
TheHouse.start()
```

To evaluate two Poker Hands, you must call TheHouse.check_winner(player, dealer) with two arguments, both of them are a tuple of two elements. The first element is the name of the player, and the second element is an array of 5 Strings representing Poker cards.

For Example:

````
      player_input = {"Player", ["AS", "KS", "QS", "JS", "TS"]}
      dealer_input = {"Dealer", ["2H", "4H", "6H", "7H", "9H"]}

      TheHouse.check_winner(player_input, dealer_input)

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
