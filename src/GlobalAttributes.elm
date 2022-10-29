module GlobalAttributes exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import String exposing (toInt)
import Messages exposing (..)



hoverHighlight =
    mouseOver
        [ Background.gradient
            { angle = pi
            , steps = [ rgb255 84 130 186 ]
            }
        ]

