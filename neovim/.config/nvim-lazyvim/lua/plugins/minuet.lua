-- lua/plugins/minuet.lua
return {
  -- 1. minuet-ai: the AI completion engine
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("minuet").setup({
        provider = "openai_compatible",
        provider_options = {
          openai_compatible = {
            model = "anthropic/claude-sonnet-4-5",
            base_url = "https://openrouter.ai/api/v1/",
            api_key = "OPENROUTER_API_KEY", -- env var name, not the key itself
            optional = {
              temperature = 0.2,
            },
          },
        },
        n_completions = 1,
        context_window = 512,
        throttle = 1500,
        debounce = 600,
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            accept = "<A-a>", -- accept full suggestion
            accept_line = "<A-l>", -- accept one line at a time
            next = "<A-]>", -- cycle to next suggestion
            prev = "<A-[>", -- cycle to prev suggestion
            dismiss = "<A-e>", -- dismiss
          },
        },
      })
    end,
  },
}
