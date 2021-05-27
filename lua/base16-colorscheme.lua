local NONE = 'NONE'

-- Some useful links for making your own colorscheme:
-- https://github.com/chriskempson/base16
-- https://colourco.de/
-- https://color.adobe.com/create/color-wheel
-- http://vrl.cs.brown.edu/color

local M = {}

-- This is a bit of syntactic sugar for creating highlight groups.
--
-- local colorscheme = require('colorscheme')
-- local hi = colorscheme.highlight
-- hi.Comment = { guifg='#ffffff', guibg='#000000', gui='italic', guisp=nil }
--
-- This is equivalent to the following vimscript
--
-- hi Comment guifg=#ffffff guibg=#000000 gui=italic
M.highlight = setmetatable({}, {
    __newindex = function(_, hlgroup, args)
        local guifg, guibg, gui, guisp = args.guifg, args.guibg, args.gui, args.guisp
        local cmd = {'hi', hlgroup}
        if guifg then table.insert(cmd, 'guifg='..guifg) end
        if guibg then table.insert(cmd, 'guibg='..guibg) end
        if gui then table.insert(cmd, 'gui='..gui) end
        if guisp then table.insert(cmd, 'guisp='..guisp) end
        vim.cmd(table.concat(cmd, ' '))
    end
})

