module HSLSliderPanel exposing (hslSliderPanel)

-- import Element exposing (centerX, fill, focused, padding, px, rgb, rgb255, spacing, text, width)

import ColorRecord exposing (ColorRecord)
import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (selected)
import Messages exposing (Msg(..))
import GlobalAttributes exposing (..)


--This is the panel containing the red green and blue slider groups


hslSliderPanel : ColorRecord -> Element.Element Msg
hslSliderPanel selectedColor =
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
            [ hueSlideGroup selectedColor
            , saturationSlideGroup selectedColor
            , luminationSlideGroup selectedColor
            ]



--This is the group containing the textbox, the label and the slider


sliderComponent : FocusColor -> ColorRecord -> Element Msg
sliderComponent colorFocus selectedColor =
    let
        inputValueToInt y =
            Maybe.withDefault 0 <| String.toInt y

        conditionalData =
            case colorFocus of
                Red ->
                    { colorComponent = selectedColor.red
                    , colorText = "Hue"
                    , updateColorComponent = \inputBoxString -> { selectedColor | red = inputValueToInt inputBoxString }
                    }

                Green ->
                    { colorComponent = selectedColor.green
                    , colorText = "Saturation"
                    , updateColorComponent = \inputBoxString -> { selectedColor | green = inputValueToInt inputBoxString }
                    }

                Blue ->
                    { colorComponent = selectedColor.blue
                    , colorText = "Lumination"
                    , updateColorComponent = \inputBoxString -> { selectedColor | blue = inputValueToInt inputBoxString }
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
                , width
                    (fill
                        |> maximum 55
                    )
                ]
                { label = Input.labelHidden ""
                , onChange = \newValue -> ChangeColor <| conditionalData.updateColorComponent newValue
                , placeholder = Just <| Input.placeholder [] <| text ""
                , text = String.fromInt conditionalData.colorComponent
                }
            , colorSlider colorFocus selectedColor
            ]
        ]


hueSlideGroup : ColorRecord -> Element.Element Msg
hueSlideGroup selectedColor =
    sliderComponent Red selectedColor


saturationSlideGroup : ColorRecord -> Element.Element Msg
saturationSlideGroup selectedColor =
    sliderComponent Green selectedColor


luminationSlideGroup : ColorRecord -> Element.Element Msg
luminationSlideGroup selectedColor =
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
                    , onChange =
                        \sliderValue ->
                            ChangeColor { selectedColor | red = round sliderValue }
                    }

                Green ->
                    { label = "Green"
                    , value = toFloat selectedColor.green
                    , onChange =
                        \sliderValue ->
                            ChangeColor { selectedColor | green = round sliderValue }
                    }

                Blue ->
                    { label = "Blue"
                    , value = toFloat selectedColor.blue
                    , onChange =
                        \sliderValue ->
                            ChangeColor { selectedColor | blue = round sliderValue }
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
