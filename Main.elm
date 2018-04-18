module Main exposing (..)

import Html exposing (Html, body, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Colors exposing (colors)
import List exposing (drop, head)
import Random


main =
    Html.program
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


init : ( Maybe Color, Cmd Msg )
init =
    ( head colors, Random.generate (ChangeColor) (listGenerator colors) )


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


view : Maybe Color -> Html Msg
view mc =
    case mc of
        Just color ->
            div
                [ style [ ( "backgroundColor", color ), ( "height", "100%" ), ( "width", "100%" ) ]
                , onClick (ChangeColor mc)
                ]
                [ div [] [ text color ] ]

        Nothing ->
            div [] [ div [ onClick (ChangeColor mc) ] [ text "No" ] ]
