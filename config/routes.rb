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
      get '/add_course', :to =>'exam_management#add_course', as: :new_course
      patch '/saveCourse', :to => 'exam_management#save_course'
      get '/closed-prompt', :to => 'exam_management#closed_prompt', as: :closed_prompt
      put '/closed', :to => 'exam_management#closed', as: :closed
      resources :schedule_management, controller: 'schedule_management', :path => "/schedule", only: [:index, :create, :show, :new, :edit, :update, :destroy], as: :schedule do
        get '/delete', :to => 'schedule_management#delete'
        get '/exportPDF', :to => 'schedule_management#export_pdf', :format => "pdf", as: :export_pdf
      end
    end

    scope path: 'api', as: 'api' do
      get '/room-schedule/:id', :to => 'room_management#room_schedule'
    end
  end

  namespace :student_module, as: :student, :path => "/student"  do
    get '/', :to => "dashboard_student#index"
    get '/registration/:courseID/', :to => 'dashboard_student#new_registration', as: :register
    post '/registration/:courseID/', :to => 'dashboard_student#save_registration', as: :save_register
    get '/print-schedule', :to => 'schedule_print#index'
    get '/exportPDF', :to => 'schedule_print#export_pdf', :format => "pdf", as: :export_pdf
  end

  get 'error/permission' => 'dashboard#fallback_permission'

end
