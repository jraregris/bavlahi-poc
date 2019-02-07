module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Json.Decode as D
import Json.Encode exposing (Value)
import YouTube
import YouTube.API as API
import YouTube.Status as Status exposing (Status(..))
import YouTube.VideoData exposing (VideoData)


type alias Model =
    { youtube : YouTube.Model, inField : String, code : Maybe String }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


view : Model -> Html Msg
view model =
    Html.div []
        [ renderTitle model.youtube.videoData
        , renderAuthor model.youtube.videoData
        , Html.text (Status.toString model.youtube.status)
        , Html.br [] []
        , Html.input
            [ Attributes.placeholder "Video URL"
            , Attributes.value model.inField
            , Events.onInput ChangeUrl
            ]
            []
        , Html.button [ Events.onClick LoadUrl ] [ Html.text "Load URL" ]
        ]


renderTitle : Maybe VideoData -> Html msg
renderTitle mdata =
    case mdata of
        Nothing ->
            Html.text ""

        Just data ->
            Html.h2 [] [ Html.text data.title ]


renderAuthor : Maybe VideoData -> Html msg
renderAuthor mdata =
    case mdata of
        Nothing ->
            Html.text ""

        Just data ->
            Html.h3 [] [ Html.text data.author ]


init : flags -> ( Model, Cmd msg )
init _ =
    ( Model YouTube.init "" Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayerStateChange n ->
            let
                maybeStatus =
                    Status.fromInt n
            in
            case maybeStatus of
                Just status ->
                    let
                        yt =
                            model.youtube

                        youtube =
                            { yt | status = status }
                    in
                    ( { model | youtube = youtube }, API.getVideoData () )

                Nothing ->
                    ( model, Cmd.none )

        PlayerReady () ->
            ( model, API.getVideoData () )

        SetVideoData v ->
            let
                dataResult =
                    D.decodeValue API.videoDataDecoder v
            in
            case dataResult of
                Ok data ->
                    let
                        yt =
                            model.youtube

                        youtube =
                            { yt | videoData = Just data }
                    in
                    ( { model | youtube = youtube }, Cmd.none )

                Err _ ->
                    let
                        yt =
                            model.youtube

                        youtube =
                            { yt | videoData = Nothing }
                    in
                    ( { model | youtube = yt }, Cmd.none )

        ChangeUrl s ->
            ( { model | urlField = s }, Cmd.none )

        LoadUrl ->
            ( model, API.loadVideoById model.urlField )


subscriptions : model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ API.onPlayerStateChange PlayerStateChange
        , API.onPlayerReady PlayerReady
        , API.setVideoData SetVideoData
        ]


type Msg
    = PlayerStateChange Int
    | PlayerReady ()
    | ChangeUrl String
    | SetVideoData Value
    | LoadUrl
