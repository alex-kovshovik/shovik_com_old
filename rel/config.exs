use Mix.Releases.Config,
  default_release: :default,
  default_environment: :prod

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"OYQ>8j$rWRU{R0ts|mtNU-V-i!1i|=MC.X+q9MR/KYfbFo6_c}+;~aF~.R5:%Ra;"
end

release :shovik_com do
  set version: current_version(:shovik_com)
end
