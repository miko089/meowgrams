module Types exposing (..)

import Http
import Array2D exposing (Array2D)

type alias Nono = 
    { title  : String
    , height : Int
    , width  : Int
    , rows   : List (List Int)
    , columns: List (List Int)
    , goal   : List (List Bool) 
    }

type alias Matrix = 
    Array2D Bool

type Msg 
    = GotNono (Result Http.Error Nono)
    | More
    | Check (Int, Int)

type Model 
    = Failure String
    | Loading 
    | Succ (Nono, Matrix)
    | Win