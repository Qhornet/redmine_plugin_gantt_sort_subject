module GanttSortSubject
  module GanttPatch
    extend ActiveSupport::Concern

    included do
      original = Redmine::Helpers::Gantt.method(:sort_issue_logic)

      define_singleton_method :sort_issue_logic do |issue|
        # active
        if '1' == Setting.plugin_redmine_plugin_gantt_sort_subject['sort_subject_enabled'].to_s
          issue_subjects = []
          current_issue = issue
          begin
            issue_subjects.unshift(current_issue.subject)
            current_issue = current_issue.parent
          end while (current_issue)
          issue_subjects
        # inactive -> original method
        else
          original.call(issue)
        end
      end
    end

  end
end

ActionDispatch::Reloader.to_prepare do
  unless Redmine::Helpers::Gantt.included_modules.include? GanttSortSubject::GanttPatch
    Redmine::Helpers::Gantt.send(:include, GanttSortSubject::GanttPatch)
  end
end
