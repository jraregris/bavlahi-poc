module YouTube.Status exposing (Status(..), fromInt, toString)


type Status
    = Unstarted
    | Ended
    | Playing
    | Paused
    | Buffering
    | VideoCued


toString : Status -> String
toString status =
    case status of
        Unstarted ->
            "Unstarted"

        Ended ->
            "Ended"

        Playing ->
            "Playing"

        Paused ->
            "Paused"

        Buffering ->
            "Buffering"

        VideoCued ->
            "Video cued"


fromInt : Int -> Maybe Status
fromInt int =
    -- Because Elm cannot match on negative numbers, this is a bit quirky
    case int + 1 of
        0 ->
            Just Unstarted

        1 ->
            Just Ended

        2 ->
            Just Playing

        3 ->
            Just Paused

        4 ->
            Just Buffering

        6 ->
            Just VideoCued

        _ ->
            Nothing
