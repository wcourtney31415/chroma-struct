module HSLSliderPanel exposing (..)

import Color
import Color.Colors exposing (white)
import Color.Conversions exposing (hslaToColor)
import Color.Types exposing (RawColor)
import Element
    exposing
        ( Element
        , centerX
        , fill
        , maximum
        , padding
        , paddingEach
        , px
        , rgb255
        , spacing
        , text
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (borderShadow)
import Messages exposing (Msg(..))


type alias InputRowData =
    { currentValue : Int
    , label : String
    , textOnChange : String -> Msg
    , sliderOnChange : Float -> Msg
    , range : ( Int, Int )
    }


{-| This is the panel containing the red green and blue slider groups
-}
panel : RawColor -> Element.Element Msg
panel selectedColor =
    Element.el
        [ Background.color <| rgb255 0 85 128
        , padding 15
        , width <| px 256
        , Border.rounded 5
        , borderShadow
        , centerX
        ]
    <|
        let
            hsla =
                Color.toHsla selectedColor
        in
        Element.column
            [ width fill
            , spacing 5
            ]
            [ hueInputRow hsla
            , saturationInputRow hsla
            , luminationInputRow hsla
            ]


hueInputRow : Color.Types.HslaFloatColor -> Element.Element Msg
hueInputRow hsla =
    inputRow
        { currentValue = round hsla.hue
        , label = "Hue"
        , textOnChange =
            \newValue ->
                { hsla | hue = inputValueToFloat newValue }
                    |> hslaToColor
                    |> ChangeColor
        , sliderOnChange =
            \newSliderValue ->
                { hsla | hue = newSliderValue }
                    |> hslaToColor
                    |> ChangeColor
        , range = (0, 360)
        }


saturationInputRow : Color.Types.HslaFloatColor -> Element.Element Msg
saturationInputRow hsla =
    inputRow
        { currentValue = round <| 100 * hsla.saturation
        , label = "Saturation"
        , textOnChange =
            \newValue ->
                { hsla | saturation = (inputValueToFloat newValue) / 100 }
                    |> hslaToColor
                    |> ChangeColor
        , sliderOnChange =
            \newSliderValue ->
                { hsla | saturation = newSliderValue / 100 }
                    |> hslaToColor
                    |> ChangeColor
        , range = ( 0, 100 )
        }


luminationInputRow : Color.Types.HslaFloatColor -> Element.Element Msg
luminationInputRow hsla =
    inputRow
        { currentValue = round <| 100 * hsla.lightness
        , label = "Lumination"
        , textOnChange =
            \newValue ->
                { hsla | lightness = (inputValueToFloat newValue) / 100 }
                    |> hslaToColor
                    |> ChangeColor
        , sliderOnChange =
            \newSliderValue ->
                { hsla | lightness = newSliderValue / 100 }
                    |> hslaToColor
                    |> ChangeColor
        , range = ( 0, 100 )
        }


inputRow : InputRowData -> Element Msg
inputRow localData =
    Element.column
        [ width fill ]
        [ Element.el
            [ paddingEach
                { top = 0
                , right = 0
                , left = 0
                , bottom = 5
                }
            ]
          <|
            text localData.label
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
                , onChange = localData.textOnChange
                , placeholder = Just <| Input.placeholder [] <| text ""
                , text = String.fromInt localData.currentValue
                }
            , Input.slider
                [ Element.height <| Element.px 30
                , width fill
                , Element.behindContent <|
                    Element.el
                        [ Element.height (Element.px 2)
                        , Element.centerY
                        , Background.color white
                        , Border.rounded 2
                        , width fill
                        ]
                        Element.none
                ]
                { onChange = localData.sliderOnChange
                , label = Input.labelHidden ""
                , min = toFloat <| Tuple.first localData.range
                , max = toFloat <| Tuple.second localData.range
                , step = Nothing
                , value = toFloat localData.currentValue
                , thumb = Input.defaultThumb
                }
            ]
        ]


inputValueToInt : String -> Int
inputValueToInt =
    Maybe.withDefault 0 << String.toInt


inputValueToFloat =
    Maybe.withDefault 0 << String.toFloat
