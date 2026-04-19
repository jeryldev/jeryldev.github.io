---
layout: post
title: "pyworks.nvim: Zero-Config Python Notebooks in Neovim"
date: 2026-01-25
tags: [Neovim, Python, Lua, Developer Tools, Open Source]
description: "A Neovim plugin that runs Jupyter-style Python notebooks in the terminal with zero setup — auto venvs, missing-package detection, inline matplotlib plots, and Jupytext for .ipynb files."
image: /images/jeryl.jpg
excerpt: "I built a Neovim plugin that brings Jupyter-like notebook workflows to the terminal with zero configuration. Here's why I created it and how it works under the hood."
---

## The Problem: Terminal Python Development Friction

I love working in Neovim, but Python development always felt clunky compared to Jupyter notebooks. The typical workflow involved:

1. Manually creating virtual environments
2. Installing packages one by one
3. Configuring Jupyter kernels
4. Setting up notebook conversion tools
5. Dealing with `.ipynb` JSON files

Every time I started a new Python project, I spent 10-15 minutes on setup before writing a single line of code. For quick data exploration or prototyping, this friction was enough to make me reach for VSCode instead.

**I wanted the immediacy of Jupyter notebooks with the power of Neovim.**

## Enter pyworks.nvim

pyworks.nvim is a Neovim plugin that eliminates this setup overhead entirely. Open any Python file, and it:

- Creates and activates a virtual environment automatically
- Detects missing packages from your imports
- Converts `.ipynb` notebooks to editable Python on-the-fly
- Initializes Jupyter kernels when you run your first cell
- Displays matplotlib plots inline in the terminal

Zero configuration. Just open files and start coding.

## Key Design Decisions

### 1. **Project Root Detection**

The plugin needs to know where your project starts to create the right virtual environment. I implemented a priority-based detection system:

```lua
-- Highest priority: explicit venv
if exists('.venv') then use_that_directory

-- Python project markers
elseif exists('pyproject.toml') then use_that_directory
elseif exists('requirements.txt') then use_that_directory

-- Framework entry points
elseif exists('manage.py') then use_that_directory  -- Django
elseif exists('app.py') then use_that_directory     -- Flask

-- Fallback to git root
elseif exists('.git') then use_that_directory
```

This covers 99% of Python project structures while avoiding false positives in nested folders.

### 2. **Smart Package Detection**

Simply parsing `import` statements isn't enough. The plugin needs to filter out:

- Standard library modules (`os`, `sys`, `json`)
- Local project modules (`src`, `utils`, `app`)
- Already installed packages

I built a detection system that scans your code, checks what's installed in the venv, and only suggests real PyPI packages:

```lua
-- Extract imports from buffer
local imports = scan_python_imports(bufnr)

-- Filter out standard library
imports = filter_stdlib(imports)

-- Filter out local/custom packages
imports = filter_custom_packages(imports, config.custom_package_prefixes)

-- Check what's actually missing
local missing = check_installed_packages(imports, venv_path)
```

### 3. **Inline Image Rendering**

Getting matplotlib plots to display inline was tricky. The solution uses the [Kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/) through `image.nvim`:

```lua
-- Configure image.nvim for Molten output
require("image").setup({
  backend = "kitty",
  integrations = {
    markdown = { enabled = false },
    neorg = { enabled = false },
    html = { enabled = false },
    css = { enabled = false },
  },
  max_width = 100,
  max_height = 12,
  processor = "magick_rock",
})
```

This required:
- Detecting terminal capabilities
- Integrating with `molten-nvim`'s output system
- Handling image cleanup when cells are re-executed

### 4. **Zero-Config Jupytext Integration**

Editing `.ipynb` files as JSON is painful. I integrated `jupytext` CLI to convert notebooks to percent-style Python (`# %%`) on-the-fly:

```lua
-- On .ipynb file open:
1. Run jupytext CLI to convert to .py format
2. Load converted content into buffer
3. Enable cell markers and folding
4. On save, convert back to .ipynb
```

