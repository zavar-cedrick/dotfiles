return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night", -- Choix du style : night, storm, day, moon
      transparent = true, -- Active la transparence du fond
      styles = {
        sidebars = "transparent", -- Transparence pour les barres latérales
        floats = "transparent", -- Transparence pour les fenêtres flottantes
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
