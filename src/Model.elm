module Model exposing (Model)

import ColorRecord exposing (ColorRecord)


type alias Model =
    { selectedColor : ColorRecord
    , palette : List ColorRecord
    }
