require 'capistrano/recipes/deploy/strategy/copy'
require 'fileutils'

module Capistrano
  module Deploy
    module Strategy
      class CopyWithBundlePackage < Copy

        def build(directory)
          cmd = "#{fetch(:bundle_cmd, 'bundle')} package"

          Dir.chdir(directory) do
            FileUtils.rm_rf 'vendor/cache'
            defined?(Bundler) ? with_original_env { system(cmd) } : system(cmd)

            # Check the return code of bundle package command and rollback if not 0
            unless $? == 0
              raise Capistrano::Error, 'bundle package failed'
            end
          end
        end

        private

        def with_original_env
          original_env = ENV.to_hash

          begin
            # Clean the ENV from Bundler settings
            ENV.delete('RUBYOPT')
            ENV.keys.each { |k| ENV.delete(k) if k =~ /^bundle_/i }

            yield
          ensure
            ENV.replace(original_env)
          end
        end
      end
    end
  end
end
