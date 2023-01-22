module HSVSliderPanel exposing (hsvSliderPanel)

import ColorRecord exposing (ColorRecord, HSVColorRecord)
import Colors exposing (..)
import Conversions exposing (hsvToRgb, rgbToHsv)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import Messages exposing (Msg(..))



--This is the panel containing the red green and blue slider groups


hsvSliderPanel : ColorRecord -> Element.Element Msg
hsvSliderPanel selectedColor =
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
            [ hueSlideGroup <| rgbToHsv selectedColor
            , saturationSlideGroup <| rgbToHsv selectedColor
            , valueSlideGroup <| rgbToHsv selectedColor
            ]



--This is the group containing the textbox, the label and the slider


sliderComponent : FocusColor -> HSVColorRecord -> Element Msg
sliderComponent colorFocus selectedColor =
    let
        inputValueToFloat y =
            Maybe.withDefault 0 <| String.toFloat y

        conditionalData =
            case colorFocus of
                Red ->
                    { colorComponent = selectedColor.hue
                    , colorText = "Hue"
                    , updateColorComponent = \inputBoxString -> { selectedColor | hue = inputValueToFloat inputBoxString }
                    }

                Green ->
                    { colorComponent = selectedColor.saturation
                    , colorText = "Saturation"
                    , updateColorComponent = \inputBoxString -> { selectedColor | saturation = inputValueToFloat inputBoxString }
                    }

                Blue ->
                    { colorComponent = selectedColor.value
                    , colorText = "Value"
                    , updateColorComponent = \inputBoxString -> { selectedColor | value = inputValueToFloat inputBoxString }
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
                , width <| maximum 55 <| fill
                ]
                { label = Input.labelHidden ""
                , onChange = \newValue -> ChangeColor <| hsvToRgb <| conditionalData.updateColorComponent newValue
                , placeholder = Just <| Input.placeholder [] <| text ""
                , text = String.fromFloat conditionalData.colorComponent
                }
            , colorSlider colorFocus selectedColor
            ]
        ]


hueSlideGroup : HSVColorRecord -> Element.Element Msg
hueSlideGroup selectedColor =
    sliderComponent Red selectedColor


saturationSlideGroup : HSVColorRecord -> Element.Element Msg
saturationSlideGroup selectedColor =
    sliderComponent Green selectedColor


valueSlideGroup : HSVColorRecord -> Element.Element Msg
valueSlideGroup selectedColor =
    sliderComponent Blue selectedColor


type FocusColor
    = Red
    | Green
    | Blue



--This is the slider itself


colorSlider : FocusColor -> HSVColorRecord -> Element.Element Msg
colorSlider focusColor selectedColor =
    let
        localData =
            case focusColor of
                Red ->
                    { label = "Hue"
                    , value = selectedColor.hue
                    , onChange =
                        \sliderValue ->
                            ChangeColor <| hsvToRgb { selectedColor | hue = sliderValue }
                    }

                Green ->
                    { label = "Saturation"
                    , value = selectedColor.saturation
                    , onChange =
                        \sliderValue ->
                            ChangeColor <| hsvToRgb { selectedColor | saturation = sliderValue }
                    }

                Blue ->
                    { label = "Value"
                    , value = selectedColor.value
                    , onChange =
                        \sliderValue ->
                            ChangeColor <| hsvToRgb { selectedColor | value = sliderValue }
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
