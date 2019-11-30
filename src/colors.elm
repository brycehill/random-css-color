module Colors exposing (Color, fromUrl, getRandomColor, isLightColor)

import List exposing (append, drop, head, member)
import Random
import Url
import Url.Parser as Parser



-- toString color = color


type alias Color =
    String


light =
    [ "AntiqueWhite"
    , "AliceBlue"
    , "Azure"
    , "Beige"
    , "Bisque"
    , "BlanchedAlmond"
    , "Cornsilk"
    , "LavenderBlush"
    , "FloralWhite"
    , "Yellow"
    , "Ivory"
    , "Gainsboro"
    , "GhostWhite"
    , "HoneyDew"
    , "LemonChiffon"
    , "LightCyan"
    , "LightGray"
    , "LightGrey"
    , "LightGoldenRodYellow"
    , "LightYellow"
    , "Linen"
    , "Lavender"
    , "Moccasin"
    , "OldLace"
    , "PaleGoldenRod"
    , "PapayaWhip"
    , "PeachPuff"
    , "PowderBlue"
    , "MintCream"
    , "MistyRose"
    , "NavajoWhite"
    , "SeaShell"
    , "Snow"
    , "Wheat"
    , "White"
    , "WhiteSmoke"
    ]


colors =
    append light
        [ "Aqua"
        , "Aquamarine"
        , "Black"
        , "Blue"
        , "BlueViolet"
        , "Brown"
        , "BurlyWood"
        , "CadetBlue"
        , "Chartreuse"
        , "Chocolate"
        , "Coral"
        , "CornflowerBlue"
        , "Crimson"
        , "Cyan"
        , "DarkBlue"
        , "DarkCyan"
        , "DarkGoldenRod"
        , "DarkGray"
        , "DarkGrey"
        , "DarkGreen"
        , "DarkKhaki"
        , "DarkMagenta"
        , "DarkOliveGreen"
        , "Darkorange"
        , "DarkOrchid"
        , "DarkRed"
        , "DarkSalmon"
        , "DarkSeaGreen"
        , "DarkSlateBlue"
        , "DarkSlateGray"
        , "DarkSlateGrey"
        , "DarkTurquoise"
        , "DarkViolet"
        , "DeepPink"
        , "DeepSkyBlue"
        , "DimGray"
        , "DimGrey"
        , "DodgerBlue"
        , "FireBrick"
        , "ForestGreen"
        , "Fuchsia"
        , "Gold"
        , "GoldenRod"
        , "Gray"
        , "Grey"
        , "Green"
        , "GreenYellow"
        , "HotPink"
        , "IndianRed"
        , "Indigo"
        , "Khaki"
        , "LawnGreen"
        , "LightBlue"
        , "LightCoral"
        , "LightGreen"
        , "LightPink"
        , "LightSalmon"
        , "LightSeaGreen"
        , "LightSkyBlue"
        , "LightSlateGray"
        , "LightSlateGrey"
        , "LightSteelBlue"
        , "Lime"
        , "LimeGreen"
        , "Magenta"
        , "Maroon"
        , "MediumAquaMarine"
        , "MediumBlue"
        , "MediumOrchid"
        , "MediumPurple"
        , "MediumSeaGreen"
        , "MediumSlateBlue"
        , "MediumSpringGreen"
        , "MediumTurquoise"
        , "MediumVioletRed"
        , "MidnightBlue"
        , "Navy"
        , "Olive"
        , "OliveDrab"
        , "Orange"
        , "OrangeRed"
        , "Orchid"
        , "PaleGreen"
        , "PaleTurquoise"
        , "PaleVioletRed"
        , "Peru"
        , "Pink"
        , "Plum"
        , "Purple"
        , "Red"
        , "RosyBrown"
        , "RoyalBlue"
        , "SaddleBrown"
        , "Salmon"
        , "SandyBrown"
        , "SeaGreen"
        , "Sienna"
        , "Silver"
        , "SkyBlue"
        , "SlateBlue"
        , "SlateGray"
        , "SlateGrey"
        , "SpringGreen"
        , "SteelBlue"
        , "Tan"
        , "Teal"
        , "Thistle"
        , "Tomato"
        , "Turquoise"
        , "Violet"
        , "YellowGreen"
        ]



-- Helpers


fromUrl : Url.Url -> Maybe Color
fromUrl url =
    Parser.parse Parser.string url


get : List a -> Int -> Maybe a
get list i =
    head (drop i list)


listGenerator : List a -> Random.Generator (Maybe a)
listGenerator list =
    Random.map (get list) (Random.int 0 (List.length list))


getRandomColor : (Maybe String -> msg) -> Cmd msg
getRandomColor toMsg =
    Random.generate toMsg (listGenerator colors)


isLightColor : Color -> Bool
isLightColor color =
    member color light
