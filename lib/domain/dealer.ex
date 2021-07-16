defmodule Dealer do
  def check_winner(black_input, white_input)
      when is_binary(black_input) and is_binary(white_input) do
    black_hand = Card.cards_from_string(black_input)
    white_hand = Card.cards_from_string(white_input)

    black_hand_ranked = PokerHand.find_ranking(black_hand)
    white_hand_ranked = PokerHand.find_ranking(white_hand)

    compare_results(black_hand_ranked, white_hand_ranked) |> handle_winner
  end

  defp compare_results(black_hand, white_hand) do
    case black_hand.ranking.value > white_hand.ranking.value do
      true ->
        {:black_wins, black_hand}

      false ->
        case white_hand.ranking.value > black_hand.ranking.value do
          true -> {:white_wins, white_hand}
          false -> compare_high_cards(black_hand.cards, white_hand.cards)
        end
    end
  end

  defp compare_high_cards([], []) do
    :tie
  end

  defp compare_high_cards(black_hand, white_hand) do
    high_card_black = Card.high_card(black_hand)
    high_card_white = Card.high_card(white_hand)

    case high_card_black.value.value_of > high_card_white.value.value_of do
      true ->
        {:black_wins_high_card, high_card_black}

      false ->
        case high_card_white.value.value_of > high_card_black.value.value_of do
          true ->
            {:white_wins_high_card, high_card_white}

          false ->
            compare_high_cards(
              List.delete(black_hand, high_card_black),
              List.delete(white_hand, high_card_white)
            )
        end
    end
  end

  defp handle_winner(winner) do
    case winner do
      {:white_wins, ranked} ->
        "White wins - #{ranked.ranking.to_string}"

      {:black_wins, ranked} ->
        "Black wins - #{ranked.ranking.to_string}"

      {:white_wins_high_card, high_card} ->
        "White wins - High Card: #{Card.card_to_string(high_card)}"

      {:black_wins_high_card, high_card} ->
        "Black wins - High Card: #{Card.card_to_string(high_card)}"

      _ ->
        "TIE"
    end
  end
end
