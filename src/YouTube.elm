module YouTube exposing (Model, init)

import YouTube.Status as Status exposing (Status)


type alias Model =
    { status : Status
    }


init : Model
init =
    Model Status.Unstarted
