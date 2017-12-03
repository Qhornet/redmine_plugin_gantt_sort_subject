module GanttSortSubject
  module GanttPatch
    extend ActiveSupport::Concern

    included do
      define_singleton_method :sort_issue_logic do |issue|
        issue_subjects = []
        current_issue = issue
        begin
          issue_subjects.unshift(current_issue.subject)
          current_issue = current_issue.parent
        end while (current_issue)
        issue_subjects
      end
    end

  end
end

ActionDispatch::Reloader.to_prepare do
  unless Redmine::Helpers::Gantt.included_modules.include? GanttSortSubject::GanttPatch
    Redmine::Helpers::Gantt.send(:include, GanttSortSubject::GanttPatch)
  end
end