--- Creates a base16 colorscheme using the colors specified.
--
-- Builtin colorschemes can be found in the M.colorschemes table.
--
-- The default Vim highlight groups (including User[1-9]), highlight groups
-- pertaining to Neovim's builtin LSP, and highlight groups pertaining to
-- Treesitter will be defined.
--
-- It's worth noting that many colorschemes will specify language specific
-- highlight groups like rubyConstant or pythonInclude. However, I don't do
-- that here since these should instead be linked to an existing highlight
-- group.
--
-- @param colors (table) table with keys 'base00', 'base01', 'base02',
--   'base03', 'base04', 'base05', 'base06', 'base07', 'base08', 'base09',
--   'base0A', 'base0B', 'base0C', 'base0D', 'base0E', 'base0F'. Each key should
--   map to a valid 6 digit hex color. If a string is provided, the
--   corresponding table specifying the colorscheme will be used.
function M.setup(colors)
    if type(colors) == 'string' then
        colors = M.colorschemes[colors]
    end

    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    vim.cmd('set termguicolors')

    M.colors = colors or M.colorschemes[vim.env.BASE16_THEME] or M.colorschemes['schemer-dark']

    local hi = M.highlight

    hi.Bold         = { guifg = nil,             guibg = nil,             gui = "bold", guisp = nil }
    hi.ColorColumn  = { guifg = nil,             guibg = M.colors.base01, gui = NONE,   guisp = nil }
    hi.Conceal      = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.Cursor       = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil,    guisp = nil }
    hi.CursorColumn = { guifg = nil,             guibg = M.colors.base01, gui = NONE,   guisp = nil }
    hi.CursorLine   = { guifg = nil,             guibg = M.colors.base01, gui = NONE,   guisp = nil }
    hi.CursorLineNr = { guifg = M.colors.base04, guibg = M.colors.base01, gui = nil,    guisp = nil }
    hi.Debug        = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.Directory    = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
    hi.Error        = { guifg = M.colors.base00, guibg = M.colors.base08, gui = nil,    guisp = nil }
    hi.ErrorMsg     = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.Exception    = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.FoldColumn   = { guifg = M.colors.base0C, guibg = M.colors.base01, gui = nil,    guisp = nil }
    hi.Folded       = { guifg = M.colors.base03, guibg = M.colors.base01, gui = nil,    guisp = nil }
    hi.IncSearch    = { guifg = M.colors.base01, guibg = M.colors.base09, gui = NONE,   guisp = nil }
    hi.Italic       = { guifg = nil,             guibg = nil,             gui = NONE,   guisp = nil }
    hi.LineNr       = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.Macro        = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.MatchParen   = { guifg = nil,             guibg = M.colors.base03, gui = nil,    guisp = nil }
    hi.ModeMsg      = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
    hi.MoreMsg      = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
    hi.NonText      = { guifg = M.colors.base03, guibg = nil,             gui = NONE,   guisp = nil }
    hi.Normal       = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.NormalFloat  = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.FloatBorder  = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.NormalNC     = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.PMenu        = { guifg = M.colors.base05, guibg = M.colors.base01, gui = NONE,   guisp = nil }
    hi.PmenuSbar    = { guifg = M.colors.base05, guibg = M.colors.base01, gui = nil,    guisp = nil }
    hi.PMenuSel     = { guifg = M.colors.base01, guibg = M.colors.base05, gui = nil,    guisp = nil }
    hi.PmenuThumb   = { guifg = M.colors.base05, guibg = M.colors.base03, gui = nil,    guisp = nil }
    hi.Question     = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
    hi.QuickFixLine = { guifg = nil,             guibg = M.colors.base01, gui = NONE,   guisp = nil }
    hi.Search       = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = nil,    guisp = nil }
    hi.SignColumn   = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.SpecialKey   = { guifg = M.colors.base03, guibg = nil,             gui = nil,    guisp = nil }
    hi.StatusLine   = { guifg = M.colors.base04, guibg = M.colors.base02, gui = NONE,   guisp = nil }
    hi.StatusLineNC = { guifg = M.colors.base03, guibg = M.colors.base01, gui = NONE,   guisp = nil }
    hi.Substitute   = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = NONE,   guisp = nil }
    hi.TabLine      = { guifg = M.colors.base04, guibg = M.colors.base02, gui = NONE,   guisp = nil }
    hi.TabLineFill  = { guifg = M.colors.base03, guibg = M.colors.base01, gui = NONE,   guisp = nil }
    hi.TabLineSel   = { guifg = M.colors.base0B, guibg = M.colors.base01, gui = NONE,   guisp = nil }
    hi.TermCursor   = { guifg = M.colors.base00, guibg = M.colors.base05, gui = NONE,   guisp = nil }
    hi.TermCursorNC = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil,    guisp = nil }
    hi.Title        = { guifg = M.colors.base0D, guibg = nil,             gui = NONE,   guisp = nil }
    hi.TooLong      = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.Underlined   = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.VertSplit    = { guifg = M.colors.base05, guibg = M.colors.base00, gui = NONE,   guisp = nil }
    hi.Visual       = { guifg = nil,             guibg = M.colors.base02, gui = nil,    guisp = nil }
    hi.VisualNOS    = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.WarningMsg   = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.WildMenu     = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil,    guisp = nil }

    hi.SpellBad   = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base08 }
    hi.SpellLocal = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0C }
    hi.SpellCap   = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0D }
    hi.SpellRare  = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }

    hi.Comment        = { guifg = M.colors.base03, guibg = nil,             gui = 'italic',         guisp = nil }
    hi.Constant       = { guifg = M.colors.base09, guibg = nil,             gui = NONE,             guisp = nil }
    hi.String         = { guifg = M.colors.base0B, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Character      = { guifg = M.colors.base0C, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Number         = { guifg = M.colors.base09, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Boolean        = { guifg = M.colors.base09, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Float          = { guifg = M.colors.base09, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Identifier     = { guifg = M.colors.base08, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Function       = { guifg = M.colors.base0D, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Statement      = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Conditional    = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Repeat         = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Label          = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Operator       = { guifg = M.colors.base05, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Keyword        = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Exception      = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.PreProc        = { guifg = M.colors.base0A, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Include        = { guifg = M.colors.base0D, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Define         = { guifg = M.colors.base0D, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Macro          = { guifg = M.colors.base0D, guibg = nil,             gui = NONE,             guisp = nil }
    hi.PreCondit      = { guifg = M.colors.base0D, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Type           = { guifg = M.colors.base0D, guibg = nil,             gui = NONE,             guisp = nil }
    hi.StorageClass   = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Structure      = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Typedef        = { guifg = M.colors.base0E, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Special        = { guifg = M.colors.base0C, guibg = nil,             gui = NONE,             guisp = nil }
    hi.SpecialChar    = { guifg = M.colors.base0C, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Tag            = { guifg = M.colors.base0A, guibg = nil,             gui = 'underline',      guisp = nil }
    hi.Delimiter      = { guifg = M.colors.base0F, guibg = nil,             gui = NONE,             guisp = nil }
    hi.SpecialComment = { guifg = M.colors.base0C, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Debug          = { guifg = M.colors.base08, guibg = nil,             gui = NONE,             guisp = nil }
    hi.Underlined     = { guifg = M.colors.base05, guibg = nil,             gui = 'bold,underline', guisp = nil }
    hi.Error          = { guifg = M.colors.base00, guibg = M.colors.base08, gui = NONE,             guisp = nil }
    hi.Todo           = { guifg = M.colors.base0A, guibg = M.colors.base01, gui = NONE,             guisp = nil }

    hi.LspReferenceText                   = { guifg = nil,             guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspReferenceRead                   = { guifg = nil,             guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspReferenceWrite                  = { guifg = nil,             guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspDiagnosticsDefaultError         = { guifg = M.colors.base08, guibg = nil, gui = NONE,        guisp = nil             }
    hi.LspDiagnosticsDefaultWarning       = { guifg = M.colors.base0E, guibg = nil, gui = NONE,        guisp = nil             }
    hi.LspDiagnosticsDefaultInformation   = { guifg = M.colors.base05, guibg = nil, gui = NONE,        guisp = nil             }
    hi.LspDiagnosticsDefaultHint          = { guifg = M.colors.base0C, guibg = nil, gui = NONE,        guisp = nil             }
    hi.LspDiagnosticsUnderlineError       = { guifg = nil,             guibg = nil, gui = 'undercurl', guisp = M.colors.base08 }
    hi.LspDiagnosticsUnderlineWarning     = { guifg = nil,             guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }
    hi.LspDiagnosticsUnderlineInformation = { guifg = nil,             guibg = nil, gui = 'undercurl', guisp = M.colors.base0F }
    hi.LspDiagnosticsUnderlineHint        = { guifg = nil,             guibg = nil, gui = 'undercurl', guisp = M.colors.base0C }

    hi.TSAnnotation         = { guifg = M.colors.base0A, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSAttribute          = { guifg = M.colors.base0A, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSBoolean            = { guifg = M.colors.base09, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSCharacter          = { guifg = M.colors.base0C, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSComment            = { guifg = M.colors.base03, guibg = nil, gui = 'italic',        guisp = nil }
    hi.TSConstructor        = { guifg = M.colors.base0C, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSConditional        = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSConstant           = { guifg = M.colors.base09, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSConstBuiltin       = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSConstMacro         = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSError              = { guifg = M.colors.base08, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSException          = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSField              = { guifg = M.colors.base08, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSFloat              = { guifg = M.colors.base09, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSFunction           = { guifg = M.colors.base0D, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSFuncBuiltin        = { guifg = M.colors.base0E, guibg = nil, gui = 'italic',        guisp = nil }
    hi.TSFuncMacro          = { guifg = M.colors.base0D, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSInclude            = { guifg = M.colors.base0D, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSKeyword            = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSKeywordFunction    = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSLabel              = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSMethod             = { guifg = M.colors.base0D, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSNamespace          = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSNone               = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSNumber             = { guifg = M.colors.base09, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSOperator           = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSParameter          = { guifg = M.colors.base08, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSParameterReference = { guifg = M.colors.base08, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSProperty           = { guifg = M.colors.base0A, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSPunctDelimiter     = { guifg = M.colors.base0F, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSPunctBracket       = { guifg = M.colors.base0C, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSPunctSpecial       = { guifg = M.colors.base0F, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSRepeat             = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSString             = { guifg = M.colors.base0B, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSStringRegex        = { guifg = M.colors.base0B, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSStringEscape       = { guifg = M.colors.base0C, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSTag                = { guifg = M.colors.base0A, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSTagDelimiter       = { guifg = M.colors.base0F, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSText               = { guifg = M.colors.base05, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSStrong             = { guifg = nil,             guibg = nil, gui = 'bold',          guisp = nil }
    hi.TSEmphasis           = { guifg = M.colors.base09, guibg = nil, gui = 'italic',        guisp = nil }
    hi.TSUnderline          = { guifg = M.colors.base00, guibg = nil, gui = 'underline',     guisp = nil }
    hi.TSStrike             = { guifg = M.colors.base00, guibg = nil, gui = 'strikethrough', guisp = nil }
    hi.TSTitle              = { guifg = M.colors.base0D, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSLiteral            = { guifg = M.colors.base09, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSURI                = { guifg = M.colors.base09, guibg = nil, gui = 'underline',     guisp = nil }
    hi.TSType               = { guifg = M.colors.base0A, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSTypeBuiltin        = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSVariable           = { guifg = M.colors.base08, guibg = nil, gui = NONE,            guisp = nil }
    hi.TSVariableBuiltin    = { guifg = M.colors.base0E, guibg = nil, gui = NONE,            guisp = nil }

    hi.TSDefinition      = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.TSDefinitionUsage = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.TSCurrentScope    = { guifg = nil, guibg = nil, gui = 'bold',      guisp = nil }

    hi.User1 = { guifg = M.colors.base08, guibg = M.colors.base02, gui = NONE, guisp = nil }
    hi.User2 = { guifg = M.colors.base0E, guibg = M.colors.base02, gui = NONE, guisp = nil }
    hi.User3 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = NONE, guisp = nil }
    hi.User4 = { guifg = M.colors.base0C, guibg = M.colors.base02, gui = NONE, guisp = nil }
    hi.User5 = { guifg = M.colors.base01, guibg = M.colors.base02, gui = NONE, guisp = nil }
    hi.User6 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = NONE, guisp = nil }
    hi.User7 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = NONE, guisp = nil }
    hi.User8 = { guifg = M.colors.base00, guibg = M.colors.base02, gui = NONE, guisp = nil }
    hi.User9 = { guifg = M.colors.base00, guibg = M.colors.base02, gui = NONE, guisp = nil }

    hi.DiffAdd     = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffChange  = { guifg = M.colors.base03, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffDelete  = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffText    = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffAdded   = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffFile    = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffNewFile = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffLine    = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffRemoved = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }

    hi.gitcommitOverflow      = { guifg = M.colors.base08, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitSummary       = { guifg = M.colors.base0B, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitComment       = { guifg = M.colors.base03, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitUntracked     = { guifg = M.colors.base03, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitDiscarded     = { guifg = M.colors.base03, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitSelected      = { guifg = M.colors.base03, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitHeader        = { guifg = M.colors.base0E, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitSelectedType  = { guifg = M.colors.base0D, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitUnmergedType  = { guifg = M.colors.base0D, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitDiscardedType = { guifg = M.colors.base0D, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitBranch        = { guifg = M.colors.base09, guibg = nil, gui = "bold", guisp = nil }
    hi.gitcommitUntrackedFile = { guifg = M.colors.base0A, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitUnmergedFile  = { guifg = M.colors.base08, guibg = nil, gui = "bold", guisp = nil }
    hi.gitcommitDiscardedFile = { guifg = M.colors.base08, guibg = nil, gui = "bold", guisp = nil }
    hi.gitcommitSelectedFile  = { guifg = M.colors.base0B, guibg = nil, gui = "bold", guisp = nil }

    hi.NvimInternalError = { guifg = M.colors.base00, guibg = M.colors.base08, gui = NONE, guisp = nil }
end

function M.available_colorschemes()
  return vim.tbl_keys(M.colorschemes)
end

M.colorschemes = require('colors')

-- My own personal theme
-- #16161D is called eigengrau and is kinda-ish the color your see when you
-- close your eyes. It makes for a really good background.
M.colorschemes['schemer-dark'] = {
  base00 = '#16161D', base01 = '#3e4451', base02 = '#2c313c', base03 = '#565c64',
  base04 = '#6c7891', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
  base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
  base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
}
M.colorschemes['schemer-medium'] = {
  base00 = '#212226', base01 = '#3e4451', base02 = '#2c313c', base03 = '#565c64',
  base04 = '#6c7891', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
  base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
  base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
}

return M
