module Model exposing (Model)

import Color exposing (Color)


type alias Model =
    { selectedColor : Color
    , palette : List Color
    }
