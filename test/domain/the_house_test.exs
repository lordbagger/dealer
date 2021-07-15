defmodule TheHouseTest do
  use ExUnit.Case, async: false

  describe "check_winner errors scenarios" do
    test "returns an error if Player sends an empty hand" do
      player_input = {"Player", []}
      dealer_input = {"Dealer", ["AS", "KS", "QS", "JS", "TS"]}

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Error: received empty hand from Player"
    end

    test "returns an error if Dealer sends an empty hand" do
      player_input = {"Player", ["AS", "KS", "QS", "JS", "TS"]}
      dealer_input = {"Dealer", []}

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Error: received empty hand from Dealer"
    end

    test "returns an error if both players send an empty hand" do
      player_input = {"Player", []}
      dealer_input = {"Dealer", []}

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Error: received empty hand from both players"
    end

    test "returns an error if a player sends a PokerHand with less than 5 cards " do
      player_input = {"Player", ["AS"]}
      dealer_input = {"Dealer", ["AS", "KS", "QS", "JS", "TS"]}

      suits = Card.Suit.values()
      values = Card.Value.values()

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Check your cards! Your hand must contain exactly 5 cards, Suits must be in #{
                 suits
               }. Values must be in #{values}"
    end

    test "returns an error if a player sends a PokerHand with more than 5 cards " do
      player_input = {"Player", ["AS", "KS", "QS", "JS", "TS", "KH"]}
      dealer_input = {"Dealer", ["AS", "KS", "QS", "JS", "TS"]}

      suits = Card.Suit.values()
      values = Card.Value.values()

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Check your cards! Your hand must contain exactly 5 cards, Suits must be in #{
                 suits
               }. Values must be in #{values}"
    end

    test "returns an error if a player sends a PokerHand with an invalid value" do
      player_input = {"Player", ["11S", "KS", "QS", "JS", "TS"]}
      dealer_input = {"Dealer", ["AS", "KS", "QS", "JS", "TS"]}

      suits = Card.Suit.values()
      values = Card.Value.values()

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Check your cards! Your hand must contain exactly 5 cards, Suits must be in #{
                 suits
               }. Values must be in #{values}"
    end

    test "returns an error if a player sends a PokerHand with an invalid suit" do
      player_input = {"Player", ["AH", "KS", "QS", "JS", "TS"]}
      dealer_input = {"Dealer", ["AW", "KS", "QS", "JS", "TS"]}

      suits = Card.Suit.values()
      values = Card.Value.values()

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Check your cards! Your hand must contain exactly 5 cards, Suits must be in #{
                 suits
               }. Values must be in #{values}"
    end
  end

  describe "check_winner correctly return the results" do
    test "Player wins by Straight Flush over Flush" do
      player_input = {"Player", ["AS", "KS", "QS", "JS", "TS"]}
      dealer_input = {"Dealer", ["2H", "4H", "6H", "7H", "9H"]}

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Player wins - Straight Flush"
    end

    test "Dealer wins by Straight over Pair" do
      player_input = {"Player", ["AS", "AH", "QS", "JS", "TS"]}
      dealer_input = {"Dealer", ["2H", "3S", "4H", "5D", "6C"]}

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Dealer wins - Straight"
    end

    test "returns TIE for identical hands" do
      player_input = {"Player", ["AS", "AH", "QS", "JS", "TS"]}
      dealer_input = {"Dealer", ["AC", "AD", "QC", "JH", "TD"]}

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) == "TIE"
    end

    test "Player wins by High Card after a tie" do
      # flush
      player_input = {"Player", ["2S", "4S", "6S", "8S", "AS"]}
      # also a flush
      dealer_input = {"Dealer", ["2H", "4H", "6H", "7H", "KH"]}

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Player wins - High Card: AS"
    end

    test "Dealer wins by High Card after a tie" do
      # flush
      player_input = {"Player", ["2S", "4S", "6S", "8S", "KS"]}
      # also a flush
      dealer_input = {"Dealer", ["2H", "4H", "6H", "7H", "AH"]}

      TheHouse.start()

      assert TheHouse.check_winner(player_input, dealer_input) ==
               "Dealer wins - High Card: AH"
    end
  end
end
