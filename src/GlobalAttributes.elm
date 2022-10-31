module GlobalAttributes exposing (hoverHighlight)

import Element exposing (mouseOver, rgb255)
import Element.Background as Background



hoverHighlight =
    mouseOver
        [ Background.gradient
            { angle = pi
            , steps = [ rgb255 84 130 186 ]
            }
        ]

