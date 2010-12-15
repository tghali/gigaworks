Given /^"([^\"]*)" task ran$/ do |task_name|
  require 'rake'
  require 'rake/testtask'
  require 'rake/rdoctask'
  require 'tasks/rails'

  task = Rake::Task[task_name]
  task.reenable

  task.invoke
end