require 'json'
require 'rubycritic/version'
require 'pathname'

module RubyCritic
  module Generator
    module Json
      class Simple
        def initialize(analysed_modules)
          @analysed_modules = analysed_modules
        end

        FILE_NAME = 'report.json'.freeze

        def render
          JSON.dump(data)
        end

        def data
          {
            metadata: {
              rubycritic: {
                version: RubyCritic::VERSION
              }
            },
            analysed_modules: @analysed_modules,
            score: @analysed_modules.score
          }
        end

        def file_directory
          @file_directory ||= Pathname.new(Config.root)
        end

        def file_pathname
          File.join(file_directory, FILE_NAME)
        end
      end
    end
  end
end
