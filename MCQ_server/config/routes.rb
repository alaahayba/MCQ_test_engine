Rails.application.routes.draw do

  get 'topics/index'
  get 'admin/topics/view', to: "topics#all" , constraints: { format: "json" }
  post 'admin/topic/create', to: "topics#topic_create" , constraints: { format: "json" }

  post 'admin/topic/edit', to: "topics#edit" , constraints: { format: "json" }
  post 'admin/students/results', to: "topics#edit"
  post 'admin/students/results/average', to: "topics#edit"
  post 'admin/topics/results/average', to: "topics#edit"
  post 'admin/topics/highes/scores', to: "topics#edit"

  get 'student/index'
  post 'student/exam/enroll' , to: "student#enroll" , constraints: { format: "json" }
  post 'student/exam/submit' , to: "student#submit" , constraints: { format: "json" }

end
