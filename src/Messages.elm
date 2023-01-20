module Messages exposing (Msg(..))

import ColorRecord exposing (ColorRecord, HSVColorRecord)


type Msg
    = SendDataToJS
    | ReceivedDataFromJS String
    | AddColorToPalette ColorRecord
    | ChangeColor ColorRecord
    | ChangeHSV HSVColorRecord
    | RemoveColor Int
