const activate = (oni) => {
   // access the Oni plugin API here

   // for example, unbind the default `<c-p>` action:
   oni.input.unbind("<c-p>")

   // bind to some provided commands
   oni.input.bind("<c-space>", "quickOpen.show")                 // ctrl-space to jump to a file
   oni.input.bind("<s-f8>", "oni.editor.previousError")          // shift-F8 to jump to the previous error in the buffer
   oni.input.bind("<f8>", "oni.editor.nextError")                // F8 to jump to the next error in the buffer

   // or bind a new action:
   oni.input.bind("<c-enter>", () => alert("Pressed control enter"));
};

module.exports = {
    activate,
    "achievements.enabled":                false, // Turn off achievements tracking / UX
    "autoClosingPairs.enabled":            false, // disable autoclosing pairs
    "autoUpdate.enabled":                  true,
    "browser.defaultUrl":                  "https://duckduckgo.com",
    "commandline.icons":                   true,
    "commandline.mode":                    true,
    "editor.clipboard.enabled":            true,
    "editor.clipboard.synchronizeYank":    true,
    "editor.completions.enabled":          true
    "editor.completions.mode":             "oni",
    "editor.cursorLine":                   true,
    "editor.definition.enabled":           true,
    "editor.fontFamily":                   "hack",
    "editor.fontSize":                     "14px",
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
