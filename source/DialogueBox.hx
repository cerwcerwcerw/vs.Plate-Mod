package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitRight:FlxSprite;
	var portraitBmouth:FlxSprite;
	var portraitBangry:FlxSprite;
	var portraitGneutral:FlxSprite;
	var portraitGmouth:FlxSprite;
	var portraitGangry:FlxSprite;
	
	var portraitLeft:FlxSprite;
	var portraitPangry:FlxSprite;
	var portraitPhappy:FlxSprite;
	var portraitPbruh:FlxSprite;
	var portraitPshock:FlxSprite;
	var portraitPconf:FlxSprite;
	

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
				
			case 'mana':
				hasDialog = true;
				box.y = 385;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking','shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normalOpen', 'Speech bubble normal Open', [4], "", 24);
		
			case 'arcana':
				hasDialog = true;
				box.y = 385;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking','shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normalOpen', 'Speech bubble normal Open', [4], "", 24);
			
			case 'euphoria':
				hasDialog = true;
				box.y = 385;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking','shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normalOpen', 'Speech bubble normal Open', [4], "", 24);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
				if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
			
			
			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		
			box.animation.play('normalOpen');
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
			box.updateHitbox();
			add(box);

			box.screenCenter(X);
			portraitLeft.screenCenter(X);
	
			handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
			add(handSelect);

		}
		
		
