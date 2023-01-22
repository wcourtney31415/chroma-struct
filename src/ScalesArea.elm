module ScalesArea exposing (..)

import Color
import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import GlobalAttributes exposing (..)
import Messages exposing (Msg(..))


rightColumn : Element msg
rightColumn =
    Element.column
        [ height fill
        , Background.color <| rgb255 0 50 77
        , Font.color white
        , Border.color black
        , width fill
        , Border.widthEach
            { top = 0
            , bottom = 0
            , left = 1
            , right = 1
            }
        ]
        [ Element.el
            [ centerX
            , padding 6
            , Font.size 16
            ]
          <|
            text "Color Variants"
        , Element.row [ width fill ]
            [ luminationScale
            , saturationScale
            ]
        ]


luminationScale : Element msg
luminationScale =
    Element.el
        [ Background.color <| rgb255 0 37 57
        , height fill
        , paddingXY 25 10
        ]
    <|
        Element.row
            [ padding 15
            , Border.rounded 15
            , Font.color white
            , Font.bold
            , spacing 10

            -- , Background.color <| rgb255 0 85 128
            , borderShadow
            ]
            [ Element.column
                [ spacing 5
                , alignTop
                , centerX
                ]
              <|
                List.map (\x -> sampleColorBlock <| hslToColor 200 1 x) <|
                    [ 1
                    , 0.95
                    , 0.9
                    , 0.85
                    , 0.8
                    , 0.75
                    , 0.7
                    , 0.65
                    , 0.6
                    , 0.55
                    , 0.5
                    , 0.45
                    , 0.4
                    , 0.35
                    , 0.3
                    , 0.25
                    , 0.2
                    , 0.15
                    , 0.1
                    , 0
                    ]
            ]


hslToColor : Int -> Float -> Float -> Color.Color
hslToColor hue sat light =
    Color.fromHsl { hue = toFloat hue, saturation = sat, lightness = light }


sampleColorBlock : Color.Color -> Element msg
sampleColorBlock color =
    let
        rgba255 =
            Color.toRgba255 color
    in
    Element.el
        [ Background.color <| rgb255 rgba255.red rgba255.green rgba255.blue
        , width <| px 32
        , height <| px 32
        , Border.width 1
        , Border.color black
        ]
    <|
        text " "


saturationScale : Element msg
saturationScale =
    Element.el
        [ width fill
        , Background.color <| rgb255 0 37 57
        , height fill
        , paddingXY 25 10
        ]
    <|
        Element.row
            [ padding 15
            , Border.rounded 15
            , Font.color white
            , Font.bold
            , spacing 10
            , Background.color <| rgb255 0 85 128
            , borderShadow
            ]
            [ Element.column
                [ spacing 5
                , alignTop
                , centerX
                ]
              <|
                List.map (\x -> sampleColorBlock <| hslToColor 200 x 1) <|
                    [ 1
                    , 0.95
                    , 0.9
                    , 0.85
                    , 0.8
                    , 0.75
                    , 0.7
                    , 0.65
                    , 0.6
                    , 0.55
                    , 0.5
                    , 0.45
                    , 0.4
                    , 0.35
                    , 0.3
                    , 0.25
                    , 0.2
                    , 0.15
                    , 0.1
                    , 0
                    ]
            ]