The plugin handles jupytext installation automatically and provides helpful fallbacks if it's not available yet.

## Technical Challenges

### Challenge 1: Async Operations Without Blocking

Package installation can take seconds. I needed to:
- Run pip/uv in the background
- Show progress to users
- Update UI when complete
- Not block Neovim

Solution: Neovim's `vim.system()` API for async command execution:

```lua
vim.system({ "uv", "pip", "install", package }, {
  cwd = project_root,
  env = { VIRTUAL_ENV = venv_path },
}, function(result)
  if result.code == 0 then
    vim.schedule(function()
      vim.notify("Installed " .. package, vim.log.levels.INFO)
    end)
  end
end)
```

### Challenge 2: Kernel State Management

Jupyter kernels are stateful. The plugin needs to track:
- Which kernels are running for which files
- When to initialize vs. reuse kernels
- How to handle kernel crashes

I built a caching layer with TTLs:

```lua
cache = {
  kernel_list = { data = nil, expires_at = 0, ttl = 60 },
  installed_packages = { data = nil, expires_at = 0, ttl = 300 },
}
```

This reduced redundant kernel queries while keeping state fresh.

### Challenge 3: Plugin Interoperability

pyworks.nvim depends on `molten-nvim` and `image.nvim`. I needed to:
- Detect if they're installed
- Configure them automatically
- Provide escape hatches if users want manual control

Solution: Optional auto-configuration with skip flags:

```lua
require("pyworks").setup({
  skip_molten = false,    -- Set true to configure Molten yourself
  skip_image = false,     -- Set true to configure image.nvim yourself
  skip_keymaps = false,   -- Set true to define your own keymaps
})
```

## Performance Optimizations

### Using `uv` Instead of `pip`

Package installation was the biggest bottleneck. Switching to [`uv`](https://github.com/astral-sh/uv) (Rust-based package manager) gave **10-100x speedups**:

```bash
# pip install numpy pandas matplotlib
# → 45 seconds

# uv pip install numpy pandas matplotlib
# → 2 seconds
```

The plugin auto-detects `uv` and falls back to `pip` if unavailable.

### Caching Expensive Operations

I cache:
- Project root detection (directory traversal is slow)
- Installed package lists (avoids repeated pip freeze)
- Kernel enumeration (subprocess overhead)

This made file opening instant even in large projects.

## What I Learned

**1. Zero-config is hard**

Every "assume nothing" decision adds complexity. Project detection alone required handling:
- Django, Flask, FastAPI entry points
- Poetry, Pipenv, uv, conda lock files
- Monorepos with nested projects
- ML pipelines (DVC, MLflow configs)

**2. Async APIs are essential for responsiveness**

Neovim's `vim.system()` and `vim.schedule()` were game-changers. Background operations keep the editor snappy.

**3. Terminal capabilities vary wildly**

Inline images work in Kitty and Ghostty, but not most terminals. The plugin needed graceful fallbacks and clear error messages.

**4. Developer experience matters**

Features like "press `<leader>jl` to auto-initialize kernel" remove cognitive load. Users shouldn't need to remember initialization steps.

## Try It Out

pyworks.nvim is open source and available now:

- **GitHub:** [github.com/jeryldev/pyworks.nvim](https://github.com/jeryldev/pyworks.nvim)
- **Installation:** Works with lazy.nvim, packer, vim-plug
- **Requirements:** Neovim ≥ 0.10.0, Python 3.8+

If you're a Neovim user doing Python work, give it a try! Feedback and contributions welcome.

## What's Next

I'm working on:
- Better support for remote Jupyter servers
- Integration with LSP for smarter package suggestions
- R and Julia kernel support
- Collaborative editing features

Building this plugin taught me a ton about Neovim's plugin ecosystem, Lua APIs, and the balance between magic and control in developer tools.

---

**Links:**

- [GitHub Repository](https://github.com/jeryldev/pyworks.nvim)
- [Installation Guide](https://github.com/jeryldev/pyworks.nvim#installation)
- [Full Documentation](https://github.com/jeryldev/pyworks.nvim#readme)
