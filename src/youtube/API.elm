port module YouTube.API exposing (onPlayerReady, onPlayerStateChange, videoDataDecoder)

import Json.Decode as D
import Json.Encode exposing (Value)
import YouTube.VideoData exposing (VideoData)


port onPlayerStateChange : (Int -> msg) -> Sub msg


port onPlayerReady : (Value -> msg) -> Sub msg


videoDataDecoder : D.Decoder VideoData
videoDataDecoder =
    D.map3 VideoData
        (D.field "video_id" D.string)
        (D.field "author" D.string)
        (D.field "title" D.string)
