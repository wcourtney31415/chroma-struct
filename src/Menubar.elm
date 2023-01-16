module Menubar exposing (..)

-- import Element exposing (centerX, fill, focused, padding, px, rgb, rgb255, spacing, text, width)

import ColorRecord exposing (ColorRecord)
import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (selected)
import Messages exposing (Msg(..))
import GlobalAttributes exposing (..)


menuBar : Element Msg
menuBar =
    Element.row
        [ width fill
        , Background.color <| rgb255 0 136 204
        , Background.gradient
            { angle = pi
            , steps =
                [ rgb255 0 136 204
                , rgb255 0 102 153
                ]
            }
        , Font.size 15
        , Font.color white
        ]
    <|
        List.map
            menuBarItem
            [ "File"
            , "Edit"
            , "View"
            , "Import/Export"
            , "Help"
            ]


menuBarItem : String -> Element a
menuBarItem myText =
    Input.button
        [ hoverHighlight
        , paddingXY 5 5
        , height fill
        ]
        { label = text myText, onPress = Nothing }
