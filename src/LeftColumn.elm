module LeftColumn exposing (leftColumn)

import Color
import Color.Types exposing (RawColor)
import Color.Colors exposing (..)
import Element exposing (centerX, centerY, fill, height, padding, paddingXY, px, rgb255, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import HSLSliderPanel exposing (hslSliderPanel)
import Messages exposing (Msg(..))
import Model exposing (Model)
import RGBSliderPanel exposing (rgbSliderPanel)


leftColumn : Model -> RawColor -> Element.Element Msg
leftColumn model color =
    Element.column
        [ height fill
        , Background.color <| rgb255 0 50 77
        , Font.color white
        , Border.color black
        , Border.widthEach
            { top = 0
            , bottom = 0
            , left = 0
            , right = 1
            }
        ]
        [ Element.el [ centerX, padding 6, Font.size 16 ] <| text "Color Selection"
        , Element.column
            [ paddingXY 20 20
            , height fill
            , Background.color <| rgb255 0 37 57
            , spacing 12
            ]
            [ colorSelectDisplay color
            , addColorButton model "Dropper Tool"
            , addColorButton model "Add to Palette"
            , hslSliderPanel model.selectedColor
            , rgbSliderPanel model.selectedColor
            ]
        ]


addColorButton : Model -> String -> Element.Element Msg
addColorButton model myText =
    Input.button
        [ centerX
        , hoverHighlight
        ]
        { onPress = Just <| AddColorToPalette model.selectedColor
        , label =
            Element.el
                [ Background.color <| rgb255 0 133 204
                , Font.color <| white
                , width <| px 256
                , Font.size 15
                , Font.bold
                , centerX
                , Background.gradient
                    { angle = pi
                    , steps =
                        [ rgb255 0 133 204
                        , rgb255 0 85 128
                        ]
                    }
                , Border.rounded 5
                , borderShadow
                , padding 10
                ]
            <|
                Element.el [ centerX ] <|
                    text myText
        }


colorSelectDisplay : RawColor -> Element.Element Msg
colorSelectDisplay color =
    let
        rgba255 =
            Color.toRgba255 color

        squareSize =
            256

        bkgColor =
            rgb255
                rgba255.red
                rgba255.green
                rgba255.blue

        myRgb =
            "rgb255 "
                ++ String.fromInt rgba255.red
                ++ " "
                ++ String.fromInt rgba255.green
                ++ " "
                ++ String.fromInt rgba255.blue
                ++ " "
    in
    Input.button
        [ Background.color bkgColor
        , width <| px squareSize
        , borderShadow
        , height <| px squareSize
        ]
        { label =
            Element.el
                [ centerX
                , centerY
                ]
            <|
                text <|
                    myRgb
        , onPress = Maybe.Just SendDataToJS
        }