// I KNOW there has to be a smarter way to do the stuff I did here but im no programmer, never heard of this language before. Excuse my stupitidy.
// I tried animations, they don't work. I know im doing something wrong there but I dunno what.


		if (PlayState.SONG.song.toLowerCase()=='mana' || PlayState.SONG.song.toLowerCase()=='arcana' || PlayState.SONG.song.toLowerCase()=='euphoria')
		{
			// BF
			portraitRight = new FlxSprite(675, 60);
			portraitRight.frames = Paths.getSparrowAtlas('bfPortrait', 'shared');
			portraitRight.animation.addByPrefix('enter', 'bf Portrait neutral', 24, false);
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
			
			portraitBmouth = new FlxSprite(675, 60);
			portraitBmouth.frames = Paths.getSparrowAtlas('bfPortrait', 'shared');
			portraitBmouth.animation.addByPrefix('enter', 'bf Portrait mouth', 24, false);
			portraitBmouth.updateHitbox();
			portraitBmouth.scrollFactor.set();
			add(portraitBmouth);
			portraitBmouth.visible = false;
			
			portraitBangry = new FlxSprite(675, 60);
			portraitBangry.frames = Paths.getSparrowAtlas('bfPortrait', 'shared');
			portraitBangry.animation.addByPrefix('enter', 'bf Portrait angry', 24, false);
			portraitBangry.updateHitbox();
			portraitBangry.scrollFactor.set();
			add(portraitBangry);
			portraitBangry.visible = false;
			
			// GF
			portraitGneutral = new FlxSprite(675, 60);
			portraitGneutral.frames = Paths.getSparrowAtlas('bfPortrait', 'shared');
			portraitGneutral.animation.addByPrefix('enter', 'gf Portrait neutral', 24, false);
			portraitGneutral.updateHitbox();
			portraitGneutral.scrollFactor.set();
			add(portraitGneutral);
			portraitGneutral.visible = false;
			
			portraitGmouth = new FlxSprite(675, 60);
			portraitGmouth.frames = Paths.getSparrowAtlas('bfPortrait', 'shared');
			portraitGmouth.animation.addByPrefix('enter', 'gf Portrait mouth', 24, false);
			portraitGmouth.updateHitbox();
			portraitGmouth.scrollFactor.set();
			add(portraitGmouth);
			portraitGmouth.visible = false;
			
			portraitGangry = new FlxSprite(675, 60);
			portraitGangry.frames = Paths.getSparrowAtlas('bfPortrait', 'shared');
			portraitGangry.animation.addByPrefix('enter', 'gf Portrait angry', 24, false);
			portraitGangry.updateHitbox();
			portraitGangry.scrollFactor.set();
			add(portraitGangry);
			portraitGangry.visible = false;
			
			// Plate
			portraitLeft = new FlxSprite(125, 20);
			portraitLeft.frames = Paths.getSparrowAtlas('platePortrait', 'shared');
			portraitLeft.animation.addByPrefix('enter', 'plate Portrait neutral', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
			
			portraitPangry = new FlxSprite(125, 20);
			portraitPangry.frames = Paths.getSparrowAtlas('platePortrait', 'shared');
			portraitPangry.animation.addByPrefix('enter', 'plate Portrait angry', 24, false);
			portraitPangry.updateHitbox();
			portraitPangry.scrollFactor.set();
			add(portraitPangry);
			portraitPangry.visible = false;
			
			portraitPhappy = new FlxSprite(125, 20);
			portraitPhappy.frames = Paths.getSparrowAtlas('platePortrait', 'shared');
			portraitPhappy.animation.addByPrefix('enter', 'plate Portrait happy', 24, false);
			portraitPhappy.updateHitbox();
			portraitPhappy.scrollFactor.set();
			add(portraitPhappy);
			portraitPhappy.visible = false;
			
			portraitPbruh = new FlxSprite(125, 20);
			portraitPbruh.frames = Paths.getSparrowAtlas('platePortrait', 'shared');
			portraitPbruh.animation.addByPrefix('enter', 'plate Portrait bruh', 24, false);
			portraitPbruh.updateHitbox();
			portraitPbruh.scrollFactor.set();
			add(portraitPbruh);
			portraitPbruh.visible = false;
			
			portraitPshock = new FlxSprite(125, 20);
			portraitPshock.frames = Paths.getSparrowAtlas('platePortrait', 'shared');
			portraitPshock.animation.addByPrefix('enter', 'plate Portrait shock', 24, false);
			portraitPshock.updateHitbox();
			portraitPshock.scrollFactor.set();
			add(portraitPshock);
			portraitPshock.visible = false;
			
			portraitPconf = new FlxSprite(125, 20);
			portraitPconf.frames = Paths.getSparrowAtlas('platePortrait', 'shared');
			portraitPconf.animation.addByPrefix('enter', 'plate Portrait confusion', 24, false);
			portraitPconf.updateHitbox();
			portraitPconf.scrollFactor.set();
			add(portraitPconf);
			portraitPconf.visible = false;
		
			box.animation.play('normalOpen');
			box.setGraphicSize(Std.int(box.width * 0.9));
			box.updateHitbox();
			add(box);

			box.screenCenter(X);
		}

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = 0xFF3F2021;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);

			dialogue = new Alphabet(0, 80, "", false, true);
			// dialogue.x = 90;
			// add(dialogue);
		}
		if (PlayState.SONG.song.toLowerCase()=='mana' || PlayState.SONG.song.toLowerCase()=='arcana' || PlayState.SONG.song.toLowerCase()=='euphoria')
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = FlxColor.GRAY;
			add(dropText);
	
			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = FlxColor.BLACK;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);

			dialogue = new Alphabet(0, 80, "", false, true);
		}
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
		
			case 'bf':
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;				
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}			
			case 'bmouth':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;					
				if (!portraitRight.visible)
				{
					portraitBmouth.visible = true;
					portraitBmouth.animation.play('enter');
				}
			case 'bangry':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;					
				if (!portraitRight.visible)
				{
					portraitBangry.visible = true;
					portraitBangry.animation.play('enter');
				}	
			case 'gf':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;					
				if (!portraitRight.visible)
				{
					portraitGneutral.visible = true;
					portraitGneutral.animation.play('enter');
				}	
			case 'gmouth':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGangry.visible = false;
				portraitGneutral.visible = false;					
				if (!portraitRight.visible)
				{
					portraitGmouth.visible = true;
					portraitGmouth.animation.play('enter');
				}
			case 'gangry':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGmouth.visible = false;					
				if (!portraitRight.visible)
				{
					portraitGangry.visible = true;
					portraitGangry.animation.play('enter');
				}	
 
				//Pain

			case 'dad':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;				
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'pangry':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGmouth.visible = false;	
				
				if (!portraitPangry.visible)
				{
					portraitPangry.visible = true;
					portraitPangry.animation.play('enter');
				}
			case 'phappy':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;	
				
				if (!portraitPhappy.visible)
				{
					portraitPhappy.visible = true;
					portraitPhappy.animation.play('enter');
				}
			case 'pbruh':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;	
							
				if (!portraitPbruh.visible)
				{
					portraitPbruh.visible = true;
					portraitPbruh.animation.play('enter');
				}
			case 'pshock':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;	
				
				if (!portraitPshock.visible)
				{
					portraitPshock.visible = true;
					portraitPshock.animation.play('enter');
				}
			case 'pconf':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitPangry.visible = false;
				portraitPhappy.visible = false;
				portraitPbruh.visible = false;
				portraitPshock.visible = false;
				portraitPconf.visible = false;
				portraitBangry.visible = false;
				portraitBmouth.visible = false;
				portraitGneutral.visible = false;
				portraitGangry.visible = false;
				portraitGmouth.visible = false;	
				
				if (!portraitPconf.visible)
				{
					portraitPconf.visible = true;
					portraitPconf.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
