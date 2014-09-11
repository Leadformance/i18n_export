require_relative "i18n_export/config"
require_relative "i18n_export/railtie" if defined?(Rails)
require "fileutils"
require "json"
require "i18n"

module I18nExport
  def self.config_file=(file)
    @@config_file = file
  end

  def self.config_file
    @@config_file ||= "config/i18n-export.yml"
  end

  def self.configuration
    I18nExport::Config.new(config_file)
  end

  def self.export!
    configuration.file_definitions.each { |definition| export_file(definition) }
  end

  def self.export_file(definition)
    FileUtils.mkdir_p File.dirname(definition.filename)

    open(definition.filename, "w+") do |f|
      f.print "var I18n = I18n || {};\n"
      f.print "I18n.translations = "
      f.print JSON.dump(generate_output(definition.filters))
      f.print ";\n"
    end
  end

  def self.generate_output(filters)
    I18n.available_locales.each_with_object({}) do |locale, result|
      if filters.nil? || filters.empty?
        result[locale] = I18n.t(".", locale: locale)
      else
        result[locale] ||= {}

        filters.each do |filter|
          insert_data(I18n.t(filter, locale: locale), filter.split("."), result[locale])
        end
      end
    end
  end

  def self.insert_data(data, path, result)
    component = path.shift

    if path.empty?
      result[component] = data
    else
      result[component] ||= {}
      insert_data(data, path, result[component])
    end
  end
end
