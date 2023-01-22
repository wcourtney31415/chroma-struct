module Messages exposing (Msg(..))

import Color.Types exposing (RawColor)


type Msg
    = SendDataToJS
    | ReceivedDataFromJS String
    | AddColorToPalette RawColor
    | ChangeColor RawColor
    | RemoveColor Int
