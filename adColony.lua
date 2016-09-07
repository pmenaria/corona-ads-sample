local composer = require( "composer" )
local adcolony = require( "plugin.adcolony" )
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

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local interstitialButton
local rewardedButton

display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 1)

local adcolonyLogo = display.newImage("logo-adcolony-600x.png")
adcolonyLogo.anchorY = 0
adcolonyLogo.x, adcolonyLogo.y = display.contentCenterX, 0
adcolonyLogo:scale(0.3, 0.3)

local subTitle = display.newText {
    text = "plugin for Corona SDK",
    x = display.contentCenterX,
    y = 50,
    font = display.systemFont,
    fontSize = 14
}
subTitle:setFillColor(0.3)

local eventDataTextBox = native.newTextBox( display.contentCenterX, display.contentHeight - 100, 310, 200)
eventDataTextBox.placeholder = "Event data will appear here"

processEventTable = function(event)
    local logString = json.prettify(event):gsub("\\","")
    logString = "\nPHASE: "..event.phase.." - - - - - - - - - - - -\n" .. logString
    print(logString)
    eventDataTextBox.text = logString .. eventDataTextBox.text
end

--------------------------------------------------------------------------
-- plugin implementation
--------------------------------------------------------------------------

-- Corona Ads API Key
local apiKey = "5223c2c3-cf81-4c43-ae41-2d4ed16552bc" -- Corona Ads Sample app

print("Using: "..apiKey)

local adcolonyListener = function(event)
    processEventTable(event)

    local data = (event.data ~= nil) and json.decode(event.data) or {}

    if event.phase == "init" then
        if (adcolony.isLoaded("interstitial")) then
            interstitialButton:setLabel("Show interstitial")
        end

        if (adcolony.isLoaded("rewardedVideo")) then
            rewardedButton:setLabel("Show rewarded video")
        end

    elseif event.phase == "loaded" then
        if data.zoneName == "interstitial" then
            interstitialButton:setLabel("Show interstitial video")
        elseif data.zoneName == "rewardedVideo" then
            rewardedButton:setLabel("Show rewarded video")
        end

    elseif event.phase == "closed" then
        if data.zoneName == "interstitial" then
            if (not adcolony.isLoaded("interstitial")) then
                interstitialButton:setLabel("Loading interstitial video...")
            end
        elseif data.zoneName == "rewardedVideo" then
            if (not adcolony.isLoaded("rewardedVideo")) then
                rewardedButton:setLabel("Loading rewarded video...")
            end
        end
    end
end

adcolony.init(adcolonyListener, {
    apiKey = apiKey,
    debugLogging = true
})

interstitialButton = widget.newButton {
    label = "Loading interstitial...",
    width = 300,
    onRelease = function(event)
        if adcolony.isLoaded("interstitial") then
            adcolony.show("interstitial")
        end
    end
}

interstitialButton.x, interstitialButton.y = display.contentCenterX, 100

rewardedButton = widget.newButton {
    label = "Loading rewarded video...",
    width = 300,
    onRelease = function(event)
        if adcolony.isLoaded("rewardedVideo") then
            adcolony.show("rewardedVideo", {prePopup=true, postPopup=true})
        end
    end
}

rewardedButton.x, rewardedButton.y = display.contentCenterX, 150


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
