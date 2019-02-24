
var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;

function onYouTubeIframeAPIReady() {
    player = new YT.Player('player', {
        height: '390',
        width: '640',
        events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
        }
    });
}

function onPlayerReady(_event) {
    app.ports.onPlayerReady.send(null);
}

function onPlayerStateChange(event) {
    app.ports.onPlayerStateChange.send(event.data);
}

function stopVideo() {
    player.pauseVideo();
}
