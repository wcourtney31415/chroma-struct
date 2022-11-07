module Messages exposing (Msg(..))

import ColorRecord exposing (ColorRecord)


type Msg
    = SendDataToJS
    | ReceivedDataFromJS String
    | AddColorToPalette ColorRecord
    | ChangeColor ColorRecord
    | RemoveColor Int
