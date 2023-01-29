module ScalesArea exposing (..)

import Color
import Color.Colors exposing (..)
import Color.Types exposing (RawColor)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import Messages exposing (Msg(..))


rightColumn selectedColor =
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
            [  padding 6
            , Font.size 16
            , Background.color <| rgb255 0 50 77
            , width fill
            ]
          <|
            Element.el [ centerX ] <|
                text "Color Variants"
        , Element.row
            [ paddingXY 20 10
            , spacing 20
            , Background.color <| rgb255 0 30 46
            , width fill
            ]
            [ hueScale selectedColor
            , saturationScale selectedColor
            , luminationScale selectedColor
            ]
        ]


luminationScale selectedColor =
    let
        hslColor =
            Color.toHsla selectedColor

        hue =
            hslColor.hue |> round

        sat =
            hslColor.saturation
    in
    Element.column
        [ spacing 5
        , alignTop
        -- , centerX
        , padding 15
        , Border.rounded 15
        , Font.color white
        , Background.color <| rgb255 0 50 77
        , Font.bold
        , spacing 10
        , borderShadow
        ]
    <|
        List.map (\x -> sampleColorBlock <| hslToColor hue sat (x / 100)) <|
            makeListOfNumbers 0 100 5


hueScale selectedColor =
    let
        hslColor =
            Color.toHsla selectedColor

        lumination =
            hslColor.lightness

        sat =
            hslColor.saturation
    in
    Element.column
        [ spacing 5
        , alignTop
        , padding 15
        , Border.rounded 15
        , Background.color <| rgb255 0 50 77
        , Font.color white
        , Font.bold
        , spacing 10
        , borderShadow
        ]
    <|
        List.map (\x -> sampleColorBlock <| hslToColor (round x) sat lumination) <|
            makeListOfNumbers 0 360 18


makeListOfNumbers min max steps =
    List.map (\y -> toFloat y) <|
        List.filter (\y -> modBy steps y == 0) <|
            List.range min max


hslToColor : Int -> Float -> Float -> RawColor
hslToColor hue sat light =
    Color.fromHsl { hue = toFloat hue, saturation = sat, lightness = light }


sampleColorBlock : RawColor -> Element Msg
sampleColorBlock color =
    let
        rgba255 =
            Color.toRgba255 color
    in
    Input.button
        [ Background.color <| rgb255 rgba255.red rgba255.green rgba255.blue
        , width <| px 32
        , height <| px 32
        , Border.width 1
        , Border.color black
        ]
        { label = text "", onPress = Just <| ChangeColor color }


saturationScale selectedColor =
    Element.column
        [ spacing 5
        , alignTop
        -- , centerX
        , padding 15
        , Border.rounded 15
        , Font.color white
        , Font.bold
        , spacing 10
        , Background.color <| rgb255 0 50 77
        , borderShadow
        ]
    <|
        List.map (\x -> sampleColorBlock <| hslToColor (Color.toHsla selectedColor |> .hue |> round) (x / 100) (Color.toHsla selectedColor |> .lightness)) <|
            makeListOfNumbers 0 100 5
