--
-- Abstract: GBCTranslate Library Plugin Test Project
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2015 Corona Labs Inc. All Rights Reserved.
--
------------------------------------------------------------

-- Load plugin library
local GBCLanguageCabinet = require "plugin.GBCLanguageCabinet"

-------------------------------------------------------------------------------
-- BEGIN (Insert your sample test starting here)
-------------------------------------------------------------------------------

local widget = require "widget"
local Buttons = {}
local txtString

-- button event handler
-- displays the translated text when button is pressed
local function buttonHandler(event)
    local target = event.target.id
    
    if target == "zh" then
        txtString.text = GBCLanguageCabinet.getText("RedBall", "zh", {
            color = "紅",
            object = "球"
        })
    elseif target == "en" then
        txtString.text = GBCLanguageCabinet.getText("RedBall", "en", {
            color = "red",
            object = "ball",
        })
    elseif target == "es" then
        txtString.text = GBCLanguageCabinet.getText("RedBall", "es", {
            color = "rojo",
            object = "bola",
        }) 
    elseif target == "de" then
        txtString.text = GBCLanguageCabinet.getText("RedBall", "de", {
            color = "rot",
            object = "Ball",
        })         
    end
end

-- add some languages
GBCLanguageCabinet.addLanguage("English", "en")
GBCLanguageCabinet.addLanguage("Deutsch", "de")
GBCLanguageCabinet.addLanguage("Español", "es")
GBCLanguageCabinet.addLanguage("中國", "zh")


------------------------------------
-- add a table of text.
-- Notice choose one of the 3 options below to populate a table of text
------------------------------------  

-- Option 1 - create entry using addText()
-- Notice that "yoda" will not be imported since we did not add that
-- as a language in the previous step.
GBCLanguageCabinet.addText("RedBall", {
    {"en", "That is a ##color## ##object##"},
    {"de", "Das ist eine ##color## ##object##"},
    {"es", "Esa es una ##object## ##color##"},
    {"zh", "這是一個 ##color## ##object##"},
    {"yoda", "##color##, that ##object## is"},
})

-- Option 2 - create entry by importing a json file
-- Note that json file only has entries for some of the languages,
-- so some buttons will not display text
--GBCLanguageCabinet.addTextFromFile("testfile.json", "json")

-- Option 3 - create entry by importing a csv file
-- Note that csv file only has entries for some of the languages,
-- so some buttons will not display text
--GBCLanguageCabinet.addTextFromFile("testfile.txt", "csv")

-------------------------------

-- Create some buttons for the demo
-- Utilize the language table
local Languages = GBCLanguageCabinet.getLanguages()

for i = 1, #Languages do
    Buttons[i] = widget.newButton({
        id = Languages[i].key,
        label = Languages[i].language,
        labelColor = {default = {0,0,0,1}, over = {0.5, 0.5, 0.5, 1}},
        width = 80,
        height = 30,
        shape = "roundedRect",
        fillColor = {default = {1, 0.5, 0 , 1}, over = {204/255, 102/255, 0, 1}},
        left = 20,
        top = 50 * i,
        onRelease = buttonHandler,
    })
end

-- create text string to hold the displayed text on the screen
txtString = display.newText({
    text = "",
    x = display.contentCenterX,
    y = display.contentCenterY + (display.contentCenterY * 0.5),
    align = "center",
    width = 380,
    height = 0,
    fontSize = 24,
})

-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------