module Menubar exposing (..)

import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import Messages exposing (Msg(..))


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
