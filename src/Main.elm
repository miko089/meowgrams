module Main exposing (..)

import Browser
import Init exposing (init)
import Update exposing (update)
import Subs exposing (subscriptions)
import View exposing (view)

main = 
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view 
        }