port module YouTube.API exposing (getVideoData, loadVideoById, loadVideoByUrl, onPlayerReady, onPlayerStateChange, playVideo, setVideoData, videoDataDecoder)

import Json.Decode as D
import Json.Encode exposing (Value)
import YouTube.VideoData exposing (VideoData)


port onPlayerStateChange : (Int -> msg) -> Sub msg


port onPlayerReady : (() -> msg) -> Sub msg


port setVideoData : (Value -> msg) -> Sub msg


videoDataDecoder : D.Decoder VideoData
videoDataDecoder =
    D.map3 VideoData
        (D.field "video_id" D.string)
        (D.field "author" D.string)
        (D.field "title" D.string)


port playVideo : () -> Cmd msg


port loadVideoByUrl : String -> Cmd msg


port loadVideoById : String -> Cmd msg


port getVideoData : () -> Cmd msg
