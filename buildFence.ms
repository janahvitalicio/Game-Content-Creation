fn buildFence x y colour numSegment rotateZAxis = (
	xTemp = 0

	for i = 1 to numSegment do (
		railWidth = 165
		post = box pos:[x + xTemp, y, 0] length:10 width:10 height:105 wirecolor:colour
		topPost = box pos:[x + xTemp, y, post.height] length:15 width:15 height:5 wirecolor:colour
		
		topRail = box pos:[x+85 + xTemp, y+2.5, 60] length:2 width:railWidth height:7 wirecolor:colour
		
		bottomRail = box pos:[x+85 + xTemp, y+2.5, 5] length:2 width:railWidth height:7 wirecolor:colour
		
		a = x + 15
		for i = 1 to ((10*numSegment)+numSegment) do (
			b = box pos:[a,y,5] length:3 width:7 height:80 wirecolor:colour
			a = a + 15
		)
		
		xTemp = xTemp + railWidth
	)
	
	lastPost = box pos:[x + xTemp,y,0] length:10 width:10 height:100 wirecolor:colour
	topPost = box pos:[x + xTemp, y, lastPost.height] length:15 width:15 height:5 wirecolor:colour
	
	select $*
	
	group selection name:"MyGroup" select:true
	$MyGroup.pivot = [0,0,0]
	rotate $MyGroup (quat rotateZAxis [0,0,1])
	ungroup $MyGroup
)


try(destroyDialog fenceDialog) catch()
rollout fenceDialog "Picket Fence Generator" (
	group "Position" (
		spinner xPosSpinner "x position:" type:#integer fieldwidth:50 align:#left
		spinner yPosSpinner "y position:" type:#integer fieldwidth:50 align:#left
	) 
	angle rotateZAxis "Direction:" degrees:360 color:[153,47,183]
	spinner numSegment "Major Segments:" range:[1,10000,10] type:#integer fieldwidth:50 align:#left
	colorpicker fenceColourPicker "Fence Colour:" color:[153,47,183] align:#left
	button createFenceButton "Generate"
    
    on createFenceButton pressed do (
        buildFence xPosSpinner.value yPosSpinner.value fenceColourPicker.color numSegment.value rotateZAxis.degrees
    )
)

fn main = (
	createDialog fenceDialog 200 300
)

main()