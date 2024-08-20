function onStartCountdown(){
    dadColor = dominantColor(iconP2);
	bfColor = dominantColor(iconP1);
    healthBar.createFilledBar(dadColor, bfColor);
}

function dominantColor(sprite:flixel.FlxSprite):Int
    {
        var countByColor:Map<Int, Int> = [];
        for(col in 0...sprite.frameWidth) {
            for(row in 0...sprite.frameHeight) {
                var colorOfThisPixel:Int = sprite.pixels.getPixel32(col, row);
                if(colorOfThisPixel != 0) {
                    if(countByColor.exists(colorOfThisPixel))
                        countByColor[colorOfThisPixel] = countByColor[colorOfThisPixel] + 1;
                    else if(countByColor[colorOfThisPixel] != 13520687 - (2*13520687))
                        countByColor[colorOfThisPixel] = 1;
                }
            }
        }
        var maxCount = 0;
        var maxKey:Int = 0; //after the loop this will store the max color
        countByColor[FlxColor.BLACK] = 0;
        for(key in countByColor.keys()) {
            if(countByColor[key] >= maxCount) {
                maxCount = countByColor[key];
                maxKey = key;
            }
        }
        countByColor = [];
        return maxKey;
    }