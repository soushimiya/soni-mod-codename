// this literally fucks oh my god
// return;
var bot = true;
function postUpdate() {
    if (bot) {
        playerStrums.cpu = true;
        for (i in playerStrums.members)
            if (i.animation.finished && i.getAnim() == "confirm")
                i.playAnim("static");
    }
}

function onNoteHit(e) {
    if (bot) {
        if (e.note.strumLine != playerStrums) return;
        e.score = 300;
        e.countScore = true;
        e.accuracy = 1;
        e.countAsCombo = true;
        e.showRating = true;
        e.note.strumLine.addHealth(0.023);
        e.showSplash = !e.note.isSustainNote;
    }
}