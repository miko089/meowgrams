module Styles exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Types exposing (Msg(..))

trStyle = [ style "border" "1px solid" ]

headerStyle = [ style "vertical-align" "bottom" ]

tdStyle = [ style "white-space" "pre-line"
            , style "border" "1px solid" 
            , style "display" "table-cell"
            , style "max-width" "0"
            , style "max-height" "0"
        ]

tableStyle = [ style "border" "1px solid" 
             , style "table-layout" "fixed" 
             , style "display" "table" 
             , style "width" "100%" 
             , style "height" "100%" 
        ]

cellStyle = [ style "aspect-ratio" "1 / 1" 
            , style "width" "1em"
            , style "height" "1em"
        ]

checkStyle x y = [ onClick (Check (x, y)) ]

activeStyle = [style "background" "black" ]
inactiveStyle = [style "background" "white" ]