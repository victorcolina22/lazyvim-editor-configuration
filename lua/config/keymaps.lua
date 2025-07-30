local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- save changes in a file
keymap.set("n", "<leader>wc", ":w<CR>", { desc = "Save changes in a file" })

-- save changes in a file without formatting
keymap.set("n", "<leader>nw", ":noa w<CR>", { desc = "Save changes in a file without formatting" })

-- save changes in all files
keymap.set("n", "<leader>wa", ":wa<CR>", { desc = "Save changes in all files" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- quit all nvim
keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit nvim" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')
keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
keymap.set("n", "dd", '"_dd', { noremap = true })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>sl", ":vertical resize -10<CR>", { desc = "Resize vsplit window to the left" }) -- resize vsplit window
keymap.set("n", "<leader>shh", ":vertical resize +10<CR>", { desc = "Resize vsplit window to the right" }) -- resize vsplit window
keymap.set("n", "<leader>sk", ":horizontal resize +5<CR>", { desc = "Resize split window to up" }) -- resize vsplit window +
keymap.set("n", "<leader>sj", ":horizontal resize -5<CR>", { desc = "Resize split window to down" }) -- resize vsplit window -

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- tab navigation (overwrite)
keymap.set("n", "<S-l>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<S-h>", "<cmd>tabp<CR>", { desc = "Go to next tab" }) -- go to previous tab

keymap.set("n", "<leader>ml", "<C-v>", { desc = "Insert the same characters across multiple lines" }) -- insert the same characters across multiple lines
