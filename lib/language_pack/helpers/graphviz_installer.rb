require "language_pack/shell_helpers"

class LanguagePack::GraphvizInstaller
  include LanguagePack::ShellHelpers

  GRAPHVIZ_BASE_URL = "https://s3-us-west-2.amazonaws.com/mfenniak-graphviz"
  GRAPHVIZ_VERSION = "graphviz-2.30"

  def initialize(slug_vendor_graphviz, stack)
    @vendor_dir = slug_vendor_graphviz
    @stack = stack
    @fetcher = LanguagePack::Fetcher.new(GRAPHVIZ_BASE_URL, stack)
  end

  def install(forced = false)
    topic "Installing Graphviz: #{GRAPHVIZ_VERSION}"

    FileUtils.mkdir_p(@vendor_dir)
    Dir.chdir(@vendor_dir) do
      @fetcher.fetch_untar("#{GRAPHVIZ_VERSION}.tgz")
    end

    bin_dir = "bin"
    FileUtils.mkdir_p bin_dir
    Dir["#{@vendor_dir}/bin/*"].each do |bin|
      run("ln -s ../#{bin} #{bin_dir}")
    end
  end
end
