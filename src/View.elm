module View exposing (..)

import Types exposing (Nono, Msg(..), Matrix, Model(..))
import Html exposing (h3, tr, td, text, Html, table, div, h2)
import List exposing (map, range)
import String exposing (join)
import Styles exposing (trStyle, tdStyle, tableStyle, activeStyle, inactiveStyle, cellStyle)
import Array2D exposing (get, rows, columns)
import Maybe exposing (withDefault)
import Utils exposing (zip)
import Styles exposing (headerStyle)
import Styles exposing (cellStyle)
import Styles exposing (activeStyle)
import Styles exposing (checkStyle)
import Html.Events exposing (onClick)
import Html exposing (button)

viewTitle : Nono -> Html Msg
viewTitle nono = 
    h3 [] [ text nono.title ]

makeHeader : Nono -> Html Msg
makeHeader nono = tr ( [] ++ trStyle ++ headerStyle )
    <| td ( [] ++ tdStyle ) [] :: map (\x -> td ( [] ++ tdStyle )
        [text <| join "\n" (map String.fromInt (x))]) nono.rows

makeTable : Nono -> Matrix -> List (Html Msg)
makeTable nono matrix = 
    map (\(num, row) -> tr trStyle <| td tdStyle [ text <| join " " (map String.fromInt row)] 
        :: map (\col -> if (withDefault False (get num col matrix)) then td (tdStyle ++ cellStyle ++ activeStyle ++ (checkStyle num col)) [] else td (tdStyle ++ cellStyle ++ inactiveStyle ++ (checkStyle num col)) []) (range 0 (nono.width-1))
            ) 
            (zip (range 0 (nono.height-1)) nono.columns)

view : Model -> Html Msg
view model = 
    case model of 
        Failure err -> 
            text ("Error while loading. Try reload a page" ++ err)
        Loading -> 
            text "Loading"
        Succ (nono, matrix) ->
            div []
                [ h2 [] [text "Meowgram"]
                , viewTitle nono
                , text <| String.fromInt nono.height ++ " "
                , text <| String.fromInt nono.width ++ " "
                , text <| String.fromInt (rows matrix) ++ " "
                , text <| String.fromInt (columns matrix)
                , table ( [] ++ tableStyle ) (makeHeader nono :: makeTable nono matrix)
                , button [ onClick More ] [ text "New Nono!" ]
            ]
        Win -> 
            div []
                [ h2 [] [text "Meowgram"]
                , text "correct! New game?"
                , button [ onClick More ] [ text "New Nono!" ]
            ]