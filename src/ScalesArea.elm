module ScalesArea exposing (..)

-- import Element exposing (centerX, fill, focused, padding, px, rgb, rgb255, spacing, text, width)

import ColorRecord exposing (ColorRecord)
import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import Html.Attributes exposing (selected)
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
                List.map (\x -> sampleColorBlock <| hslToRgb 200 1 x) <|
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


hslToRgb : Int -> Float -> Float -> ColorRecord
hslToRgb hue sat light =
    let
        h =
            toFloat hue / 60

        t2 =
            if light <= 0.5 then
                light * (sat + 1)

            else
                light + sat - (light * sat)

        t1 =
            light * 2 - t2

        hueToRgb tOne tTwo tHue =
            let
                hh =
                    if tHue < 0 then
                        tHue + 6

                    else if tHue >= 6 then
                        tHue - 6

                    else
                        tHue

                ret =
                    if hh < 1 then
                        (tTwo - tOne) * hh + tOne

                    else if hh < 3 then
                        tTwo

                    else if hh < 4 then
                        (tTwo - tOne) * (4 - hh) + tOne

                    else
                        tOne
            in
            ret

        r =
            hueToRgb t1 t2 (h + 2) * 255

        g =
            hueToRgb t1 t2 h * 255

        b =
            hueToRgb t1 t2 (h - 2) * 255
    in
    { red = round r, green = round g, blue = round b }


sampleColorBlock : ColorRecord -> Element msg
sampleColorBlock color =
    Element.el
        [ Background.color <| rgb255 color.red color.green color.blue
        , width <| px 32
        , height <| px 32
        , Border.width 1
        , Border.color black
        ]
    <|
        text " "


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
                List.map (\x -> sampleColorBlock <| hslToRgb 200 x 1) <|
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