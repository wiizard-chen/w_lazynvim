# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.


# Install 

- Make a backup of your current Neovim files:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clone the starter

  ```sh
  git clone https://github.com/wiizard-chen/w_lazynvim ~/.config/nvim
  ```

- Remove the `.git` folder, so you can add it to your own repo later

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Start Neovim!

  ```sh
  nvim
  ```

  Refer to the comments in the files on how to customize **LazyVim**.



# Customize KeyMaps

### Basic
https://www.lazyvim.org/

### Emacs
| plugin | keymaps           | desc                        | mode |
| ------ | ----------------- | --------------------------- | ---- |
| emacs  | c-a               | jump to the start of line   | n,i  |
| emacs  | c-e               | jump to the end of line     | n,i  |
| emacs  | c-d               | delete forward character    | i    |
| emacs  | c-h               | delete backward character   | i    |
| emacs  | c-k               | delete the forward of line  | i    |
| emacs  | c-u               | delete the backward of line | i    |
| buffer | \<leader\>[number] | jump number buffer          | n    |


### Buffers & Jump word
| plugin | keymaps    | desc                            | mode |
| ------ | ---------- | ------------------------------- | ---- |
| buffer | ss         | Horizontal split screen         | n    |
| buffer | sv         | Vertical split screen           | n    |
| buffer | sh         | Go to left window               | n    |
| buffer | sj         | Go to lower window              | n    |
| buffer | sk         | Go to upper window              | n    |
| buffer | sl         | Go to right window              | n    |
| buffer | s=         | Resize each window              | n    |
| buffer | sc         | close cur window                | n    |
| buffer | so         | close other window              | n    |
| buffer | sn         | next window                     | n    |
| buffer | sp         | previous window                 | n    |
| buffer | sw         | switch float window             | n    |
| buffer | <leader>so | close other buffers but pinned  | n    |
| buffer | <leader>sO | close other buffers but current | n    |
| buffer | <leader>sp | pin current window              | n    |
| leap     | ;s      | leap-forward-to        | n    |
| leap     | ;S      | leap-backward-to       | n    |
 

### Tab
| plugin | keymaps        | desc                        | mode |
| ------ | -------------- | --------------------------- | ---- |
| tab    | <leader><tab>n | new tab with current buffer | n    |
| tab    | <leader><tab>o | close other tab             | n    |

### Terminal
| plugin   | keymaps | desc                   | mode |
| -------- | ------- | ---------------------- | ---- |
| terminal | ;lg     | toggle lazygit         | n,t  |
| terminal | c-\     | toggle normal terminal | n,t  |

### Neo-tree
| plugin   | keymaps | desc                                    | mode |
| -------- | ------- | --------------------------------------- | ---- |
| neo-tree | gy      | copy node relative path                 | n    |
| neo-tree | gY      | copy node absolute path                 | n    |
| neo-tree | g;f     | search file in current path (directory) | n    |
| neo-tree | g;r     | grep string in current path (directory) | n    |
| neo-tree | g?      | show all commands                       | n    | 


### Zen-mode
| plugin   | keymaps    | desc     | mode |
| -------- | ---------- | -------- | ---- |
| zen-mode | <leader>zz | zen mode | n    |

### Private Keymap
| plugin              | keymaps    | desc                                                      | mode |
| ------------------- | ---------- | --------------------------------------------------------- | ---- |
| other               | <leader>fs | save all file and format                                  | n    |
| typescript          | gO         | remove unused var and sort imports (typescript exclusive) | n    |
| telescope           | ;r         | find git files                                            | n    |
| telescope           | ;f         | search all file (without regex)                           | n    |
| telescope           | ;e         | telescope resume                                          | n    |
| telescope           | <leader>ss | grep git staged file                                      | n    |
| treesitter          | \<CR\>      | init_selection                                            | n,v  |
| treesitter          | \<BS\>       | node_decremental                                          | n,v  |
| git | <leader>gl | open current file history | n   |
| --- | ---------- | ------------------------- | --- |
| git | <leader>go | open current file history | n   |
| typescript snippets | wlog       | quickly log from clipboard content                        | i    |


