Dir[File.expand_path('../lib/sort_subject_patch', __FILE__) << '/*.rb'].each do |file|
  require_dependency file
end

Redmine::Plugin.register :redmine_plugin_gantt_sort_subject do
  name 'Gantt Sort Subject plugin'
  author 'mas0061'
  description 'This plugin is for sorting Gantt Chart for Redmine by the subject.'
  version '0.0.1'
  url 'https://github.com/Qhornet/redmine_plugin_gantt_sort_subject'
  author_url 'https://github.com/mas0061'
  settings :default => { 'sort_subject_enabled' => '0' }, :partial => 'settings/gantt_sort_subject_settings'
end
