module RGBSliderPanel exposing (rgbSliderPanel)

import ColorRecord exposing (ColorRecord)
import Element exposing (centerX, fill, padding, px, rgb, rgb255, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Messages exposing (Msg(..))


rgbSliderPanel : ColorRecord -> Element.Element Msg
rgbSliderPanel selectedColor =
    Element.el
        [ Background.color <| rgb255 0 85 128
        , padding 15
        , width <| px 256
        , Border.rounded 5
        , centerX
        ]
    <|
        Element.column
            [ width fill ]
            [ redSlideGroup selectedColor
            , greenSlideGroup selectedColor
            , blueSlideGroup selectedColor

            ]


redSlideGroup : ColorRecord -> Element.Element Msg
redSlideGroup selectedColor =
    Element.column []
        [ Element.el [] <| text "Red"
        , Element.row []
            [ Input.text [ Font.color <| rgb 0 0 0 ]
                { label = Input.labelHidden ""
                , onChange =
                    \y ->
                        ChangeColor
                            { selectedColor | red = Maybe.withDefault 0 <| String.toInt y }
                , placeholder = Just <| Input.placeholder [] <| text ""
                , text = String.fromInt selectedColor.red
                }
            , colorSlider Red selectedColor
            ]
        ]


greenSlideGroup : ColorRecord -> Element.Element Msg
greenSlideGroup selectedColor =
    Element.column []
        [ Element.el [] <| text "Green"
        , Element.row []
            [ Input.text [ Font.color <| rgb 0 0 0 ]
                { label = Input.labelHidden ""
                , onChange =
                    \y ->
                        ChangeColor
                            { selectedColor | green = Maybe.withDefault 0 <| String.toInt y }
                , placeholder = Just <| Input.placeholder [] <| text ""
                , text = String.fromInt selectedColor.green
                }
            , colorSlider Green selectedColor
            ]
        ]


blueSlideGroup : ColorRecord -> Element.Element Msg
blueSlideGroup selectedColor =
    Element.column []
        [ Element.el [] <| text "Blue"
        , Element.row []
            [ Input.text [ Font.color <| rgb 0 0 0 ]
                { label = Input.labelHidden ""
                , onChange =
                    \y ->
                        ChangeColor
                            { selectedColor | blue = Maybe.withDefault 0 <| String.toInt y }
                , placeholder = Just <| Input.placeholder [] <| text ""
                , text = String.fromInt selectedColor.blue
                }
            , colorSlider Blue selectedColor
            ]
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
            Input.labelHidden ""
        , min = 0
        , max = 255
        , step = Nothing
        , value = localData.value
        , thumb =
            Input.defaultThumb
        }


sliderBar : Element.Attribute msg
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
