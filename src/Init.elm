module Init exposing (..)

import Types exposing (Model(..), Msg(..))
import Utils exposing (getRandomNono)


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, getRandomNono )
