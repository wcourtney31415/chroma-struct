module Messages exposing (..)

import ColorRecord exposing (..)


type Msg
    = SendDataToJS
    | ReceivedDataFromJS String
    | AddColorToPalette ColorRecord
