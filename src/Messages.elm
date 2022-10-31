module Messages exposing (..)

import ColorRecord exposing (..)
import Element exposing (..)


type Msg
    = SendDataToJS
    | ReceivedDataFromJS String
    | AddColorToPalette ColorRecord
