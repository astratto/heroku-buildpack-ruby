require "language_pack"
require "language_pack/ruby"

# CloudyCoding Language Pack. This is for CloudyCoding.
class LanguagePack::CloudyCoding < LanguagePack::Ruby
  # detects if this is a valid CloudyCoding app by seeing if "config.ru" exists
  # @return [Boolean] true if it's a CloudyCoding app
  def self.use?
    instrument "cloudy_coding.use" do
      true
    end
  end

  def initialize(build_path, cache_path=nil)
    super(build_path, cache_path)

    @graphviz_installer = LanguagePack::GraphvizInstaller.new(slug_vendor_graphviz, @stack)
  end

  def name
    "Ruby/CloudyCoding"
  end

  # def default_config_vars
  #   instrument "cloudy_coding.default_config_vars" do
  #     super.merge({
  #       "RACK_ENV" => env("RACK_ENV") || "production"
  #     })
  #   end
  # end

  # def default_process_types
  #   instrument "cloudy_coding.default_process_types" do
  #     # let's special case thin here if we detect it
  #     web_process = bundler.has_gem?("thin") ?
  #       "bundle exec thin start -R config.ru -e $RACK_ENV -p $PORT" :
  #       "bundle exec rackup config.ru -p $PORT"
  #
  #     super.merge({
  #       "web" => web_process
  #     })
  #   end
  # end

private

  def slug_vendor_graphviz
    "vendor/graphviz"
  end

end

