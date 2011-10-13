require 'capistrano/recipes/deploy/strategy/copy'

module Capistrano
  module Deploy
    module Strategy
      class CopyWithBundlePackage < Copy

        def build(directory)
          super
          bundle_package(directory)
        end

        private

        def bundle_package(directory)
          cmd = "#{fetch(:bundle_cmd, 'bundle')} package"

          Dir.chdir(directory) do
            defined?(Bundler) ? with_original_env { system(cmd) } : system(cmd)

            # Check the return code of bundle package command and rollback if not 0
            unless $? == 0
              raise Capistrano::Error, 'bundle package failed'
            end
          end
        end

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
