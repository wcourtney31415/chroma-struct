module Messages exposing (Msg(..))

import Color exposing (Color)


type Msg
    = SendDataToJS
    | ReceivedDataFromJS String
    | AddColorToPalette Color
    | ChangeColor Color
    | RemoveColor Int
