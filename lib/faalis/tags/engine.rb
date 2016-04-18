module Faalis
  module Tags
    class Engine < ::Rails::Engine
      isolate_namespace Faalis::Tags

      engine_name 'faalis_tags'
    end
  end
end
