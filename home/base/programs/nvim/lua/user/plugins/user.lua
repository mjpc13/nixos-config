return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    --Highlights TODOs
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
  },
  {
    --Not working I think
    "thibthib18/ros-nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    --To leap between keywords
    "ggandor/leap.nvim",
    opts = {},
    event = "User AstroFile",
  },
  {
    "David-Kunz/gen.nvim",
    lazy = false,
    -- require('gen').prompts['Elaborate_Text'] = {
    --   prompt = "Elaborate the following text:\n$text",
    --   replace = true
    -- },
    config = function() 
        -- vim.keymap.set('v', '<leader>gn', ':Gen<CR>')
      require('gen').setup({
        model = "mixtral:8x7b", -- The default model to use.
        host = "100.113.106.149", -- The host running the Ollama service.
        port = "11434", -- The port on which the Ollama service is listening.
        display_mode = "float", -- The display mode. Can be "float" or "split".
        show_prompt = false, -- Shows the Prompt submitted to Ollama.
        show_model = false, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = false, -- Never closes the window automatically.
        -- init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
        -- Function to initialize Ollama
        command = function(options)
            return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/generate -d $body"
        end,
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a command string.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        -- list_models = '<omitted lua function>', -- Retrieves a list of model names
        debug = true -- Prints errors and the command which is run.
      })

      require('gen').prompts['Comment_Code'] = {
        prompt = "Add comments to the following code to help document it:\n$text",
        replace = true
      }
      require('gen').prompts['Mimic_Style'] = {
        prompt = "You are a academic researcher, mimic the following style, STYLE, to improve and increase the clarity of the following text:\n$text",
        replace = true
      }
      require('gen').prompts['Enhance_Wording_Pro'] = {
        prompt = [[You are a Researcher writing an Academic paper, and you have 10 principles when writing text: 
        1. Open your sentences with short, concrete subjects that name the characters in your story.
        2. Use specific verbs to name their important actions.
        3. Get to main verbs quickly:
          • Avoid long introductory phrases and clauses.
          • Avoid interrupting the subject-verb connection.
        4. Open your sentences with information familiar to your reader.
        5. Push new, complex units of information to the ends of sentences.
        6. Begin sentences constituting a passage with consistent subjects/topics.
        7. Be concise:
          • Cut meaningless and repeated words with obvious implications.
          • Compress the meaning of a phrase into one or two words.
          • Prefer affirmative sentences to negative ones.
        8. Control sprawl:
          • Don’t tack more than one subordinate clause onto another.
          • Extend sentences with resumptive, summative, and free modifiers.
          • Extend sentences with coordinate structures, arranging elements from shorter to longer.
        9. Use parallel structures to create a sense of balance and elegance.
        10. Above all, write to others as you would have others write to you. 
        Modify the following text by adhering to your writing principles, just output the final text without additional quotes around it:\n$text]],
        replace = true
      }
    end,
 },


}
