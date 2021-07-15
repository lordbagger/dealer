defmodule Dealer do
  def check_winner(player_cards, dealer_cards) do
    left = PokerHand.find_ranking(player_cards)
    right = PokerHand.find_ranking(dealer_cards)

    compare_results(left, right)
  end

  defp compare_results(player_hand, dealer_hand) do
    case player_hand.ranking.value > dealer_hand.ranking.value do
      true ->
        {:player_wins, player_hand}

      false ->
        case dealer_hand.ranking.value > player_hand.ranking.value do
          true -> {:dealer_wins, dealer_hand}
          false -> compare_high_cards(player_hand.cards, dealer_hand.cards)
        end
    end
  end

  defp compare_high_cards([], []) do
    :tie
  end

  defp compare_high_cards(player_cards, dealer_cards) do
    high_card_player = Card.high_card(player_cards)
    high_card_dealer = Card.high_card(dealer_cards)

    case high_card_player.value.value_of > high_card_dealer.value.value_of do
      true ->
        {:player_wins_high_card, high_card_player}

      false ->
        case high_card_dealer.value.value_of > high_card_player.value.value_of do
          true ->
            {:dealer_wins_high_card, high_card_dealer}

          false ->
            compare_high_cards(
              List.delete(player_cards, high_card_player),
              List.delete(dealer_cards, high_card_dealer)
            )
        end
    end
  end
end
