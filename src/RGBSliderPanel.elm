module RGBSliderPanel exposing (rgbSliderPanel)

import Color
import Color.Types exposing (RawColor)
import Colors exposing (..)
import Conversions exposing (rgba255ToColor)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import Messages exposing (Msg(..))



--This is the panel containing the red green and blue slider groups


rgbSliderPanel : RawColor -> Element.Element Msg
rgbSliderPanel selectedColor =
    Element.el
        [ Background.color <| rgb255 0 85 128
        , padding 15
        , width <| px 256
        , Border.rounded 5
        , borderShadow
        , centerX
        ]
    <|
        Element.column
            [ width fill
            , spacing 5
            ]
            [ redSlideGroup selectedColor
            , greenSlideGroup selectedColor
            , blueSlideGroup selectedColor
            ]



--This is the group containing the textbox, the label and the slider


sliderComponent : FocusColor -> RawColor -> Element Msg
sliderComponent colorFocus selectedColor =
    let
        rgba255 =
            Color.toRgba255 selectedColor

        inputValueToInt y =
            Maybe.withDefault 0 <| String.toInt y

        conditionalData =
            case colorFocus of
                Red ->
                    { colorComponent = rgba255.red
                    , colorText = "Red"
                    , updateColorComponent = \inputBoxString -> { rgba255 | red = inputValueToInt inputBoxString }
                    }

                Green ->
                    { colorComponent = rgba255.green
                    , colorText = "Green"
                    , updateColorComponent = \inputBoxString -> { rgba255 | green = inputValueToInt inputBoxString }
                    }

                Blue ->
                    { colorComponent = rgba255.blue
                    , colorText = "Blue"
                    , updateColorComponent = \inputBoxString -> { rgba255 | blue = inputValueToInt inputBoxString }
                    }
    in
    Element.column [ width fill ]
        [ Element.el
            [ paddingEach
                { top = 0
                , right = 0
                , left = 0
                , bottom = 5
                }
            ]
          <|
            text conditionalData.colorText
        , Element.row
            [ spacing 10
            , width fill
            ]
            [ Input.text
                [ Font.color white
                , Background.color <| rgb255 0 51 77
                , padding 5
                , width (fill |> maximum 55)
                ]
                { label = Input.labelHidden ""
                , onChange = \newValue -> ChangeColor <| rgba255ToColor <| conditionalData.updateColorComponent newValue
                , placeholder = Just <| Input.placeholder [] <| text ""
                , text = String.fromInt conditionalData.colorComponent
                }
            , colorSlider colorFocus selectedColor
            ]
        ]


redSlideGroup : RawColor -> Element.Element Msg
redSlideGroup selectedColor =
    sliderComponent Red selectedColor


greenSlideGroup : RawColor -> Element.Element Msg
greenSlideGroup selectedColor =
    sliderComponent Green selectedColor


blueSlideGroup : RawColor -> Element.Element Msg
blueSlideGroup selectedColor =
    sliderComponent Blue selectedColor


type FocusColor
    = Red
    | Green
    | Blue



--This is the slider itself


colorSlider : FocusColor -> RawColor -> Element.Element Msg
colorSlider focusColor selectedColor =
    let
        rgba255 =
            Color.toRgba255 selectedColor

        localData =
            case focusColor of
                Red ->
                    { label = "Red"
                    , value = toFloat rgba255.red
                    , onChange =
                        \sliderValue ->
                            ChangeColor <| rgba255ToColor { rgba255 | red = round sliderValue }
                    }

                Green ->
                    { label = "Green"
                    , value = toFloat rgba255.green
                    , onChange =
                        \sliderValue ->
                            ChangeColor <| rgba255ToColor { rgba255 | green = round sliderValue }
                    }

                Blue ->
                    { label = "Blue"
                    , value = toFloat rgba255.blue
                    , onChange =
                        \sliderValue ->
                            ChangeColor <| rgba255ToColor { rgba255 | blue = round sliderValue }
                    }
    in
    Input.slider
        [ Element.height (Element.px 30)
        , width fill
        , sliderBar
        ]
        { onChange = localData.onChange
        , label = Input.labelHidden ""
        , min = 0
        , max = 255
        , step = Nothing
        , value = localData.value
        , thumb = Input.defaultThumb
        }



--This is the background bar to the slider


sliderBar : Element.Attribute msg
sliderBar =
    Element.behindContent <|
        Element.el
            [ Element.height (Element.px 2)
            , Element.centerY
            , Background.color white
            , Border.rounded 2
            , width fill
            ]
            Element.none
