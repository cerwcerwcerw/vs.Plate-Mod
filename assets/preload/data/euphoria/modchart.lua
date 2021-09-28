
function start(song)

end

function update(elapsed)

	if curStep >= 1168 then
		setCamZoom(0.55)
	end

end

function beatHit(beat)

end

function stepHit (step)

	--Variables

	if step == 1 then
		h = getActorY('girlfriend')
		i = getActorY('dad')
	end

	--Camera
	
	--if step == 1216 or step == 1280 or step == 1312 or step == 1344 or step == 1408 or step == 1472 or step == 1536 or step == 1600 then
	--	setCamZoom(0.75)
	--end
	
	--GF

	if step == 1168 then
		setActorAccelerationY(30, 'girlfriend')
	end
	
	if getActorY('girlfriend') >= h - 170 then
		setActorAccelerationY(0,'girlfriend')
	end
	
	if step >= 1168 then
		setActorY(getActorY('girlfriend') + math.sin (curBeat * 2) * 5,'girlfriend')
	end

	--Plate
	
	if step == 1152 then
		changeDadCharacter('plate_song3B')
		setActorAccelerationY(20, 'dad')
		setActorAccelerationX(5, 'dad')
	end
	
	if getActorY('dad') >= i - 60 then
		setActorAccelerationY(0,'dad')
		setActorAccelerationX(0,'dad')
	end

	if step >= 1152 then
		setActorX(getActorX('dad') + math.cos (curBeat) * 8,'dad')
		setActorY(getActorY('dad') + math.sin (curBeat * 2) * 8,'dad')
	end

end
