module Color.Types exposing (..)

{-| This module provides aliases for various "color" types used in the project, to make them less ambiguous
-}

import Color
import Element


{-| The escherlies/elm-color Color type.
This type can be easily translated into different formats!
-}
type alias RawColor =
    Color.Color


{-| The mdgriffith/elm-ui Color type.
This type is used by the view code to interpret colors for display purposes.
-}
type alias ElementColor =
    Element.Color


{-| A Color represented as a record that represents the RGBA values as integers from 0-255.
-}
type alias Rgba255Color =
    { red : Int
    , green : Int
    , blue : Int
    , alpha : Int
    }


{-| A Color represented as a record that represents the RGBA values as floats from 0-1.
-}
type alias RgbaFloatColor =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }

{-| A Color represented as a record that represents the HSLA values as floats from 0-1 and hue to be from 0-360.
-}
type alias HslaFloatColor =
    { hue : Float
    , saturation : Float
    , lightness : Float
    , alpha : Float
    }
