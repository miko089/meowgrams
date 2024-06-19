module Main exposing (..)

import Browser
import Init exposing (init)
import Subs exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
