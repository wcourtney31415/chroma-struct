module Colors exposing (..)

import Element


grey : Int -> Element.Color
grey x =
    Element.rgb255 x x x


black : Element.Color
black =
    grey 0


white : Element.Color
white =
    grey 255
