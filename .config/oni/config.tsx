import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")
}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    "achievements.enabled":                false, // Turn off achievements tracking / UX
    "autoClosingPairs.enabled":            false, // disable autoclosing pairs
    "autoUpdate.enabled":                  true,
    "browser.defaultUrl":                  "https://duckduckgo.com",
    "commandline.icons":                   true,
    "commandline.mode":                    true,
    "editor.clipboard.enabled":            true,
    "editor.clipboard.synchronizeYank":    true,
    "editor.completions.mode":             "oni",
    "editor.cursorLine":                   true,
    "editor.definition.enabled":           true,
    "editor.quickInfo.delay":              500,
    "editor.quickInfo.enabled":            true,
    "editor.textMateHighlighting.enabled": true,
    "editor.typingPrediction":             false, // Wait for vim's confirmed typed characters, avoid edge cases
    "learning.enabled":                    false, // Turn off learning pane
    "oni.enhancedSyntaxHighlighting":      true,
    "oni.hideMenu":                        "hidden", // Hide top bar menu
    "oni.loadInitVim":                     true, // Load user's init.vim
    "oni.useDefaultConfig":                true,
    "sidebar.default.open":                true,
    "sidebar.enabled":                     true,
    "snippets.enabled":                    true,
    "snippets.userSnippetFolder":          null,
    "statusbar.enabled":                   true,
    "tabs.mode":                           "native", // Use vim's tabline, need completely quit Oni and restart a few times
    "ui.animations.enabled":               true,
    "ui.colorscheme":                      "molokai",
    "ui.fontSmoothing":                    "auto",
    "ui.iconTheme":                        "theme-icons-seti",
    "wildmenu.mode":                       true,
}
