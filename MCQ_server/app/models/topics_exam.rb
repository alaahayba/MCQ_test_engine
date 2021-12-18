class TopicsExam
  include Mongoid::Document
  field :topic_name, type: String
  field :questions, type: Array
  field :answers, type: Object
end
