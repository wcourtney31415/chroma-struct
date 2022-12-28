module GlobalAttributes exposing (..)

import Colors
import Element exposing (mouseOver, rgb255)
import Element.Background as Background
import Element.Border as Border


hoverHighlight : Element.Attribute msg
hoverHighlight =
    mouseOver
        [ Background.gradient
            { angle = pi
            , steps = [ rgb255 84 130 186 ]
            }
        ]


borderShadow : Element.Attr decorative msg
borderShadow =
    Border.shadow
        { offset = ( 4, 2 )
        , color = Colors.black
        , size = 1
        , blur = 10
        }
