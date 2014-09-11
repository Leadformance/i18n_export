describe I18nExport::Config do
  it "loads the configuration file" do
    config = I18nExport::Config.new(fixture_filename("config.yml"))

    expect(config.file_definitions).to match_array [
      an_object_having_attributes(
        filename: "spec/tmp/app.js",
        filters: %w[app]
      ),
      an_object_having_attributes(
        filename: "spec/tmp/client.js",
        filters: %w[app active_record.attributes]
      ),
      an_object_having_attributes(
        filename: "spec/tmp/all.js",
        filters: nil
      ),
    ]
  end

  it "returns the default config file when not configured" do
    I18nExport.config_file = nil
    expect(I18nExport.config_file).to eq("config/i18n-export.yml")
  end

  it "raises an exception when config file doesn't exist" do
    I18nExport.config_file = "nonexistentfile.yml"

    expect { I18nExport::Config.new }.to raise_error(Errno::ENOENT)
  end
end
