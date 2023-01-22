module Color.Dropper exposing (open, subscribe)

import Color.Conversions exposing (hexToColor, rgbToColor)
import Color.Types exposing (RawColor)
import Ports


open : Cmd msg
open =
    Ports.openJsEyeDropper ()


subscribe : (RawColor -> msg) -> Sub msg
subscribe toMsg =
    Ports.onJsEyeDropperResult (toMsg << eyeDropperStringToColor)


eyeDropperStringToColor : String -> RawColor
eyeDropperStringToColor str =
    if String.startsWith "rgb(" str then
        rgbToColor str

    else
        hexToColor str
