module Utils exposing (..)

import Types exposing (Msg(..), Nono)
import Http
import Json.Decode exposing (Decoder, map6, field, int, string, list, bool)

zip = List.map2 Tuple.pair

getRandomNono : Cmd Msg
getRandomNono =
    Http.get
        { url = "https://nonogramapi-1-v4517841.deta.app/random"
        , expect = Http.expectJson GotNono nonoDecoder 
        }

nonoDecoder : Decoder Nono
nonoDecoder = 
    map6 Nono
        (field "title" string)
        (field "height" int)
        (field "width" int)
        (field "rows" (list (list int)))
        (field "columns" (list (list int)))
        (field "goal" (list (list bool)))

 