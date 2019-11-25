Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
             controllers: "clearance/passwords",
             only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  root to: 'application#index'

  namespace :admin do
    resources :dashboard_admin, controller: "dashboard_admin", :path => "/dashboard", only: [:index]
    resources :student_management, controller: 'student_management', :path => "/student", only: [:index] do

      get '/deleteAll', :to => 'student_management#deleteAll', on: :collection
      post '/deleteSelected', :to => 'student_management#deleteSelected', on: :collection
      post '/uploadData', :to => 'student_management#uploadData', on: :collection
      get '/importData', :to => 'student_management#importData', on: :collection
      get '/new', :to => 'student_management#new', on: :collection
      post '/', :to => 'student_management#create', on: :collection
      get ':id/edit', :to => 'student_management#edit', on: :collection
    end
    resources :course_management, controller: 'course_management', :path => "/course", only: [:index]
    resources :schedule_management, controller: 'schedule_management', :path => "/schedule", only: [:index, :create] do

    end
  end

  scope 'student', module: :student_controllers do
    # root to: 'dashboard_student#index'
    resources :dashboard_student, controller: "dashboard_student", :path => "/dashboard", only: [:index]
  end

  get 'error/permission' => 'dashboard#fallback_permission'

end
