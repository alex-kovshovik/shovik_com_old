# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"FDF3Vsa`!1pu0U;.t$}~LPH^3J&[R1d`Tax@}NsQKX]n5pxt9[;lw{I:W%8~XD&0"
end

environment :prod do
  set include_erts: false
  set include_src: false
  set cookie: :">G)km}.BwNo58h:pvnDk3|Tr>S7M9mk9,Qc!QI6j=js3*`%m)t.?P70WI1}3slM%"

  set post_start_hook: "rel/hooks/post_start"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :shovik_com do
  set version: current_version(:shovik_com)
end
