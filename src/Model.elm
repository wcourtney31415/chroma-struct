module Model exposing (Model)

import Color.Types exposing (RawColor)


type alias Model =
    { selectedColor : RawColor
    , palette : List RawColor
    }
