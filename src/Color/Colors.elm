module Color.Colors exposing (..)

import Color.Types exposing (ElementColor)
import Element


grey : Int -> ElementColor
grey x =
    Element.rgb255 x x x


black : ElementColor
black =
    grey 0


white : ElementColor
white =
    grey 255
