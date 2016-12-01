# Shovik Blog

[![Build Status](https://travis-ci.org/alex-kovshovik/shovik_com.svg?branch=master)](https://travis-ci.org/alex-kovshovik/shovik_com)

This repo is the source code of Alex Kovshovik's personal website/blog: [https://shovik.com](https://shovik.com)

To start Shovik.com on your machine (_why would you do that? LOL!_):

  * Install dependencies with `mix deps.get`
  * Fix database connection parameters in `config/dev.exs`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Run database seeds with `mix run priv/repo/seeds.exs`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

# Cheat sheet

  * `alias ShovikCom.Anything` would let you use `Anything` unqualified.
  * run `iex -s mix` to run interactive console in context of the app.
  * run `mix ecto.gen.migration migration_file_name` to create new migration.
