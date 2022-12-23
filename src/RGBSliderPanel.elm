module RGBSliderPanel exposing (rgbSliderPanel)

import ColorRecord exposing (ColorRecord)
import Element exposing (centerX, fill, focused, padding, px, rgb, rgb255, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (selected)
import Messages exposing (Msg(..))



--This is the panel containing the red green and blue slider groups


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



--This is the group containing the textbox, the label and the slider


sliderComponent colorFocus selectedColor =
    let
        inputValueToInt y =
            Maybe.withDefault 0 <| String.toInt y

        conditionalData =
            case colorFocus of
                Red ->
                    { colorComponent = selectedColor.red
                    , colorText = "Red"
                    , updateColorComponent = \inputBoxString -> { selectedColor | red = inputValueToInt inputBoxString }
                    }

                Green ->
                    { colorComponent = selectedColor.green
                    , colorText = "Green"
                    , updateColorComponent = \inputBoxString -> { selectedColor | green = inputValueToInt inputBoxString }
                    }

                Blue ->
                    { colorComponent = selectedColor.blue
                    , colorText = "Blue"
                    , updateColorComponent = \inputBoxString -> { selectedColor | blue = inputValueToInt inputBoxString }
                    }
    in
    Element.column []
        [ Element.el [] <| text conditionalData.colorText
        , Element.row []
            [ Input.text [ Font.color <| rgb 0 0 0 ]
                { label = Input.labelHidden ""
                , onChange = \newValue -> ChangeColor <| conditionalData.updateColorComponent newValue
                , placeholder = Just <| Input.placeholder [] <| text ""
                , text = String.fromInt conditionalData.colorComponent
                }
            , colorSlider colorFocus selectedColor
            ]
        ]


redSlideGroup : ColorRecord -> Element.Element Msg
redSlideGroup selectedColor =
    sliderComponent Red selectedColor


greenSlideGroup : ColorRecord -> Element.Element Msg
greenSlideGroup selectedColor =
    sliderComponent Green selectedColor


blueSlideGroup : ColorRecord -> Element.Element Msg
blueSlideGroup selectedColor =
    sliderComponent Blue selectedColor


type FocusColor
    = Red
    | Green
    | Blue



--This is the slider itself


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



--This is the background bar to the slider


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
