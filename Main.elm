module Main exposing (Color, Msg(..), get, init, listGenerator, main, subscriptions, update, view)

import Colors exposing (colors)
import Browser exposing (Document)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Browser exposing (Document)
import Html.Attributes exposing (style)
import List exposing (drop, head)
import Random


-- main : Program () Color Msg


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Color =
    String


get : List a -> Int -> Maybe a
get list i =
    head (drop i list)


listGenerator : List a -> Random.Generator (Maybe a)
listGenerator list =
    Random.map (get list) (Random.int 0 (List.length list))



-- UPDATE


type Msg
    = ChangeColor (Maybe String)



-- init : flags -> ( Maybe Color, Cmd Msg )


init () =
    ( head colors, Random.generate ChangeColor (listGenerator colors) )


update : Msg -> Maybe Color -> ( Maybe Color, Cmd Msg )
update msg model =
    case msg of
        ChangeColor color ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Maybe Color -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Maybe Color -> Document Msg
view mc =
    { title = ""
    , body =
        [ case mc of
            Just color ->
                div
                    [ style "backgroundColor" color
                    , style "height" "100%"
                    , style "width" "100%"
                    , onClick (ChangeColor mc)
                    ]
                    [ div [] [ text color ] ]

            Nothing ->
                div [] [ div [ onClick (ChangeColor mc) ] [ text "No" ] ]
        ]
    }
