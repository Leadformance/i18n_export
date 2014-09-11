describe I18nExport do
  before do
    I18nExport.config_file = fixture_filename "config.yml"

    I18n.available_locales = nil

    translations = YAML::load_file(fixture_filename("translations.yml"))

    translations.each do |locale, translations|
      I18n.backend.store_translations(locale, translations)
    end
  end

  after do
    I18n.available_locales = nil
  end

  it "returns a configuration object" do
    expect(I18nExport.configuration).to be_a(I18nExport::Config)
  end

  it "creates the js file" do
    expect(File.file?(tempfile("app.js"))).to eq(false)

    I18nExport.export!

    expect(File.file?(tempfile("app.js"))).to eq(true)
  end

  it "exports nested directories without blowing up" do
    I18nExport.config_file = fixture_filename "config-with-nested-directory.yml"

    expect { I18nExport.export! }.not_to raise_error
  end

  it "performs full export" do
    I18nExport.export!

    expect(File.read(tempfile "all.js")).to eq(fixture("all.js"))
  end

  it "performs partial export" do
    I18nExport.export!

    expect(File.read(tempfile "app.js")).to eq(fixture "app.js")
    expect(File.read(tempfile "client.js")).to eq(fixture "client.js")
  end
end
