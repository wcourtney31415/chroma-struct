module GlobalAttributes exposing (..)

import Element exposing (..)
import Element.Background as Background
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

