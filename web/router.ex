defmodule ShovikCom.Router do
  use ShovikCom.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ShovikCom.CurrentUserPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShovikCom do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/blog", BlogController, only: [:index, :show]
    resources "/posts", PostController, except: [:show] do
      post "/create_image", PostController, :create_image
    end
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
