module I18nExport
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/i18n_export.rake"
    end
  end
end
