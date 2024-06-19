module View exposing (..)

import Array2D exposing (get)
import Html exposing (Html, button, div, h2, h3, table, td, text, tr)
import Html.Events exposing (onClick)
import List exposing (map, range)
import Maybe exposing (withDefault)
import String exposing (join)
import Styles exposing (activeStyle, cellStyle, checkStyle, headerStyle, inactiveStyle, tableStyle, tdStyle, trStyle)
import Types exposing (Matrix, Model(..), Msg(..), Nono)
import Utils exposing (zip)


viewTitle : Nono -> Html Msg
viewTitle nono =
    h3 [] [ text nono.title ]


makeHeader : Nono -> Html Msg
makeHeader nono =
    tr ([] ++ trStyle ++ headerStyle) <|
        td ([] ++ tdStyle) []
            :: map
                (\x ->
                    td ([] ++ tdStyle)
                        [ text <| join "\n" (map String.fromInt x) ]
                )
                nono.rows


makeCell : Matrix -> Int -> Int -> Html Msg
makeCell matrix num col =
    td
        (tdStyle
            ++ cellStyle
            ++ (if withDefault False (get num col matrix) then
                    activeStyle

                else
                    inactiveStyle
               )
            ++ checkStyle num col
        )
        []


makeTable : Nono -> Matrix -> List (Html Msg)
makeTable nono matrix =
    map
        (\( num, row ) ->
            tr trStyle <|
                td tdStyle [ text <| join " " (map String.fromInt row) ]
                    :: map
                        (makeCell matrix num)
                        (range 0 (nono.width - 1))
        )
        (zip (range 0 (nono.height - 1)) nono.columns)


view : Model -> Html Msg
view model =
    case model of
        Failure err ->
            text ("Error while loading. Try reload a page" ++ err)

        Loading ->
            text "Loading"

        Succ ( nono, matrix ) ->
            div []
                [ h2 [] [ text "Meowgram" ]
                , viewTitle nono
                , table ([] ++ tableStyle) (makeHeader nono :: makeTable nono matrix)
                , button [ onClick More ] [ text "New Nono!" ]
                ]

        Win ->
            div []
                [ h2 [] [ text "Meowgram" ]
                , text "correct! New game?"
                , button [ onClick More ] [ text "New Nono!" ]
                ]
