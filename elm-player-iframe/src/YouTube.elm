module YouTube exposing (Model, init)

import YouTube.Status as Status exposing (Status)
import YouTube.VideoData exposing (VideoData)


type alias Model =
    { status : Status
    , videoData : Maybe VideoData
    }


init : Model
init =
    Model Status.Unstarted Nothing
