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
    # Dashboard
    resources :dashboard_admin, controller: "dashboard_admin", :path => "/dashboard", only: [:index]

    # Student Management
    resources :student_management, controller: 'student_management', :path => "/student", only: [:index] do

      get '/deleteAll', :to => 'student_management#deleteAll', on: :collection
      post '/deleteSelected', :to => 'student_management#deleteSelected', on: :collection
      post '/uploadData', :to => 'student_management#uploadData', on: :collection
      get '/importData', :to => 'student_management#importData', on: :collection
      get '/new', :to => 'student_management#new', on: :collection
      post '/', :to => 'student_management#create', on: :collection
      get ':id/edit', :to => 'student_management#edit', on: :collection, as: :edit_student
      patch '/:id', :to => 'student_management#update', on: :collection, as: :update_student
    end

    # Course Management
    resources :course_management, controller: 'course_management', :path => "/course", as: :course
    resources :room_management, controller: 'room_management', :path => "/room"


    resources :exam_management, controller: 'exam_management', :path => "/exam", as: :exam, only:[:index, :new, :edit, :update, :create, :destroy] do
      resources :schedule_management, controller: 'schedule_management', :path => "/schedule", only: [:index, :create, :show, :new], as: :schedule
        get '/newCourse', :to =>'schedule_management#newCourse', as: :new_course
        post '/saveCourse', :to => 'schedule_management#saveCourse'
    end

    scope path: 'api', as: 'api' do
      get '/room-schedule/:id', :to => 'room_management#room_schedule'
    end
  end

  scope 'student', module: :student_controllers do
    # root to: 'student_info#index'
    resources :student_info_management, controller: "student_info_management", :path => "/student_info", only: [:index, :creat] do
    end
    resources :dashboard_student, controller: "dashboard_student", :path => "/dashboard", only: [:index]
    get '/print-schedule', :to => 'schedule_print#index'
  end

  get 'error/permission' => 'dashboard#fallback_permission'

end
