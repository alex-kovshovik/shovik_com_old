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

  pipeline :admin do
    plug ShovikCom.Admin.ForceUserPlug
  end

  scope "/", ShovikCom do
    pipe_through :browser

    get "/", PageController, :index

    resources "/blog", BlogController, only: [:index, :show]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/admin", as: :admin do
    pipe_through [:browser, :admin]

    resources "/posts", ShovikCom.Admin.PostController, except: [:show] do
      post "/create_image", ShovikCom.Admin.PostController, :create_image
      get "/make_image_primary", ShovikCom.Admin.PostController, :make_image_primary
      get "/delete_image", ShovikCom.Admin.PostController, :delete_image # TODO: I know this must be delete, I'll fix it later.
    end
  end
end
