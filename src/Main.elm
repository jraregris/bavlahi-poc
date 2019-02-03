port module Main exposing (main)

import Browser
import Html exposing (Html)
import Json.Encode as E


type Status
    = Stopped
    | Unknown
    | Playing


main : Program () Status Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


view : Status -> Html msg
view model =
    Html.div [] [ Html.text (status2Text model) ]


status2Text : Status -> String
status2Text status =
    case status of
        Stopped ->
            "Stopped"

        Playing ->
            "Playing"

        Unknown ->
            "Unknown"


init : flags -> ( Status, Cmd msg )
init _ =
    ( Stopped, Cmd.none )


update : Msg -> model -> ( Status, Cmd Msg )
update msg model =
    case msg of
        PlayerStatus s ->
            ( playerStatus2Status s, Cmd.none )


playerStatus2Status : Int -> Status
playerStatus2Status ps =
    case ps of
        1 ->
            Playing

        2 ->
            Stopped

        _ ->
            Unknown


subscriptions : model -> Sub Msg
subscriptions _ =
    player_status PlayerStatus


type Msg
    = PlayerStatus Int


port player_status : (Int -> msg) -> Sub msg
