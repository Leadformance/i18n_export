require "pathname"

module FixturesHelper
  def fixture(file)
    fixture_filename(file).read
  end

  def fixture_filename(file)
    Pathname.new("spec/fixture").join(file).expand_path
  end

  def tempfile(filename)
    tempdir.join(filename)
  end

  def tempdir
    Pathname.new("spec/tmp").expand_path
  end
end

RSpec.configure do |c|
  c.include FixturesHelper

  c.before do
    temporary_directory = File.dirname(tempfile "foo")
    FileUtils.mkdir(temporary_directory)
  end

  c.after do
    temporary_directory = File.dirname(tempfile "foo")
    FileUtils.rm_r(temporary_directory)
  end
end
