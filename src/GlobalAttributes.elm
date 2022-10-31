module GlobalAttributes exposing (hoverHighlight)

import Element exposing (..)
import Element.Background as Background
import Messages exposing (..)



hoverHighlight =
    mouseOver
        [ Background.gradient
            { angle = pi
            , steps = [ rgb255 84 130 186 ]
            }
        ]

