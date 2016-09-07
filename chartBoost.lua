local composer = require( "composer" )
local chartboost = require( "plugin.chartboost" )
local widget = require( "widget" )
local json = require("json")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )
widget.setTheme( "widget_theme_ios" )

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local chartboostLogo = display.newImage("chartboostlogo.png")
    chartboostLogo.anchorY = 0
    chartboostLogo.x, chartboostLogo.y = display.contentCenterX, 0

    local subTitle = display.newText {
        text = "plugin for Corona SDK",
        x = display.contentCenterX,
        y = chartboostLogo.contentHeight + 15,
        font =display.systemFont,
        fontSize = 20
    }

    local statusText = display.newText {
        text = "Please load an ad",
        x = display.contentCenterX,
        y = display.contentHeight,
        font = display.systemFont,
        fontSize = 10,
        width = 280,
        align = "center"
    }
    statusText.anchorY = 1

    native.showAlert(
        "Corona Chartboost sample",
        "This is the Corona Chartboost sample project. "..
        "Consider having a look at the device log to see the events being received.",
        { "OK" }
    )

    processEventTable = function(event)
        local logString = json.prettify(event):gsub("\\","")
        logString = "\nPHASE: "..event.phase.." - - - - - - - - - - - - - - - - - - - - -\n" .. logString
        print(logString)
    end

    local sdkReady = false
    statusText.text = "Initializing..."

    --------------------------------------------------------------------------
    -- plugin implementation
    --------------------------------------------------------------------------

    -- Corona Ads API Key
    local apiKey = "6aa84da4-72e8-40ae-9ed3-e45baefd887d"

    print("Using "..apiKey)

    -- The ChartBoost listener function
    local function chartBoostListener( event )
        processEventTable(event)

        local data = (event.data ~= nil) and json.decode(event.data) or {}

        if event.phase == "init" then
            sdkReady = true
            statusText.text = "SDK is ready"

        elseif event.phase == "loaded" then
            statusText.text = "A new "..event.type.." is loaded"

        elseif event.phase == "failed" then
            statusText.text = data.errorMsg
        end
    end

    -- Initialise ChartBoost
    chartboost.init( chartBoostListener, {
        apiKey = apiKey,
        appOrientation = "portrait"
    })

    -- Load Interstitial Ad
    local loadInterstitialButton = widget.newButton {
        label = "Load Interstitial",
        width = 250,
        fontSize = 15,
        emboss = false,
        labelColor = { default={1,1,1,0.75}, over={0,0,0,0.5} },
        shape = "roundedRect",
        width = 200,
        height = 35,
        cornerRadius = 4,
        fillColor = { default={116/255,150/255,67/255,1}, over={129/255,204/255,20/255,1} },
        strokeColor = { default={255/255,178/255,25/255,1}, over={255/255,178/255,25/255,1} },
        strokeWidth = 2,
        onRelease = function( event )
            if (sdkReady) then
                statusText.text = "Loading interstitial..."
                chartboost.load( "interstitial" )
            end
        end,
    }
    loadInterstitialButton.x = display.contentCenterX
    loadInterstitialButton.y = 175

    -- Load More Apps
    local loadMoreAppsButton = widget.newButton
    {
        label = "Load More Apps",
        width = 200,
        fontSize = 15,
        emboss = false,
        labelColor = { default={1,1,1,0.75}, over={0,0,0,0.5} },
        shape = "roundedRect",
        width = 200,
        height = 35,
        cornerRadius = 4,
        fillColor = { default={116/255,150/255,67/255,1}, over={129/255,204/255,20/255,1} },
        strokeColor = { default={255/255,178/255,25/255,1}, over={255/255,178/255,25/255,1} },
        strokeWidth = 2,
        onRelease = function( event )
            if (sdkReady) then
                statusText.text = "Loading More Apps screen..."
                chartboost.load( "moreApps" )
            end
        end
    }
    loadMoreAppsButton.x = display.contentCenterX
    loadMoreAppsButton.y = loadInterstitialButton.y + loadInterstitialButton.contentHeight + loadMoreAppsButton.contentHeight * 0.25

    -- Load Rewarded Video
    local loadRewardedVideoButton = widget.newButton
    {
        label = "Load Rewarded Video",
        width = 200,
        fontSize = 15,
        emboss = false,
        labelColor = { default={1,1,1,0.75}, over={0,0,0,0.5} },
        shape = "roundedRect",
        width = 200,
        height = 35,
        cornerRadius = 4,
        fillColor = { default={116/255,150/255,67/255,1}, over={129/255,204/255,20/255,1} },
        strokeColor = { default={255/255,178/255,25/255,1}, over={255/255,178/255,25/255,1} },
        strokeWidth = 2,
        onRelease = function( event )
            if (sdkReady) then
                statusText.text = "Loading rewarded video..."
                chartboost.load( "rewardedVideo" )
            end
        end
    }
    loadRewardedVideoButton.x = display.contentCenterX
    loadRewardedVideoButton.y = loadMoreAppsButton.y + loadMoreAppsButton.contentHeight + loadRewardedVideoButton.contentHeight * 0.25


    -- Show Interstitial button
    local showInterstitialButton = widget.newButton {
        label = "Show Interstitial",
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
            if (sdkReady) then
                if not chartboost.isLoaded( "interstitial" ) then
                    native.showAlert( "No ad available", "Please load Interstitial.", { "OK" })
                else
                    statusText.text = ""
                    chartboost.show( "interstitial" )
                end
            end
        end
    }
    showInterstitialButton.x = display.contentCenterX
    showInterstitialButton.y = 325

    -- Show More Apps button
    local showMoreAppsButton = widget.newButton {
        label = "Show More Apps",
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
            if (sdkReady) then
                if not chartboost.isLoaded( "moreApps" ) then
                    native.showAlert( "Not available", "Please load More Apps.", { "OK" })
                else
                    statusText.text = ""
                    chartboost.show( "moreApps" )
                end
            end
        end
    }
    showMoreAppsButton.x = display.contentCenterX
    showMoreAppsButton.y = showInterstitialButton.y + showInterstitialButton.contentHeight + showMoreAppsButton.contentHeight * 0.25


    -- Show Rewarded Video button
    local showRewardedVideoButton = widget.newButton
    {
        label = "Show Rewarded Video",
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
            if (sdkReady) then
                if not chartboost.isLoaded( "rewardedVideo" ) then
                    native.showAlert( "Not available", "Please load Rewarded Video.", { "OK" })
                else
                    statusText.text = ""
                    chartboost.show( "rewardedVideo" )
                end
            end
        end
    }
    showRewardedVideoButton.x = display.contentCenterX
    showRewardedVideoButton.y = showMoreAppsButton.y + showMoreAppsButton.contentHeight + showRewardedVideoButton.contentHeight * 0.25

    --------------------------------------------------------------------------------------
    -- To enable Chartboost to handle the back button on Android (close ads), you need to
    -- implement chartboost.onBackPressed() as follows
    --------------------------------------------------------------------------------------
    local function onKeyEvent( event )
        local phase = event.phase
        local keyName = event.keyName

        if keyName == "back" and phase == "up" then
            if chartboost.onBackPressed() then
                -- chartboost closed an active ad
                print ( "back key handled by chartboost")
                return true -- don't pass the event down the responder chain
            else
                -- handle the back key yourself
                print ("Back key handled by Corona")
            end
        end

        return false
    end

    Runtime:addEventListener( "key", onKeyEvent )

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
