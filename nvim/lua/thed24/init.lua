-- Before
require("thed24.before.remap")
require("thed24.before.lazy")
require("thed24.before.settings")

-- Plugins
require("lazy").setup("plugins")

-- After
require("thed24.after.theme")
require("thed24.after.code")
require("thed24.after.lsp")
require("thed24.after.ui")
