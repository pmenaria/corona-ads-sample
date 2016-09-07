local composer = require( "composer" )
 local widget = require( "widget" )


local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local chartBoostBtn = widget.newButton
    {
        label = "ChartBoost",
        width = 200,
        fontSize = 15,
        emboss = false,
        labelColor = { default={0,0,0,0.75}, over={0,0,0,0.5} },
        shape = "roundedRect",
        width = 200,
        height = 35,
        cornerRadius = 4,
        fillColor = { default={175/255,226/255,101/255,1}, over={129/255,204/255,20/255,1} },
        strokeColor = { default={226/255,116/255,90/255,1}, over={255/255,178/255,25/255,1} },
        strokeWidth = 2,
        onRelease = function( event )
          if ( "ended" == event.phase ) then
              print( "Button was pressed and released" )
              composer.gotoScene( "chartBoost" )
          end
        end
    }

    chartBoostBtn.x = display.contentWidth/2
    chartBoostBtn.y = display.contentHeight/4
    sceneGroup:insert( chartBoostBtn )

    local adColonyBtn = widget.newButton
    {
        label = "Ad Colony Sample",
        width = 200,
        fontSize = 15,
        emboss = false,
        labelColor = { default={0,0,0,0.75}, over={0,0,0,0.5} },
        shape = "roundedRect",
        width = 200,
        height = 35,
        cornerRadius = 4,
        fillColor = { default={175/255,226/255,101/255,1}, over={129/255,204/255,20/255,1} },
        strokeColor = { default={226/255,116/255,90/255,1}, over={255/255,178/255,25/255,1} },
        strokeWidth = 2,
        onRelease = function( event )
          if ( "ended" == event.phase ) then
              print( "Button was pressed and released" )
              composer.gotoScene( "adColony" )
          end
        end
    }

    adColonyBtn.x = display.contentWidth/2
    adColonyBtn.y = display.contentHeight/2.7
    sceneGroup:insert( adColonyBtn )

    local coronaAdsBtn = widget.newButton
    {
        label = "Corona Ads Sample",
        width = 200,
        fontSize = 15,
        emboss = false,
        labelColor = { default={0,0,0,0.75}, over={0,0,0,0.5} },
        shape = "roundedRect",
        width = 200,
        height = 35,
        cornerRadius = 4,
        fillColor = { default={175/255,226/255,101/255,1}, over={129/255,204/255,20/255,1} },
        strokeColor = { default={226/255,116/255,90/255,1}, over={255/255,178/255,25/255,1} },
        strokeWidth = 2,
        onRelease = function( event )
          if ( "ended" == event.phase ) then
              print( "Button was pressed and released" )
              composer.gotoScene( "coronaAds" )
          end
        end
    }

    coronaAdsBtn.x = display.contentWidth/2
    coronaAdsBtn.y = display.contentHeight/2
    sceneGroup:insert( coronaAdsBtn)
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
