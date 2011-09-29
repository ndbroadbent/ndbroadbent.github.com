require 'fssm'

module Watcher
  class Base
    class << self
      def config
        # _config.yml contains config keys for the subclasses of Watcher::Base
        config_key = self.name[/::([^:]*)$/,1].downcase
        @config ||= YAML.load_file('_config.yml')['watchers'][config_key]
      end

      def status_message(output_file)
        color, action = File.exist?(output_file) ? [33, 'overwrite'] : [32, '   create']
        "\033[0;#{color}m#{action}\033[0m #{output_file}"
      end
    end
  end
end

