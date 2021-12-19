Rails.application.routes.draw do
  get "topics/index"
  get "admin/topics/list", to: "topics#all", constraints: { format: "json" }
  post "admin/topic/create", to: "topics#topic_create", constraints: { format: "json" }
  post "admin/topic/edit", to: "topics#topic_edit", constraints: { format: "json" }

  post "admin/students/results", to: "student#get_scores"
  post "admin/students/results/average", to: "student#student_average"
  post "admin/topics/results/average", to: "topics#topic_average"
  post "admin/topics/results/scores", to: "topics#highest_score"

  get "student/index"
  post "student/exam/enroll", to: "student#enroll", constraints: { format: "json" }
  post "student/exam/submit", to: "student#submit", constraints: { format: "json" }
end
