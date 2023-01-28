module RGBSliderPanel exposing (panel)

-- import GlobalAttributes exposing (..)

import Color
import Color.Colors exposing (white)
import Color.Conversions exposing (rgba255ToColor)
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
            rgba255 =
                Color.toRgba255 selectedColor
        in
        Element.column
            [ width fill
            , spacing 5
            ]
            [ redInputRow rgba255
            , greenInputRow rgba255
            , blueInputRow rgba255
            ]


redInputRow : Color.Types.Rgba255Color -> Element.Element Msg
redInputRow rgba255 =
    inputRow
        { currentValue = rgba255.red
        , label = "Red"
        , textOnChange =
            \newValue ->
                { rgba255 | red = inputValueToInt newValue }
                    |> rgba255ToColor
                    |> ChangeColor
        , sliderOnChange =
            \newSliderValue ->
                { rgba255 | red = round newSliderValue }
                    |> rgba255ToColor
                    |> ChangeColor
        }


greenInputRow : Color.Types.Rgba255Color -> Element.Element Msg
greenInputRow rgba255 =
    inputRow
        { currentValue = rgba255.green
        , label = "Green"
        , textOnChange =
            \newValue ->
                { rgba255 | green = inputValueToInt newValue }
                    |> rgba255ToColor
                    |> ChangeColor
        , sliderOnChange =
            \newSliderValue ->
                { rgba255 | green = round newSliderValue }
                    |> rgba255ToColor
                    |> ChangeColor
        }


blueInputRow : Color.Types.Rgba255Color -> Element.Element Msg
blueInputRow rgba255 =
    inputRow
        { currentValue = rgba255.blue
        , label = "Blue"
        , textOnChange =
            \newValue ->
                { rgba255 | blue = inputValueToInt newValue }
                    |> rgba255ToColor
                    |> ChangeColor
        , sliderOnChange =
            \newSliderValue ->
                { rgba255 | blue = round newSliderValue }
                    |> rgba255ToColor
                    |> ChangeColor
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
                , min = 0
                , max = 255
                , step = Nothing
                , value = toFloat localData.currentValue
                , thumb = Input.defaultThumb
                }
            ]
        ]


inputValueToInt : String -> Int
inputValueToInt =
    Maybe.withDefault 0 << String.toInt
