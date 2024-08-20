function onPostGenerateStrums() {
	strumLines.members[0].forEach(strum -> {
		FlxTween.tween(strum, { x: strum.x - 600 }, 0.01, { ease: FlxEase.circOut });
	});
}

function stepHit(curStep) {
	switch(curStep) {
		case 123:
			strumLines.members[0].forEach(strum -> {
				FlxTween.tween(strum, { x: strum.x + 600 }, Conductor.crochet / 1000 * 6, { ease: FlxEase.circInOut });
			});
		case 1024:
			FlxTween.tween(scoreTxt,{ alpha: 0}, 3);
			FlxTween.tween(missesTxt,{ alpha: 0}, 3);
			FlxTween.tween(accuracyTxt,{ alpha: 0}, 3);
			FlxTween.tween(iconP1,{ alpha: 0}, 3);
			FlxTween.tween(iconP2,{ alpha: 0}, 3);
			FlxTween.tween(healthBar,{ alpha: 0}, 3);
			FlxTween.tween(healthBarBG,{ alpha: 0}, 3);

			strumLines.members[0].forEach(strum -> {
				FlxTween.tween(strum, { alpha: 0}, 3);
			});
			strumLines.members[1].forEach(strum -> {
				FlxTween.tween(strum, { alpha: 0}, 3);
			});
		case 1141:
			strumLines.members[0].forEach(strum -> {
				FlxTween.tween(strum, { alpha: 1}, 1);
			});
		case 1150:
			strumLines.members[1].forEach(strum -> {
				FlxTween.tween(strum, { alpha: 1}, 0.3);
			});
		case 1279:
			FlxTween.tween(scoreTxt,{ alpha: 1}, 1);
			FlxTween.tween(missesTxt,{ alpha: 1}, 1);
			FlxTween.tween(accuracyTxt,{ alpha: 1}, 1);
			FlxTween.tween(iconP1,{ alpha: 1}, 1);
			FlxTween.tween(iconP2,{ alpha: 1}, 1);
			FlxTween.tween(healthBar,{ alpha: 1}, 1);
			FlxTween.tween(healthBarBG,{ alpha: 1}, 1);
	}
}