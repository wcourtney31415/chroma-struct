module RGBSliderPanel exposing (sliderPanel)

import ColorRecord exposing (ColorRecord)
import Element exposing (centerX, fill, padding, px, rgb, rgb255, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Messages exposing (Msg(..))


sliderPanel : ColorRecord -> Element.Element Msg
sliderPanel selectedColor =
    Element.el
        [ Background.color <| rgb255 0 85 128
        , padding 15
        , width <| px 256
        , Border.rounded 5
        , centerX
        ]
    <|
        Element.column
            [width fill]
            [ colorSlider Red selectedColor
            , colorSlider Green selectedColor
            , colorSlider Blue selectedColor
            ]


type FocusColor
    = Red
    | Green
    | Blue


colorSlider : FocusColor -> ColorRecord -> Element.Element Msg
colorSlider focusColor selectedColor =
    let
        localData =
            case focusColor of
                Red ->
                    { label = "Red"
                    , value = toFloat selectedColor.red
                    , onChange = \sliderValue -> ChangeColor { selectedColor | red = round sliderValue }
                    }

                Green ->
                    { label = "Green"
                    , value = toFloat selectedColor.green
                    , onChange = \sliderValue -> ChangeColor { selectedColor | green = round sliderValue }
                    }

                Blue ->
                    { label = "Blue"
                    , value = toFloat selectedColor.blue
                    , onChange = \sliderValue -> ChangeColor { selectedColor | blue = round sliderValue }
                    }
    in
    Input.slider
        [ Element.height (Element.px 30)
        , width fill
        , sliderBar
        ]
        { onChange = localData.onChange
        , label =
            Input.labelAbove []
                (text localData.label)
        , min = 0
        , max = 255
        , step = Nothing
        , value = localData.value
        , thumb =
            Input.defaultThumb
        }


sliderBar =
    Element.behindContent <|
        Element.el
            [ Element.height (Element.px 2)
            , Element.centerY
            , Background.color <| rgb 1 1 1
            , Border.rounded 2
            , width fill
            ]
            Element.none
