require 'rubygems'
require 'fssm'

module Watcher
  class Base
    def self.status_message(output_file)
      color, action = File.exist?(output_file) ? [33, 'overwrite'] : [32, '   create']
      "\033[0;#{color}m#{action}\033[0m #{output_file}"
    end
  end
end

