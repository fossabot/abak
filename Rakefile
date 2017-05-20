#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Abak::Application.load_tasks

desc 'add_slug by friendly_id for existing model'
task :add_slug do
  # use rails console for do this
  Post.find_each(&:save)
  Category.find_each(&:save)
end
