module Readme exposing (..)

import Color exposing (Color, fromHexUnsafe, fromPalette, hsl, rgb, rgb255, toCssString)
import Element exposing (Element, el, text)
import Element.Background
import Html exposing (Html)
import Html.Attributes exposing (style)



{- # elm-color

   An Elm package to programmatically work with web colors.


   # Example

   ![](./docs/Example.b3f19e1.png)

   You can find this example at `example/src/Main.elm`.


   # Usage

   Build using different constructors, or manipulate values, i.e., change the lightness of a color in the HSL space.

-}


colors : List Color
colors =
    [ hsl 194 0.49 0.14
    , fromHexUnsafe "#06A77D"
    , rgb 0.96 0.976 0.996
    , rgb255 122 137 194
    ]


colorPalette : List Color
colorPalette =
    fromPalette "https://coolors.co/40f99b-61707d"


green : Color
green =
    hsl 164 0.93 0.34


viewHtml : Html msg
viewHtml =
    Html.div
        [ style "background-color" (Color.toCssString green)
        ]
        [ Html.text (toCssString green) ]


{-| Elm-UI example

For elm-ui see <https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/>

-}
view : Element msg
view =
    el
        [ Element.Background.color (toElementColor green)
        ]
        (text (toCssString green))


{-| Helper to convert to elm-ui color
-}
toElementColor : Color -> Element.Color
toElementColor =
    Element.fromRgb << Color.toRgba



{- # Notes

   ## Drop in replacement for avh4/elm-color

   This package is a new implementation from the ground up with many more features. However, it shares the same api as [avh4/elm-color](https://package.elm-lang.org/packages/avh4/elm-color/latest/). Since that package doesn't seem to be actively maintained anymore, you can use this new package as a drop-in replacement.

-}
