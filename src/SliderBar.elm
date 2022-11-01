module SliderBar exposing (sliderBar)

import ColorRecord exposing (ColorRecord)
import Element exposing (centerX, centerY, fill, height, padding, paddingXY, px, rgb, rgb255, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (hoverHighlight)
import Messages exposing (Msg(..))
import Model exposing (Model)



-- sliderBar : Element.Element Msg


sliderBar model =
    Element.el
        [ Background.color <| rgb255 0 85 128
        , padding 15
        , Border.rounded 5
        , centerX
        ]
    <|
        Element.column
            []
            [ colorSlider Red model.selectedColor
            , colorSlider Green model.selectedColor
            , colorSlider Blue model.selectedColor
            ]


type FocusColor
    = Red
    | Green
    | Blue


colorSlider focusColor selectedColor =
    let
        changeIt x =
            case focusColor of
                Red ->
                    ChangeColor { selectedColor | red = round x }

                Green ->
                    ChangeColor { selectedColor | green = round x }

                Blue ->
                    ChangeColor { selectedColor | blue = round x }

        labelText =
            case focusColor of
                Red ->
                    "Red"

                Green ->
                    "Green"

                Blue ->
                    "Blue"

        myValue =
            case focusColor of
                Red ->
                    toFloat selectedColor.red

                Green ->
                    toFloat selectedColor.green

                Blue ->
                    toFloat selectedColor.blue
    in
    Input.slider
        [ Element.height (Element.px 30)
        , width <| px 150
        , Element.behindContent
            (Element.el
                [ Element.width Element.fill
                , Element.height (Element.px 2)
                , Element.centerY
                , Background.color <| rgb 1 1 1
                , Border.rounded 2
                ]
                Element.none
            )
        ]
        { onChange = changeIt
        , label =
            Input.labelAbove []
                (text labelText)
        , min = 0
        , max = 255
        , step = Nothing
        , value = myValue
        , thumb =
            Input.defaultThumb
        }
