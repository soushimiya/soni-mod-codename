var barTop:FlxSprite;
var barBottom:FlxSprite;

function create() {
    var camCinematics:FlxCamera = new FlxCamera();
    camCinematics.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camCinematics, false);
    FlxG.cameras.add(camHUD, false);

    barBottom = new FlxSprite(0, FlxG.height).makeSolid(FlxG.width*2, FlxG.height, FlxColor.BLACK);
    barBottom.cameras = [camCinematics];
    barBottom.screenCenter(FlxAxes.X);
    add(barBottom);

    barTop = new FlxSprite(0, -FlxG.height).makeSolid(FlxG.width*2, FlxG.height, FlxColor.BLACK);
    barTop.cameras = [camCinematics];
    barTop.screenCenter(FlxAxes.X);
    add(barTop);
}

var barTweens:Map<String, FlxTween> = [];
var strumsTweens:Map<String, FlxTween> = [];
var hudTweens:Map<String, FlxTween> = [];
function onEvent(_) {
    if (_.event.name == "Cinematics (Bar)") {
        if (barTweens.exists("CinematicBarTop")) {
            barTweens.get("CinematicBarTop").cancel();
            barTweens.get("CinematicBarTop").destroy();
            barTweens.remove("CinematicBarTop");
        }
        if (barTweens.exists("CinematicBarBottom")) {
            barTweens.get("CinematicBarBottom").cancel();
            barTweens.get("CinematicBarBottom").destroy();
            barTweens.remove("CinematicBarBottom");
        }

        var tweenEase:FlxEase = switch(_.event.params[1]) {
            case "Linear": FlxEase.linear;
            default: Reflect.field(FlxEase, _.event.params[1].toLowerCase() + _.event.params[2]);
        };
        var opacity:Float = _.event.params[0] ? 1 : 0;
        var hudElements = [healthBarBG, healthBar, iconP1, iconP2, scoreTxt, accuracyTxt, missesTxt];
        var hudElementsString = ["healthBarBG", "healthBar", "iconP1", "iconP2", "scoreTxt", "accuracyTxt", "missesTxt"];
        for (i => obj in hudElements) {
            var key:String = hudElementsString[i];
            if (hudTweens.exists(key)) {
                hudTweens.get(key).cancel();
                hudTweens.get(key).destroy();
                hudTweens.remove(key);
            }
            if (_.event.params[0] == "0") {
                    hudTweens.set(key, FlxTween.tween(obj, {alpha: 1}, _.event.params[3], {ease: tweenEase, onComplete: function() {
                    hudTweens.remove(key);
                }}));
            } else {
                    hudTweens.set(key, FlxTween.tween(obj, {alpha: 0}, _.event.params[3], {ease: tweenEase, onComplete: function() {
                    hudTweens.remove(key);
                }}));
            }
        }
        var yVal = -FlxG.height + ((FlxG.height / 2) * (_.event.params[0] / 100));
        barTweens.set("CinematicBarTop", FlxTween.tween(barTop, {y: yVal}, _.event.params[3], {ease: tweenEase, onComplete: function() {
            barTweens.remove("CinematicBarTop");
        }}));

        var yVal = FlxG.height - ((FlxG.height / 2) * (_.event.params[0] / 100));
        barTweens.set("CinematicBarBottom", FlxTween.tween(barBottom, {y: yVal}, _.event.params[3], {ease: tweenEase, onComplete: function() {
            barTweens.remove("CinematicBarBottom");
        }}));
        for (id => s in strumLines.members) {
            for (i in 0...4) {
                var strum = s.members[i];
                var key:String = Std.string(id) + "-" + Std.string(i);
                if (strumsTweens.exists(key)) {
                    strumsTweens.get(key).cancel();
                    strumsTweens.get(key).destroy();
                    strumsTweens.remove(key);
                }
                if (_.event.params[0] == "0") {
                    strumsTweens.set(key, FlxTween.tween(strum, {alpha: 1}, _.event.params[3], {ease: tweenEase, onComplete: function() {
                        strumsTweens.remove(key);
                    }}));
                } else {
                    strumsTweens.set(key, FlxTween.tween(strum, {alpha: 0.5}, _.event.params[3], {ease: tweenEase, onComplete: function() {
                        strumsTweens.remove(key);
                    }}));
                }
            };
        }
    }
}

function postUpdate() {
    for (s in strumLines.members) {
        for (n in s.notes.members) {
            n.alpha = s.members[n.noteData].alpha;
        }
    }
}