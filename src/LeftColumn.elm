module LeftColumn exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import Messages exposing (..)


leftColumn model color =
    Element.column
        [ height fill
        , Background.color <| rgb255 0 50 77
        , Font.color <| rgb 1 1 1
        , Border.color <| rgb 0 0 0
        , Border.widthEach
            { top = 0
            , bottom = 0
            , left = 0
            , right = 1
            }
        ]
        [ Element.el [ centerX, padding 6, Font.size 16 ] <| text "Color Selection"
        , Element.column
            [ paddingXY 20 5
            , height fill
            , Background.color <| rgb255 0 37 57
            , spacing 20
            ]
            [ colorSelectDisplay color
            , addColorButton model "Add to Pallet"
            , addColorButton model "Remove Color"
            ]
        ]


addColorButton model myText =
    Input.button
        [ centerX
        , hoverHighlight
        ]
        { onPress = Just <| AddColorToPalette model.selectedColor
        , label =
            Element.el
                [ Background.color <| rgb255 0 133 204
                , Font.color <| rgb 1 1 1
                , width <| px 220
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
                , Border.shadow
                    { blur = 10
                    , size = 1
                    , color = rgb 0 0 0
                    , offset = ( 4, 4 )
                    }
                , padding 10
                ]
            <|
                Element.el [ centerX ] <|
                    text myText
        }


colorSelectDisplay color =
    let
        squareSize =
            256

        bkgColor =
            rgb255
                color.red
                color.green
                color.blue

        myRgb =
            "rgb255 "
                ++ String.fromInt color.red
                ++ " "
                ++ String.fromInt color.green
                ++ " "
                ++ String.fromInt color.blue
                ++ " "
    in
    Input.button
        [ Background.color bkgColor
        , width <| px squareSize
        , Border.shadow
            { blur = 10
            , size = 1
            , color = rgb 0 0 0
            , offset = ( 4, 4 )
            }
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
