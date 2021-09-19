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

    -- Vim editor colors
    hi.Normal       = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.Bold         = { guifg = nil,             guibg = nil,             gui = 'bold', guisp = nil }
    hi.Debug        = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.Directory    = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
    hi.Error        = { guifg = M.colors.base00, guibg = M.colors.base08, gui = nil,    guisp = nil }
    hi.ErrorMsg     = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.Exception    = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.FoldColumn   = { guifg = M.colors.base0C, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.Folded       = { guifg = M.colors.base03, guibg = M.colors.base01, gui = nil,    guisp = nil }
    hi.IncSearch    = { guifg = M.colors.base01, guibg = M.colors.base09, gui = 'none', guisp = nil }
    hi.Italic       = { guifg = nil,             guibg = nil,             gui = 'none', guisp = nil }
    hi.Macro        = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.MatchParen   = { guifg = nil,             guibg = M.colors.base03, gui = nil,    guisp = nil }
    hi.ModeMsg      = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
    hi.MoreMsg      = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
    hi.Question     = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
    hi.Search       = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = nil,    guisp = nil }
    hi.Substitute   = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = 'none', guisp = nil }
    hi.SpecialKey   = { guifg = M.colors.base03, guibg = nil,             gui = nil,    guisp = nil }
    hi.TooLong      = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.Underlined   = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.Visual       = { guifg = nil,             guibg = M.colors.base02, gui = nil,    guisp = nil }
    hi.VisualNOS    = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.WarningMsg   = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.WildMenu     = { guifg = M.colors.base08, guibg = M.colors.base0A, gui = nil,    guisp = nil }
    hi.Title        = { guifg = M.colors.base0D, guibg = nil,             gui = 'none', guisp = nil }
    hi.Conceal      = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.Cursor       = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil,    guisp = nil }
    hi.NonText      = { guifg = M.colors.base03, guibg = nil,             gui = nil,    guisp = nil }
    hi.LineNr       = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.SignColumn   = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.StatusLine   = { guifg = M.colors.base04, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.StatusLineNC = { guifg = M.colors.base03, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.VertSplit    = { guifg = M.colors.base05, guibg = M.colors.base00, gui = 'none', guisp = nil }
    hi.ColorColumn  = { guifg = nil,             guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.CursorColumn = { guifg = nil,             guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.CursorLine   = { guifg = nil,             guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.CursorLineNr = { guifg = M.colors.base04, guibg = M.colors.base01, gui = nil,    guisp = nil }
    hi.QuickFixLine = { guifg = nil,             guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.PMenu        = { guifg = M.colors.base05, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.PMenuSel     = { guifg = M.colors.base01, guibg = M.colors.base05, gui = nil,    guisp = nil }
    hi.TabLine      = { guifg = M.colors.base03, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.TabLineFill  = { guifg = M.colors.base03, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.TabLineSel   = { guifg = M.colors.base0B, guibg = M.colors.base01, gui = 'none', guisp = nil }

    -- Standard syntax highlighting
    hi.Boolean      = { guifg = M.colors.base09, guibg = nil,             gui = nil,    guisp = nil }
    hi.Character    = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.Comment      = { guifg = M.colors.base03, guibg = nil,             gui = nil,    guisp = nil }
    hi.Conditional  = { guifg = M.colors.base0E, guibg = nil,             gui = nil,    guisp = nil }
    hi.Constant     = { guifg = M.colors.base09, guibg = nil,             gui = nil,    guisp = nil }
    hi.Define       = { guifg = M.colors.base0E, guibg = nil,             gui = 'none', guisp = nil }
    hi.Delimiter    = { guifg = M.colors.base0F, guibg = nil,             gui = nil,    guisp = nil }
    hi.Float        = { guifg = M.colors.base09, guibg = nil,             gui = nil,    guisp = nil }
    hi.Function     = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
    hi.Identifier   = { guifg = M.colors.base08, guibg = nil,             gui = 'none', guisp = nil }
    hi.Include      = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
    hi.Keyword      = { guifg = M.colors.base0E, guibg = nil,             gui = nil,    guisp = nil }
    hi.Label        = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
    hi.Number       = { guifg = M.colors.base09, guibg = nil,             gui = nil,    guisp = nil }
    hi.Operator     = { guifg = M.colors.base05, guibg = nil,             gui = 'none', guisp = nil }
    hi.PreProc      = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
    hi.Repeat       = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
    hi.Special      = { guifg = M.colors.base0C, guibg = nil,             gui = nil,    guisp = nil }
    hi.SpecialChar  = { guifg = M.colors.base0F, guibg = nil,             gui = nil,    guisp = nil }
    hi.Statement    = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
    hi.StorageClass = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
    hi.String       = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
    hi.Structure    = { guifg = M.colors.base0E, guibg = nil,             gui = nil,    guisp = nil }
    hi.Tag          = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
    hi.Todo         = { guifg = M.colors.base0A, guibg = M.colors.base01, gui = nil,    guisp = nil }
    hi.Type         = { guifg = M.colors.base0A, guibg = nil,             gui = 'none', guisp = nil }
    hi.Typedef      = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }

    -- Diff highlighting
    hi.DiffAdd     = { guifg = M.colors.base0B, guibg = M.colors.base00,  gui = nil, guisp = nil }
    hi.DiffChange  = { guifg = M.colors.base03, guibg = M.colors.base00,  gui = nil, guisp = nil }
    hi.DiffDelete  = { guifg = M.colors.base08, guibg = M.colors.base00,  gui = nil, guisp = nil }
    hi.DiffText    = { guifg = M.colors.base0D, guibg = M.colors.base00,  gui = nil, guisp = nil }
    hi.DiffAdded   = { guifg = M.colors.base0B, guibg = M.colors.base00,  gui = nil, guisp = nil }
    hi.DiffFile    = { guifg = M.colors.base08, guibg = M.colors.base00,  gui = nil, guisp = nil }
    hi.DiffNewFile = { guifg = M.colors.base0B, guibg = M.colors.base00,  gui = nil, guisp = nil }
    hi.DiffLine    = { guifg = M.colors.base0D, guibg = M.colors.base00,  gui = nil, guisp = nil }
    hi.DiffRemoved = { guifg = M.colors.base08, guibg = M.colors.base00,  gui = nil, guisp = nil }

    -- Git highlighting
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
    hi.gitcommitBranch        = { guifg = M.colors.base09, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitUntrackedFile = { guifg = M.colors.base0A, guibg = nil, gui = nil,    guisp = nil }
    hi.gitcommitUnmergedFile  = { guifg = M.colors.base08, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitDiscardedFile = { guifg = M.colors.base08, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitSelectedFile  = { guifg = M.colors.base0B, guibg = nil, gui = 'bold', guisp = nil }

    -- GitGutter highlighting
    hi.GitGutterAdd          = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.GitGutterChange       = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.GitGutterDelete       = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.GitGutterChangeDelete = { guifg = M.colors.base0E, guibg = M.colors.base00, gui = nil, guisp = nil }

    -- Spelling highlighting
    hi.SpellBad   = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base08 }
    hi.SpellLocal = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0C }
    hi.SpellCap   = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0D }
    hi.SpellRare  = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }

    hi.LspReferenceText                   = { guifg = nil,             guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspReferenceRead                   = { guifg = nil,             guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspReferenceWrite                  = { guifg = nil,             guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.DiagnosticError                    = { guifg = M.colors.base08, guibg = nil, gui = 'none',      guisp = nil             }
    hi.DiagnosticWarn                     = { guifg = M.colors.base0E, guibg = nil, gui = 'none',      guisp = nil             }
    hi.DiagnosticInfo                     = { guifg = M.colors.base05, guibg = nil, gui = 'none',      guisp = nil             }
    hi.DiagnosticHint                     = { guifg = M.colors.base0C, guibg = nil, gui = 'none',      guisp = nil             }
    hi.DiagnosticUnderlineError           = { guifg = nil,             guibg = nil, gui = 'undercurl', guisp = M.colors.base08 }
    hi.DiagnosticUnderlineWarning         = { guifg = nil,             guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }
    hi.DiagnosticUnderlineInformation     = { guifg = nil,             guibg = nil, gui = 'undercurl', guisp = M.colors.base0F }
    hi.DiagnosticUnderlineHint            = { guifg = nil,             guibg = nil, gui = 'undercurl', guisp = M.colors.base0C }

    hi.TSAnnotation         = { guifg = M.colors.base0F, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSAttribute          = { guifg = M.colors.base0A, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSBoolean            = { guifg = M.colors.base09, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSCharacter          = { guifg = M.colors.base08, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSComment            = { guifg = M.colors.base03, guibg = nil, gui = 'italic',        guisp = nil }
    hi.TSConstructor        = { guifg = M.colors.base0D, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSConditional        = { guifg = M.colors.base0E, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSConstant           = { guifg = M.colors.base09, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSConstBuiltin       = { guifg = M.colors.base09, guibg = nil, gui = 'italic',        guisp = nil }
    hi.TSConstMacro         = { guifg = M.colors.base08, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSError              = { guifg = M.colors.base08, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSException          = { guifg = M.colors.base08, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSField              = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSFloat              = { guifg = M.colors.base09, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSFunction           = { guifg = M.colors.base0D, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSFuncBuiltin        = { guifg = M.colors.base0D, guibg = nil, gui = 'italic',        guisp = nil }
    hi.TSFuncMacro          = { guifg = M.colors.base08, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSInclude            = { guifg = M.colors.base0D, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSKeyword            = { guifg = M.colors.base0E, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSKeywordFunction    = { guifg = M.colors.base0E, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSKeywordOperator    = { guifg = M.colors.base0E, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSLabel              = { guifg = M.colors.base0A, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSMethod             = { guifg = M.colors.base0D, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSNamespace          = { guifg = M.colors.base08, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSNone               = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSNumber             = { guifg = M.colors.base09, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSOperator           = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSParameter          = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSParameterReference = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSProperty           = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSPunctDelimiter     = { guifg = M.colors.base0F, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSPunctBracket       = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSPunctSpecial       = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSRepeat             = { guifg = M.colors.base0A, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSString             = { guifg = M.colors.base0B, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSStringRegex        = { guifg = M.colors.base0C, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSStringEscape       = { guifg = M.colors.base0C, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSSymbol             = { guifg = M.colors.base0B, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSTag                = { guifg = M.colors.base0A, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSTagDelimiter       = { guifg = M.colors.base0F, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSText               = { guifg = M.colors.base05, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSStrong             = { guifg = nil,             guibg = nil, gui = 'bold',          guisp = nil }
    hi.TSEmphasis           = { guifg = M.colors.base09, guibg = nil, gui = 'italic',        guisp = nil }
    hi.TSUnderline          = { guifg = M.colors.base00, guibg = nil, gui = 'underline',     guisp = nil }
    hi.TSStrike             = { guifg = M.colors.base00, guibg = nil, gui = 'strikethrough', guisp = nil }
    hi.TSTitle              = { guifg = M.colors.base0D, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSLiteral            = { guifg = M.colors.base09, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSURI                = { guifg = M.colors.base09, guibg = nil, gui = 'underline',     guisp = nil }
    hi.TSType               = { guifg = M.colors.base0A, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSTypeBuiltin        = { guifg = M.colors.base0A, guibg = nil, gui = 'italic',        guisp = nil }
    hi.TSVariable           = { guifg = M.colors.base08, guibg = nil, gui = 'none',          guisp = nil }
    hi.TSVariableBuiltin    = { guifg = M.colors.base08, guibg = nil, gui = 'italic',        guisp = nil }

    hi.TSDefinition      = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.TSDefinitionUsage = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.TSCurrentScope    = { guifg = nil, guibg = nil, gui = 'bold',      guisp = nil }

    hi.NvimInternalError = { guifg = M.colors.base00, guibg = M.colors.base08, gui = 'none', guisp = nil }

    hi.NormalFloat  = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.FloatBorder  = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.NormalNC     = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
    hi.TermCursor   = { guifg = M.colors.base00, guibg = M.colors.base05, gui = 'none', guisp = nil }
    hi.TermCursorNC = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil,    guisp = nil }

    hi.User1 = { guifg = M.colors.base08, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User2 = { guifg = M.colors.base0E, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User3 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User4 = { guifg = M.colors.base0C, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User5 = { guifg = M.colors.base01, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User6 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User7 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User8 = { guifg = M.colors.base00, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User9 = { guifg = M.colors.base00, guibg = M.colors.base02, gui = 'none', guisp = nil }

    hi.TreesitterContext = { guifg = nil, guibg = M.colors.base01, gui = 'italic', guisp = nil }

    vim.g.terminal_color_0  = M.colors.base00
    vim.g.terminal_color_1  = M.colors.base08
    vim.g.terminal_color_2  = M.colors.base0B
    vim.g.terminal_color_3  = M.colors.base0A
    vim.g.terminal_color_4  = M.colors.base0D
    vim.g.terminal_color_5  = M.colors.base0E
    vim.g.terminal_color_6  = M.colors.base0C
    vim.g.terminal_color_7  = M.colors.base05
    vim.g.terminal_color_8  = M.colors.base03
    vim.g.terminal_color_9  = M.colors.base08
    vim.g.terminal_color_10 = M.colors.base0B
    vim.g.terminal_color_11 = M.colors.base0A
    vim.g.terminal_color_12 = M.colors.base0D
    vim.g.terminal_color_13 = M.colors.base0E
    vim.g.terminal_color_14 = M.colors.base0C
    vim.g.terminal_color_15 = M.colors.base07
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
