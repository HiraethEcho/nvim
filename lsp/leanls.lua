return {
  cmd = { "lean", "--server" },
  filetypes = { "lean" },
  on_new_config = function(config, root)
    if not util.path.is_file(root .. "/leanpkg.toml") then
      return
    end
    if not config.cmd_cwd then
      config.cmd_cwd = root
    end
  end,
  root_dir = function(fname)
    return util.root_pattern("leanpkg.toml")(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
  end,
}
