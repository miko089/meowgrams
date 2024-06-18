module Update exposing (..)

import Types exposing (Model(..), Msg(..))
import Utils exposing (getRandomNono)
import Array2D exposing (repeat, set, get)
import Platform.Cmd as Cmd
import Array2D exposing (fromList)
import Platform.Cmd as Cmd

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        More -> (Loading, getRandomNono)

        GotNono res ->
            case res of 
                Ok nono -> 
                    (Succ (nono, repeat nono.height nono.width False), Cmd.none)
                
                Err err ->
                    (Failure <| Debug.toString err, Cmd.none)
        Check (x, y) ->
            case model of
                Succ (nono, matrix) ->
                    case get x y matrix of
                        Just w -> 
                            if (set x y (not w) matrix) == (fromList nono.goal)
                                then (Win, Cmd.none)
                                else (Succ (nono, set x y (not w) matrix), Cmd.none)
                        Nothing -> (Failure "Impossible", Cmd.none)
                _ -> (Loading, getRandomNono)