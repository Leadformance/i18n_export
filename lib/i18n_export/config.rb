require "yaml"

module I18nExport
  class Config
    FileDefinition = Struct.new(:filename, :filters)

    def initialize(filename = I18nExport.config_file)
      raise Errno::ENOENT unless File.file?(filename)
      @filename = filename
    end

    def file_definitions
      config.fetch("translations", []).map { |definition|
        FileDefinition.new(
          definition.fetch("file"),
          definition.fetch("only", [])
        )
      }
    end

    private

    def config
      @config ||= YAML.load_file(@filename)
    end
  end
end
